package alphanet.ultra.digibar.bd;

import javax.swing.table.AbstractTableModel;

public class MyTableModel
  extends AbstractTableModel
{
  protected String[] nombreColumnas = null;
  protected Object[][] datos = (Object[][])null;
  private static final long serialVersionUID = 1L;
  
  public MyTableModel(String[] paramArrayOfString, Object[][] paramArrayOfObject)
  {
    this.nombreColumnas = paramArrayOfString;
    this.datos = paramArrayOfObject;
  }
  
  public boolean isCellEditable(int paramInt1, int paramInt2)
  {
    return false;
  }
  
  public int getColumnCount()
  {
    return this.nombreColumnas.length;
  }
  
  public int getRowCount()
  {
    return this.datos.length;
  }
  
  public String getColumnName(int paramInt)
  {
    return this.nombreColumnas[paramInt];
  }
  
  public Object getValueAt(int paramInt1, int paramInt2)
  {
    return this.datos[paramInt1][paramInt2];
  }
  
  public void setValueAt(Object paramObject, int paramInt1, int paramInt2)
  {
    this.datos[paramInt1][paramInt2] = paramObject;
    fireTableCellUpdated(paramInt1, paramInt2);
  }
  
  public void deleteRow(int paramInt)
  {
    fireTableRowsDeleted(paramInt, paramInt);
    super.fireTableDataChanged();
  }
  
  private void printDebugData()
  {
    int i = getRowCount();
    int j = getColumnCount();
    for (int k = 0; k < i; k++)
    {
      System.out.print("    row " + k + ":");
      for (int m = 0; m < j; m++) {
        System.out.print("  " + this.datos[k][m]);
      }
      System.out.println();
    }
    System.out.println("--------------------------");
  }
}
