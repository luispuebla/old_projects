package com.vas.bd;

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


public class ManagerVenta {

	private String claveCliente = new String("");
	private String observaciones = new String("");
	private String subtotal = new String("");
	private String iva = new String("");
	private String total = new String("");
	private String fechaEntrega = new String("");
	private String fechaAlta = new String("");
	private String documento = new String("");
	private String numFac = new String("");
	private String cantNumProductos = new String("");
	private String[] ArrayCantidad   = new String[2];
	private	String[] ArrayProducto   = new String[2];
	private	String[] ArrayCunidad   = new String[2];
	private	String[] ArrayImporte   = new String[2];
	private String[] ArrayRegalos = new String[2];
	private	String prod1 = new String("");
	private	String prod2 = new String("");
	private	String prod3 = new String("");
	private	String can1 = new String("");
	private	String can2 = new String("");
	private	String can3 = new String("");
	private	String repartidor = new String("");
	private String claveProducto = new String("");
	private String claveVenta = new String("");
	private String fechaInicial = new String("");
	private String fechaFinal = new String("");
	private String error = new String("");
	private	String usuario = new String("");
	private TimeStamp tiempo;
	private ConexionBD con;
	private ConexionBD con2;


	public void setDocumento(String documento){
				this.documento = documento;
	}

	public void setClaveVenta(String claveVenta){
				this.claveVenta = claveVenta;
	}

	public void setRepartidor(String repartidor){
				this.repartidor = repartidor;
	}

	public void setNumFac(String numFac){
				this.numFac = numFac;
	}

	public void setClaveCliente(String claveCliente){
				this.claveCliente = claveCliente;
	}

	public void setObservaciones(String observaciones){
				this.observaciones = observaciones;
	}

	public void setSubtotal(String subtotal){
			this.subtotal = subtotal;
	}

	public void setIva(String iva){
			this.iva = iva;
	}

	public void setTotal(String total){
			this.total = total;
	}

	public void setFechaEntrega(String fechaEntrega){
			this.fechaEntrega = fechaEntrega;
	}

	public void setFechaAlta(String fechaAlta){
			this.fechaAlta = fechaAlta;
	}

	public void setCantNumProductos(String cantNumProductos){
			this.cantNumProductos = cantNumProductos;
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

	public void setCan1(String can1){
				this.can1 = can1;
		}

	public void setCan2(String can2){
				this.can2 = can2;
		}

	public void setCan3(String can3){
				this.can3 = can3;
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

	public void setUsuario(String usuario){
				this.usuario = usuario;
	}

	public void setFechaInicial(String fechaInicial){
		this.fechaInicial = fechaInicial;
	}

	public void setFechaFinal(String fechaFinal){
		this.fechaFinal = fechaFinal;
	}

/**
* El método tieneIva verifica que el Producto agrave IVA.
*	@return bandera 	Boolean si es igual 0 la Línea no exite y si es igual a 1 la Línea se encuentra en la Base de Datos.
*/
public boolean tieneIva(String producto) throws SQLException, Exception     {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		ConexionBD con2 = new ConexionBD();

  	  if (con2.miConnection !=null) {
  	  	try {

  	  		st = con2.creaStatement();
  	  		rs = st.executeQuery("select * from productos where claveProducto = '"+producto+"'");
  	  		while(rs.next()){

  	  			if(rs.getString("iva").equalsIgnoreCase("1")) {
  	  				bandera = true;
  	  				}
  	  		}

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
  	  //System.out.println("Tiene iva?: "+bandera);
  	  return bandera;
  }


/**
* El Método dameCostoProducto nos regresa el nombre del Cliente al que correspondio una venta.
* @return String correspondiente al listado de los Precios registrados para un producto.
*/
	public double dameCostoProducto(String producto){
		ResultSet rs = null;
		double costo = 0.0;
		try{
			String query = ("SELECT costo FROM productos WHERE claveProducto ='"+producto +"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				costo = rs.getDouble("costo");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameCostoProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameCostoProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, dameCostoProducto ");
					q.printStackTrace();
				}
			}
		}
		return costo;
	}


/**
* El Método datosClienteImpTabla nos regresa el nombre del Cliente al que correspondio una venta.
* @return String correspondiente al listado de los Precios registrados para un producto.
*/
	public String datosClienteImpTabla(String claveDeVenta){
		ResultSet rs = null;
		String elNombre = "";
		try{
			String query = ("SELECT clientes.nombre FROM clientes, ventas WHERE ventas.claveVenta="+claveDeVenta +" AND clientes.rfc = ventas.claveCliente");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				elNombre = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, datosClienteImpTabla ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, datosClienteImpTabla ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, datosClienteImpTabla ");
					q.printStackTrace();
				}
			}
		}
		return elNombre;
	}

/**
* El Método datosFechaEImpTabla nos regresa el nombre del Cliente al que correspondio una venta.
* @return String correspondiente al listado de los Precios registrados para un producto.
*/
	public String datosFechaEImpTabla(String claveDeVenta){
		ResultSet rs = null;
		String elNombre = "";
		try{
			String query = ("SELECT fechaEntrega FROM  ventas WHERE claveVenta= "+claveDeVenta);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				elNombre = rs.getString("fechaEntrega");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, datosFechaEImpTabla ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, datosFechaEImpTabla ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, datosFechaEImpTabla ");
					q.printStackTrace();
				}
			}
		}
		return elNombre;
	}

/**
* El Método numRemisionImp nos regresa el numero de remision de una venta.
* @return String correspondiente al listado de los Precios registrados para un producto.
*/
	public String numRemisionImp(String claveDeVenta){
		ResultSet rs = null;
		String elNombre = "";
		try{
			String query = ("SELECT remision FROM  ventas WHERE claveVenta= "+claveDeVenta);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				elNombre = rs.getString("remision");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, numRemisionImp ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, numRemisionImp ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, numRemisionImp ");
					q.printStackTrace();
				}
			}
		}
		return elNombre;
	}


/**
* El Método hayProductosV nos informa si en la venta hya productos vendidos.
* @return boolean correspondiente al resultado de existencia de Productos para Venta
*/
	public boolean hayProductosV(String claveDeVenta){
		ResultSet rs = null;
		boolean resultado = false;
		try{
			String query = ("SELECT claveVenta FROM productos_venta WHERE claveVenta="+claveDeVenta );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getString("claveVenta").equalsIgnoreCase(claveDeVenta)){
					resultado = true;
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, hayProductosV ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, hayProductosV ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, hayProductosV ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}

/**
* El Método hayProductosO nos informa si en la venta hya productos obsequiados.
* @return boolean correspondiente al resultado de existencia de Productos para Venta
*/
	public boolean hayProductosO(String claveDeVenta){
		ResultSet rs = null;
		boolean resultado = false;
		try{
			String query = ("SELECT claveVenta FROM regalos_venta WHERE claveVenta="+claveDeVenta );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getString("claveVenta").equalsIgnoreCase(claveDeVenta)){
					resultado = true;
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, hayProductosO ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, hayProductosO ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, hayProductosO ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}



/**
* El Método datosVentaClie nos regresa la informacion de un cliente para imprimir su factura.
* @return ResultSet correspondiente al listado de los productos vendidos registrados.
*/
	public ResultSet datosVentaClie(String claveDeVenta){
		ResultSet rs = null;
		try{
			String query = ("SELECT clientes.rfc, clientes.nombre, CONCAT(clientes.direccion,', Col. ',clientes.colonia,', Del. ', clientes.delegacion,', C.P. ', clientes.CP)AS direccion, clientes.ciudad FROM clientes, ventas WHERE ventas.claveVenta = "+claveDeVenta +" AND clientes.rfc = ventas.claveCliente");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, datosVentaClie ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, datosVentaClie ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método productosVImp nos regresa el Listado de los productos Vendidos para una venta.
* @return ResultSet correspondiente al listado de los productos vendidos registrados.
*/
	public ResultSet productosVImp(String claveDeVenta){
		ResultSet rs = null;
		try{
			String query = ("SELECT productos_venta.ClaveProducto, (productos.iva)AS GravaIva,  productos_venta.Cantidad, CONCAT(linea.nombre,' ', marca. nombre,' ', productos.descripcion) AS nombre, productos_venta.Costo, productos_venta.Importe, productos_venta.Llegan, (productos_venta.Cantidad-productos_venta.Llegan)AS Faltantes FROM productos, linea, marca, productos_venta WHERE productos_venta.claveVenta = "+claveDeVenta +" AND productos.claveProducto = productos_venta.ClaveProducto AND linea.clave = productos.linea AND marca.clave=productos.marca ");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, productosVImp ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, productosVImp ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método productosOImp nos regresa el Listado de los productos Obsequiados para una venta.
* @return ResultSet correspondiente al listado de los productos obsequiados registrados.
*/
	public ResultSet productosOImp(String claveDeVenta){
		ResultSet rs = null;
		try{
			String query = ("SELECT regalos_venta.ClaveProducto,  regalos_venta.Cantidad, CONCAT(linea.nombre,' ', marca. nombre,' ', productos.descripcion) AS nombre,  regalos_venta.Llego, (regalos_venta.Cantidad-regalos_venta.Llego) AS Faltantes   FROM productos, linea, marca, regalos_venta WHERE regalos_venta.claveVenta = "+claveDeVenta +" AND productos.claveProducto = regalos_venta.ClaveProducto AND linea.clave = productos.linea AND marca.clave=productos.marca ");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, productosOImp ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, productosOImp ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método datosVentaImp nos regresa los datos extras de la impresion de una venta tales como subtotal, iva, total y observaciones
* @return ResultSet correspondiente al listado de datos extras de una venta.
*/
	public ResultSet datosVentaImp(String claveDeVenta){
		ResultSet rs = null;
		try{
			String query = ("SELECT fechaAlta, fechaEntrega, observaciones, subtotal, iva, total, repartidor FROM ventas WHERE claveVenta = "+claveDeVenta +" AND activo = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, datosVentaImp ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, datosVentaImp ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método preciosDeProducto nos regresa el Listado de los Precios para un producto en especifico
* @return ResultSet correspondiente al listado de los Precios registrados para un producto.
*/
	public ResultSet preciosDeProducto(String claveDeProducto){
		ResultSet rs = null;
		try{
			String query = ("SELECT precio1, precio2, precio3, precio4, precio5 FROM productos WHERE claveProducto ='"+claveDeProducto +"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, preciosDeProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, preciosDeProducto ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método precioProducto  nos regresa el precio de un producto de acuerdo al tipo de Cliente
*
*  @return String con el nombre de la Linea
*/
	public String precioProducto(String claveDeProducto, String claveDeCliente){
		ResultSet rs = null;
		ResultSet rs2 = null;
		String costo = null;
		int tipoCli = 0;
		String tipoClie = "";
		try{
						con = new ConexionBD();
			String query = ("SELECT tipo FROM clientes WHERE rfc = '"+claveDeCliente +"'");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				tipoCli = rs.getInt ("tipo");
			}
			if(tipoCli == 1){
				tipoClie = "precio1";
			}
			else if(tipoCli == 2){
				tipoClie = "precio2";
			}
			else if(tipoCli == 3){
				tipoClie = "precio3";
			}
			else if(tipoCli == 4){
				tipoClie = "precio4";
			}
			else{
				tipoClie = "precio5";
			}
			String query2 = ("SELECT "+tipoClie  +" FROM productos WHERE claveProducto = '"+claveDeProducto +"'");
			Statement stmt2 = con.creaStatement();
			rs2 = stmt.executeQuery(query2);
			while (rs2.next()){
				costo = rs2.getString (tipoClie);
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, precioProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, precioProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, precioProducto ");
					q.printStackTrace();
				}
			}
		}
		return costo;
	}


/**
* El Método dameCreditoDisponible  nos dice cuanto credito tiene disponible el cliente.
*
*  @return String cantidad con el Credito disponible
*/
	public String dameCreditoDisponible(String claveDeCliente){
		ResultSet rs = null;
		String cantidad = "";
		try{
			con = new ConexionBD();
			String query = ("SELECT saldoDisponible, credito FROM clientes WHERE rfc = '"+claveDeCliente +"' AND activo = 1");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getDouble("credito") == 0){
					cantidad = "No maneja crédito";
				}
				else{
					cantidad = formatoDinero(rs.getString("saldoDisponible"));
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameCreditoDisponible ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameCreditoDisponible ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, dameCreditoDisponible ");
					q.printStackTrace();
				}
			}
		}
		return cantidad;
	}


/**
* El Método estatusCredito  nos informa si el Cliente cuenta con credito para que se le realice una venta.
*
*  @return boolean con el estatus true -- Si hay credito, false --> Sobrepaso su linea de credito.
*/
	public boolean estatusCredito(String claveDeCliente){
		ResultSet rs = null;
		boolean resultado = false;
		try{
			con = new ConexionBD();
			String query = ("SELECT saldoDisponible, credito FROM clientes WHERE rfc = '"+claveDeCliente +"' AND activo = 1");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getDouble("saldoDisponible") > 0.00 ||  rs.getDouble("credito") == 0.00 ){
					resultado = true;
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, estatusCredito ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, estatusCredito ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, estatusCredito ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}

/**
* El Método datosClientesActivos nos regresa el Listado de los Clientes Activos.
*
* @return ResultSet correspondiente al listado de los Clientes Activos.
*/
	public ResultSet datosClientesActivos(){
		ResultSet rs = null;
		try{
			String query = ("SELECT rfc, nombre FROM clientes WHERE activo = 1 ORDER BY nombre");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, datosClientesActivos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, datosClientesActivos ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método dameNombreProducto  nos da la descripción de un producto de acuerdo a su linea, marca y descripcion
*
*  @return String con la descripcion completa del producto
*/
	public String dameNombreProducto(String claveDeProducto){
		ResultSet rs = null;
		String nombreP = null;
		try{
			String query = ("SELECT CONCAT(linea.nombre,' ',marca.nombre,' ',productos.descripcion) AS descripcion FROM productos, linea, marca WHERE productos.claveProducto = '"+claveDeProducto+"' AND marca.clave = productos.marca AND linea.clave = productos.linea");
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
* El Método todosLosProductosConInv  nos da el listado de todos los productos con su existencia en Inventarios
*
*  @return ResultSet con el listado correspondiente.
*/
	public ResultSet todosLosProductosConInv() throws SQLException, Exception{
		ResultSet rs = null;
		try{
			String query = ("SELECT productos.claveProducto, productos.tipo, CONCAT(linea.nombre,' ',marca.nombre,' ',productos.descripcion) AS descripcion, productos.existencia, producto_obsequio.existencia AS ExistenciaOb FROM linea, marca, productos LEFT JOIN producto_obsequio ON producto_obsequio.claveproducto = productos.claveProducto WHERE productos.activo=1 AND marca.clave = productos.marca AND linea.clave = productos.linea ORDER BY productos.claveProducto");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, todosLosProductosConInv ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, todosLosProductosConInv ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameVentasXClienteXTiempo  nos da el listado de todos los productos con su existencia en Inventarios
*
*  @return ResultSet con el listado correspondiente.
*/
	public ResultSet dameVentasXClienteXTiempo() throws SQLException, Exception{
		ResultSet rs = null;
		try{
			String query = ("SELECT ventas.claveVenta, ventas.claveCliente, ventas.fechaEntrega, ventas.fechaAlta, ventas.total, ventas.Entrega, ventas.tipo, ventas.pago, ventas.factura, ventas.remision FROM ventas WHERE ventas.claveCliente LIKE  '"+claveCliente +"' AND ventas.activo = 1 AND (ventas.fechaAlta BETWEEN  '"+fechaInicial+"' AND '"+fechaFinal+"') ORDER BY  ventas.fechaAlta DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameVentasXClienteXTiempo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameVentasXClienteXTiempo ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método todosLosProductosModInv  nos da el listado de todos los productos con su existencia en Inventarios
*
*  @return ResultSet con el listado correspondiente.
*/
	public ResultSet todosLosProductosModInv() throws SQLException, Exception{
		ResultSet rs = null;
		try{
			String query = ("SELECT productos.claveProducto, productos.tipo, CONCAT(linea.nombre,' ',marca.nombre,' ',productos.descripcion) AS descripcion, productos.existencia, producto_obsequio.existencia AS ExistenciaOb FROM linea, marca, productos LEFT JOIN producto_obsequio ON producto_obsequio.claveproducto = productos.claveProducto WHERE productos.activo=1 AND marca.clave = productos.marca AND linea.clave = productos.linea ORDER BY productos.claveProducto");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, todosLosProductosModInv ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, todosLosProductosModInv ");
			e.printStackTrace();
		}
		return rs;
	}


	public void cierraConexion() throws SQLException, Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ManagerVenta ");
				q.printStackTrace();
			}
		}
	}


/**
* El Método dameTipoDeUnidad  nos regresa el tipo de Unidad en que se maneja el producto
*
*  @return String con el nombre del tipo de unidad.
*/
	public String dameTipoDeUnidad(String claveDeProducto){
		ResultSet rs = null;
		String tipo = "Cajas";
		try{
			String query = ("SELECT tipo FROM productos WHERE claveProducto = '"+claveDeProducto+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getInt("tipo") == 2){
					tipo = "Kg.";
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameTipoDeUnidad ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameTipoDeUnidad ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, dameTipoDeUnidad ");
					q.printStackTrace();
				}
			}
		}
		return tipo;
	}

/**
* El Método dameCantidadEnInventarioV  nos regresa la existencia para un producto en especifico dentro del Inventario para Ventas.
*
*  @return String con el nombre de la Linea
*/
	public String dameCantidadEnInventarioV(String claveDeProducto){
		ResultSet rs = null;
		String cantidadI = null;
		try{
			String query = ("SELECT existencia FROM productos WHERE claveProducto = '"+claveDeProducto+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				cantidadI = rs.getDouble("existencia")+"";
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameCantidadEnInventarioV ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameCantidadEnInventarioV ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, dameCantidadEnInventarioV ");
					q.printStackTrace();
				}
			}
		}
		return cantidadI;
	}


/**
* El Método dameCantidadEnInventarioO  nos regresa la existencia para un producto en especifico dentro del Inventario para Ventas.
*
*  @return String con el nombre de la Linea
*/
	public String dameCantidadEnInventarioO(String claveDeProducto){
		ResultSet rs = null;
		int cantidadI = 0;
		try{
			String query = ("SELECT existencia FROM producto_obsequio WHERE claveproducto = '"+claveDeProducto+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				cantidadI = rs.getInt("existencia");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameCantidadEnInventarioO ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameCantidadEnInventarioO ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, dameCantidadEnInventarioO ");
					q.printStackTrace();
				}
			}
		}
		return cantidadI+"";
	}

/**
* El Método dameNombreCliente nos regresa el Nombre del Cliente solicitado.
*
* @return String correspondiente al nombre vinculado a la Clave del cliente dado.
*/
	public String dameNombreCliente(){
		String claveP = null;
		ResultSet rs = null;
		try{
			String query = ("SELECT nombre FROM clientes WHERE rfc ='"+claveCliente+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				claveP = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameNombreCliente ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameNombreCliente ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, dameNombreCliente ");
					q.printStackTrace();
				}
			}
		}
		return claveP;
	}


/**
* El Método dameRemisionSiguiente nos regresa la Siguiente Remision
*
* @return int correspondiente a la siguiente remision
*/
	public int dameRemisionSiguiente(){
		int numRem = 0;
		ResultSet rs = null;
		try{
			String query = ("SELECT MAX(remision)AS remi FROM ventas");
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				numRem = rs.getInt("remi");
			}
			numRem++;
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameRemisionSiguiente ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameRemisionSiguiente ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, dameRemisionSiguiente ");
					q.printStackTrace();
				}
			}
		}
		return numRem;
	}




/**
* El método add_Orden_Venta se encarga de añadir a la Base de Datos una Orden de Venta
*	@return String exito
*/
	public synchronized String  add_Orden_Venta(String usuario) throws SQLException, Exception {
		//System.out.println("Empiezo");
		con = new ConexionBD();
		con.cancelaAutoCommit();
		String resultado = "OK";
		boolean yaNoHay = false;
		if (con.miConnection != null) {
			try {
				ResultSet rs= null;
				tiempo = new TimeStamp();
				String fecha = tiempo.date;
				Date alta = cambiaADate(fecha);
// PRIMERO VERIFICO QUE AUN EXISTAN PRODUCTOS EN EXISTENCIA DE VENTA (INVENTARIO)
				int cantNum = cambiaAInt(cantNumProductos);
				for (int i =1; i<=cantNum; i++){
					if(!(ArrayProducto[i].equalsIgnoreCase(""))){
						String tempCP = ArrayProducto[i];
						double cantCP = cambiaADouble(ArrayCantidad[i]);
						String verificaEV = "SELECT existencia FROM productos WHERE claveProducto = '"+tempCP +"'";
						Statement st1 = con.creaStatement();
						rs = st1.executeQuery(verificaEV);
						while (rs.next()){
							if(rs.getDouble("existencia") < cantCP){
								yaNoHay = true;
								resultado = "Se terminó la existencia del producto: "+tempCP +", modifique su Orden de Venta";
							}
						}
						rs.close();
						st1.close();
					}
				}
// SI TENGO EN EXISTENCIA TODOS LOS DE VENTA CHECO AHORA LOS DE REGALO SI ES QUE EXISTEN:
				if(! yaNoHay){
					if(! prod1.equals("")){
						String verificaEO = "SELECT existencia FROM producto_obsequio WHERE claveProducto = '"+prod1 +"'";
						Statement st2 = con.creaStatement();
						ResultSet rs2 = st2.executeQuery(verificaEO);
						while (rs2.next()){
							if(rs2.getDouble("existencia") < cambiaADouble(can1)){
								yaNoHay = true;
								resultado = "Se terminó la existencia del producto obsequiado: "+prod1 +", modifique su Orden de Venta";
							}
						}
						rs2.close();
						st2.close();
					}
					if(! prod2.equals("")){
						String verificaEO = "SELECT existencia FROM producto_obsequio WHERE claveProducto = '"+prod2 +"'";
						Statement st2 = con.creaStatement();
						ResultSet rs2 = st2.executeQuery(verificaEO);
						while (rs2.next()){
							if(rs2.getDouble("existencia") < cambiaADouble(can2)){
								yaNoHay = true;
								resultado = "Se terminó la existencia del producto obsequiado: "+prod2 +", modifique su Orden de Venta";
							}
						}
						rs2.close();
						st2.close();
					}
					if(! prod3.equals("")){
						String verificaEO = "SELECT existencia FROM producto_obsequio WHERE claveProducto = '"+prod3 +"'";
						Statement st2 = con.creaStatement();
						ResultSet rs2 = st2.executeQuery(verificaEO);
						while (rs2.next()){
							if(rs2.getDouble("existencia") < cambiaADouble(can3)){
								yaNoHay = true;
								resultado = "Se terminó la existencia del producto obsequiado: "+prod3 +", modifique su Orden de Venta";
							}
						}
						rs2.close();
						st2.close();
					}
				}
// SI TENGO TAMBIEN LOS DE OBSEQUIO COMIENZO A GUARDAR
				if(! yaNoHay){
					double to = cambiaADouble(remueveComas(total));
					String cambiaSaldo = "UPDATE clientes SET saldoDisponible = saldoDisponible-"+to+" WHERE rfc = '"+claveCliente+"' ";
					Statement cambiar = con.miConnection.createStatement();
					cambiar.execute(cambiaSaldo);
					cambiar.close();
					PreparedStatement updateOrdenVenta;
					updateOrdenVenta = con.miConnection.prepareStatement("insert into ventas values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
					updateOrdenVenta.setNull(1, java.sql.Types.INTEGER);
					updateOrdenVenta.setString(2, claveCliente);
					updateOrdenVenta.setString(3, fechaAlta);
					updateOrdenVenta.setString(4, fechaEntrega);
					updateOrdenVenta.setString(5, observaciones);
					updateOrdenVenta.setDouble(6, cambiaADouble(remueveComas(subtotal)));
					updateOrdenVenta.setDouble(7, cambiaADouble(remueveComas(iva)));
					updateOrdenVenta.setDouble(8, cambiaADouble(remueveComas(total)));
					updateOrdenVenta.setInt(9, 1);
					updateOrdenVenta.setInt(10,cambiaAInt(documento));
					if(cambiaAInt(documento) == 1){
						updateOrdenVenta.setString(11, numFac);
						updateOrdenVenta.setInt(12, 0);
						resultado = resultado+"F";
					}
					else{
						updateOrdenVenta.setString(11, "");
						int laRemision = dameRemisionSiguiente();
						updateOrdenVenta.setInt(12, laRemision);
						resultado = resultado+"R"+laRemision;
					}
					updateOrdenVenta.setInt(13,2);
					updateOrdenVenta.setString(14, usuario);
					updateOrdenVenta.setInt(15, 0);
					updateOrdenVenta.setString(16, repartidor);
					updateOrdenVenta.execute();

// Obtengo la claveDelaVenta
					String query = ("SELECT MAX(claveVenta)AS ultima FROM ventas WHERE activo = 1");
					Statement stmt = con.creaStatement();
					ResultSet rs3 = stmt.executeQuery(query);
					while (rs3.next()){
						setClaveVenta(rs3.getString("ultima"));
						resultado = resultado +"**"+rs3.getString("ultima");
					}
					rs3.close();
					stmt.close();
// Comienzo a guardar los productos vendidos correspondientes:
					for (int i =1; i<=cantNum; i++){
						if(!(ArrayProducto[i].equalsIgnoreCase("")) && !(tieneIva(ArrayProducto[i])) ){
							int claUl = cambiaAInt(claveVenta);
							double can = cambiaADouble(remueveComas(ArrayCantidad[i]));
							double costo = cambiaADouble(remueveComas(ArrayCunidad[i]));
							double importe = cambiaADouble(remueveComas(ArrayImporte[i]));
							PreparedStatement updateProductosOrdenVenta;
							updateProductosOrdenVenta = con.miConnection.prepareStatement("insert into productos_venta values(?,?,?,?,?,?);");
							updateProductosOrdenVenta.setInt(1, claUl);
							updateProductosOrdenVenta.setString(2, ArrayProducto[i]);
							updateProductosOrdenVenta.setDouble(3, can);
							updateProductosOrdenVenta.setDouble(4, costo);
							updateProductosOrdenVenta.setDouble(5, importe);
							updateProductosOrdenVenta.setDouble(6, can);
							updateProductosOrdenVenta.execute();
						}
						else if(!(ArrayProducto[i].equalsIgnoreCase("")) && tieneIva(ArrayProducto[i])){
							int claUl = cambiaAInt(claveVenta);
							double can = cambiaADouble(remueveComas(ArrayCantidad[i]));
							double costo = cambiaADouble(remueveComas(ArrayCunidad[i]));
							double importe = cambiaADouble(remueveComas(ArrayImporte[i]));
							PreparedStatement updateProductosOrdenVenta;
							updateProductosOrdenVenta = con.miConnection.prepareStatement("insert into productos_venta values(?,?,?,?,?,?);");
							updateProductosOrdenVenta.setInt(1, claUl);
							updateProductosOrdenVenta.setString(2, ArrayProducto[i]);
							updateProductosOrdenVenta.setDouble(3, can);
							updateProductosOrdenVenta.setDouble(4, ((costo * 100)/115));
							updateProductosOrdenVenta.setDouble(5, ((importe * 100)/115));
							updateProductosOrdenVenta.setDouble(6, can);
							updateProductosOrdenVenta.execute();
						}
					}
// GUARDO AHORA LOS PRODUCTOS DE REGALO.
					if(!prod1.equalsIgnoreCase("")){
						int claUlR = cambiaAInt(claveVenta);
						double ocan = cambiaADouble(remueveComas(can1));
						if(ocan > 0){
							PreparedStatement updateRegalosVenta;
							updateRegalosVenta = con.miConnection.prepareStatement("insert into regalos_venta values(?,?,?,?);");
							updateRegalosVenta.setInt(1, claUlR);
							updateRegalosVenta.setString(2, prod1);
							updateRegalosVenta.setDouble(3, ocan);
							updateRegalosVenta.setDouble(4, ocan);
							updateRegalosVenta.execute();
						}
					}
					if(!prod2.equalsIgnoreCase("")){
						int claUlR = cambiaAInt(claveVenta);
						double ocan = cambiaADouble(remueveComas(can2));
						if(ocan > 0){
							PreparedStatement updateRegalosVenta;
							updateRegalosVenta = con.miConnection.prepareStatement("insert into regalos_venta values(?,?,?,?);");
							updateRegalosVenta.setInt(1, claUlR);
							updateRegalosVenta.setString(2, prod2);
							updateRegalosVenta.setDouble(3, ocan);
							updateRegalosVenta.setDouble(4, ocan);
							updateRegalosVenta.execute();
						}
					}
					if(!prod3.equalsIgnoreCase("")){
						int claUlR = cambiaAInt(claveVenta);
						double ocan = cambiaADouble(remueveComas(can3));
						if(ocan > 0){
							PreparedStatement updateRegalosVenta;
							updateRegalosVenta = con.miConnection.prepareStatement("insert into regalos_venta values(?,?,?,?);");
							updateRegalosVenta.setInt(1, claUlR);
							updateRegalosVenta.setString(2, prod3);
							updateRegalosVenta.setDouble(3, ocan);
							updateRegalosVenta.setDouble(4, ocan);
							updateRegalosVenta.execute();
						}
					}
// AHORA ACTUALIZO INVENTARIOS:
// VOY A SACAR TODO DIRECTAMENTE DE MI TABLA PARA QUE NO HAYA BRONCAS.... Y VOY A BLOQUEAR LA TABLA....
					Statement statement = con.creaStatement();
					statement.execute("LOCK TABLES productos_venta READ, productos WRITE");
					statement.close();
					Statement stmtInv = con.creaStatement();
					String queryExtractor = "SELECT ClaveProducto, Cantidad FROM productos_venta WHERE claveVenta = "+claveVenta;
					ResultSet rsExtraido = stmtInv.executeQuery(queryExtractor);
					while(rsExtraido.next()){
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement ("UPDATE productos SET existencia = (existencia - ?) WHERE claveProducto = ?");
						updateInventario.setDouble(1, rsExtraido.getDouble("Cantidad"));
						updateInventario.setString(2, rsExtraido.getString("ClaveProducto"));
						updateInventario.execute();
					}
					rsExtraido.close();
					stmtInv.close();
					statement = con.creaStatement();
					statement.execute("UNLOCK TABLES");
					statement.close();
// PRIMERO PRODUCTOS VENDIDOS:
//					for (int i =1; i<=cantNum; i++){
//						if(!(ArrayProducto[i].equalsIgnoreCase(""))){
//							int claUl = cambiaAInt(claveVenta);
//							double can = cambiaADouble(remueveComas(ArrayCantidad[i]));
//							PreparedStatement updateInventario;
//							updateInventario = con.miConnection.prepareStatement ("UPDATE productos SET existencia = (existencia-?) WHERE claveProducto = ?");
//							updateInventario.setDouble(1, can);
//							updateInventario.setString(2, ArrayProducto[i]);
//							updateInventario.execute();
//							String updateInve = "UPDATE productos SET existencia = (existencia-"+can +") WHERE claveProducto = '"+ArrayProducto[i] +"'";
//							System.out.println("updateInve:" +updateInve);
//							Statement temp2 = con.creaStatement();
//							temp2.executeUpdate(updateInve);
//						}
//					}
// SEGUNDO PRODUCTOS OBSEQUIADOS.
					if(!prod1.equalsIgnoreCase("")){
						double ocan = cambiaADouble(remueveComas(can1));
						if (ocan > 0){
							String updateObsequio = "UPDATE producto_obsequio SET existencia = (existencia-" +ocan+") WHERE ClaveProducto = '"+prod1+"'";
							Statement stmt3 = con.creaStatement();
							stmt3.executeUpdate(updateObsequio);
							stmt3.close();
						}
					}
					if(!prod2.equalsIgnoreCase("")){
						double ocan = cambiaADouble(remueveComas(can2));
						if (ocan > 0){
							String updateObsequio = "UPDATE producto_obsequio SET existencia = (existencia-"+ocan+") WHERE ClaveProducto = '"+prod2+"'";
							Statement stmt3 = con.creaStatement();
							stmt3.executeUpdate(updateObsequio);
							stmt3.close();
						}
					}
					if(!prod3.equalsIgnoreCase("")){
						double ocan = cambiaADouble(remueveComas(can3));
						if (ocan > 0){
							String updateObsequio = "UPDATE producto_obsequio SET existencia = (existencia-"+ocan+") WHERE ClaveProducto = '"+prod3+"'";
							Statement stmt3 = con.creaStatement();
							stmt3.executeUpdate(updateObsequio);
							stmt3.close();
						}
					}
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				resultado = "ERROR SQL";
				sqle.printStackTrace();
				System.out.println(	"Error SQL clase ManagerVenta, método add_Orden_Venta"+sqle);
			}
			catch (Exception q){
				con.realizaRollback();
				resultado = "ERROR";
				q.printStackTrace();
				System.out.println(	"Error clase ManagerVenta, método add_Orden_Venta");
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerVenta metodo add_Orden_Venta");
					q.printStackTrace();
				}
			}
		}
		return resultado;
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

	public String formatoMaxUnDecimal(String numero){
		StringBuilder  sb = new StringBuilder(numero);
		if(sb.indexOf(".1")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else if(sb.indexOf(".2")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else if(sb.indexOf(".3")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else if(sb.indexOf(".4")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else if(sb.indexOf(".5")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else if(sb.indexOf(".6")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else if(sb.indexOf(".7")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else if(sb.indexOf(".8")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else if(sb.indexOf(".9")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else{
			sb = sb.delete(sb.indexOf("."), sb.length());
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