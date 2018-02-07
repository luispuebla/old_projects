package alphanet.ultra.digibar.bd;

import javax.swing.table.AbstractTableModel;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;


/**
* La clase "MyTableModel" es la responsable de proveer de los datos que serán desplegados por la JTable.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 1.3
*/
class MyTableModel extends AbstractTableModel {
	private ConexionBD con = null;
	private TimeStamp ts = null;
	protected String[] nombreColumnas = null;
	protected Object[][] datos = null;
	private static final long serialVersionUID = 1L;

/**
* El Constructo de esta clase recibe como parámetros dos vectores, el primero contiene los nombres de las Columnas de la BD y el Segundo los datos correspondientes a cada columna.
* @param uno El Vector que contiene los nombre de las columnas.
* @param dos El Vector que contiene los datos a ser desplegados.
*/
	public MyTableModel(String [] nombreColumnas, Object[][] datos){
            this.nombreColumnas = nombreColumnas;
            this.datos = datos;
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
        return nombreColumnas.length;
    }

/**
* Regreso la cantidad de Renglones que poseé mi tabla.
* @return int El numero de renglones
*/
    public int getRowCount() {
        return datos.length;
    }

/**
* Regreso la cantidad de Columnas que poseé mi tabla.
* @param col La columna de la que se obtendrá el nombre
* @return String El nombre de la Columna
*/
    public String getColumnName(int col) {
        return nombreColumnas[col];
    }

/**
*Obtengo el valor específico para una coordinada renglon - columna a partir de mis vectores, los cuales deben estar anidados.
* @param row El numero de renglon a obtener dato.
* @param col El numero de columna a obtener dato.
* @return Object con los datos específicos.
*/
    public Object getValueAt(int row, int col) {
        return datos[row][col];
    }

	public void setValueAt(Object value, int row, int col) {
		datos[row][col] = value;
		fireTableCellUpdated(row, col);
	}


	public void deleteRow (int renglon){
//		datos.remove(renglon);
		fireTableRowsDeleted(renglon,renglon);
		super.fireTableDataChanged();
	}




	private void printDebugData() {
		int numRows = getRowCount();
		int numCols = getColumnCount();
		for (int i=0; i < numRows; i++) {
			System.out.print("    row " + i + ":");
			for (int j=0; j < numCols; j++) {
				System.out.print("  " + datos[i][j]);
			}
			System.out.println();
		}
		System.out.println("--------------------------");
	}
}

