import com.adobe.acrobat.*;
import java.io.*;

public class pdfCreador {
	PDFDocument   pdfD = null;
	File archivo=  new File("PruebaLoca.txt");

	public pdfCreador(){
	}

	public static void main(String [] args) throws Exception{
		pdfCreador pd = new pdfCreador();
		System.out.println("ya lo cree...");
		pd.pdfD = new PDFDocument(pd.archivo);
	}

}
