package alphanet.ultra.digibar.bd;

import java.awt.Component;
import java.awt.Font;

import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableColumnModel;

public class MultiLineCellRenderer
  extends JTextArea
  implements TableCellRenderer
{
  private static final long serialVersionUID = 1L;
  private final DefaultTableCellRenderer adaptee = new DefaultTableCellRenderer();
  protected final Font letrita = new Font("Arial Narrow", 0, 10);
  
  public MultiLineCellRenderer()
  {
    setLineWrap(false);
    setWrapStyleWord(false);
    setOpaque(true);
  }
  
  public Component getTableCellRendererComponent(JTable paramJTable, Object paramObject, boolean paramBoolean1, boolean paramBoolean2, int paramInt1, int paramInt2)
  {
    this.adaptee.getTableCellRendererComponent(paramJTable, paramObject, paramBoolean1, paramBoolean2, paramInt1, paramInt2);
    setFont(this.letrita);
    setForeground(this.adaptee.getForeground());
    setBackground(this.adaptee.getBackground());
    setBorder(this.adaptee.getBorder());
    
    setText(this.adaptee.getText());
    TableColumnModel localTableColumnModel = paramJTable.getColumnModel();
    setSize(localTableColumnModel.getColumn(paramInt2).getWidth(), 100000);
    return this;
  }
}
