
import java.sql.*;
import java.util.*;
import java.sql.Date;
import java.math.*;

public class Actualiza {

  String error;
  protected static ConNuev cNew = new ConNuev();
  protected static ConPrev cOld = new ConPrev();

/**
* El método ManagerPro es el constructor vacio de la clase.
*/

  public Actualiza()   { }


	public boolean actualizaCliente ( ) throws SQLException, Exception{
		boolean exito = true;
		System.out.println("Actualizando base de Datos de Clientes.");
		if(cNew != null && cOld != null){
			try{
				Statement stmt = cOld.creaStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM clientes WHERE activo = 1 ORDER BY nombre");
				while(rs.next()){
					PreparedStatement creaCliente;
					creaCliente = cNew.miConnection.prepareStatement("INSERT INTO clientes values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					creaCliente.setString(1, rs.getString("rfc").toUpperCase()); // RFC
					creaCliente.setString(2, rs.getString("curp")); // Curp
					creaCliente.setString(3, rs.getString("nombre").toUpperCase()); // nombre
					creaCliente.setString(4, rs.getString("direccion")); // direccion
					creaCliente.setString(5, rs.getString("colonia")); // colonia
					creaCliente.setString(6, rs.getString("delegacion")); // delegacion
					creaCliente.setString(7, rs.getString("cp")); // CP
					creaCliente.setString(8, rs.getString("ciudad")); // Ciudad
					creaCliente.setString(9, rs.getString("contacto")); // contacto
					creaCliente.setString(10, rs.getString("tel1")); // Tel1
					creaCliente.setString(11, rs.getString("tel2")); // Tel2
					creaCliente.setDate(12, cambiaADate(rs.getString("alta"))); // Existencia Actual
					creaCliente.setInt(13, rs.getInt("tipoCliente")); // Existencia Actual
					creaCliente.setDouble(14, rs.getDouble("credito"));//Activo
					creaCliente.setInt(15, rs.getInt("tiempoCredito"));//Activo
					creaCliente.setDouble(16, rs.getDouble("credito"));//Activo
					creaCliente.setInt(17, 1);//Activo
					creaCliente.setInt(18, 1);//Activo
					creaCliente.execute();
					creaCliente.close();
				}
				rs.close();
				stmt.close();
			}
			catch(SQLException sqle){
				System.out.println("Excepcion SQL en clase Actualiza, metodo actualizaCliente");
				sqle.printStackTrace();
				exito = false;
			}
			catch(Exception e){
				System.out.println("Excepcion en clase Actualiza, metodo actualizaCliente");
				e.printStackTrace();
				exito = false;
			}
		}
		else{
			exito = false;
		}
		return exito;
	}


	public boolean actualizaProveedor ( ) throws SQLException, Exception{
		boolean exito = true;
		System.out.println("Actualizando base de Datos de Proveedores.");
		if(cNew != null && cOld != null){
			try{
				Statement stmt = cOld.creaStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM proveedores WHERE activo = 1 ORDER BY nombre");
				while(rs.next()){
					PreparedStatement creaProveedor;
					creaProveedor = cNew.miConnection.prepareStatement("INSERT INTO proveedores values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					creaProveedor.setString(1, rs.getString("rfc").toUpperCase()); // RFC
					creaProveedor.setString(2, rs.getString("nombre").toUpperCase()); // nombre
					creaProveedor.setString(3, rs.getString("direccion")); // direccion
					creaProveedor.setString(4, rs.getString("colonia")); // colonia
					creaProveedor.setString(5, rs.getString("delegacion")); // delegacion
					creaProveedor.setString(6, rs.getString("cp")); // CP
					creaProveedor.setString(7, rs.getString("ciudad")); // Ciudad
					creaProveedor.setString(8, rs.getString("tel1")); // Tel1
					creaProveedor.setString(9, rs.getString("tel2")); // Tel2
					creaProveedor.setString(10, rs.getString("fax")); // Fax
					creaProveedor.setString(11, rs.getString("pagina")); // Pagina
					creaProveedor.setString(12, rs.getString("email")); // Email
					creaProveedor.setString(13, rs.getString("vendedor")); // Vendedor
					creaProveedor.setInt(14, rs.getInt("formaPago")); // formaPago
					creaProveedor.setString(15, rs.getString("cuentas")); // cuentas
					creaProveedor.setInt(16, rs.getInt("IDCredito")); // formaPago
					creaProveedor.setDouble(17, rs.getDouble("credito")); //Credito
					creaProveedor.setInt(18, rs.getInt("diasPago")); // diasPago
					creaProveedor.setDouble(19, rs.getDouble("descuento1"));//descuento1
					creaProveedor.setDouble(20, rs.getDouble("descuento2"));//descuento2
					creaProveedor.setDouble(21, rs.getDouble("descuento3"));//descuento3
					creaProveedor.setDouble(22, rs.getDouble("saldoDisponible"));//saldo Disponible
					creaProveedor.setDate(23, cambiaADate(rs.getString("alta")));//Activo
					creaProveedor.setInt(24, 1);//Activo
					creaProveedor.execute();
					creaProveedor.close();
				}
				rs.close();
				stmt.close();
			}
			catch(SQLException sqle){
				System.out.println("Excepcion SQL en clase Actualiza, metodo actualizaProveedor");
				sqle.printStackTrace();
				exito = false;
			}
			catch(Exception e){
				System.out.println("Excepcion en clase Actualiza, metodo actualizaProveedor");
				e.printStackTrace();
				exito = false;
			}
		}
		else{
			exito = false;
		}
		return exito;
	}


	public boolean actualizaProductos ( ) throws SQLException, Exception{
		boolean exito = true;
		System.out.println("Actualizando base de Datos de Proveedores.");
		if(cNew != null && cOld != null){
			try{
				Statement stmt = cOld.creaStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM productos WHERE activo = 1 ORDER BY descripcion");
				int consecutivo = 0;
				while(rs.next()){
					consecutivo++;
					PreparedStatement creaProducto;
					creaProducto = cNew.miConnection.prepareStatement("INSERT INTO productos values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					creaProducto.setInt(1, consecutivo); // ID_Pro
					creaProducto.setString(2, rs.getString("descripcion")); // descripcion
					creaProducto.setInt(3, rs.getInt("tipoPro")); // tipoPro
					creaProducto.setInt(4, rs.getInt("gravaIVA")); // gravaIVA
					creaProducto.setInt(5, rs.getInt("genero")); // genero
					creaProducto.setInt(6, 0); // materiaPrima
					creaProducto.setInt(7, 0); // producto Cortes
					creaProducto.setString(8, rs.getString("id_prov1")); // Proveedor1
					creaProducto.setString(9, rs.getString("id_prov2")); // Proveedor2
					creaProducto.setString(10, rs.getString("id_prov3")); // Proveedor3
					creaProducto.setString(11, rs.getString("id_prov4")); // Proveedor4
					creaProducto.setString(12, rs.getString("id_prov5")); // Proveedor5
					creaProducto.setInt(13, rs.getInt("uniCompra")); // Unidad Compra
					creaProducto.setDouble(14, rs.getDouble("precioUniCompra")); // precio Unidad compra
					creaProducto.setDouble(15, rs.getDouble("preCaCompra")); // precio caja compra
					creaProducto.setInt(16, rs.getInt("cantidadXCaja")); // cantidad por Caja
					creaProducto.setDouble(17, rs.getDouble("precioUnidadKG")); // precio Unidad KiloGramo
					creaProducto.setDouble(18, rs.getDouble("kgXUnidad")); // Kilogramos por Unidad
					creaProducto.setInt(19, rs.getInt("tipoPrecio")); // Tipo de Precio
					creaProducto.setInt(20, rs.getInt("manejoPrecio")); // Manejo de Precio
					// Precios de Grupo y Manejo de Precio por Kilo y Pieza.
					if(rs.getInt("tipoPrecio") == 1 && rs.getInt("manejoPrecio") == 2){
						creaProducto.setDouble(21, rs.getDouble("precioBase1")); // precio Unidad KiloGramo
						creaProducto.setDouble(22, rs.getDouble("precioBase1Caja")/rs.getDouble("kgXUnidad")); // Kilogramos por Unidad
						creaProducto.setDouble(23, rs.getDouble("precioG2")); // precio Unidad KiloGramo
						creaProducto.setDouble(24, rs.getDouble("precioG2Caja")/rs.getDouble("kgXUnidad")); // Kilogramos por Unidad
						creaProducto.setDouble(25, rs.getDouble("precioG6")); // precio Unidad KiloGramo
						creaProducto.setDouble(26, rs.getDouble("precioG6Caja")/rs.getDouble("kgXUnidad")); // Kilogramos por Unidad
					}
					else{
						creaProducto.setDouble(21, rs.getDouble("precioBase1")); // precio Unidad KiloGramo
						creaProducto.setDouble(22, rs.getDouble("precioBase1Caja")); // Kilogramos por Unidad
						creaProducto.setDouble(23, rs.getDouble("precioG2")); // precio Unidad KiloGramo
						creaProducto.setDouble(24, rs.getDouble("precioG2Caja")); // Kilogramos por Unidad
						creaProducto.setDouble(25, rs.getDouble("precioG6")); // precio Unidad KiloGramo
						creaProducto.setDouble(26, rs.getDouble("precioG6Caja")); // Kilogramos por Unidad
					}
					creaProducto.setDouble(27, rs.getDouble("maxInv")); // Maximo Inventario
					creaProducto.setDouble(28, rs.getDouble("minInv")); // Minimo Inventario
					creaProducto.setDouble(29, rs.getDouble("existencia")); // Minimo Inventario
					creaProducto.setDouble(30, 0.00); // Minimo Inventario
					creaProducto.setInt(31, 1); // Minimo Inventario
					creaProducto.execute();
					creaProducto.close();
					String query2 = "SELECT * FROM codigosb WHERE ID_Pro = " +rs.getInt("ID_Pro");
					Statement stmt2 = cOld.creaStatement();
					ResultSet rs2 = stmt2.executeQuery(query2);
					while(rs2.next()){
						PreparedStatement creaCBarra;
						creaCBarra = cNew.miConnection.prepareStatement("INSERT INTO codigosB values (?,?)");
						creaCBarra.setInt(1, consecutivo); // ID_Pro
						creaCBarra.setString(2, rs2.getString("codBarra")); // descripcion
						creaCBarra.execute();
						creaCBarra.close();
					}
					rs2.close();
					stmt2.close();
					String query3 = "SELECT * FROM pescalonados WHERE ID_Pro = "+rs.getInt("ID_Pro");
					Statement stmt3 = cOld.creaStatement();
					ResultSet rs3 = stmt3.executeQuery(query3);
					while(rs3.next()){
						PreparedStatement creaEscalon;
						creaEscalon = cNew.miConnection.prepareStatement("INSERT INTO codigosB values (?,?)");
						creaEscalon.setInt(1, consecutivo); // ID_Pro
						creaEscalon.setInt(2, rs3.getInt("ca_peEscalon")); // ca_peEscalon
						creaEscalon.setDouble(3, rs3.getDouble("campoPrecio")); // campoPrecio
						creaEscalon.setInt(1, 1); // Activo
						creaEscalon.execute();
						creaEscalon.close();
					}
					rs3.close();
					stmt3.close();
				}
				rs.close();
				stmt.close();
			}
			catch(SQLException sqle){
				System.out.println("Excepcion SQL en clase Actualiza, metodo actualizaProductos");
				sqle.printStackTrace();
				exito = false;
			}
			catch(Exception e){
				System.out.println("Excepcion en clase Actualiza, metodo actualizaProductos");
				e.printStackTrace();
				exito = false;
			}
		}
		else{
			exito = false;
		}
		return exito;
	}


	public void creaPorcentuales() throws SQLException, Exception{
		if(cNew != null){
			try{
				cNew.cancelaAutoCommit();
				String query = "SELECT * FROM productos WHERE activo = 1 ORDER BY ID_Pro";
				Statement stmt = cNew.creaStatement();
				ResultSet rs = stmt.executeQuery(query);
				while(rs.next()){
					System.out.println("Producto #: " +rs.getInt("ID_PRO"));
					double preUniCompra = rs.getDouble("precioUniCompra");
					double preCaCompra = rs.getDouble("preCaCompra");
					if(rs.getInt("tipoPrecio") != 2){ // No es escalon
						BigDecimal constante100 = new BigDecimal("100.0");
						if(rs.getInt("tipoPro") == 0){ // Es por Pieza o Caja.
							if(rs.getInt("manejoPrecio") == 0 || rs.getInt("manejoPrecio") == 1){ // Hablamos  de pieza
								if(preUniCompra <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
									preUniCompra = (rs.getDouble("preCaCompra")/rs.getDouble("cantidadXCaja"));
								}
								BigDecimal PVenta = new BigDecimal(rs.getString("precioMenu"));
								BigDecimal PCompra = new BigDecimal(preUniCompra+"");
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
								creaGananciaPorcentual.setInt(2, 1); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(rs.getInt("manejoPrecio")==1){//Hablamos de Caja Tambien:
								if(preCaCompra <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
									preCaCompra = (rs.getDouble("preUniCompra")*rs.getDouble("cantidadXCaja"));
								}
								BigDecimal PVenta = new BigDecimal(rs.getString("precioMenuC"));
								BigDecimal PCompra = new BigDecimal(preCaCompra+"");
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
								creaGananciaPorcentual.setInt(2, 2); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(rs.getInt("tipoPrecio") == 1){ // Hablamos de Grupo de Precios
								if(rs.getInt("manejoPrecio") == 0 || rs.getInt("manejoPrecio") == 1){ // Hablamos  de pieza
									if(preUniCompra <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
										preUniCompra = (rs.getDouble("preCaCompra")/rs.getDouble("cantidadXCaja"));
									}
									BigDecimal PVenta = new BigDecimal(rs.getString("precioMM"));
									BigDecimal PCompra = new BigDecimal(preUniCompra+"");
									BigDecimal gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									PreparedStatement creaGananciaPorcentual;
									creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
									creaGananciaPorcentual.setInt(2, 3); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
									PVenta = new BigDecimal(rs.getString("precioM"));
									PCompra = new BigDecimal(preUniCompra+"");
									gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
									creaGananciaPorcentual.setInt(2, 5); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
								}
								if(rs.getInt("manejoPrecio")==1){//Hablamos de Caja Tambien:
									if(preCaCompra <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
										preCaCompra = (rs.getDouble("preUniCompra")*rs.getDouble("cantidadXCaja"));
									}
									BigDecimal PVenta = new BigDecimal(rs.getString("precioMMC"));
									BigDecimal PCompra = new BigDecimal(preCaCompra+"");
									BigDecimal gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									PreparedStatement creaGananciaPorcentual;
									creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
									creaGananciaPorcentual.setInt(2, 4); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
									PVenta = new BigDecimal(rs.getString("precioMC"));
									PCompra = new BigDecimal(preCaCompra+"");
									gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
									creaGananciaPorcentual.setInt(2, 6); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
								}
							}
						}
						else if(rs.getInt("tipoPro") == 1){ // Es por Pesaje
							if(rs.getInt("manejoPrecio") == 0 || rs.getInt("manejoPrecio")  == 2){ // Hablamos  de Kg y Pieza
								BigDecimal PVenta = new BigDecimal(rs.getString("precioMenu"));
								BigDecimal PCompra = new BigDecimal(rs.getString("precioUnidadKG"));
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
								creaGananciaPorcentual.setInt(2, 1); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(rs.getInt("manejoPrecio")==2){//Hablamos de Pieza Tambien:
								double prePzXKg = rs.getDouble("precioUnidadKg")*rs.getDouble("kgXUnidad");
								BigDecimal PVenta = new BigDecimal(rs.getString("precioMenuC"));
								BigDecimal PCompra = new BigDecimal(prePzXKg+"");
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
								creaGananciaPorcentual.setInt(2, 2); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(rs.getInt("tipoPrecio") == 1){ // Hablamos de Grupo de Precios
								if(rs.getInt("manejoPrecio") == 0 || rs.getInt("manejoPrecio") == 2){ // Hablamos  de pieza
									BigDecimal PVenta = new BigDecimal(rs.getString("precioMM"));
									BigDecimal PCompra = new BigDecimal(rs.getString("precioUnidadKG"));
									BigDecimal gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									PreparedStatement creaGananciaPorcentual;
									creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
									creaGananciaPorcentual.setInt(2, 3); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
									PVenta = new BigDecimal(rs.getString("precioM"));
									PCompra = new BigDecimal(rs.getString("precioUnidadKG"));
									gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
									creaGananciaPorcentual.setInt(2, 5); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
								}
								if(rs.getInt("manejoPrecio")==2){//Hablamos de Pieza Tambien:
									double prePzXKg = rs.getDouble("precioUnidadKg")*rs.getDouble("kgXUnidad");
									BigDecimal PVenta = new BigDecimal(rs.getString("precioMMC"));
									BigDecimal PCompra = new BigDecimal(prePzXKg+"");
									BigDecimal gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									PreparedStatement creaGananciaPorcentual;
									creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
									creaGananciaPorcentual.setInt(2, 4); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
									PVenta = new BigDecimal(rs.getString("precioMC"));
									PCompra = new BigDecimal(prePzXKg+"");
									gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									creaGananciaPorcentual = cNew.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,rs.getInt("ID_Pro"));// ID_Pro
									creaGananciaPorcentual.setInt(2, 6); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, rs.getInt("tipoPro"));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
								}
							}
						}
					}
				}
				rs.close();
				stmt.close();
				cNew.realizaCommit();
			}
			catch(SQLException sqle){
				cNew.realizaRollback();
				sqle.printStackTrace();
			}
			catch(Exception e){
				cNew.realizaRollback();
				e.printStackTrace();
			}
			finally{
				cNew.habilitaAutoCommit();
			}
		}
	}

	public static void main (String[] args) throws Exception {
		Actualiza act = new Actualiza();
		if(act.actualizaCliente()){
			System.out.println("Clientes Actualizado....");
			if(act.actualizaProveedor()){
				System.out.println("Proveedores Actualizado");
				if(act.actualizaProductos()){
					System.out.println("Productos Actualizados..");
					act.creaPorcentuales();
					System.out.println("Ganancias Porcentuales actualizadas...");
				}
			}
		}
		else{
			System.out.println("Hubo un Error....");
		}
	}



// GENERICAS
/**
* El método cambiaAInt se encarga de transformar a un Entero una variables en formato String.
*  	@param 	variable	String a tranformar a Entero.
*	@return valor 		Entero con el valor de la variable.
*/
	public int cambiaAInt(String variable) throws Exception{
		variable=remueveComas(variable);
		int valor;
		try{
			valor = (Integer.parseInt(variable));
		}
		catch(NumberFormatException nfe){
			valor = 0;
		}
			return valor;
	}


/**
* El método cambiaADouble se encarga de transformar a un Double una variables en formato String.
*  	@param 	variable	String a tranformar a double.
*	@return valor 		double con el valor de la variable.
*/
	public double cambiaADouble(String variable) throws Exception{
		variable = remueveComas(variable);
		double valor;
		try{
			Double val = (Double.valueOf(variable));
			valor = val.doubleValue();
		}
		catch(NumberFormatException nfe){
			valor =0;
		}
			return valor;
	}


/**
* El método cambiaADate se encarga de transformar a un Date una variables en formato String.
*  	@param 	fecha		String a tranformar a Date.
*	@return Date 		Date con el valor de la variable.
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


// Utileria para quitar los puntos.
	private String remuevePuntuacion(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf(".") != -1){
			sb.deleteCharAt(sb.indexOf("."));
		}
		return formato = new String(sb.toString());
	}

// Utileria para quitar las comas.
	public String remueveComas(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}



	public String remueveCeros(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf("0") != -1){
			sb.deleteCharAt(sb.indexOf("0"));
		}
		if (sb.toString().trim().length() == 0 || sb.toString().trim().equalsIgnoreCase(".")){
			formato = "";
		}
		else {
			boolean encontro = true;
			sb = new StringBuilder (formato);
			int size = sb.length();
			while (sb.length() >= 0 && encontro){
				if(sb.charAt(0)=='0'){
					sb = sb.deleteCharAt(0);
				}
				else{
					encontro = false;
				}
			}
			formato = new String(sb.toString());
		}
		return formato;
	}

	public String completaString(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 6 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}

	public String formatoDinero(String formato){
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
		return losEnteros.toString()+"."+losDecimales;
	}

	public String dameDecimales(String enteros){
		StringBuilder sb = new StringBuilder (enteros);
		boolean existieron = false;
		if(sb.indexOf(".") != -1){
			sb=sb.delete(0, sb.indexOf(".")+1);
			existieron = true;
		}
		if (!existieron){
			sb = new StringBuilder ("00");
		}
		return sb.toString();
	}

	public String dameEnteros(String enteros){
		StringBuilder sb = new StringBuilder (enteros);
		if(sb.indexOf(".") != -1){
			sb=sb.delete(sb.indexOf("."),sb.length() );
		}
		return sb.toString();
	}

	public String acortaLongitud(String muchosDecimales){
		StringBuilder sb = new StringBuilder (muchosDecimales);
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


}

