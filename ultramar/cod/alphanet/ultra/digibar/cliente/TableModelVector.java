package alphanet.ultra.digibar.cliente;

import javax.swing.table.AbstractTableModel;
import java.util.Vector;

/**
* La clase "MyTableModel" es la responsable de proveer de los datos que serán desplegados por la JTable.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 1.3
*/
class TableModelVector extends AbstractTableModel {
	protected	Vector<Object> nombreColumnas;
	protected	Vector<Object> datos;
	private static final long serialVersionUID = 1L;

/**
* El Constructo de esta clase recibe como parámetros dos vectores, el primero contiene los nombres de las Columnas de la BD y el Segundo los datos correspondientes a cada columna.
* @param uno El Vector que contiene los nombre de las columnas.
* @param dos El Vector que contiene los datos a ser desplegados.
*/
	public TableModelVector(Vector<Object> uno, Vector<Object> dos){
            nombreColumnas = new Vector<Object>(uno);
            datos = new Vector<Object>(dos);
	}


/**
* Informo si la tabla se puede editar en tiempo de ejecución. Por default se puede editar.
* @param row El numero de renglon a conceder permiso
* @param col El numero de columna a conceder permiso
* @return boolean Verdadero se puede editar, Falso esta prohibido editarlo.
*/
	public boolean isCellEditable(int row, int col) {
		return false;
    }


/**
* Regreso la cantidad de Columnas que poseé mi tabla.
* @return int El numero de columnas
*/
	public int getColumnCount() {
        return nombreColumnas.size();
    }

/**
* Regreso la cantidad de Renglones que poseé mi tabla.
* @return int El numero de renglones
*/
    public int getRowCount() {
        return datos.size();
    }

/**
* Regreso la cantidad de Columnas que poseé mi tabla.
* @param col La columna de la que se obtendrá el nombre
* @return String El nombre de la Columna
*/
    public String getColumnName(int col) {
        return nombreColumnas.elementAt(col).toString();
    }

/**
*Obtengo el valor específico para una coordinada renglon - columna a partir de mis vectores, los cuales deben estar anidados.
* @param row El numero de renglon a obtener dato.
* @param col El numero de columna a obtener dato.
* @return Object con los datos específicos.
*/
    public Object getValueAt(int row, int col) {
        return ((Vector)datos.elementAt(row)).elementAt(col);
    }


	public void addRow(String cantidad, String claveG, String comensal, String producto, String tipo, String observacion) {
		Vector <Object> temporal = new Vector <Object>();
		temporal.addElement(cantidad);
		temporal.addElement(claveG);
		temporal.addElement(comensal);
		temporal.addElement(producto);
		temporal.addElement(tipo);
		temporal.addElement(observacion);
		int size = datos.size();
		datos.addElement(temporal);
		fireTableRowsInserted(size, size);
	}

	public void addRow(String cantidad, String claveG, String producto, String tipo, String observacion) {
		Vector <Object> temporal = new Vector <Object>();
		temporal.addElement(cantidad);
		temporal.addElement(claveG);
		temporal.addElement(producto);
		temporal.addElement(tipo);
		temporal.addElement(observacion);
		int size = datos.size();
		datos.addElement(temporal);
		fireTableRowsInserted(size, size);
	}


	public void removeRow (int renglon){
		datos.remove(renglon);
		fireTableRowsDeleted(renglon,renglon);
		fireTableDataChanged();
	}

	@SuppressWarnings("unchecked")
	public void setValueAt(String actualizacion, int row, int col){
//		System.out.println("Entre a setValueAt, con parametros: " +actualizacion +", "+row +", "+col);
		Vector <Object> temporal = new Vector <Object>();
		temporal = ((Vector <Object>)datos.elementAt(row));
		temporal.setElementAt(actualizacion, col);
		datos.setElementAt(temporal,row);
		fireTableDataChanged();
	}


    public Class getColumnClass(int c) {
        return getValueAt(0, c).getClass();
    }

}

