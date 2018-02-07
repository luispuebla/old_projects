package com.alpha.bd;

import java.sql.SQLException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Vector;
import com.alpha.bd.DateStamp;
/**
* La clase "BloqueaClientes" es la encargada de depurar la lista de clientes a ser bloqueados por falta de pago en creditos.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Diciembre 2004) ALPHA-NET
*/

public class BloqueaClientes  {

	DateStamp fecha;
	String error;
	private ConexionBD con = null;


	public synchronized boolean depura(){
		ResultSet rs = null;
		boolean ok = false;
		fecha = new DateStamp();
		try  {
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			String queryString = "update clientes SET bloqueoXPagoV = 0 WHERE activo = 1";
			//System.out.println("queryString1:\n"+queryString);
			stmt = con.creaStatement();
			stmt.execute(queryString);
			queryString = "update creditos set estatusCredito = 1 WHERE fechaAPagar <= '"+fecha.obtenDatos()+"' AND estatusCredito != 2 AND activo = 1";
			//System.out.println("queryString2:\n"+queryString);
			stmt = con.creaStatement();
			stmt.execute(queryString);
			queryString="update clientes SET bloqueoXPagoV = 1 WHERE rfc = ANY (SELECT rfc COLLATE latin1_spanish_ci FROM creditos WHERE estatusCredito = 1  AND activo = 1 GROUP BY nombreCliente)  AND nombre = ANY  (SELECT nombreCliente COLLATE latin1_spanish_ci FROM creditos WHERE estatusCredito = 1  AND activo = 1 GROUP BY nombreCliente);";
			//System.out.println("queryString3:\n"+queryString);
			stmt = con.creaStatement();
			stmt.execute(queryString);
			ok = true;
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta depura.";
			sqle.printStackTrace();
			ok = false;
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de depura."+e;
			ok = false;
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
		return ok;
	}

}
