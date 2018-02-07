package samples;

import java.awt.*;
import java.awt.event.*;

import java.io.*;
import java.net.*;
import java.text.*;
import java.util.*;
import com.adobe.acrobat.*;
import com.adobe.acrobat.gui.*;
import com.adobe.acrobat.util.*;
import com.adobe.acrobat.sidecar.*;

public class Nails extends Component implements Runnable, MouseListener, WindowListener
{
	public void windowClosing(WindowEvent e) 
	{
		acrobat = null;
	}
	public void windowActivated(WindowEvent e)
	{
	}
	public void windowClosed(WindowEvent e)
	{
	}
	public void windowDeactivated(WindowEvent e)
	{
	}
	public void windowDeiconified(WindowEvent e)
	{
	}
	public void windowIconified(WindowEvent e)
	{
	}
	public void windowOpened(WindowEvent e)
	{
	}
	private Dimension minDimension;
	private Image osImage; // off screen image
	private PDFDocument doc;
	private int pageNumber;
	private Rectangle pageRect;	
	private static Viewer viewer;
	private	static Frame acrobat;
	private String file;
	private File file_1;
	private String url;
	private URL url_1;
	private boolean isURL;
	private boolean error, done;
	private boolean highlight;
	private boolean loadingMainDocument;
	private boolean waitToLoad;
	private static final int kMargin = 10;
	private static Tip infotip;
	private final Frame parent;
			
	public class Tip extends Window
	{
		private Dimension dim;
		private String tip;
		private int y;
		public Tip(String t, Frame parent)
		{
			super(parent);
			setText(t);
			setBackground(SystemColor.info);
		}

		public void setVisible(boolean t)
		{
			super.setVisible(t);
		}
		
		public void setText(String t) 
		{
			tip = t;
			Font font = this.getFont();
			FontMetrics fm = Toolkit.getDefaultToolkit().getFontMetrics(font);
			y = fm.getHeight();
			dim = new Dimension(fm.stringWidth(tip) + 4, y + 4);
			setBounds(0, 0, dim.width, dim.height);
			invalidate();
			validate();
		}
		
		public Dimension getMinimumSize()
		{
			return dim;
		}

		public Dimension getPreferredSize()
		{
			return dim;
		}
		
		public void update(Graphics g)
		{
			paint(g);
		}
		
		public void paint(Graphics g)
		{
			g.setColor(SystemColor.infoText);
			g.drawString(tip, 2, y);
			g.drawRect(0, 0, getSize().width-1, getSize().height-1);
		}

		public void setLocation(int x, int y)
		{
			Dimension ss = Toolkit.getDefaultToolkit().getScreenSize();
			int w = getSize().width;
			if (x+w > ss.width) {
				x -= x+w - ss.width;
			} else if (x < 0) {
				x = 0;
			}
			if (y < 0) {
				y = 0;
			} else if (y > ss.height) {
				y = ss.height - getSize().height;
			}
			super.setLocation(x, y);
		}
	}
	
	private boolean isAcrobatClosed()
	{
		return acrobat == null; // || !acrobat.isShowing();
	}
	
	public Nails(int width, int height, Frame parent, boolean waitToLoad) 
	{
		error = false;
		done = false;
		minDimension = new Dimension(width, height); //79, 103);
		pageNumber = 0;
		highlight = false;
		this.parent = parent;
		this.loadingMainDocument = false;
		this.waitToLoad = waitToLoad;
		addMouseListener(this);
	}
	
	public void mousePressed(MouseEvent e) {}
	public void mouseReleased(MouseEvent e) {}
	
	public void mouseClicked(MouseEvent e)
	{
		if (waitToLoad) {
			loadThumbnail();
			waitToLoad = false;
			return;
		} else if (loadingMainDocument) {
			e.consume();
		} else if (isDocumentAlreadyOnDisplay() && !isAcrobatClosed()) {
			setCursor(Cursor.getDefaultCursor());
			acrobat.toFront();
			acrobat.requestFocus();
			e.consume();
		} else {
			(new GotoDocumentCommand()).start();
		}
	}
	
	private void setTipLocation(MouseEvent e)
	{
		//infotip.setLocation(e.getX()+getLocationOnScreen().x + 4, e.getY()+getLocationOnScreen().y + 4);
		infotip.setLocation(getLocationOnScreen().x, getLocationOnScreen().y-infotip.getSize().height);
	}
	
	public void mouseEntered(MouseEvent e) 
	{
		if (waitToLoad) {
			setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
			highlight = true;
			repaint();
			infotip.setText("Click to generate thumbnail for " + getFilename());
			setTipLocation(e);
			infotip.setVisible(true);
		} else if (loadingMainDocument) {
			setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
			infotip.setText("Loading...Please wait...");
			setTipLocation(e);
			infotip.setVisible(true);
			e.consume();
		} else if (isDocumentAlreadyOnDisplay() && !isAcrobatClosed()) {
			setCursor(Cursor.getDefaultCursor());
			highlight = false;
			repaint();
			infotip.setText("Document is already on display");
			setTipLocation(e);
			infotip.setVisible(true);
			e.consume();
		} else {
			setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
			highlight = true;
			repaint();
			infotip.setText(getDocumentTitle());
			setTipLocation(e);
			infotip.setVisible(true);
			e.consume();
		}
	}

	public void mouseExited(MouseEvent e) 
	{
		if (loadingMainDocument) {
			setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
			infotip.setVisible(false);
			e.consume();
		} else if (isDocumentAlreadyOnDisplay()) {
			setCursor(Cursor.getDefaultCursor());
			highlight = false;
			repaint();
			infotip.setVisible(false);
			e.consume();
		} else {
			setCursor(Cursor.getDefaultCursor());
			highlight = false;
			repaint();
			infotip.setVisible(false);
			e.consume();
		}
	}
	
	private String getDocumentTitle()
	{
		try {
			String r = doc.getDocumentInfo(PDFDocument.Title_K);
			return (r == null) ? getFilename() : r;
		} catch (Exception x) {
			return getFilename();
		}	
	}
	
	private boolean isDocumentAlreadyOnDisplay()
	{
		try {
			return viewer != null && viewer.getDocumentURL().equals(url);
		} catch (Exception x) {
			return false;
		}
	}

	public class GotoDocumentCommand extends Thread
	{
		public void run()
		{
			setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
			setEnabled(false);
			gotoDocument();
			setCursor(Cursor.getDefaultCursor());
			setEnabled(true);
			loadingMainDocument = false;
		}
	}
	
	private void gotoDocument()
	{
		try {
			Session theSession = Session.getTheSession();
			if (theSession.isIE()) {
				com.ms.security.PolicyEngine.assertPermission(com.ms.security.PermissionID.SYSTEM);
			} else if (theSession.isNetscape()) {
				netscape.security.PrivilegeManager.enablePrivilege("UniversalFileRead");
				netscape.security.PrivilegeManager.enablePrivilege("UniversalTopLevelWindow");
			}
			if (viewer == null) {
				viewer = new Viewer(true);
			}
			if (isAcrobatClosed()) {
				viewer = viewer.openNewWindow();
				acrobat = viewer.getFrame();
				acrobat.addWindowListener(this);
			}
			if (Nails.this.isURL) {
				viewer.setDocumentURL(url);
			} else {
				FileInputStream instream = new FileInputStream(file);
				viewer.setDocumentInputStream(instream);
			}
		} catch (Exception x) {
			setCursor(Cursor.getDefaultCursor());
			setEnabled(true);
			System.out.println(x);
		}
	}
	
	private void loadThumbnail()
	{
		Thread t = new Thread(this);
		try {
			Session theSession = Session.getTheSession();
			if (theSession.isIE()) {
				com.ms.security.PolicyEngine.assertPermission(com.ms.security.PermissionID.SYSTEM);
			} else if (theSession.isNetscape()) {
				netscape.security.PrivilegeManager.enablePrivilege("UniversalThreadAccess");
			}
			t.setPriority(Math.max(Thread.currentThread().getPriority()-1, Thread.MIN_PRIORITY));
		} catch (Exception x) {
		}
		t.start();
	}
	
	public String getFilename()
	{
		return (isURL) ? url : file;
	}
	
	public void setFile(String f) 
	{
		isURL = false;
		try {
			this.file_1 = new File(f+"_");
			this.file = f;
			infotip = new Tip(f, parent);
			if (!waitToLoad)
				loadThumbnail();
		} catch (Exception x) {
			error = true;
			new ErrorDialog(parent, x);
			System.out.println(x);
		}
	}
	
	public void setURL(String f) 
	{
		isURL = true;
		try {
			this.url_1 = new URL(f+"_");
			this.url = f;
			infotip = new Tip(f, parent);
			if (!waitToLoad)
				loadThumbnail();
		} catch (Exception x) {
			error = true;
			new ErrorDialog(parent, x);
			System.out.println(x);
		}
	}

	public void run()
	{
		setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		setEnabled(false);
		try {
			if (isURL) {
				doc = new PDFDocument(url_1);
			} else {
				doc = new PDFDocument(file_1);
			}
			drawPage();
			done = true;
			repaint();
			infotip.setVisible(false);
			infotip.setText(getDocumentTitle());
		} catch (Exception x) {
			error = true;
			new ErrorDialog(parent, x);
			System.out.println(x);
		}
		setCursor(Cursor.getDefaultCursor());
		setEnabled(true);
	}

	private void drawPage()
	{
		try {
			// the crop box size is the size of the page in user space, after translating
			// through the default matrix.
			FloatPoint cropBoxSize = doc.getPageSize(pageNumber);
					
			// Compute the appropriate current scale
			int width = getSize().width;
			int height = getSize().height;
					
			float hScale = (float)((width - 2 * kMargin) / cropBoxSize.x);
			float vScale = (float)((height - 2 * kMargin) / cropBoxSize.y);
			float scale = (float)Math.min(hScale, vScale);
					
			// Compute the transform -- this is just the identity matrix scaled
			// by the computed scale.
			AffineTransform transform = new AffineTransform(scale, 0, 0, scale, 0, 0);
					
			// Create the Image object and draw into it
			int w = (int)(cropBoxSize.x * scale);
			int h = (int)(cropBoxSize.y * scale);
			osImage = createImage(w, h);
			doc.drawPage(pageNumber, osImage, transform, null, this);
					
			// Compute the page rectangle by transforming the crop box and translating it in
			// order to center it
			pageRect = (new FloatRect(0, 0, cropBoxSize.x, cropBoxSize.y)).transformRect(transform).toRect();
			pageRect.x += (int)((width - scale * cropBoxSize.x) / 2) - 1;
			pageRect.y += (int)((height - scale * cropBoxSize.y) / 2) - 1;
			pageRect.width += 2;
			pageRect.height += 2;	
		} catch (Exception x) {
			error = true;
			new ErrorDialog(parent, x);
			System.out.println(x);
		}
	}
	
	public void setPageNumber(int p)
	{
		pageNumber = p;
	}
	
	public Dimension getMinimumSize()
	{
		return minDimension;
	}
	
	public Dimension getPreferredSize()
	{
		return minDimension;
	}

	public void update(Graphics g)
	{
		paint(g);
	}
	
	public void paint(Graphics g) 
	{
		if (waitToLoad) {
			g.setColor((highlight) ? Color.blue: Color.orange);
			g.drawRect(0, 0, getSize().width-1, getSize().height-1);
			g.setColor(Color.black);
			g.drawString("Click here...", 10, getSize().height / 2);
			return;
		}
		
		if (!done) {
			g.setColor(Color.green);
			g.drawRect(0, 0, getSize().width-1, getSize().height-1);
			g.setColor(Color.black);
			g.drawString("Please wait...", 10, getSize().height / 2);
			return;
		}
		if (osImage == null) {
			g.setColor(Color.red);
			g.drawRect(0, 0, getSize().width-1, getSize().height-1);
			drawPage(); // try again
		}
		if (error) {
			g.setColor(Color.red);
			g.drawRect(0, 0, getSize().width-1, getSize().height-1);
		}
		g.setColor(Color.black);
		g.drawRect(pageRect.x, pageRect.y, pageRect.width, pageRect.height);
		g.drawImage(osImage, pageRect.x + 1, pageRect.y + 1, this);
		g.setColor((highlight) ? Color.blue : Color.gray);
		g.drawRect(0, 0, getSize().width-1, getSize().height-1);
	}
	
	static public void main(String[] args)
	{
		final Frame f = new Frame("Faultline Demo");
		f.setBackground(Color.white);
		f.setBounds(100, 100, 400, 550);
		WindowAdapter adapter = new WindowAdapter()
		{
			public void windowClosing(WindowEvent event)
			{ 
				f.dispose();
				System.exit(0);
			}
		};
		f.addWindowListener(adapter);

		f.setLayout(new BorderLayout());
		Panel panel = new Panel(new GridLayout(2,2));
		f.add(panel);
		f.show();

		int w = 100;
		int h = 150;
			
		String url = "http://dosai/AcroEng/Faultline/demo/pdf/";
		Nails nail = new Nails(w, h, f, true);
		nail.setURL(url+"Underground.pdf");

		/*Nails nail2 = new Nails(w, h, f, true);
		nail2.setFile("d:\\FaultlineTestDocs\\Acrobat.pdf");
		
		Nails nail3 = new Nails(w, h, f, true);
		nail3.setFile("d:\\FaultlineTestDocs\\pcweek.pdf");

		Nails nail4 = new Nails(w, h, f, false);
		nail4.setFile("d:\\FaultlineTestDocs\\Maps.pdf");*/
		
		/*panel.add(nail4);
		panel.add(nail2);
		panel.add(nail3);*/
		panel.add(nail);
	}	
}