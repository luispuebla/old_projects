package com.ult.bd;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.Date;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Calendar;


public class ManagerCompras {

	private String error = new String("");
	private String claveProveedor = new String("");
	private String claveProducto = new String("");
	private String tipoS = new String("");
	private String observaciones = new String("");
	private String descuento1 = new String("");
	private String descuento2 = new String("");
	private String descuento3 = new String("");
	private String subtotal = new String("");
	private String descuento = new String("");
	private String iva = new String("");
	private String total = new String("");
	private String fechaentrega = new String("");
	private String cantNumProductos = new String("");
	private String claveOrden = new String("");
	private String compra = new String("");
	private String fechaCompra = new String("");
	private String tempProducto = new String("");
	private String tempUnidad = new String("");
	private	String can1 = new String("");
	private	String can2 = new String("");
	private	String can3 = new String("");
	private	String can4 = new String("");
	private	String can5 = new String("");
	private	String can6 = new String("");
	private	String can7 = new String("");
	private	String can8 = new String("");
	private	String can9 = new String("");
	private	String can10 = new String("");
	private	String can11 = new String("");
	private	String can12 = new String("");
	private	String can13 = new String("");
	private	String can14 = new String("");
	private	String can15 = new String("");
	private	String prod1 = new String("");
	private	String prod2 = new String("");
	private	String prod3 = new String("");
	private	String prod4 = new String("");
	private	String prod5 = new String("");
	private	String prod6 = new String("");
	private	String prod7 = new String("");
	private	String prod8 = new String("");
	private	String prod9 = new String("");
	private	String prod10 = new String("");
	private	String prod11 = new String("");
	private	String prod12 = new String("");
	private	String prod13 = new String("");
	private	String prod14 = new String("");
	private	String prod15 = new String("");
	private	String usuario = new String("");
	private	String laRuta = new String("");
	private String fechaInicial = new String("");
	private String fechaFinal = new String("");
	private Properties p = new Properties();
	private String[] ArrayCantidad   = new String[2];
	private	String[] ArrayProducto   = new String[2];
	private	String[] ArrayCunidad   = new String[2];
	private	String[] ArrayImporte   = new String[2];
	private String[] ArrayRegalos = new String[2];
	private TimeStamp tiempo;
	private ConexionBD con;
	private ConexionBD con2;

	public void setFechaInicial(String fechaInicial){
		this.fechaInicial = fechaInicial;
	}

	public void setFechaFinal(String fechaFinal){
		this.fechaFinal = fechaFinal;
	}

	public void setClaveProveedor(String claveProveedor){
		this.claveProveedor = claveProveedor;
	}


	public void setClaveProducto(String claveProducto){
		this.claveProducto = claveProducto;
	}

	public void setTipoS(String tipoS){
		this.tipoS = tipoS;
	}

public void setObservaciones(String observaciones){
			this.observaciones = observaciones;
	}

	public void setDescuento1(String descuento1){
			this.descuento1 = descuento1;
	}

	public void setDescuento2(String descuento2){
			this.descuento2 = descuento2;
	}

	public void setDescuento3(String descuento3){
			this.descuento3 = descuento3;
	}

	public void setSubtotal(String subtotal){
			this.subtotal = subtotal;
	}

	public void setDescuento(String descuento){
			this.descuento = descuento;
	}

	public void setIva(String iva){
			this.iva = iva;
	}

	public void setTotal(String total){
			this.total = total;
	}

	public void setCan1(String can1){
				this.can1 = can1;
		}

	public void setCan2(String can2){
				this.can2 = can2;
		}

	public void setCan3(String can3){
				this.can3 = can3;
	}

	public void setCan4(String can4){
				this.can4 = can4;
	}

	public void setCan5(String can5){
				this.can5 = can5;
	}

	public void setCan6(String can6){
				this.can6 = can6;
	}

	public void setCan7(String can7){
				this.can7 = can7;
	}

	public void setCan8(String can8){
				this.can8 = can8;
	}

	public void setCan9(String can9){
				this.can9 = can9;
	}

	public void setCan10(String can10){
				this.can10 = can10;
	}

	public void setCan11(String can11){
				this.can11 = can11;
	}

	public void setCan12(String can12){
				this.can12 = can12;
	}

	public void setCan13(String can13){
				this.can13 = can13;
	}

	public void setCan14(String can14){
				this.can14 = can14;
	}

	public void setCan15(String can15){
				this.can15 = can15;
	}


	public void setProd1(String prod1){
				this.prod1 = prod1;
	}

	public void setProd2(String prod2){
				this.prod2 = prod2;
	}

	public void setProd3(String prod3){
				this.prod3 = prod3;
	}

	public void setProd4(String prod4){
				this.prod4 = prod4;
	}

	public void setProd5(String prod5){
				this.prod5 = prod5;
	}

	public void setProd6(String prod6){
				this.prod6 = prod6;
	}

	public void setProd7(String prod7){
				this.prod7 = prod7;
	}

	public void setProd8(String prod8){
				this.prod8 = prod8;
	}

	public void setProd9(String prod9){
				this.prod9 = prod9;
	}

	public void setProd10(String prod10){
				this.prod10 = prod10;
	}

	public void setProd11(String prod11){
				this.prod11 = prod11;
	}

	public void setProd12(String prod12){
				this.prod12 = prod12;
	}

	public void setProd13(String prod13){
				this.prod13 = prod13;
	}

	public void setProd14(String prod14){
				this.prod14 = prod14;
	}

	public void setProd15(String prod15){
				this.prod15 = prod15;
	}


	public void setUsuario(String usuario){
				this.usuario = usuario;
	}

	public void setLaRuta(String laRuta){
			this.laRuta = laRuta;
	}

	public void setFechaentrega(String fechaentrega){
			this.fechaentrega = fechaentrega;
	}

	public void setCantNumProductos(String cantNumProductos){
			this.cantNumProductos = cantNumProductos;
	}

	public void setClaveOrden(String claveOrden){
				this.claveOrden = claveOrden;
	}

	public void setCompra(String compra){
					this.compra = compra;
	}

	public void setFechaCompra(String fechaCompra){
					this.fechaCompra = fechaCompra;
	}

	public void setTempProducto(String tempProducto){
						this.tempProducto = tempProducto;
	}

	public void setArrayCantidad(String[] ArrayCantidad) throws Exception{
		//System.out.println("Empiezo setArrayCantidad");
			int cantNum = cambiaAInt(cantNumProductos);
		//	System.out.println("Pase a numero");
			this.ArrayCantidad   = new String[cantNum+1];
		//	System.out.println("Asigne tamaño");
			for (int i =1; i<=cantNum; i++){
				this.ArrayCantidad[i] = ArrayCantidad[i];
				//System.out.println("Guardo: "+i);
			}
	}

	public void setArrayProducto(String[] ArrayProducto) throws Exception{
		//System.out.println("Empiezo setArrayProducto");
			int cantNum = cambiaAInt(cantNumProductos);
			this.ArrayProducto   = new String[cantNum+1];
			for (int i =1; i<=cantNum; i++){
				this.ArrayProducto[i] = ArrayProducto[i];
				//System.out.println("Dentro de la asignación del producto");
			}
	}


	public void setArrayCunidad(String[] ArrayCunidad) throws Exception{
		//System.out.println("Empiezo setArrayCunidad");
			int cantNum = cambiaAInt(cantNumProductos);
			this.ArrayCunidad   = new String[cantNum+1];
			for (int i =1; i<=cantNum; i++){
				this.ArrayCunidad[i] = ArrayCunidad[i];
			}
	}

	public void setArrayImporte(String[] ArrayImporte) throws Exception{
		//System.out.println("Empiezo setArrayImporte");
			int cantNum = cambiaAInt(cantNumProductos);
			this.ArrayImporte   = new String[cantNum+1];
			for (int i =1; i<=cantNum; i++){
				this.ArrayImporte[i] = ArrayImporte[i];
			}
	}


	public void setArrayRegalos(String[] ArrayRegalos) throws Exception{
		//System.out.println("Empiezo setArrayRegalos");
			int cantNum = cambiaAInt(cantNumProductos);
			this.ArrayRegalos   = new String[cantNum+1];
			for (int i =1; i<=cantNum; i++){
				this.ArrayRegalos[i] = ArrayRegalos[i];
			}
	}



	public ResultSet datosProveedoresActivos(){
		ResultSet rs = null;
		try{
			String query = ("SELECT rfc, nombre FROM proveedores WHERE activo = 1 ORDER BY nombre");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, datosProveedoresActivos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, datosProveedoresActivos ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El método todosLosProductos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Clientes que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Clientes.
*/
  public ResultSet todosLosProductosBebidas() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT clave, nombre, division FROM bebidas WHERE estatus = 1 ORDER BY CONCAT(division,nombre)");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query todosLosProductos.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving todosLosProductos.";
            throw new Exception(error);
          }
          return rs;
  }



/**
* El método todosLosProductosAlimentos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Clientes que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Clientes.
*/
  public ResultSet todosLosProductosAlimentos() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT clave, nombre, division FROM alimentos WHERE estatus = 1 ORDER BY CONCAT(division,nombre)");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query todosLosProductosAlimentos.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving todosLosProductosAlimentos.";
            throw new Exception(error);
          }
          return rs;
  }



/**
* El Método precioProducto  nos regresa el nombre de la linea de acuerdo a la clave porporcionada.
*
*  @return String con el nombre de la Linea
*/
	public String precioProducto(String claveProducto2, String tipo) throws SQLException, Exception {
		ResultSet rs = null;
		String costo = null;
		int clave = cambiaAInt(claveProducto2);
		con = new ConexionBD();
		try{
			if(tipo.equalsIgnoreCase("A")){
				String query = ("SELECT costoKG FROM materiaprima WHERE clave = "+clave+" ");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					costo = rs.getString("costoKG");
				}
			}
			if(tipo.equalsIgnoreCase("B")){
				String query = ("SELECT costoUnidad FROM materiaprima WHERE clave = "+clave+" ");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					costo = rs.getString("costoUnidad");
				}
			}
			if(tipo.equalsIgnoreCase("C")){
				String query = ("SELECT costoBotella1 FROM materiaprima WHERE clave = "+clave+" ");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					costo = rs.getString("costoBotella1");
				}
			}
			if(tipo.equalsIgnoreCase("D")){
				String query = ("SELECT costoBotella2 FROM materiaprima WHERE clave = "+clave+" ");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					costo = rs.getString("costoBotella2");
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompras, precioProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompras, precioProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompras, precioProducto ");
					q.printStackTrace();
				}
			}
		}
		return costo;
	}



/**
* El Método dameNombreProveedor nos regresa el Nombre del Proveedor solicitado.
*
* @return String correspondiente al nombre vinculado a la Clave del proveedor dado.
*/
	public String dameNombreProveedor(){
		String claveP = null;
		ResultSet rs = null;
		try{
			String query = ("SELECT nombre FROM proveedores WHERE rfc ='"+claveProveedor+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				claveP = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameNombreProveedor ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameNombreProveedor ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameNombreProveedor ");
					q.printStackTrace();
				}
			}
		}
		return claveP;
	}



/**
* El método tieneIva verifica que el Producto agrave IVA.
*	@return bandera 	Boolean si es igual 0 la Línea no exite y si es igual a 1 la Línea se encuentra en la Base de Datos.
*/

public boolean tieneIva(String producto) throws SQLException, Exception {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		ConexionBD con2 = new ConexionBD();

  	  if (con2.miConnection !=null) {
  	  	try {

  	  		//st = con2.creaStatement();
  	  		//rs = st.executeQuery("select * from productos where claveProducto = '"+producto+"'");
  	  		//while(rs.next()){

  	  			//if(rs.getString("iva").equalsIgnoreCase("1")) {
  	  				//bandera = true;
  	  				//}
  	  		//}
  	  		bandera = true;

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCompra metodo tieneIva");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }



/**
* El Método dameNombreProducto  nos da la descripción de un producto de acuerdo a su linea, marca y descripcion
*
*  @return String con la descripcion completa del producto
*/
	public String dameNombreProducto(String claveDeProducto)throws SQLException, Exception {
		ResultSet rs = null;
		String nombreP = null;
		int clave = cambiaAInt(claveDeProducto);
		//System.out.println(claveDeProducto);
		try{
			String query = ("SELECT nombre AS descripcion FROM materiaprima WHERE clave = "+clave+" AND Estatus = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				nombreP = rs.getString("descripcion");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameNombreProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameNombreProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, dameNombreProducto ");
					q.printStackTrace();
				}
			}
		}
		return nombreP;
	}



/**
* El método add_Orden_Compra se encarga de añadir a la Base de Datos una Orden de Compra.
*	@return exito 		Boolean con valor a true es que la transacción se realizó exitosamente y con valor a false existio algun problema en el registro.
*/
	public synchronized int add_Orden_Compra(String usuario) throws SQLException, Exception {
		//System.out.println("Empiezo");
		con = new ConexionBD();
		con.cancelaAutoCommit();
		int claveOrden = -1;
		String claveUltima = "";
		double can;
		int reg;
		double costo;
		double importe;
		//System.out.println("Antes del if y try");
		if (con.miConnection != null) {
			try {
				//System.out.println("Dentro del try");

				//Date fechaEn = cambiaADate(fechaentrega);
				double des1 = cambiaADouble(remueveComas(descuento1));
				double des2 = cambiaADouble(remueveComas(descuento2));
				double des3 = cambiaADouble(remueveComas(descuento3));
				double sub = cambiaADouble(remueveComas(subtotal));
				//System.out.println("fechaentrega: "+fechaentrega);
				//System.out.println("El subtotal: "+sub);
				double des = cambiaADouble(remueveComas(descuento));
				double iv = cambiaADouble(remueveComas(iva));
				double to = cambiaADouble(remueveComas(total));
				//System.out.println("Parsea variables");
				tiempo = new TimeStamp();
				//System.out.println("Obtiene fecha");
				String fecha = tiempo.date;
				//System.out.println(fecha);
				Date alta = cambiaADate(fecha);
				//System.out.println("Paso asignación variables1");

			PreparedStatement updateOrdenCompra;
				updateOrdenCompra = con.miConnection.prepareStatement("insert into orden_compra values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
				updateOrdenCompra.setNull(1, java.sql.Types.INTEGER);
				updateOrdenCompra.setString(2, claveProveedor);
				updateOrdenCompra.setDate(3, alta);
				updateOrdenCompra.setString(4, fechaentrega);
				updateOrdenCompra.setString(5, observaciones);
				updateOrdenCompra.setDouble(6, des1);
				updateOrdenCompra.setDouble(7, des2);
				updateOrdenCompra.setDouble(8, des3);
				updateOrdenCompra.setDouble(9, sub);
				updateOrdenCompra.setDouble(10, des);
				updateOrdenCompra.setDouble(11, iv);
				updateOrdenCompra.setDouble(12, to);
				updateOrdenCompra.setInt(13, 1);
				updateOrdenCompra.setString(14, "0");
				updateOrdenCompra.setInt(15, 0);
				updateOrdenCompra.setString(16, usuario);
				updateOrdenCompra.setInt(17, 0);

				updateOrdenCompra.execute();
				//System.out.println("Termino de guardar1");


				String cambiaSaldo = "UPDATE proveedores SET saldoDisponible = saldoDisponible-"+to+" WHERE rfc = '"+claveProveedor+"' ";
				Statement cambiar = con.miConnection.createStatement();
                cambiar.execute(cambiaSaldo);

				String query = ("SELECT MAX(ClaveOrden) AS ultima FROM orden_compra WHERE activo = 1");
				Statement stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(query);
				while (rs.next()){
					claveOrden = rs.getInt("ultima");
					claveUltima = rs.getString("ultima");
				}

				//System.out.println("Termino de sacar ultima clave: "+claveUltima);

				int cantNum = cambiaAInt(cantNumProductos);
				for (int i =1; i<=cantNum; i++){
					if(!(ArrayProducto[i].equalsIgnoreCase("")) && !(tieneIva(ArrayProducto[i]))){
						int claUl = cambiaAInt(claveUltima);
						can = cambiaADouble(remueveComas(ArrayCantidad[i]));
						costo = cambiaADouble(remueveComas(ArrayCunidad[i]));
						importe = cambiaADouble(remueveComas(ArrayImporte[i]));
						PreparedStatement updateProductosOrdenCompra;
						updateProductosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?);");
						updateProductosOrdenCompra.setInt(1, claUl);
						updateProductosOrdenCompra.setString(2, ArrayProducto[i]);
						updateProductosOrdenCompra.setDouble(3, can);
						updateProductosOrdenCompra.setDouble(4, costo);
						updateProductosOrdenCompra.setDouble(5, importe);
						updateProductosOrdenCompra.setDouble(6, 0.00);
						updateProductosOrdenCompra.execute();
					}
						else if(!(ArrayProducto[i].equalsIgnoreCase("")) && tieneIva(ArrayProducto[i])){
							int claUl = cambiaAInt(claveUltima);
							can = cambiaADouble(remueveComas(ArrayCantidad[i]));
							costo = cambiaADouble(remueveComas(ArrayCunidad[i]));
							importe = cambiaADouble(remueveComas(ArrayImporte[i]));
							PreparedStatement updateProductosOrdenCompra;
							updateProductosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?);");
							updateProductosOrdenCompra.setInt(1, claUl);
							updateProductosOrdenCompra.setString(2, ArrayProducto[i]);
							updateProductosOrdenCompra.setDouble(3, can);
							updateProductosOrdenCompra.setDouble(4, ((costo * 100)/115));
							updateProductosOrdenCompra.setDouble(5, ((importe * 100)/115));
							updateProductosOrdenCompra.setDouble(6, 0.00);
							updateProductosOrdenCompra.execute();
						}
				}

			}
			catch (SQLException sqle) {
				con.realizaRollback();
				claveOrden = -1;
				sqle.printStackTrace();
				System.out.println(	"Error SQL clase ManagerCompra, método add_Orden_Compra"+sqle);
			}
			catch (Exception q){
				con.realizaRollback();
				claveOrden = -1;
				q.printStackTrace();
				System.out.println(	"Error clase ManagerCompra, método add_Orden_Compra");
			}
			finally{
				try{
				con.habilitaAutoCommit();
				con.cierraConexion();
				}
				catch (Exception q){
					System.out.println(	"Error al cerrar conexion de ManagerCompra metodo add_Orden_Compra");
					q.printStackTrace();
				}
			}
		}
		return claveOrden;
	}



/**
* El Método todasLasOrdenesXProveedores nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet todasLasOrdenesXProveedores(){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveOrden, fecha, total FROM orden_compra WHERE claveProveedor = '"+claveProveedor +"' AND activo = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedores ");
			e.printStackTrace();
		}
		return rs;
	}


 /**
 * El método bajaOrden se encarga de actualizar campo Estatus a Baja en la Base de Datos de una Orden de Compra.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
   public boolean bajaOrden() throws SQLException, Exception {
	 		con = new ConexionBD();
	 		con.cancelaAutoCommit();
			boolean resultado = false;
			int cla = cambiaAInt(claveOrden);
			boolean exito = true;
			ResultSet rs = null;
			ResultSet rs2 = null;
			ResultSet rs0 = null;
			String rfc = "";
			double importe = 0.0;
          try  {
			   String datosPro = "SELECT claveProveedor, total FROM orden_compra WHERE claveOrden = "+cla+"";
			   Statement dame = con.creaStatement();
			   rs0 = dame.executeQuery(datosPro);
			   while(rs0.next()){
				   rfc = rs0.getString("claveProveedor");
				   importe = rs0.getDouble("total");
			   }
			   String cambiaSaldo = "UPDATE proveedores SET saldoDisponible = saldoDisponible+"+importe+" WHERE rfc = '"+rfc+"' ";
			   Statement cambiar = con.miConnection.createStatement();
               cambiar.execute(cambiaSaldo);

 			   String queryString = "UPDATE orden_compra SET activo = 0 AND usuario = '"+usuario+"' WHERE ClaveOrden = '"+cla+"' ";
               Statement stmt = con.miConnection.createStatement();
               stmt.execute(queryString);
               String query = "SELECT ClaveProducto, Llegan FROM productos_orden WHERE ClaveOrden = '"+cla+"' ";
			   Statement stmt2 = con.creaStatement();
				rs = stmt2.executeQuery(query);
				//System.out.println();
				while(rs.next()){
					int tp = 0;
					int tpa = 0;
					String cla1 = rs.getString("ClaveProducto");
					String clati = cla1.substring(cla1.length()-1);
					cla1 = cla1.substring(0,cla1.length()-1);
					int c1 = cambiaAInt(cla1);
					String saberTipo = "SELECT tipo, tipoA FROM materiaprima WHERE Clave = "+c1+"";
					Statement sati = con.creaStatement();
					Statement stmt3 = con.creaStatement();
					ResultSet st = sati.executeQuery(saberTipo);
					while (st.next()){
						tp = st.getInt("tipo");
						tpa = st.getInt("tipoA");
					}

					if(tp == 1){
						if(tpa == 1){
							String queryStringx = "UPDATE materiaprima SET inventarioKG = (inventarioKG-"+rs.getDouble("Llegan")+") WHERE clave = "+rs.getInt("ClaveProducto")+"";
							stmt3.execute(queryStringx);
						}
						if(tpa == 2){
							String queryStringx = "UPDATE materiaprima SET inventarioUnidad = (inventarioUnidad-"+rs.getDouble("Llegan")+") WHERE clave = "+rs.getInt("ClaveProducto")+"";
							stmt3.execute(queryStringx);
						}

					}

					if(tp == 2){
						if(clati.equalsIgnoreCase("C")){
							String queryStringx = "UPDATE materiaprima SET inventarioBotella1 = (inventarioBotella1-"+rs.getDouble("Llegan")+") WHERE clave = "+rs.getInt("ClaveProducto")+"";
							stmt3.execute(queryStringx);
						}
						if(clati.equalsIgnoreCase("D")){
							String queryStringx = "UPDATE materiaprima SET inventarioBotella2 = (inventarioBotella2-"+rs.getDouble("Llegan")+") WHERE clave = "+rs.getInt("ClaveProducto")+"";
							stmt3.execute(queryStringx);
						}
					}


					ResultSet rsRegPrecio = null;

					String checaExistenciaCambioPrecio = "SELECT precioCompra FROM precio_anterior_producto WHERE claveProducto = '"+cla1+"' AND claveOrden = "+cla;
					Statement rsTempis = con.creaStatement();
					rsRegPrecio = rsTempis.executeQuery(checaExistenciaCambioPrecio);
					while(rsRegPrecio.next()){
						double precioActual = damePrecioActual(cla1,clati);
					if(clati.equalsIgnoreCase("A")){
						String actualizaPrecio = "UPDATE materiaprima SET costoKG = "+((precioActual*2)-rsRegPrecio.getDouble("precioCompra")) +" WHERE clave = "+cla1+" ";
						//System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					if(clati.equalsIgnoreCase("B")){
						String actualizaPrecio = "UPDATE materiaprima SET costoUnidad = "+((precioActual*2)-rsRegPrecio.getDouble("precioCompra")) +" WHERE clave = "+cla1+"";
						//System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					if(clati.equalsIgnoreCase("C")){
						String actualizaPrecio = "UPDATE materiaprima SET costoBotella1 = "+((precioActual*2)-rsRegPrecio.getDouble("precioCompra")) +" WHERE clave = "+cla1+"";
						//System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					if(clati.equalsIgnoreCase("D")){
						String actualizaPrecio = "UPDATE materiaprima SET costoBotella2 = "+((precioActual*2)-rsRegPrecio.getDouble("precioCompra")) +" WHERE clave = "+cla1+"";
						//System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}

					}
				}
             } catch (SQLException sqle) {
					con.realizaRollback();
					exito = false;
 					sqle.printStackTrace();
               		error = "SQLException: Could not execute the query bajaOrden.";
               throw new SQLException(error);
             } catch (Exception e) {
					con.realizaRollback();
					exito = false;
               		error = "Ocurrió una excepción mientras se actualizaba bajaOrden.";
               		throw new Exception(error);
             }
             finally{
 				try{
					con.habilitaAutoCommit();
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerCompra metodo bajaOrden");
 			   		q.printStackTrace();
 			 	}
 		   }
		return exito;
     }


/**
* El Método todasLasOrdenesXProveedores2 nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet todasLasOrdenesXProveedores2(){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveOrden, fecha, total FROM orden_compra WHERE claveProveedor = '"+claveProveedor +"' AND activo = 1 AND factura = '0'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedores2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedores2 ");
			e.printStackTrace();
		}
		return rs;
	}



 /**
 * El método update_Orden_Compra se encarga de actualizar los datos referentes a una Orden de Compra.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
   public boolean update_Orden_Compra() throws SQLException, Exception {
 			con = new ConexionBD();
			boolean resultado = false;
             try  {

				 	ResultSet rs0 = null;
				 	String rfc = "";
				 	double importe = 0.0;
				 	int cla = cambiaAInt(claveOrden);
				 	double to = cambiaADouble(remueveComas(total));

				 	String datosPro = "SELECT claveProveedor, total FROM orden_compra WHERE claveOrden = "+cla+"";
				 	Statement dame = con.creaStatement();
				 	rs0 = dame.executeQuery(datosPro);
				 	while(rs0.next()){
				 		rfc = rs0.getString("claveProveedor");
				 		importe = rs0.getDouble("total");
				 	}
				 	String cambiaSaldo = "UPDATE proveedores SET saldoDisponible = saldoDisponible+"+importe+" WHERE rfc = '"+rfc+"' ";
				 	Statement cambiar = con.miConnection.createStatement();
				    cambiar.execute(cambiaSaldo);

				    String cambiaSaldo2 = "UPDATE proveedores SET saldoDisponible = saldoDisponible-"+to+" WHERE rfc = '"+rfc+"' ";
					Statement cambiar2 = con.miConnection.createStatement();
				    cambiar2.execute(cambiaSaldo2);

				 //Date fec = cambiaADate(fechaCompra);
				 				 double descu1 = cambiaADouble(remueveComas(descuento1));
				 double descu2 = cambiaADouble(remueveComas(descuento2));
				 double descu3 = cambiaADouble(remueveComas(descuento3));
				 double su = cambiaADouble(remueveComas(subtotal));
				 double de = cambiaADouble(remueveComas(descuento));
				 double iv = cambiaADouble(remueveComas(iva));

				 //System.out.println("Numeros2: "+su+" "+de+" "+iv+" "+to);
 				String queryString = "UPDATE orden_compra SET fechaEntrega = '"+fechaentrega+"', observaciones = '"+observaciones+"', descuento1 = '"+descu1+"', descuento2 = '"+descu2+"', descuento3 = '"+descu3+"', subtotal = '"+su+"', descuento = '"+de+"', iva = '"+iv+"', total = '"+to+"', usuario = '"+usuario+"' WHERE ClaveOrden = "+cla+" ";
 				//System.out.println("queryString orden de compra: "+queryString);
               Statement stmt = con.miConnection.createStatement();
               resultado = stmt.execute(queryString);
               if(resultado == false)
               	resultado = true;
               else
               	resultado = false;
             } catch (SQLException sqle) {
 				sqle.printStackTrace();
               error = "SQLException: Could not execute the query update_Orden_Compra.";
               throw new SQLException(error);
             } catch (Exception e) {
               error = "Ocurrió una excepción mientras se actualizaba update_Orden_Compra.";
               throw new Exception(error);
             }
             finally{
 				try{
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerCompra metodo update_Orden_Compra");
 			   		q.printStackTrace();
 			 	}
 		   }
		return resultado;
     }



/**
* El método update_Productos_Orden_Compra se encarga de eliminar los productos anteriores y registrar los nuevos de acuerdo a los cambios generados en una Orden de Compra.
*	@return exito 		Boolean con valor a true es que la transacción se realizó exitosamente y con valor a false existio algun problema en el registro.
*/
	public synchronized boolean update_Productos_Orden_Compra() throws SQLException, Exception {
		//System.out.println("Empiezo");
		con = new ConexionBD();
		con.cancelaAutoCommit();
		boolean exito = true;
		int uni;
		double can;
		int reg;
		double costo;
		double importe;
		//System.out.println("Antes del if y try");
		if (con.miConnection != null) {
			try {
				int claUl = cambiaAInt(claveOrden);

				String queryString = "DELETE from productos_orden WHERE ClaveOrden = "+claUl+" ";
 				//System.out.println("queryString Borrando: "+queryString);
               Statement stmt = con.miConnection.createStatement();
               exito = stmt.execute(queryString);
               if(exito)
               	exito = false;
               else
               	exito = true;
				//System.out.println("Resultado de eliminado: "+exito);

				int cantNum = cambiaAInt(cantNumProductos);
				for (int i =1; i<=cantNum; i++){
					if(!(ArrayProducto[i].equalsIgnoreCase(""))){
						//System.out.println("Dentro del for y del if");


						can = cambiaADouble(remueveComas(ArrayCantidad[i]));
						costo = cambiaADouble(remueveComas(ArrayCunidad[i]));
						importe = cambiaADouble(remueveComas(ArrayImporte[i]));
						//System.out.println("Termino de asignar variables2");

						PreparedStatement updateProductosOrdenCompra;
						updateProductosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?);");
						updateProductosOrdenCompra.setInt(1, claUl);
						updateProductosOrdenCompra.setString(2, ArrayProducto[i]);
						updateProductosOrdenCompra.setDouble(3, can);
						updateProductosOrdenCompra.setDouble(4, costo);
						updateProductosOrdenCompra.setDouble(5, importe);
						updateProductosOrdenCompra.setDouble(6, 0.00);
						updateProductosOrdenCompra.execute();
						exito = true;
						//System.out.println("Termino de guardar2");
					}
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				exito = false;
				sqle.printStackTrace();
				System.out.println(	"Error SQL clase ManagerCompra, método update_Productos_Orden_Compra");
			}
			catch (Exception q){
				con.realizaRollback();
				exito = false;
				q.printStackTrace();
				System.out.println(	"Error clase ManagerCompra, método update_Productos_Orden_Compra");
			}
			finally{
				try{
				con.habilitaAutoCommit();
				con.cierraConexion();
				}
				catch (Exception q){
					System.out.println(	"Error al cerrar conexion de ManagerCompra metodo update_Productos_Orden_Compra");
					q.printStackTrace();
				}
			}
		}
		return exito;
	}



/**
* El Método datosOrdenCompra nos regresa los Datos de la Orden de Compra seleccionada.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet datosOrdenCompra() throws SQLException, Exception {
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT * FROM orden_compra WHERE ClaveOrden = '"+cla+"'");
			//System.out.println("query: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, datosOrdenCompra ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, datosOrdenCompra ");
			e.printStackTrace();
		}
		return rs;
	}


	public ResultSet todasLasOrdenesXProveedoresAgregada2(){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT ClaveOrden, Fecha, total FROM orden_compra WHERE ClaveProveedor = '"+claveProveedor +"' AND activo = 1 AND entrega !=2");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedores2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedores2 ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método cuentaTodosProductosOrden nos regresa la Cantidad de Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con la cantidad de Productos de una Orden de Compra.
*/
	public int cuentaTodosProductosOrden() throws SQLException, Exception {
		ResultSet rs = null;
		String aver = new String();
		int resul = 0;
		try{
			//System.out.println("La ClaveString: "+claveOrden);
			int cla = cambiaAInt(claveOrden);
			//System.out.println("La Clave: "+cla);
			String query = ("SELECT COUNT(ClaveProducto) AS todos FROM productos_orden WHERE ClaveOrden = "+cla+"");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				resul = rs.getInt("todos");
			}
			//resul = cambiaAInt(aver);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, cuentaTodosProductosOrden ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, cuentaTodosProductosOrden ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, cuentaTodosProductosOrden ");
					q.printStackTrace();
				}
			}
		}
		//System.out.println("En el java salida: "+resul);
		return resul;
	}



	public ResultSet todosProductosOrden3(){
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT DISTINCT productos_orden.*, orden_compra.ClaveProveedor FROM productos_orden, orden_compra WHERE orden_compra.ClaveOrden = "+cla+" AND productos_orden.ClaveOrden = orden_compra.ClaveOrden");
			//System.out.println("da lata: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todosProductosOrden ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todosProductosOrden ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameLlegaron nos regresa la Cantidad de Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con la cantidad de Productos de una Orden de Compra.
*/
	public double dameLlegaron(String producto){
		ResultSet rs = null;
		String aver = new String();
		double resul = 0.00;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT llegan FROM productos_orden WHERE ClaveOrden = "+cla+" AND ClaveProducto = '"+producto+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				aver = rs.getString("llegan");
			}
			resul = cambiaADouble(aver);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameLlegaron ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameLlegaron ");
			e.printStackTrace();
		}
		return resul;
	}



 /**
 * El método validaCantidadIngreso se encarga de verificar que la Cantidad a ingresar de producto entregado NO sea mayor a la estipulada originalmente.
 *	@return int -1 todo bien, X -> Renglon con el primer error.
 */

 public int validaCantidadIngreso() throws SQLException, Exception{
	int resultadoValidacion = -1;
	String query = "SELECT Cantidad, Llegan FROM productos_orden WHERE ClaveOrden = '"+claveOrden +"'";
	int todosLosProductos = cuentaTodosProductosOrden();
	String[] ArrayCantidadExiste   = new String[todosLosProductos+1];
	ResultSet rs = null;
	try{
		con = new ConexionBD();
		Statement stmt = con.creaStatement();
		rs = stmt.executeQuery(query);
		for (int i =1; i<=todosLosProductos; i++){
			while(rs.next()){
				ArrayCantidadExiste[i] = (rs.getDouble("Cantidad")-rs.getDouble("Llegan"))+"";
				i++;
			}
		}
		//Checo que no se pase de lo pedido.
		for (int i =1; i<=todosLosProductos; i++){
			double faltante = cambiaADouble(ArrayCantidadExiste[i]);
			double llega = cambiaADouble(ArrayCantidad[i]);
			if(faltante - llega < 0){
				resultadoValidacion = i;
			}
		}
	}
	 catch(SQLException sqle){
		 resultadoValidacion =  0;
		 System.out.println("Excepcion SQL en bean ManagerCompra, Metodo: validaCantidadIngreso.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 resultadoValidacion =  0;
		 System.out.println("Excepcion en bean ManagerCompra, Metodo: validaCantidadIngreso.\n");
		 e.printStackTrace();
	 }
	 finally{
		 if(con != null){
			 try{
				 con.cierraConexion();
			 }
			 catch (Exception e2){
				 e2.printStackTrace();
			 }
		 }
	 }
	 return resultadoValidacion;
 }



 public boolean finalizaRecepcion (String usuario) throws SQLException, Exception{
	 boolean exito = true;
	 con = new ConexionBD();
	 con.cancelaAutoCommit();
	 try{
		String facturaPrevia = tieneFactura2();
		ResultSet productos = todosProductosOrden();
		int claveDeOrden = cambiaAInt(claveOrden);
		int cantNum = cambiaAInt(cantNumProductos);
		// Almaceno primero factura correspondiente:
		Statement stmt = con.creaStatement();
		Statement stmt2 = con.creaStatement();
		String updateFactura = "";
		if(facturaPrevia.equalsIgnoreCase("0")){
			updateFactura = "UPDATE orden_compra SET factura = '"+compra+"', fechaEntrega = '"+fechaCompra+"', Entrega = 1, usuario = '"+usuario+	"' WHERE ClaveOrden = "+claveDeOrden;
			stmt.execute(updateFactura);
		}
		else{
			PreparedStatement updateFacturas;
			updateFacturas = con.miConnection.prepareStatement("insert into facturas values(?,?,?);");
			updateFacturas.setInt(1, claveDeOrden);
			updateFacturas.setString(2, compra);
			updateFacturas.setString(3, fechaCompra);
			updateFacturas.execute();
		}
		// Actualizo mis productos por los que pague
		for (int i =1; i<=cantNum; i++){
			double canti = cambiaADouble(ArrayCantidad[i]);
			String tc = ArrayProducto[i];
			tc = tc.substring(0, tc.length()-1);
			String queryString = "UPDATE productos_orden SET Llegan = (Llegan+"+canti+") WHERE ClaveOrden = "+claveDeOrden+" AND ClaveProducto = '"+ArrayProducto[i]+"'";
			stmt2.execute(queryString);
		}
		// Aumento mi exsitencia de productos a la venta (Inventario)
		for (int i =1; i<=cantNum; i++){
			double canti = cambiaADouble(ArrayCantidad[i]);
			String tc = ArrayProducto[i];
			String clati = tc.substring(tc.length()-1);
			tc = tc.substring(0, tc.length()-1);
			int clp = cambiaAInt(tc);
			int tp = 0;
			int tpa = 0;

			String saberTipo = "SELECT tipo, tipoA FROM materiaprima WHERE Clave = "+clp+"";
			Statement sati = con.creaStatement();
			ResultSet st = sati.executeQuery(saberTipo);
			while (st.next()){
				tp = st.getInt("tipo");
				tpa = st.getInt("tipoA");
			}

			if(tp == 1){
				if(tpa == 1){
					String queryStringx = "UPDATE materiaprima SET inventarioKG = (inventarioKG+"+canti+") WHERE clave = "+clp+"";
					stmt2.execute(queryStringx);
				}
				if(tpa == 2){
					String queryStringx = "UPDATE materiaprima SET inventarioUnidad = (inventarioUnidad+"+canti+") WHERE clave = "+clp+"";
					stmt2.execute(queryStringx);
				}
			}

			if(tp == 2){
				if(clati.equalsIgnoreCase("C")){
					String queryStringx = "UPDATE materiaprima SET inventarioBotella1 = (inventarioBotella1+"+canti+") WHERE clave = "+clp+"";
					stmt2.execute(queryStringx);
				}
				if(clati.equalsIgnoreCase("D")){
					String queryStringx = "UPDATE materiaprima SET inventarioBotella2 = (inventarioBotella2+"+canti+") WHERE clave = "+clp+"";
					stmt2.execute(queryStringx);
				}
			}
		}
		// Si cambio el precio saco un promedio y lo almaceno en productos
		String queryParaActualizarPrecios = "SELECT ClaveProducto, Costo FROM productos_orden WHERE ClaveOrden = "+claveDeOrden;
		Statement stChecaP = con.creaStatement();
		ResultSet rsP = stChecaP.executeQuery(queryParaActualizarPrecios);
		while (rsP.next()){
			String tc = rsP.getString("ClaveProducto");
			//System.out.println(tc);
			String tca = tc.substring(tc.length()-1);
			//System.out.println(tca);
			tc = tc.substring(0, tc.length()-1);
			int tci = cambiaAInt(tc);
			if(! tieneIva(tc)){
				double precioActual = damePrecioActual (tc,tca);
				double precioRegistrado = rsP.getDouble("Costo");
				if(precioActual != precioRegistrado){
					if(tca.equalsIgnoreCase("A")){
						String actualizaPrecio = "UPDATE materiaprima SET costoKG = " +((precioActual+precioRegistrado) / 2) +"WHERE clave = "+tci+"";
						//System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					if(tca.equalsIgnoreCase("B")){
						String actualizaPrecio = "UPDATE materiaprima SET costoUnidad = " +((precioActual+precioRegistrado) / 2) +"WHERE clave = "+tci+"";
						//System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					if(tca.equalsIgnoreCase("C")){
						String actualizaPrecio = "UPDATE materiaprima SET costoBotella1 = " +((precioActual+precioRegistrado) / 2) +"WHERE clave = "+tci+"";
						//System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					if(tca.equalsIgnoreCase("D")){
						String actualizaPrecio = "UPDATE materiaprima SET costoBotella2 = " +((precioActual+precioRegistrado) / 2) +"WHERE clave = "+tci+"";
						//System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					// Almacenado cambio de producto:
					PreparedStatement updatePrecioAnterior;
					updatePrecioAnterior = con.miConnection.prepareStatement("insert into precio_anterior_producto values(?,?,?,?);");
					updatePrecioAnterior.setString(1, tc);
					updatePrecioAnterior.setInt(2, claveDeOrden);
					updatePrecioAnterior.setDouble(3, precioActual);
					updatePrecioAnterior.setDouble(4, precioRegistrado);
					updatePrecioAnterior.execute();
				}
			}
			else{
				double precioActual = damePrecioActual (tc,tca);
				double precioRegistrado = ((rsP.getDouble("Costo")*1.15) +.01);
				if(precioActual != precioRegistrado){
					if(tca.equalsIgnoreCase("A")){
						String actualizaPrecio = "UPDATE materiaprima SET costoKG = " +((precioActual+precioRegistrado) / 2) +"WHERE clave = "+tci+"";
						System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					if(tca.equalsIgnoreCase("B")){
						String actualizaPrecio = "UPDATE materiaprima SET costoUnidad = " +((precioActual+precioRegistrado) / 2) +"WHERE clave = "+tci+"";
						System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					if(tca.equalsIgnoreCase("C")){
						String actualizaPrecio = "UPDATE materiaprima SET costoBotella1 = " +((precioActual+precioRegistrado) / 2) +"WHERE clave = "+tci+"";
						System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}
					if(tca.equalsIgnoreCase("D")){
						String actualizaPrecio = "UPDATE materiaprima SET costoBotella2 = " +((precioActual+precioRegistrado) / 2) +"WHERE clave = "+tci+"";
						System.out.println(actualizaPrecio);
						Statement stAct = con.creaStatement();
						stAct.execute(actualizaPrecio);
					}

					// Almacenado cambio de producto:
					PreparedStatement updatePrecioAnterior;
					updatePrecioAnterior = con.miConnection.prepareStatement("insert into precio_anterior_producto values(?,?,?,?);");
					updatePrecioAnterior.setString(1, tc);
					updatePrecioAnterior.setInt(2, claveDeOrden);
					updatePrecioAnterior.setDouble(3, precioActual);
					updatePrecioAnterior.setDouble(4, precioRegistrado);
					updatePrecioAnterior.execute();
				}
			}
		}
		boolean finalizadosPC = true;
		String queryFinProductosC = "SELECT Cantidad, Llegan FROM productos_orden WHERE ClaveOrden = "+claveDeOrden;
		Statement estadoPC = con.creaStatement();
		ResultSet rsPC = estadoPC.executeQuery(queryFinProductosC);
		while (rsPC.next()){
			if(rsPC.getDouble("Cantidad") != rsPC.getDouble("Llegan")){
				finalizadosPC = false;
			}
		}
		if(finalizadosPC){
			String updateFinalizadaEntradas = "UPDATE orden_compra SET Entrega = 2 WHERE ClaveOrden = "+claveDeOrden;
			Statement temp2 = con.creaStatement();
			temp2.execute(updateFinalizadaEntradas);
		}
		 con.realizaCommit();
	 }
	 catch(SQLException sqle){
		 exito = false;
		 con.realizaRollback();
		 System.out.println("Excepcion SQL en bean ManagerCompra, Metodo: finalizaRecepcion.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 exito = false;
		 con.realizaRollback();
		 System.out.println("Excepcion en bean ManagerCompra, Metodo: finalizaRecepcion.\n");
		 e.printStackTrace();
	 }
	 finally{
		 if(con != null){
			 try{
				 con.habilitaAutoCommit();
				 con.cierraConexion();
			 }
			 catch (Exception e2){
				 e2.printStackTrace();
			 }
		 }
	 }
	 return exito;
 }


	public String tieneFactura2(){
		ResultSet rs = null;
		String aver = new String();
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT factura FROM orden_compra WHERE ClaveOrden = "+cla+" ");
			//System.out.println("A ver si tiene: "+query);
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				aver = rs.getString("factura");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, tieneFactura2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, tieneFactura2 ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, tieneFactura2 ");
					q.printStackTrace();
				}
			}
		}
		return aver;
	}


/**
* El Método todosProductosOrden nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public ResultSet todosProductosOrden(){
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT DISTINCT pro.*, ord.ClaveProveedor FROM productos_orden pro, orden_compra ord WHERE ord.ClaveOrden = "+cla+" AND  pro.ClaveOrden = ord.ClaveOrden");
			//System.out.println("da lata: "+query);
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todosProductosOrden ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todosProductosOrden ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método damePrecioActual nos regresa los precios registrados actualmente en el Sistema.
*
*  @return double  con el precio correspondiente al producto.
*/

	public double damePrecioActual(String claveDelProducto, String tipo) throws SQLException, Exception{
		double precioAc = 0.00;
		ResultSet rs = null;
		int cla = cambiaAInt(claveDelProducto);
		try{
			if(tipo.equalsIgnoreCase("A")){
				String query = ("SELECT costoKG FROM materiaprima WHERE clave = "+cla +"");
				con2 = new ConexionBD();
				Statement stmt = con2.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					precioAc = rs.getDouble("costoKG");
				}
			}
			if(tipo.equalsIgnoreCase("B")){
				String query = ("SELECT costoUnidad FROM materiaprima WHERE clave = "+cla +"");
				con2 = new ConexionBD();
				Statement stmt = con2.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					precioAc = rs.getDouble("costoUnidad");
				}
			}
			if(tipo.equalsIgnoreCase("C")){
				String query = ("SELECT costoBotella1 FROM materiaprima WHERE clave = "+cla +"");
				con2 = new ConexionBD();
				Statement stmt = con2.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					precioAc = rs.getDouble("costoBotella1");
				}
			}
			if(tipo.equalsIgnoreCase("D")){
				String query = ("SELECT costoBotella2 FROM materiaprima WHERE clave = "+cla +"");
				con2 = new ConexionBD();
				Statement stmt = con2.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					precioAc = rs.getDouble("costoCostoBotella2");
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, damePrecioActual ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, damePrecioActual ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, damePrecioActual ");
					q.printStackTrace();
				}
			}
		}
		return precioAc;
	}



/**
* El método Ordenes_Dia se encarga de enviar la información de las Ordenes de Compra realizadas para un periodo de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos los datos de las Ordenes de Compra
*/

	public ResultSet Ordenes_Dia(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(fecha.length() < 8){
			fecha = fecha+"-%%";
		}
		try  {
			String queryString = ("SELECT * FROM orden_compra WHERE fechaEntrega like '" +fecha+"%%%%%%%%%%%' AND activo = 1 AND factura = 0 AND Entrega = 0 ORDER BY ClaveOrden");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Ordenes_Dia.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Ordenes_Dia.";
			throw new Exception(error);
		}
	return rs;
	}


/**
* El método Ordenes_Semana se encarga de enviar la información de Ordenes de Compra para una periodo de una semana de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos la información de las Ordenes de Compra
*/

	public ResultSet Ordenes_Semana(String semana, String fecha) throws SQLException, Exception {
		//System.out.println("Me llego : " +semana +", " +fecha);
		String diaInicial = "01";
		String diaFinal = "08";
		ResultSet rs = null;
		con = new ConexionBD();
		if (semana.equalsIgnoreCase("02")){
			diaInicial = "08";
			diaFinal = "16";

		}
		else if (semana.equalsIgnoreCase("03")){
			diaInicial = "16";
			diaFinal = "24";

		}
		else if (semana.equalsIgnoreCase("04")) {
			diaInicial = "24";
			diaFinal = "31";

		}
		try  {
			String queryString = ("SELECT * FROM orden_compra WHERE fechaEntrega >= '" +fecha+"-"+diaInicial+"%%%%%%%%%%%' AND fechaEntrega <'"+fecha+"-"+diaFinal+"%%%%%%%%%%%' AND activo = 1 AND factura = 0 AND Entrega = 0 ORDER BY ClaveOrden");
			//System.out.println(queryString);
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Ordenes_Semana.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Ordenes_Semana.";
			throw new Exception(error);
		}
	return rs;
	}

 public ResultSet Ordenes_Mes(String fecha0) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println(fecha1);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT * FROM orden_compra WHERE fechaEntrega like '"+fecha0+"%%%%%%%%%' AND activo = 1 AND factura = 0 AND Entrega = 0 ORDER BY ClaveOrden");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Ordenes_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Ordenes_Mes.";
          throw new Exception(error);
        }
        return rs;
  }



/**
* El Método todosProductosOrden2 nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public ResultSet todosProductosOrden2() throws SQLException, Exception {
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT pro.* FROM productos_orden pro WHERE pro.ClaveOrden = "+cla+"");
			//System.out.println("da lata: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todosProductosOrden ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todosProductosOrden ");
			e.printStackTrace();
		}
		return rs;
	}



 public ResultSet Producto_Mes(String fecha0, String producto) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
  		//System.out.println(fecha0);
  		//System.out.println(producto);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT ord.claveOrden, ord.claveProveedor, ord.fechaEntrega, ord.factura, pr.Cantidad FROM orden_compra ord, productos_orden pr WHERE ord.FechaEntrega like '"+fecha0+"%%' AND ord.activo = 1 AND ord.factura != '0' AND ord.ClaveOrden = pr.ClaveOrden AND pr.ClaveProducto = '"+producto+"' ORDER BY ord.fechaEntrega");
        //  System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Facturas_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Facturas_Mes.";
          throw new Exception(error);
        }
        return rs;
  }



/**
* El Método dameFacturasExtras nos regresa todas las Devoluciones correspondientes a una Compra.
*
*  @return rs ResultSet con las Devoluciones de una Compra.
*/
	public ResultSet dameFacturasExtras(String clave){
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(clave);

			String query = ("SELECT * FROM facturas WHERE Clave_Orden = "+cla+"");
			//System.out.println("query: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameFacturasExtras ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameFacturasExtras ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameComprasXProveedorXTiempoNueva nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComprasXProveedorXTiempoNueva(){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT orden_compra.claveOrden, proveedores.rfc, orden_compra.fechaEntrega, orden_compra.total, orden_compra.Entrega FROM orden_compra, proveedores WHERE orden_compra.activo = 1 AND (orden_compra.Entrega = 0 OR orden_compra.Entrega = 1 OR orden_compra.Entrega = 2) AND orden_compra.claveProveedor LIKE '"+claveProveedor +"' AND proveedores.rfc = orden_compra.claveProveedor AND fechaEntrega BETWEEN '"+fechaInicial+"' AND '"+fechaFinal+"' ORDER BY orden_compra.fechaEntrega DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameComprasXProveedorXTiempoNueva ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameComprasXProveedorXTiempoNueva ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameProductosCompradosYEntregas nos regresa los Productos comprados para una Orden de Compra junto con sus entregas parciales y faltantes, este metodo es empleado por la reimpresion de una orden de compra.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet dameProductosCompradosYEntregas() throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT productos_orden.ClaveProducto, productos_orden.Cantidad, productos_orden.Llegan, (productos_orden.Cantidad-productos_orden.Llegan)AS Faltantes, materiaprima.nombre AS descripcion, productos_orden.Costo, productos_orden.Importe FROM materiaprima, productos_orden WHERE productos_orden.ClaveOrden = "+claveOrden +" AND materiaprima.clave = productos_orden.ClaveProducto");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameProductosCompradosYEntregas ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameProductosCompradosYEntregas ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameResumenCompra nos regresa los Datos correspondientes a una  Orden de Compra sin especificar los productos es empleado por la reimpresion de una orden de compra.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet dameResumenCompra() throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT subtotal, observaciones, descuento1, descuento2, descuento3, descuento, iva, total  FROM orden_compra  WHERE claveOrden = "+claveOrden);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameResumenCompra ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameResumenCompra ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameNombreProveedor2 nos regresa el Nombre del Proveedor solicitado de acuerdo a una orden solicitada.
*
* @return String correspondiente al nombre vinculado a la Clave del proveedor dado.
*/
	public String dameNombreProveedor2(){
		String claveP = null;
		ResultSet rs = null;
		try{
			String query = ("SELECT proveedores.nombre FROM proveedores, orden_compra WHERE orden_compra.claveOrden = "+claveOrden +" AND proveedores.rfc = orden_compra.claveProveedor");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				claveP = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameNombreProveedor2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameNombreProveedor2 ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameNombreProveedor2 ");
					q.printStackTrace();
				}
			}
		}
		return claveP;
	}



/**
* El Método DameFechaEntrega nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public String DameFechaEntrega() throws SQLException, Exception {
		ResultSet rs = null;
		String fecha = "";
		try{
			String query = ("SELECT fechaEntrega FROM orden_compra WHERE ClaveOrden = "+claveOrden+"");
			//System.out.println("da lata: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				fecha = rs.getString("fechaEntrega");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, DameFechaEntrega ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, DameFechaEntrega ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, DameFechaEntrega ");
					q.printStackTrace();
				}
			}
		}
		return fecha;
	}



/**
* El Método datosOrdenCompra2 nos regresa los Datos de la Orden de Compra seleccionada.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet datosOrdenCompra2(String clave) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(clave);
			String query = ("SELECT * FROM orden_compra WHERE ClaveOrden = '"+cla+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, datosOrdenCompra2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, datosOrdenCompra2 ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameComprasXProveedorXTiempo2 nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComprasXProveedorXTiempo2(){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT orden_compra.claveOrden, orden_compra.fechaEntrega, orden_compra.factura, orden_compra.total, orden_compra.pago, CONCAT(usuarios.Nombre,' ',usuarios.APaterno) AS Nombre, orden_compra.Entrega FROM orden_compra, usuarios WHERE orden_compra.claveProveedor = '"+claveProveedor +"' AND orden_compra.activo = 1 AND (orden_compra.fechaEntrega BETWEEN '"+fechaInicial+"' AND  '"+fechaFinal+"') AND usuarios.ClaveU = orden_compra.usuario ORDER BY  orden_compra.fechaEntrega DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameComprasXProveedorXTiempo 2");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameComprasXProveedorXTiempo2 ");
			e.printStackTrace();
		}
		return rs;
	}
































/**
* El Método datosImpCheque nos regresa los Datos del cheque
*
*  @return rs ResultSet con los Datos del cheque.
*/
	public ResultSet datosImpCheque(String consePago) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT pagos.fechaPago, proveedores.nombre, pagos.monto  FROM pagos, proveedores  WHERE pagos.consecutivo = "+consePago +" AND proveedores.rfc = pagos.claveProveedor");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, datosImpCheque ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, datosImpCheque ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameFacturasCheque nos regresa el/los documento(s) que avalan una Compra
*
*  @return String con los documentos que avalan una compra.
*/
	public String dameFacturasCheque(String consePago) throws SQLException, Exception {
		ResultSet rs = null;
		String imprime = "Pago de la(s) factura(s):   ";
		String claveDeCompra = "";
		String facturas = "";
		try{
			con = new ConexionBD();
			Statement stmt1 = con.creaStatement();
			Statement stmt2 = con.creaStatement();
			Statement stmt3 = con.creaStatement();
			String query1 = "SELECT orden_compra.factura, orden_compra.claveOrden FROM orden_compra,  pagos WHERE pagos.consecutivo = "+consePago +" AND orden_compra.claveOrden = pagos.claveOrden";
			rs = stmt1.executeQuery(query1);
			while(rs.next()){
				claveDeCompra = rs.getString("claveOrden");
				facturas = rs.getString("factura");
			}
			imprime +=" \n"+facturas;
			String query2 = ("SELECT  facturas.factura FROM facturas, pagos WHERE pagos.consecutivo = "+consePago +" AND facturas.Clave_Orden = pagos.claveOrden");
			rs=stmt2.executeQuery(query2);
			while(rs.next()){
				imprime += "," +rs.getString("factura");
			}

		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameFacturasCheque ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameFacturasCheque ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameFacturasCheque ");
					q.printStackTrace();
				}
			}
		}
		return imprime;
	}



/**
* El Método dameFacturasRemisionesAdicionales nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameFacturasRemisionesAdicionales(String claveDeOrden){
		ResultSet rs = null;
		try{
			String query = ("SELECT factura FROM facturas WHERE Clave_Orden = '"+claveDeOrden  +"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameFacturasRemisionesAdicionales ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameFacturasRemisionesAdicionales ");
			e.printStackTrace();
		}
		return rs;
	}




/**
* El Método dameComprasXProveedorXTiempo nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComprasXProveedorXTiempo(){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT orden_compra.claveOrden, orden_compra.fechaEntrega, orden_compra.factura, orden_compra.total, CONCAT(usuarios.Nombre,' ',usuarios.APaterno) AS Nombre, orden_compra.Entrega FROM orden_compra, usuarios WHERE orden_compra.claveProveedor = '"+claveProveedor +"' AND orden_compra.activo = 1 AND (orden_compra.fechaEntrega BETWEEN '"+fechaInicial+"' AND  '"+fechaFinal+"') AND usuarios.ClaveU = orden_compra.usuario ORDER BY  orden_compra.fechaEntrega DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameComprasXProveedorXTiempo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameComprasXProveedorXTiempo ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método dameComprasFaltantesXProveedorXTiempo nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComprasFaltantesXProveedorXTiempo(){
		ResultSet rs = null;
		try{
			String query = ("SELECT orden_compra.claveOrden, proveedores.rfc, orden_compra.fechaEntrega, orden_compra.total, orden_compra.Entrega FROM orden_compra, proveedores WHERE orden_compra.activo = 1 AND (orden_compra.Entrega = 0 OR orden_compra.Entrega = 1) AND orden_compra.claveProveedor LIKE '"+claveProveedor +"' AND proveedores.rfc = orden_compra.claveProveedor AND fechaEntrega BETWEEN '"+fechaInicial+"' AND '"+fechaFinal+"' ORDER BY orden_compra.fechaEntrega DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameComprasFaltantesXProveedorXTiempo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameComprasFaltantesXProveedorXTiempo ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método todasLasComprasXProveedores nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet todasLasComprasXProveedores(String claveProveedor){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveOrden, fecha, total, pago FROM orden_compra WHERE claveProveedor = '"+claveProveedor +"' AND activo = 1 AND entrega != '0'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasComprasXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasComprasXProveedores ");
			e.printStackTrace();
		}
		return rs;
	}



 /**
 * El método cambiaSaldo se encarga de actualizar campo Estatus a Baja en la Base de Datos de una Orden de Compra.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
   public void cambiaSaldo(String proveedor, String claveOrden) throws SQLException, Exception {
	 		con = new ConexionBD();
	 		con.cancelaAutoCommit();
			boolean resultado = false;
			int cla = cambiaAInt(claveOrden);
			ResultSet rs0 = null;
			String rfc = "";
			double importe = 0.0;
          try  {
			   String datosPro = "SELECT claveProveedor, total FROM orden_compra WHERE claveOrden = "+cla+"";
			   Statement dame = con.creaStatement();
			   rs0 = dame.executeQuery(datosPro);
			   while(rs0.next()){
				   rfc = rs0.getString("claveProveedor");
				   importe = rs0.getDouble("total");
			   }
			   String cambiaSaldo = "UPDATE proveedores SET saldoDisponible = saldoDisponible+"+importe+" WHERE rfc = '"+rfc+"' ";
			   Statement cambiar = con.miConnection.createStatement();
               cambiar.execute(cambiaSaldo);


             } catch (SQLException sqle) {
					con.realizaRollback();
					sqle.printStackTrace();
               		error = "SQLException: Could not execute the query cambiaSaldo.";
               throw new SQLException(error);
             } catch (Exception e) {
					con.realizaRollback();
					error = "Ocurrió una excepción mientras se actualizaba cambiaSaldo.";
               		throw new Exception(error);
             }
             finally{
 				try{
					con.habilitaAutoCommit();
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerCompra metodo cambiaSaldo");
 			   		q.printStackTrace();
 			 	}
 		   }
     }




	public ResultSet todasLasOrdenesXProveedoresAgregada(){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT orden_compra.ClaveOrden, orden_compra.Fecha, orden_compra.total FROM orden_compra, productos_orden WHERE orden_compra.ClaveProveedor = '"+claveProveedor +"' AND orden_compra.activo = 1 AND productos_orden.ClaveOrden = orden_compra.ClaveOrden AND productos_orden.Cantidad > productos_Orden.Llegan");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedores ");
			e.printStackTrace();
		}
		return rs;
	}



 /**
 * El método addFactura se encarga de asignar una Factura a la Orden de Compra.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
	public boolean addFactura(String usuario) throws SQLException, Exception {
		String tiene = tieneFactura2();
		ResultSet produc = todosProductosOrden();
		con = new ConexionBD();
		boolean resultado = false;
		try  {
			//Date fec = cambiaADate(fechaCompra);
			int cla = cambiaAInt(claveOrden);
			// System.out.println("La fexcha: "+fechaCompra);
			if(tiene.equalsIgnoreCase("0")){
				//System.out.println("No tiene");
				String queryString = "UPDATE orden_compra SET factura = '"+compra+"', fechaEntrega = '"+fechaCompra+"', Entrega = 1, usuario = '"+usuario+	"' WHERE ClaveOrden = "+cla+" ";
				//System.out.println("query: "+queryString);
				//System.out.println("queryString: "+queryString);
				Statement stmt = con.miConnection.createStatement();
				resultado = stmt.execute(queryString);
				if(resultado == false)
					resultado = true;
				else
					resultado = false;
			}
			else{
				//System.out.println("Si tiene");
				PreparedStatement updateFacturas;
				updateFacturas = con.miConnection.prepareStatement("insert into facturas values(?,?,?);");
				updateFacturas.setInt(1, cla);
				updateFacturas.setString(2, compra);
				updateFacturas.setString(3, fechaCompra);
				updateFacturas.execute();
				resultado = true;
			}
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query addFactura.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Ocurrió una excepción mientras se actualizaba addFactura.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerCompra metodo addFactura");
				q.printStackTrace();
			}
		}
		return resultado;
	}


 /**
 * El método actualiza_llego1 se encarga de asignar las Cantidades recibidas en los pordutos normales.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
   public boolean actualiza_llego1() throws SQLException, Exception {
 			con = new ConexionBD();
			boolean resultado = false;
             try  {
				 int cla = cambiaAInt(claveOrden);
				int cantNum = cambiaAInt(cantNumProductos);
				String cambio = "";

				for (int i =1; i<=cantNum; i++){

					int canti = cambiaAInt(ArrayCantidad[i]);

					//System.out.println("Unidad: "+ArrayUnidad[i]);

					String queryString = "UPDATE productos_orden SET Llegan = (Llegan+"+canti+") WHERE ClaveOrden = "+cla+" AND ClaveProducto = '"+ArrayProducto[i]+"'";
 					//System.out.println("queryString Productos: "+queryString);

               		Statement stmt = con.miConnection.createStatement();
               		resultado = stmt.execute(queryString);

               		if(resultado == false)
               			resultado = true;
               		else
               			resultado = false;
				}
             } catch (SQLException sqle) {
 				sqle.printStackTrace();
               error = "SQLException: Could not execute the query actualiza_llego1."+sqle;
               throw new SQLException(error);
             } catch (Exception e) {
               error = "Ocurrió una excepción mientras se actualizaba actualiza_llego1."+e;
               throw new Exception(error);
             }
             finally{
 				try{
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerCompra metodo actualiza_llego1");
 			   		q.printStackTrace();
 			 	}
 		   }
		return resultado;
     }



/**
* El método Facturas_Dia se encarga de enviar la información de las Facturas realizadas para un periodo de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos los datos de las Facturas
*/

	public ResultSet Facturas_Dia(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(fecha.length() < 8){
			fecha = fecha+"-%%";
		}
		try  {
			String queryString = ("SELECT * FROM orden_compra WHERE fecha like '" +fecha+"' AND activo = 1 AND factura != '0' ORDER BY claveOrden");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Facturas_Dia.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Facturas_Dia.";
			throw new Exception(error);
		}
	return rs;
	}



/**
* El método Facturas_Semana se encarga de enviar la información de Facturas para una periodo de una semana de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos la información de las Facturas
*/

	public ResultSet Facturas_Semana(String semana, String fecha) throws SQLException, Exception {
		//System.out.println("Me llego : " +semana +", " +fecha);
		String diaInicial = "01";
		String diaFinal = "08";
		ResultSet rs = null;
		con = new ConexionBD();
		if (semana.equalsIgnoreCase("02")){
			diaInicial = "08";
			diaFinal = "16";

		}
		else if (semana.equalsIgnoreCase("03")){
			diaInicial = "16";
			diaFinal = "24";

		}
		else if (semana.equalsIgnoreCase("04")) {
			diaInicial = "24";
			diaFinal = "31";

		}
		try  {
			String queryString = ("SELECT * FROM orden_compra WHERE fecha >= '" +fecha+"-"+diaInicial+"%%%%%%%%%%%' AND fecha <'"+fecha+"-"+diaFinal+"%%%%%%%%%%%'  AND activo = 1 AND factura != '0' ORDER BY claveOrden");
			//System.out.println(queryString);
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Facturas_Semana.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Facturas_Semana.";
			throw new Exception(error);
		}
	return rs;
	}


 public ResultSet Facturas_Mes(String fecha0) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println(fecha1);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT * FROM orden_compra WHERE fecha like '"+fecha0+"%%%%%%%%%' AND activo = 1 AND factura != '0' ORDER BY claveOrden");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Facturas_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Facturas_Mes.";
          throw new Exception(error);
        }
        return rs;
  }



/**
* El Método tieneFactura nos regresa si la orden de compra tiene factura.
*
*  @return rs ResultSet con la cantidad de Productos de una Orden de Compra.
*/
	public int tieneFactura(){
		ResultSet rs = null;
		String aver = new String();
		int resul = 0;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT factura FROM orden_compra WHERE ClaveOrden = "+cla+" ");
			//System.out.println("A ver si tiene: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				aver = rs.getString("factura");
			}
			//System.out.println("antes del entero: "+aver);
			resul = cambiaAInt(aver);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, tieneFactura ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, tieneFactura ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, tieneFactura ");
					q.printStackTrace();
				}
			}
		}
		//System.out.println("Regreso: "+resul);
		return resul;
	}




/**
* El Método datosProveedores nos regresa todos los Proveedores registrados.
*
*  @return ResultSet con los proveedores
*/
	public ResultSet datosProveedores(){
		ResultSet rs = null;
		try{
			String query = ("SELECT Clave_Proveedor, Nombre_Proveedor FROM proveedores WHERE Habilitado = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, datosProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, datosProveedores ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método todasLasFacturasXProveedores nos regresa todas las Facturas de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Facturas de Compra.
*/
	public ResultSet todasLasFacturasXProveedores(){
		ResultSet rs = null;
		try{
			String query = ("SELECT ClaveOrden,Compra,FechaCompra FROM orden_compra WHERE ClaveProveedor = '"+claveProveedor +"' AND Estatus = 1 AND Compra != '0' ORDER BY FechaCompra");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasFacturasXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasFacturasXProveedores ");
			e.printStackTrace();
		}
		return rs;
	}




/**
* El Método dameCantidadOriginalFactura nos regresa la Cantidad del Producto correspondientes a una Factura.
*
*  @return aver Int con la cantidad de Productos de una Factura.
*/
	public String dameCantidadOriginalFactura(){
		ResultSet rs = null;
		String aver = new String();
		try{
			int cla = cambiaAInt(claveOrden);
			int unid = cambiaAInt(tempUnidad);
			String query = ("SELECT Cantidad FROM productos_orden WHERE ClaveOrden = "+cla+" AND  ClaveProducto = '"+tempProducto+"' AND Unidad = "+unid+"");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				aver = rs.getString("Cantidad");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameCantidadOriginalFactura ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameCantidadOriginalFactura ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameCantidadOriginalFactura ");
					q.printStackTrace();
				}
			}
		}
		return aver;
	}


/**
* El Método todasLasComprasXProveedores nos regresa todas las Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Compras.
*/
	public ResultSet todasLasComprasXProveedores(){
		ResultSet rs = null;
		try{
			String query = ("SELECT * FROM orden_compra WHERE ClaveProveedor = '"+claveProveedor +"' AND Estatus = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedores ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método Lista_Precios nos regresa la Lista de Precios para Ventas.
*
*  @return rs ResultSet con la Lista de Precios.
*/
	public ResultSet Lista_Precios(){
		ResultSet rs = null;
		try{

			String query = ("SELECT pre.*, propv.Clave_Producto, ma.Nombre_Marca, li.Nombre_Linea, su.Nombre_Sublinea FROM precio_prod_x_prov pre, producto_proveedor propv, productos pro, marca ma, sublinea su, lineas li WHERE propv.ClaveP_P = pre.ClaveP_P AND pre.Estatus = 1 AND pro.Clave_Producto = propv.Clave_Producto AND ma.Clave_Marca = pro.Clave_Marca AND su.Clave_Sublinea = pro.Clave_Sublinea AND su.Clave_Linea = pro.Clave_Linea AND li.Clave_Linea = pro.Clave_Linea ORDER BY propv.Clave_Producto");
			//System.out.println("query: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, Lista_Precios ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, Lista_Precios ");
			e.printStackTrace();
		}
		return rs;
	}




 public ResultSet Proveedor_Mes(String fecha0, String proveedor) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println(fecha1);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT ClaveOrden, Total, FechaCompra, Compra FROM orden_compra WHERE FechaCompra like '"+fecha0+"%%%%%%%%%' AND Estatus = 1 AND Compra != '0' AND ClaveProveedor = '"+proveedor+"' ORDER BY FechaCompra");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Proveedor_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Proveedor_Mes.";
          throw new Exception(error);
        }
        return rs;
  }



 public ResultSet Entrega_Mes(String fecha0, String entrega) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println("Antes del query");
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = (
          "SELECT ord.* FROM orden_compra ord WHERE ord.FechaCompra like '"+fecha0+"%%%%%%%%%' AND ord.Estatus = 1 AND ord.Compra != '0' AND ord.Entrega = '"+entrega+"' ORDER BY  ord.ClaveOrden");
       //   System.out.println("query: "+queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
       //   System.out.println("Despues del ResultSet");
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Entrega_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Entrega_Mes.";
          throw new Exception(error);
        }
       return rs;
  }



 public void cierraConexion() throws SQLException, Exception
 {
	 if(con != null){
		try{
			con.cierraConexion();
		}
		catch (Exception q){
		System.out.println("Error al momento de cerrar conexion en ManagerPersonal, con ");
		q.printStackTrace();
		}
	}
	 if(con2 != null){
		try{
			con2.cierraConexion();
		}
		catch (Exception q){
		System.out.println("Error al momento de cerrar conexion en ManagerPersonal, con2 ");
		q.printStackTrace();
		}
	}
}




// Funciones Genericas de Transformacion:

/**
* El método cambiaADate se encarga de transformar a un Date una variables en formato String.
*  	@param 	fecha	String a tranformar a Date.
*	@return Date	double con el valor de la variable.
*/
	public Date cambiaADate(String fecha) {
		java.sql.Date elDia;
		try {
			elDia = java.sql.Date.valueOf(new String(fecha));
		}
		catch(IllegalArgumentException iae){
			elDia = java.sql.Date.valueOf(new String("9999-10-10"));
		}
		return elDia;
	}


	public int cambiaAInt(String variable) throws Exception{
		int valor;
		try{
			valor = (Integer.parseInt(variable));
		}
		catch(NumberFormatException nfe){
			valor = 0;
		}
			return valor;
	}


	public String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}

	public double cambiaADouble(String variable) throws Exception{
		double valor;
		if(variable == null){
			variable = "";
		}
		try{
			Double val = (Double.valueOf(variable));
			valor = val.doubleValue();
		}
		catch(NumberFormatException nfe){
			valor =0;
		}
			return valor;
	}


	public String acortaLongitud(String muchosDecimales){
		StringBuffer sb = new StringBuffer (muchosDecimales);
		if(sb.indexOf(".") != -1){
			String decimales=sb.substring(sb.indexOf("."));
			String decima;
			decima = sb.substring(0, sb.indexOf("."));
			sb.delete(0,sb.length());
			if (decimales.length()>3){
				decimales = decimales.substring(0,3);
			}
			if(decimales.length()<=2){
				decimales = decimales+"0";
			}
			sb.append(decima);
			sb.append(decimales);
		}
		return sb.toString();
	}

	public String formatoDinero(String formato){
		//System.out.println("formato es: "+formato);
		StringBuffer losEnteros = new StringBuffer(dameEnteros(formato));
		String losDecimales = dameDecimales(formato);
		if(losEnteros.length() == 8){
			losEnteros.insert(2,',');
			losEnteros.insert(6,',');
		}
		else if(losEnteros.length() == 7){
			losEnteros.insert(1,',');
			losEnteros.insert(5,',');
		}
		else if(losEnteros.length() == 4 ){
			losEnteros.insert(1,',');
		}
		else if(losEnteros.length() == 5 ){
			losEnteros.insert(2,',');
		}
		else if(losEnteros.length() == 6 ){
			losEnteros.insert(3,',');
		}
		//System.out.println("Sale: "+losEnteros.toString()+"."+losDecimales);
		return losEnteros.toString()+"."+losDecimales;
	}

	public String dameDecimales(String enteros){
		StringBuffer sb = new StringBuffer (enteros);
		boolean existieron = false;
		if(sb.indexOf(".") != -1){
			sb=sb.delete(0, sb.indexOf(".")+1);
			existieron = true;
		}
		if (!existieron){
			sb = new StringBuffer ("00");
		}
		return sb.toString();
	}

	public String dameEnteros(String enteros){
		StringBuffer sb = new StringBuffer (enteros);
		if(sb.indexOf(".") != -1){
			sb=sb.delete(sb.indexOf("."),sb.length() );
		}
		return sb.toString();
	}

	private String checkSize (String revisa){
		StringBuffer verificador = new StringBuffer(revisa);
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
	}
}