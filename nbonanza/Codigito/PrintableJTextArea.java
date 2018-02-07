Try this class performs simple printing of a JTextArea by extending JTextArea and implementing Printable.

All you need to do is invoke SimplePrintableJTextArea.print() from your application.


/*
* PrintableJTextArea.java
*
*/

package your.package;

import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.standard.Chromaticity;
import javax.print.attribute.standard.MediaPrintableArea;
import javax.print.attribute.standard.OrientationRequested;
import javax.print.attribute.standard.PrintQuality;
import javax.swing.JTextArea;

import javax.swing.text.BadLocationException;

/**
*
* @author David J. Ward
*/
public class SimplePrintableJTextArea extends JTextArea implements Printable {

/**
* Holds value of property jobName.
*/
private String jobName = "Print Job for "+System.getProperty("user.name");

/** Creates a new instance of PrintableJTextArea */
public SimplePrintableJTextArea() {
super();
}
public SimplePrintableJTextArea(String text) {
super(text);
}

int inchesToPage(double inches) {
return (int)(inches*72.0);
}

int left_margin = inchesToPage(0.5);
int right_margin = inchesToPage(0.5);
int top_margin = inchesToPage(0.5);
int bottom_margin = inchesToPage(0.5);

public void print() {

// Create a printerJob object
final PrinterJob printJob = PrinterJob.getPrinterJob();

// Set the printable class to this one since we
// are implementing the Printable interface
printJob.setPrintable(this);
printJob.setJobName(jobName);

//Collect the print request attributes.
final HashPrintRequestAttributeSet attrs = new HashPrintRequestAttributeSet();
attrs.add(OrientationRequested.PORTRAIT);
attrs.add(Chromaticity.COLOR);
attrs.add(Chromaticity.MONOCHROME);
attrs.add(PrintQuality.NORMAL);
attrs.add(PrintQuality.DRAFT);
attrs.add(PrintQuality.HIGH);

//Assume US Letter size, someone else can do magic for other paper formats
attrs.add(new MediaPrintableArea(0.25f, 0.25f, 8.0f, 10.5f, MediaPrintableArea.INCH));

// Show a print dialog to the user. If the user
// clicks the print button, then print, otherwise
// cancel the print job
if (printJob.printDialog()) {
//You may want to do the printing in a thread or SwingWorker
//But this gets the job done all the same.
try {
printJob.print(attrs);
} catch (Exception PrintException) {
PrintException.printStackTrace();
}
}
}

public int print(java.awt.Graphics graphics, java.awt.print.PageFormat pageFormat, int pageIndex) throws PrinterException {
Graphics2D g2 = (Graphics2D) graphics;

//Found it unwise to use the TextArea font's size,
//We area just printing text so use a a font size that will
//be generally useful.
g2.setFont(getFont().deriveFont(9.0f));

int bodyheight = (int)pageFormat.getImageableHeight();
int bodywidth = (int)pageFormat.getImageableWidth();
int lineheight = g2.getFontMetrics().getHeight()-(g2.getFontMetrics().getLeading()/2);

int lines_per_page = (bodyheight-top_margin-bottom_margin)/lineheight;

int start_line = lines_per_page*pageIndex;

if (start_line > getLineCount()) {
return NO_SUCH_PAGE;
}

int page_count = (getLineCount()/lines_per_page)+1;

int end_line = start_line + lines_per_page;

int linepos = (int)top_margin;

int lines = getLineCount();

g2.translate(pageFormat.getImageableX(), pageFormat.getImageableY());


for (int line = start_line; line < end_line; line++) {
try {
String linetext = getText(
getLineStartOffset(line),
getLineEndOffset(line)-getLineStartOffset(line));
g2.drawString(linetext, left_margin, linepos);
} catch (BadLocationException e) {
//never a bad location
}

linepos += lineheight;
if (linepos > bodyheight-bottom_margin) {
break;
}
}

return Printable.PAGE_EXISTS;

}
}
 

    Back to Forum    |    Watch this topic     
 
 
This topic has 3 replies on 1 page.   
 
 

 
