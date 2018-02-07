import java.awt.*;
import java.awt.event.*;
import java.io.*;

import com.adobe.acrobat.Viewer;
import com.adobe.acrobat.ViewerCommand;

public class Exerciser implements ViewerCommand {
    private TextArea log;
    private Frame frame;
	private Viewer acrobat;

    public Exerciser() {
		log = new TextArea(10, 70);
		frame = new Frame("Faultline Exerciser");
		frame.setLayout(new BorderLayout());
		frame.add(log, BorderLayout.CENTER);
		frame.setSize(400, 400);
		frame.show();
		frame.addWindowListener(new WindowAdapter() {
		    public void windowClosing(WindowEvent e) {
				System.exit(0); 
		    }
		});
		try {
			acrobat = (new Viewer()).openNewWindow();
		} catch (Exception x) {
		    log.append("Unable to create viewer \n");
		}
    }

    public void ls(String dir) {
		list(new File(dir), ".");
    }

    private void list(File cd, String file) {
		File d = new File(cd, file);
		String files[] = d.list();
		for (int i = 0; i < files.length; i++) {
		    File f = new File(d, files[i]);
		    if (f.isDirectory()) {
				list(d, files[i]);
		    } else if (f.isFile() && f.getName().toLowerCase().endsWith(".pdf")) {
				render(f);
		    }
		}
    }

    private void render(File f) {
		try {
		    System.out.println("Start to render: " + f.getAbsolutePath());
		    FileInputStream fis = new FileInputStream(f);
		    acrobat.setDocumentInputStream(fis);
			long start = System.currentTimeMillis();
		    for (int i = 0; i < acrobat.getPageCount(); i++) {
				try {
				    acrobat.renderPage(i);
				} catch (Exception x) {
				    System.out.println("Unable to render page: " + i + " of file " + f.getName());
				    x.printStackTrace();
				}
		    }
		    long elapsed = System.currentTimeMillis() - start;
		    log.append("Rendered (" + elapsed + "): " + f.getAbsolutePath() + "\n");
		    acrobat.execMenuItem(ViewerCommand.Close_K);
			fis.close();
		} catch(Exception x) {
		    System.out.println("Unable to render file: " + f.getName());
		    log.append("Unable to render: " + f.getAbsolutePath() + "\n");
		}
    }

    public static void main(String args[]) {
		Exerciser e = new Exerciser();
		e.ls(args[0]);
    }
}




