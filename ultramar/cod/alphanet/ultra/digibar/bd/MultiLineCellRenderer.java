package alphanet.ultra.digibar.bd;

import javax.swing.JTextArea;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableColumnModel;
import javax.swing.JTable;
import java.awt.Component;
import java.awt.Font;


public class MultiLineCellRenderer extends JTextArea implements TableCellRenderer {

  private final DefaultTableCellRenderer adaptee = new DefaultTableCellRenderer();
  protected final Font letrita = new Font("Arial Narrow",Font.PLAIN,10);

	public MultiLineCellRenderer() {
		setLineWrap(false);
		setWrapStyleWord(false);
		setOpaque(true);
	}

	public Component getTableCellRendererComponent(JTable table, Object obj, boolean isSelected, boolean hasFocus, int row, int column) {
	    adaptee.getTableCellRendererComponent(table, obj, isSelected, hasFocus, row, column);
	  	setFont(letrita);
	    setForeground(adaptee.getForeground());
	    setBackground(adaptee.getBackground());
	    setBorder(adaptee.getBorder());
//	    setFont(adaptee.getFont());
	    setText(adaptee.getText());
		TableColumnModel columnModel = table.getColumnModel();
		setSize(columnModel.getColumn(column).getWidth(), 100000);
		return this;
	}

}