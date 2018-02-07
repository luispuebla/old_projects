package com.alpha.bd;

import com.alpha.bd.DateStamp;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import java.math.*;

/**
* La clase "ManagerPro" es la encargada de administrar los datos correspondientes a los Productos como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Diciembre 2004)
*/

public class ManagerPro {

  String error;
  private ConexionBD con = null;
  private ConexionBD con2 = null;
  private DateStamp dt= new DateStamp();


/**
* El método ManagerPro es el constructor vacio de la clase.
*/

  public ManagerPro()   { }



	// Métodos Revisados
	//ARREGLAR DE ACUERDO A LA NUEVA TABLA!!!! Y LO QUE ENTRA!!!!!!!!

	public synchronized int  add_Producto (String descripcion,String  tipo,String  iva,String  genero, String mp, String cortes, String  codBarras1,String  codBarras2,String  codBarras3, String  codBarras4,String  codBarras5,String  codBarras6,String  codBarras7,String  codBarras8,String  codBarras9,String  codBarras10,String  codBarras11, String  codBarras12, String  proveedor1,String  proveedor2,String  proveedor3,String  proveedor4,String  proveedor5,String  uniCompra,String  preUniCompra,String  preCaCompra,String  piezasc, String preKgCompra,String  kgXUni,String  tipoPrecio,String  manejo,String  precioMenu,String  precioMenuC,String  precioMM,String  precioMMC,String  precioM,String  precioMC, String  pieza1,String  precioE1,String  pieza2,String  precioE2,String  pieza3,String  precioE3,String  pieza4,String  precioE4,String  pieza5,String  precioE5,String  maxInv, String  minInv,String invTienda, String invAlmacen) throws SQLException, Exception {
//		System.out.println("c1: " +codBarras1+" c2: "+codBarras2+" c3: "+codBarras3+" c4: "+codBarras4+" c5: "+codBarras5+" c6: "+codBarras6+" c7: "+codBarras7+" c8: "+codBarras8+" c9: "+codBarras9);
//		System.out.println("Descripcion: " +descripcion 		+"\n Tipo: "+tipo		+"\n iva: "+iva 		+"\n genero: "+genero 		+"\n proveedor1: "+proveedor1 		+"\n proveedor2: "+proveedor2 		+"\n proveedor3: "+proveedor3 		+"\n uniCompra: "+uniCompra 		+"\n preUniCompra: "+preUniCompra	+"\n preCaCompra: "+preCaCompra);
		boolean codigoRepetido = dimeCodigoRepetido(codBarras1, codBarras2, codBarras3, codBarras4,  codBarras5,  codBarras6, codBarras7, codBarras8,  codBarras9, codBarras10, codBarras11,  codBarras12);
		if(codigoRepetido){
			return -1;
		}
		con = new ConexionBD();
		con.cancelaAutoCommit();
		int clavePLUFinal =  0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		if (con != null) {
			try {
				PreparedStatement updateProducto;
				updateProducto = con.miConnection.prepareStatement("insert into productos values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
				updateProducto.setNull(1,java.sql.Types.INTEGER);// ID_Pro
				updateProducto.setString(2, descripcion); //descripcion
				updateProducto.setInt(3, cambiaAInt(tipo)); //tipoProducto
				updateProducto.setInt(4, cambiaAInt(iva));  //gravaIVA
				updateProducto.setInt(5, cambiaAInt(genero)); //genero
				updateProducto.setInt(6, cambiaAInt(mp)); //materiaPrima
				updateProducto.setInt(7, cambiaAInt(cortes)); //Productocortes
				updateProducto.setString(8, proveedor1); //id_proveedor1
				updateProducto.setString(9, proveedor2); //id_proveedor2
				updateProducto.setString(10, proveedor3); //id_proveedor3
				updateProducto.setString(11, proveedor4); //id_proveedor4
				updateProducto.setString(12, proveedor5); //id_proveedor5
				updateProducto.setInt(13, cambiaAInt(uniCompra)); //uniCompra
				updateProducto.setDouble(14, cambiaADouble(preUniCompra)); // precioUnidadCompra
				updateProducto.setDouble(15, cambiaADouble(preCaCompra)); // PrecioCajaCompra
				updateProducto.setInt(16, cambiaAInt(piezasc)); //cantidad de piezas en Caja
				updateProducto.setDouble(17, cambiaADouble(preKgCompra)); // precio Unidad en Kg.
				updateProducto.setDouble(18, cambiaADouble(kgXUni)); // Kilos por Unidad
				updateProducto.setInt(19, cambiaAInt(tipoPrecio)); // Tipo de Precio
				updateProducto.setInt(20, cambiaAInt(manejo)); //Manejo de Precio
				updateProducto.setDouble(21, cambiaADouble(precioMenu)); // Precio Menudeo x Pza
				updateProducto.setDouble(22, cambiaADouble(precioMenuC)); // Precio Menudeo x Caja
				updateProducto.setDouble(23, cambiaADouble(precioMM)); // Precio MedioMayoreo x Pza
				updateProducto.setDouble(24, cambiaADouble(precioMMC));// Precio MedioMayoreo x Caja
				updateProducto.setDouble(25, cambiaADouble(precioM)); // Precio Mayoreo x Pza
				updateProducto.setDouble(26, cambiaADouble(precioMC));// Precio Mayoreo x Caja
				updateProducto.setDouble(27, cambiaADouble(maxInv)); // Maximo del producto en inventario
				updateProducto.setDouble(28, cambiaADouble(minInv)); // Minimo del producto en Inventario
				updateProducto.setDouble(29, cambiaADouble(invTienda)); // Existencia Actual
				updateProducto.setDouble(30, cambiaADouble(invAlmacen)); // Existencia Actual
				updateProducto.setInt(31, 1);//Activo
				updateProducto.execute();
				updateProducto.close();
				String queryString = ("SELECT MAX(ID_Pro) AS claveProducto FROM productos" );
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
				while(rs.next()){
					clavePLUFinal = rs.getInt("claveProducto");
				}
				rs.close();
				stmt.close();
				// Si me regreso una clave nueva, por lo que voy a almacenar.
				if(clavePLUFinal > 0){
// Primero calculo y almaceno porcentual de ganacia por producto siempre y cuando no sea precio escalonado
					if(cambiaAInt(tipoPrecio) != 2){ // No es escalon
						BigDecimal constante100 = new BigDecimal("100.0");
						if(cambiaAInt(tipo) == 0){ // Es por Pieza o Caja.
							if(cambiaAInt(manejo) == 0 || cambiaAInt(manejo) == 1){ // Hablamos  de pieza
								if(cambiaADouble(preUniCompra) <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
									preUniCompra = (cambiaADouble(preCaCompra)/cambiaADouble(piezasc))+"";
								}
								BigDecimal PVenta = new BigDecimal(remueveComas(precioMenu));
								BigDecimal PCompra = new BigDecimal(remueveComas(preUniCompra));
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
								creaGananciaPorcentual.setInt(2, 1); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(cambiaAInt(manejo)==1){//Hablamos de Caja Tambien:
								if(cambiaADouble(preCaCompra) <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
									preCaCompra = (cambiaADouble(preUniCompra)*cambiaADouble(piezasc))+"";
								}
								BigDecimal PVenta = new BigDecimal(remueveComas(precioMenuC));
								BigDecimal PCompra = new BigDecimal(remueveComas(preCaCompra));
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
								creaGananciaPorcentual.setInt(2, 2); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(cambiaAInt(tipoPrecio) == 1){ // Hablamos de Grupo de Precios
								if(cambiaAInt(manejo) == 0 || cambiaAInt(manejo) == 1){ // Hablamos  de pieza
									if(cambiaADouble(preUniCompra) <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
										preUniCompra = (cambiaADouble(preCaCompra)/cambiaADouble(piezasc))+"";
									}
									BigDecimal PVenta = new BigDecimal(remueveComas(precioMM));
									BigDecimal PCompra = new BigDecimal(remueveComas(preUniCompra));
									BigDecimal gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									PreparedStatement creaGananciaPorcentual;
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
									creaGananciaPorcentual.setInt(2, 3); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
									PVenta = new BigDecimal(remueveComas(precioM));
									PCompra = new BigDecimal(remueveComas(preUniCompra));
									gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
									creaGananciaPorcentual.setInt(2, 5); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
								}
								if(cambiaAInt(manejo)==1){//Hablamos de Caja Tambien:
									if(cambiaADouble(preCaCompra) <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
										preCaCompra = (cambiaADouble(preUniCompra)*cambiaADouble(piezasc))+"";
									}
									BigDecimal PVenta = new BigDecimal(remueveComas(precioMMC));
									BigDecimal PCompra = new BigDecimal(remueveComas(preCaCompra));
									BigDecimal gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									PreparedStatement creaGananciaPorcentual;
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
									creaGananciaPorcentual.setInt(2, 4); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
									PVenta = new BigDecimal(remueveComas(precioMC));
									PCompra = new BigDecimal(remueveComas(preCaCompra));
									gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
									creaGananciaPorcentual.setInt(2, 6); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
								}
							}
						}
						else if(cambiaAInt(tipo) == 1){ // Es por Pesaje
							if(cambiaAInt(manejo) == 0 || cambiaAInt(manejo) == 2){ // Hablamos  de Kg y Pieza
								BigDecimal PVenta = new BigDecimal(remueveComas(precioMenu));
								BigDecimal PCompra = new BigDecimal(remueveComas(preKgCompra));
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
								creaGananciaPorcentual.setInt(2, 1); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(cambiaAInt(manejo)==2){//Hablamos de Pieza Tambien:
								double prePzXKg = cambiaADouble(preKgCompra)*(cambiaADouble(kgXUni));
								BigDecimal PVenta = new BigDecimal(remueveComas(precioMenuC));
								BigDecimal PCompra = new BigDecimal(prePzXKg+"");
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
								creaGananciaPorcentual.setInt(2, 2); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(cambiaAInt(tipoPrecio) == 1){ // Hablamos de Grupo de Precios
								if(cambiaAInt(manejo) == 0 || cambiaAInt(manejo) == 2){ // Hablamos  de pieza
									BigDecimal PVenta = new BigDecimal(remueveComas(precioMM));
									BigDecimal PCompra = new BigDecimal(remueveComas(preKgCompra));
									BigDecimal gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									PreparedStatement creaGananciaPorcentual;
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
									creaGananciaPorcentual.setInt(2, 3); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
									PVenta = new BigDecimal(remueveComas(precioM));
									PCompra = new BigDecimal(remueveComas(preKgCompra));
									gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
									creaGananciaPorcentual.setInt(2, 5); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
								}
								if(cambiaAInt(manejo)==2){//Hablamos de Pieza Tambien:
									double prePzXKg = cambiaADouble(preKgCompra)*(cambiaADouble(kgXUni));
									BigDecimal PVenta = new BigDecimal(remueveComas(precioMMC));
									BigDecimal PCompra = new BigDecimal(prePzXKg+"");
									BigDecimal gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									PreparedStatement creaGananciaPorcentual;
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
									creaGananciaPorcentual.setInt(2, 4); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
									PVenta = new BigDecimal(remueveComas(precioMC));
									PCompra = new BigDecimal(prePzXKg+"");
									gananciaPorcentual = new BigDecimal("0.0");
									gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
									gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
									creaGananciaPorcentual.setInt(1,clavePLUFinal);// ID_Pro
									creaGananciaPorcentual.setInt(2, 6); //PrecioTipo
									creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
									creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
									creaGananciaPorcentual.execute();
									creaGananciaPorcentual.close();
								}
							}
						}
					}
// Comienzo a almacenar codigos de barra...
					if(!codBarras1.equalsIgnoreCase("")){
						PreparedStatement updateCod1;
						updateCod1= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod1.setInt(1, clavePLUFinal); //ID_Producto
						updateCod1.setString(2, codBarras1); //Codigo de Barras #1
						updateCod1.execute();
						updateCod1.close();
					}
					if(!codBarras2.equalsIgnoreCase("")){
						PreparedStatement updateCod2;
						updateCod2= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod2.setInt(1, clavePLUFinal); // ID_Producto
						updateCod2.setString(2, codBarras2); //Codigo de Barras #2
						updateCod2.execute();
						updateCod2.close();
					}
					if(!codBarras3.equalsIgnoreCase("")){
						PreparedStatement updateCod3;
						updateCod3= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod3.setInt(1, clavePLUFinal); // ID_Producto
						updateCod3.setString(2, codBarras3); //Codigo de Barras #3
						updateCod3.execute();
						updateCod3.close();
					}
					if(!codBarras4.equalsIgnoreCase("")){
						PreparedStatement updateCod4;
						updateCod4= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod4.setInt(1, clavePLUFinal); // ID_Producto
						updateCod4.setString(2, codBarras4); //Codigo de Barras #4
						updateCod4.execute();
						updateCod4.close();
					}
					if(!codBarras5.equalsIgnoreCase("")){
						PreparedStatement updateCod5;
						updateCod5= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod5.setInt(1, clavePLUFinal); // ID_Producto
						updateCod5.setString(2, codBarras5); //Codigo de Barras #5
						updateCod5.execute();
						updateCod5.close();
					}
					if(!codBarras6.equalsIgnoreCase("")){
						PreparedStatement updateCod6;
						updateCod6= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod6.setInt(1, clavePLUFinal); // ID_Producto
						updateCod6.setString(2, codBarras6); //Codigo de Barras #6
						updateCod6.execute();
						updateCod6.close();
					}
					if(!codBarras7.equalsIgnoreCase("")){
						PreparedStatement updateCod7;
						updateCod7= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod7.setInt(1, clavePLUFinal); // ID_Producto
						updateCod7.setString(2, codBarras7); //Codigo de Barras #7
						updateCod7.execute();
						updateCod7.close();
					}
					if(!codBarras8.equalsIgnoreCase("")){
						PreparedStatement updateCod8;
						updateCod8= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod8.setInt(1, clavePLUFinal); // ID_Producto
						updateCod8.setString(2, codBarras8); //Codigo de Barras #8
						updateCod8.execute();
						updateCod8.close();
					}
					if(!codBarras9.equalsIgnoreCase("")){
						PreparedStatement updateCod9;
						updateCod9= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod9.setInt(1, clavePLUFinal); // ID_Producto
						updateCod9.setString(2, codBarras9); //Codigo de Barras #9
						updateCod9.execute();
						updateCod9.close();
					}
					if(!codBarras10.equalsIgnoreCase("")){
						PreparedStatement updateCod10;
						updateCod10= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod10.setInt(1, clavePLUFinal); // ID_Producto
						updateCod10.setString(2, codBarras10); //Codigo de Barras #10
						updateCod10.execute();
						updateCod10.close();
					}
					if(!codBarras11.equalsIgnoreCase("")){
						PreparedStatement updateCod11;
						updateCod11= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod11.setInt(1, clavePLUFinal); // ID_Producto
						updateCod11.setString(2, codBarras11); //Codigo de Barras #11
						updateCod11.execute();
						updateCod11.close();
					}
					if(!codBarras12.equalsIgnoreCase("")){
						PreparedStatement updateCod12;
						updateCod12= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
						updateCod12.setInt(1, clavePLUFinal); // ID_Producto
						updateCod12.setString(2, codBarras12); //Codigo de Barras #12
						updateCod12.execute();
						updateCod12.close();
					}
					// Voy a guardar tambien en mi tabla de escalonado si es el caso.
					if(tipoPrecio.equalsIgnoreCase("2")){
						PreparedStatement updateEscalon;
						if(cambiaAInt(pieza1) > 0){
							updateEscalon = con.miConnection.prepareStatement("insert into pescalonados values(?,?,?,?);");
							updateEscalon.setInt(1, clavePLUFinal); // ID_Producto
							updateEscalon.setInt(2, cambiaAInt(pieza1)-1); // ca_peEscalon
							updateEscalon.setDouble(3, cambiaADouble(precioE1)); // campoPrecio
							updateEscalon.setInt(4, 1); // activo
							updateEscalon.execute();
							updateEscalon.close();
						}
						if(cambiaAInt(pieza2) > 0){
							updateEscalon = con.miConnection.prepareStatement(	"insert into pescalonados values(?,?,?,?);");
							updateEscalon.setInt(1, clavePLUFinal); // ID_Producto
							updateEscalon.setInt(2, cambiaAInt(pieza2)-1); // ca_peEscalon
							updateEscalon.setDouble(3, cambiaADouble(precioE2)); // campoPrecio
							updateEscalon.setInt(4, 1); // activo
							updateEscalon.execute();
							updateEscalon.close();
						}
						if(cambiaAInt(pieza3) > 0){
							updateEscalon = con.miConnection.prepareStatement(	"insert into pescalonados values(?,?,?,?);");
							updateEscalon.setInt(1, clavePLUFinal); // ID_Producto
							updateEscalon.setInt(2, cambiaAInt(pieza3)-1); // ca_peEscalon
							updateEscalon.setDouble(3, cambiaADouble(precioE3)); // campoPrecio
							updateEscalon.setInt(4, 1); // activo
							updateEscalon.execute();
							updateEscalon.close();
						}
						if(cambiaAInt(pieza4) > 0){
							updateEscalon = con.miConnection.prepareStatement(	"insert into pescalonados values(?,?,?,?);");
							updateEscalon.setInt(1, clavePLUFinal); // ID_Producto
							updateEscalon.setInt(2, cambiaAInt(pieza4)-1); // ca_peEscalon
							updateEscalon.setDouble(3, cambiaADouble(precioE4)); // campoPrecio
							updateEscalon.setInt(4, 1); // activo
							updateEscalon.execute();
							updateEscalon.close();
						}
						if(cambiaAInt(pieza5) > 0){
							updateEscalon = con.miConnection.prepareStatement(	"insert into pescalonados values(?,?,?,?);");
							updateEscalon.setInt(1, clavePLUFinal); // ID_Producto
							updateEscalon.setInt(2, cambiaAInt(pieza5)-1); // ca_peEscalon
							updateEscalon.setDouble(3, cambiaADouble(precioE5)); // campoPrecio
							updateEscalon.setInt(4, 1); // activo
							updateEscalon.execute();
							updateEscalon.close();
						}
					}
				} // Cierra if
			}// Cierra try
			catch (SQLException sqle) {
				clavePLUFinal = 0;
				System.out.println("ERROR DE TIPO SQL!!!: ");
				sqle.printStackTrace();
				con.realizaRollback();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada";
			}
			catch (Exception q){
				clavePLUFinal = 0;
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.realizaCommit ( );
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPro metodo add_Producto");
					q.printStackTrace();
				}
			}
		}
		return clavePLUFinal;
	}


		public ResultSet listado_productoXCat(String formato) throws SQLException, Exception {
			String complemento = "";
			ResultSet rs = null;
			if(cambiaAInt(formato) == 1){
					complemento += "descripcion, genero";
			}
			else{
					complemento += "genero, descripcion";
			}
			con = new ConexionBD();
			if(con != null){
				try  {
					String queryString = ("SELECT ID_Pro, descripcion, genero FROM productos WHERE activo = 1 ORDER BY " +complemento);
					Statement stmt = con.miConnection.createStatement();
					rs = stmt.executeQuery(queryString);
				}
				catch (SQLException sqle) {
					error = "SQLException: Could not execute the query listado_productoXCat.";
					sqle.printStackTrace();
					throw new SQLException(error);
				}
				catch (Exception e) {
					error = "An exception occured while retrieving listado_productoXCat.";
					throw new Exception(error);
				}
			}
			return rs;
	}


	public boolean existeProductoActivo(String ID_Pro) throws SQLException, Exception{

		boolean bandera = false;
  		ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT productos.ID_Pro FROM productos WHERE productos.ID_Pro = "+cambiaAInt(ID_Pro)+" AND productos.activo = 1 ");
          Statement stmt = con.creaStatement();
          rs = stmt.executeQuery(queryString);
          while (rs.next()){
			  if(rs.getInt("ID_Pro") == cambiaAInt(ID_Pro));
			  bandera = true;
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query existeProductoActivo.";
          sqle.printStackTrace();
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving existeProductoActivo.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerPro metodo existeProductoActivo");
		   		q.printStackTrace();
		  	}
		}
        return bandera;
	}

/**
* El método datos_Producto se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto.
*  	@param 	plu  		String con el PLU correspondiente al Producto solicitado.
*	@return ResultSet	rs que contiene todos los datos correspondiente a un Producto.
*/
	public ResultSet datos_Producto(String ID_Pro) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT * FROM productos WHERE ID_Pro = "+cambiaAInt(ID_Pro)+" AND activo = 1");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query datos_Producto.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving datos_Producto.";
			throw new Exception(error);
		}
		return rs;
	}

/**
* El método datos_Codigo se encarga de enviar todos los codigos de Barra registrados dentro de la Base de Datos correspondientes a un Producto.
*  	@param 	plu  		String con el PLU correspondiente al Producto solicitado.
*	@return ResultSet	rs que contiene todos los datos correspondiente a un Producto.
*/
	public ResultSet datos_Codigo(String ID_Pro) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT * FROM codigosB WHERE ID_Pro = "+cambiaAInt(ID_Pro));
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query datos_Codigo.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving datos_Codigo.";
			throw new Exception(error);
		}
		return rs;
	}


/**
* El método datos_Escalonado se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto que es Escalonado.
*  	@param 	plu  		String con el PLU correspondiente al Producto solicitado.
*	@return ResultSet	rs que contiene todos los datos correspondiente a un Producto tipo Escalonado.
*/
	public ResultSet datos_Escalonado(String ID_Pro) throws SQLException, Exception {
		ResultSet rs = null;
		con2 = new ConexionBD();
		try  {
			String queryString = ("SELECT * FROM pescalonados WHERE ID_Pro = "+cambiaAInt(ID_Pro)+" AND activo = 1 ORDER BY ca_peEscalon");
			Statement stmt = con2.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query datos_Escalonado.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving datos_Escalonado.";
			throw new Exception(error);
		}
		return rs;
	}


/**
* El método mod_Producto se encarga de añadir los datos de un nuevo Producto dentro de la Base de Datos.
*  	@param 	plu  			String con el PLU del Producto solicitado.
*	@param 	textoarticulo	String con Descripción del Producto.
*	@param 	preciobase1		String con el Precio del Producto.
*	@param 	claseplu		Entero con el tipo de Producto.
*/

	//ARREGLAR DE ACUERDO A LA NUEVA TABLA!!!! Y LO QUE ENTRA!!!!!!!!
	public synchronized int  mod_Producto (String descripcion,String  tipo,String  iva,String  genero, String mp, String cortes, String  codBarras1,String  codBarras2,String  codBarras3, String  codBarras4,String  codBarras5,String  codBarras6,String  codBarras7,String  codBarras8,String  codBarras9,String  codBarras10,String  codBarras11, String  codBarras12, String  proveedor1,String  proveedor2,String  proveedor3,String  proveedor4,String  proveedor5,String  uniCompra,String  preUniCompra,String  preCaCompra,String  piezasc, String preKgCompra,String  kgXUni,String  tipoPrecio,String  manejo,String  precioMenu,String  precioMenuC,String  precioMM,String  precioMMC,String  precioM,String  precioMC, String  pieza1,String  precioE1,String  pieza2,String  precioE2,String  pieza3,String  precioE3,String  pieza4,String  precioE4,String  pieza5,String  precioE5,String  maxInv, String  minInv, String ID_Pro ) throws SQLException, Exception {
		int exito = 1;
		boolean codigoRepetido = dimeCodigoRepetido(codBarras1, codBarras2, codBarras3, codBarras4,  codBarras5,  codBarras6, codBarras7, codBarras8,  codBarras9, codBarras10, codBarras11,  codBarras12);
		if(codigoRepetido){
			return -1;
		}
		String queryString = "";
		boolean existe = existeEscalon(cambiaAInt(ID_Pro));
		con = new ConexionBD();
		con.cancelaAutoCommit();
		ResultSet rs = null;
		ResultSet rs2 = null;
		if (con.miConnection != null) {
			try {
				Statement stmt = con.creaStatement();
				if(existe){
					queryString = "DELETE FROM pescalonados WHERE ID_Pro = "+cambiaAInt(ID_Pro);
					stmt.execute(queryString);
					stmt.close();
				}
				else{
					queryString = "DELETE FROM ganancia_porcentual  WHERE ID_Pro = "+cambiaAInt(ID_Pro);
					stmt.execute(queryString);
					stmt.close();
				}
				stmt = con.creaStatement();
				queryString = "DELETE FROM codigosB WHERE ID_Pro = " +ID_Pro;
				stmt.execute(queryString);
				stmt.close();
				PreparedStatement updateProducto;
				updateProducto = con.miConnection.prepareStatement(	"UPDATE productos SET  descripcion = ?, tipoPro =  ?, gravaIVA =  ?, genero = ?,  materiaPrima = ?, cortes = ?,  id_prov1 =  ?, id_prov2 = ?, id_prov3 = ?, id_prov4 = ?,id_prov5 = ?,  uniCompra = ?, precioUniCompra = ?, preCaCompra = ?, cantidadXCaja = ?,  precioUnidadKG = ?,  kgXUnidad= ?, tipoPrecio = ?,  manejoPrecio = ?, precioMenu = ?,  precioMenuC = ?,  precioMM = ?,  precioMMC =?,  precioM = ?,  precioMC = ?,  maxInv = ?,  minInv = ?  WHERE ID_Pro = ? AND activo = 1");
				updateProducto.setString(1, descripcion); //descripcion
				updateProducto.setInt(2, cambiaAInt(tipo)); //tipoProducto
				updateProducto.setInt(3, cambiaAInt(iva));  //gravaIVA
				updateProducto.setInt(4, cambiaAInt(genero)); //genero
				updateProducto.setInt(5, cambiaAInt(mp));  //Materia Prima
				updateProducto.setInt(6, cambiaAInt(cortes));  //Producto Cortes
				updateProducto.setString(7, proveedor1); //id_proveedor1
				updateProducto.setString(8, proveedor2); //id_proveedor2
				updateProducto.setString(9, proveedor3); //id_proveedor3
				updateProducto.setString(10, proveedor4); //id_proveedor4
				updateProducto.setString(11, proveedor5); //id_proveedor5
				updateProducto.setInt(12, cambiaAInt(uniCompra)); //uniCompra
				updateProducto.setDouble(13, cambiaADouble(preUniCompra)); // precioUnidadCompra
				updateProducto.setDouble(14, cambiaADouble(preCaCompra)); // PrecioCajaCompra
				updateProducto.setInt(15, cambiaAInt(piezasc)); //cantidad de piezas en Caja
				updateProducto.setDouble(16, cambiaADouble(preKgCompra)); // precio Unidad en Kg.
				updateProducto.setDouble(17, cambiaADouble(kgXUni)); // Kilos por Unidad
				updateProducto.setInt(18, cambiaAInt(tipoPrecio)); // Tipo de Precio
				updateProducto.setInt(19, cambiaAInt(manejo)); //Manejo de Precio
				updateProducto.setDouble(20, cambiaADouble(precioMenu)); // Precio Base x pza
				updateProducto.setDouble(21, cambiaADouble(precioMenuC)); // Precio Base x caja
				updateProducto.setDouble(22, cambiaADouble(precioMM)); // Precio G1 x pza
				updateProducto.setDouble(23, cambiaADouble(precioMMC)); // Precio G1 x caja
				updateProducto.setDouble(24, cambiaADouble(precioM)); // Precio G2 x pza
				updateProducto.setDouble(25, cambiaADouble(precioMC)); // Precio G2 x caja
				updateProducto.setDouble(26, cambiaADouble(maxInv)); // Maximo del producto en inventario
				updateProducto.setDouble(27, cambiaADouble(minInv)); // Minimo del producto en Inventario
				updateProducto.setInt(28, cambiaAInt(ID_Pro));//Activo
				updateProducto.execute();
				updateProducto.close();
// Primero calculo y almaceno porcentual de ganacia por producto siempre y cuando no sea precio escalonado
				if(cambiaAInt(tipoPrecio) != 2){ // No es escalon
					BigDecimal constante100 = new BigDecimal("100.0");
					if(cambiaAInt(tipo) == 0){ // Es por Pieza o Caja.
						if(cambiaAInt(manejo) == 0 || cambiaAInt(manejo) == 1){ // Hablamos  de pieza
							if(cambiaADouble(preUniCompra) <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
								preUniCompra = (cambiaADouble(preCaCompra)/cambiaADouble(piezasc))+"";
							}
							BigDecimal PVenta = new BigDecimal(remueveComas(precioMenu));
							BigDecimal PCompra = new BigDecimal(remueveComas(preUniCompra));
							BigDecimal gananciaPorcentual = new BigDecimal("0.0");
							gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
							gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
							PreparedStatement creaGananciaPorcentual;
							creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
							creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
							creaGananciaPorcentual.setInt(2, 1); //PrecioTipo
							creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
							creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
							creaGananciaPorcentual.execute();
							creaGananciaPorcentual.close();
						}
						if(cambiaAInt(manejo)==1){//Hablamos de Caja Tambien:
							if(cambiaADouble(preCaCompra) <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
								preCaCompra = (cambiaADouble(preUniCompra)*cambiaADouble(piezasc))+"";
							}
							BigDecimal PVenta = new BigDecimal(remueveComas(precioMenuC));
							BigDecimal PCompra = new BigDecimal(remueveComas(preCaCompra));
							BigDecimal gananciaPorcentual = new BigDecimal("0.0");
							gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
							gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
							PreparedStatement creaGananciaPorcentual;
							creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
							creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
							creaGananciaPorcentual.setInt(2, 2); //PrecioTipo
							creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
							creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
							creaGananciaPorcentual.execute();
							creaGananciaPorcentual.close();
						}
						if(cambiaAInt(tipoPrecio) == 1){ // Hablamos de Grupo de Precios
							if(cambiaAInt(manejo) == 0 || cambiaAInt(manejo) == 1){ // Hablamos  de pieza
								if(cambiaADouble(preUniCompra) <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
									preUniCompra = (cambiaADouble(preCaCompra)/cambiaADouble(piezasc))+"";
								}
								BigDecimal PVenta = new BigDecimal(remueveComas(precioMM));
								BigDecimal PCompra = new BigDecimal(remueveComas(preUniCompra));
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
								creaGananciaPorcentual.setInt(2, 3); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
								PVenta = new BigDecimal(remueveComas(precioM));
								PCompra = new BigDecimal(remueveComas(preUniCompra));
								gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
								creaGananciaPorcentual.setInt(2, 5); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(cambiaAInt(manejo)==1){//Hablamos de Caja Tambien:
								if(cambiaADouble(preCaCompra) <= 0.00){ // Checo si no se ingreso precio por unidad de compra y lo calculo.
									preCaCompra = (cambiaADouble(preUniCompra)*cambiaADouble(piezasc))+"";
								}
								BigDecimal PVenta = new BigDecimal(remueveComas(precioMMC));
								BigDecimal PCompra = new BigDecimal(remueveComas(preCaCompra));
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
								creaGananciaPorcentual.setInt(2, 4); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
								PVenta = new BigDecimal(remueveComas(precioMC));
								PCompra = new BigDecimal(remueveComas(preCaCompra));
								gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
								creaGananciaPorcentual.setInt(2, 6); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
						}
					}
					else if(cambiaAInt(tipo) == 1){ // Es por Pesaje
						if(cambiaAInt(manejo) == 0 || cambiaAInt(manejo) == 2){ // Hablamos  de Kg y Pieza
							BigDecimal PVenta = new BigDecimal(remueveComas(precioMenu));
							BigDecimal PCompra = new BigDecimal(remueveComas(preKgCompra));
							BigDecimal gananciaPorcentual = new BigDecimal("0.0");
							gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
							gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
							PreparedStatement creaGananciaPorcentual;
							creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
							creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
							creaGananciaPorcentual.setInt(2, 1); //PrecioTipo
							creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
							creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
							creaGananciaPorcentual.execute();
							creaGananciaPorcentual.close();
						}
						if(cambiaAInt(manejo)==2){//Hablamos de Pieza Tambien:
							double prePzXKg = cambiaADouble(preKgCompra)*(cambiaADouble(kgXUni));
							BigDecimal PVenta = new BigDecimal(remueveComas(precioMenuC));
							BigDecimal PCompra = new BigDecimal(prePzXKg+"");
							BigDecimal gananciaPorcentual = new BigDecimal("0.0");
							gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
							gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
							PreparedStatement creaGananciaPorcentual;
							creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
							creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
							creaGananciaPorcentual.setInt(2, 2); //PrecioTipo
							creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
							creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
							creaGananciaPorcentual.execute();
							creaGananciaPorcentual.close();
						}
						if(cambiaAInt(tipoPrecio) == 1){ // Hablamos de Grupo de Precios
							if(cambiaAInt(manejo) == 0 || cambiaAInt(manejo) == 2){ // Hablamos  de pieza
								BigDecimal PVenta = new BigDecimal(remueveComas(precioMM));
								BigDecimal PCompra = new BigDecimal(remueveComas(preKgCompra));
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
								creaGananciaPorcentual.setInt(2, 3); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
								PVenta = new BigDecimal(remueveComas(precioM));
								PCompra = new BigDecimal(remueveComas(preKgCompra));
								gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
								creaGananciaPorcentual.setInt(2, 5); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
							if(cambiaAInt(manejo)==2){//Hablamos de Pieza Tambien:
								double prePzXKg = cambiaADouble(preKgCompra)*(cambiaADouble(kgXUni));
								BigDecimal PVenta = new BigDecimal(remueveComas(precioMMC));
								BigDecimal PCompra = new BigDecimal(prePzXKg+"");
								BigDecimal gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement creaGananciaPorcentual;
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
								creaGananciaPorcentual.setInt(2, 4); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(remueveComas(gananciaPorcentual.toString()))); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
								PVenta = new BigDecimal(remueveComas(precioMC));
								PCompra = new BigDecimal(prePzXKg+"");
								gananciaPorcentual = new BigDecimal("0.0");
								gananciaPorcentual = (((constante100.multiply(PVenta)).divide(PCompra,new MathContext(100))).subtract(constante100));
								gananciaPorcentual = gananciaPorcentual.setScale(3, RoundingMode.HALF_UP);
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
								creaGananciaPorcentual.setInt(1,cambiaAInt(ID_Pro));// ID_Pro
								creaGananciaPorcentual.setInt(2, 6); //PrecioTipo
								creaGananciaPorcentual.setDouble(3, cambiaADouble(gananciaPorcentual.toString())); //porcentaje de Ganancia
								creaGananciaPorcentual.setInt(4, cambiaAInt(tipo));  //Tipo Producto
								creaGananciaPorcentual.execute();
								creaGananciaPorcentual.close();
							}
						}
					}
				}
// Comienzo a almacenar codigos de barra...
				if(!codBarras1.equalsIgnoreCase("")){
					PreparedStatement updateCod1;
					updateCod1= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod1.setInt(1, cambiaAInt(ID_Pro)); //ID_Producto
					updateCod1.setString(2, codBarras1); //Codigo de Barras #1
					updateCod1.execute();
					updateCod1.close();
				}
				if(!codBarras2.equalsIgnoreCase("")){
					PreparedStatement updateCod2;
					updateCod2= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod2.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod2.setString(2, codBarras2); //Codigo de Barras #2
					updateCod2.execute();
					updateCod2.close();
				}
				if(!codBarras3.equalsIgnoreCase("")){
					PreparedStatement updateCod3;
					updateCod3= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod3.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod3.setString(2, codBarras3); //Codigo de Barras #3
					updateCod3.execute();
					updateCod3.close();
				}
				if(!codBarras4.equalsIgnoreCase("")){
					PreparedStatement updateCod4;
					updateCod4= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod4.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod4.setString(2, codBarras4); //Codigo de Barras #4
					updateCod4.execute();
					updateCod4.close();
				}
				if(!codBarras5.equalsIgnoreCase("")){
					PreparedStatement updateCod5;
					updateCod5= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod5.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod5.setString(2, codBarras5); //Codigo de Barras #5
					updateCod5.execute();
					updateCod5.close();
				}
				if(!codBarras6.equalsIgnoreCase("")){
					PreparedStatement updateCod6;
					updateCod6= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod6.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod6.setString(2, codBarras6); //Codigo de Barras #6
					updateCod6.execute();
					updateCod6.close();
				}
				if(!codBarras7.equalsIgnoreCase("")){
					PreparedStatement updateCod7;
					updateCod7= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod7.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod7.setString(2, codBarras7); //Codigo de Barras #7
					updateCod7.execute();
					updateCod7.close();
				}
				if(!codBarras8.equalsIgnoreCase("")){
					PreparedStatement updateCod8;
					updateCod8= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod8.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod8.setString(2, codBarras8); //Codigo de Barras #8
					updateCod8.execute();
					updateCod8.close();
				}
				if(!codBarras9.equalsIgnoreCase("")){
					PreparedStatement updateCod9;
					updateCod9= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod9.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod9.setString(2, codBarras9); //Codigo de Barras #9
					updateCod9.execute();
					updateCod9.close();
				}
				if(!codBarras10.equalsIgnoreCase("")){
					PreparedStatement updateCod10;
					updateCod10= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod10.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod10.setString(2, codBarras10); //Codigo de Barras #10
					updateCod10.execute();
					updateCod10.close();
				}
				if(!codBarras11.equalsIgnoreCase("")){
					PreparedStatement updateCod11;
					updateCod11= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod11.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod11.setString(2, codBarras11); //Codigo de Barras #11
					updateCod11.execute();
					updateCod11.close();
				}
				if(!codBarras12.equalsIgnoreCase("")){
					PreparedStatement updateCod12;
					updateCod12= con.miConnection.prepareStatement("insert into codigosB values(?,?);");
					updateCod12.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
					updateCod12.setString(2, codBarras12); //Codigo de Barras #12
					updateCod12.execute();
					updateCod12.close();
				}
				// Voy a guardar tambien en mi tabla de escalonado si es el caso.
				if(tipoPrecio.equalsIgnoreCase("2")){
					PreparedStatement updateEscalon;
					if(cambiaAInt(pieza1) > 0){
						updateEscalon = con.miConnection.prepareStatement("insert into pescalonados values(?,?,?,?);");
						updateEscalon.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
						updateEscalon.setInt(2, cambiaAInt(pieza1)-1); // ca_peEscalon
						updateEscalon.setDouble(3, cambiaADouble(precioE1)); // campoPrecio
						updateEscalon.setInt(4, 1); // activo
						updateEscalon.execute();
						updateEscalon.close();
					}
					if(cambiaAInt(pieza2) > 0){
						updateEscalon = con.miConnection.prepareStatement(	"insert into pescalonados values(?,?,?,?);");
						updateEscalon.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
						updateEscalon.setInt(2, cambiaAInt(pieza2)-1); // ca_peEscalon
						updateEscalon.setDouble(3, cambiaADouble(precioE2)); // campoPrecio
						updateEscalon.setInt(4, 1); // activo
						updateEscalon.execute();
						updateEscalon.close();
					}
					if(cambiaAInt(pieza3) > 0){
						updateEscalon = con.miConnection.prepareStatement(	"insert into pescalonados values(?,?,?,?);");
						updateEscalon.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
						updateEscalon.setInt(2, cambiaAInt(pieza3)-1); // ca_peEscalon
						updateEscalon.setDouble(3, cambiaADouble(precioE3)); // campoPrecio
						updateEscalon.setInt(4, 1); // activo
						updateEscalon.execute();
						updateEscalon.close();
					}
					if(cambiaAInt(pieza4) > 0){
						updateEscalon = con.miConnection.prepareStatement(	"insert into pescalonados values(?,?,?,?);");
						updateEscalon.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
						updateEscalon.setInt(2, cambiaAInt(pieza4)-1); // ca_peEscalon
						updateEscalon.setDouble(3, cambiaADouble(precioE4)); // campoPrecio
						updateEscalon.setInt(4, 1); // activo
						updateEscalon.execute();
						updateEscalon.close();
					}
					if(cambiaAInt(pieza5) > 0){
						updateEscalon = con.miConnection.prepareStatement(	"insert into pescalonados values(?,?,?,?);");
						updateEscalon.setInt(1, cambiaAInt(ID_Pro)); // ID_Producto
						updateEscalon.setInt(2, cambiaAInt(pieza5)-1); // ca_peEscalon
						updateEscalon.setDouble(3, cambiaADouble(precioE5)); // campoPrecio
						updateEscalon.setInt(4, 1); // activo
						updateEscalon.execute();
						updateEscalon.close();
					}
				}
				con.realizaCommit();
			}// Cierra try
			catch (SQLException sqle) {
				exito = 0;
				sqle.printStackTrace();
				con.realizaRollback();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada mod_Producto";
			}
			catch (Exception q){
				 exito = 0;
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPro metodo mod_Producto");
					q.printStackTrace();
				}
			}
		}
		return exito;
	}


/**
* El método existe2 verifica que el Producto solicitado existe dentro de nuestra Base de Datos y se encuentre habilitado, es decir que no haya sido dado de baja.
*  	@param 	plu  		String con el plu del Producto solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public boolean existe2(String plu) throws SQLException, Exception    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean existe = false;
	  con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {
  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("SELECT * FROM productos WHERE ID_Pro = "+cambiaAInt(plu)+"  AND activo = 1");
  	  		while(rs.next()){
  	  			if(rs.getInt("ID_Pro") == cambiaAInt(plu)){
  	  				existe  = true;//realiza comparación con la base de datos
  	  			}
  	  		}
  	  		rs.close();
  	  		st.close();
  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		 finally{
	  		 	try{
	  		 		con.cierraConexion();
	  			}
	  		 	catch (Exception q){
	  		 		System.out.println("Error al cerrar conexion de ManagerPro metodo existe2");
	  		 		q.printStackTrace();
	  			}
			 }
  	  }
  	  return existe;
  }

  /**
  * El método baja_Producto se encarga de colocar un 0 en el campo "activo" del Producto en la Base de Datos, para realizar una Baja lógica del Producto correspondiente.
  *  	@param 	plu		String con el plu del Producto solicitado.
  *	@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */

	public boolean baja_Producto(String plu) throws SQLException, Exception {
		boolean exito =  true;
		try  {
			con = new ConexionBD();
			con.cancelaAutoCommit();
			String queryString = "UPDATE productos SET activo = 0 WHERE ID_Pro  = "+cambiaAInt(plu);
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);
			queryString = "DELETE FROM pescalonados WHERE ID_Pro = "+cambiaAInt(plu);
			stmt.execute(queryString);
			queryString = "DELETE FROM ganancia_porcentual  WHERE ID_Pro = "+cambiaAInt(plu);
			stmt.execute(queryString);
			queryString = ("DELETE FROM codigosB WHERE ID_Pro =  "+cambiaAInt(plu));
			stmt.execute(queryString);
			stmt.close();
			con.realizaCommit ( );
		}
		catch (SQLException sqle) {
			exito = false;
			con.realizaRollback();
			error = "SQLException: Could not execute the query. ManagerPro metodo baja_Producto";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			exito = false;
			con.realizaRollback();
			error = "An exception occured while retrieving ManagerPro metodo baja_Producto.";
			e.printStackTrace();
		}
		finally{
			try{
				con.habilitaAutoCommit();
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerPro metodo baja_Producto");
				q.printStackTrace();
			}
		}
		return exito;
	}

/**
* El método listadoPorCodigos se encarga de enviar la lista de todos los productos que tienen registrados por lo menos un codigo de barras.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a todos los Productos con codigo.
*/
  public ResultSet listadoPorCodigos(String orden) throws SQLException, Exception {
		String complemento = " productos.descripcion";
		int tipo = cambiaAInt(orden);
		if(tipo == 2){
			complemento = " productos.ID_Pro";
		}
		else if(tipo == 3){
			complemento = " productos.genero, productos.descripcion";
		}
		else if(tipo ==4){
			complemento = " productos.genero, productos.ID_Pro";
		}
          ResultSet rs = null;
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT productos.ID_Pro, productos.descripcion, productos.genero, codigosb.codBarra FROM codigosb, productos WHERE productos.ID_Pro = codigosb.ID_Pro AND productos.activo = 1 ORDER BY " +complemento);
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query listadoPorCodigos.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving listadoPorCodigos.";
            throw new Exception(error);
          }
          return rs;
  }

/**
* El método dameProductos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Productos que se encuentren activos.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a todos los Productos.
*/

	public ResultSet listadoProductos(String orden) throws SQLException, Exception {
		ResultSet rs = null;
		String complemento = " descripcion";
		int tipo = cambiaAInt(orden);
		if(tipo == 2){
			complemento = " ID_Pro";
		}
		else if(tipo == 3){
			complemento = " genero,descripcion";
		}
		else if(tipo ==4){
			complemento = " genero,ID_Pro";
		}
		con = new ConexionBD();
		if(con != null){
			try  {
				String queryString = ("SELECT * FROM productos WHERE activo = 1 ORDER BY "+complemento);
//				System.out.println(queryString);
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL metodo listadoProductos en ManagerPro");
				error = "SQLException: Could not execute the query listadoProductos.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				System.out.println("Error metodo listadoProductos en ManagerPro");
				error = "An exception occured while retrieving listadoProductos.";
				throw new Exception(error);
			}
		}
	return rs;
	}


/**
* El método dameProductos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Productos que se encuentren activos.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a todos los Productos.
*/

	public ResultSet dameInfoEscalon(String claveProducto) throws SQLException, Exception {
		ResultSet rs = null;
		con2 = new ConexionBD();
		if(con2 != null){
			try  {
				String queryString = ("SELECT ca_peEscalon, campoPrecio FROM pescalonados WHERE ID_Pro = "+claveProducto +" AND  activo = 1 ORDER BY ca_peEscalon");
//				System.out.println(queryString);
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL metodo dameInfoEscalon en ManagerInventarios");
				error = "SQLException: Could not execute the query dameInfoEscalon.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				System.out.println("Error metodo dameInfoEscalon en ManagerInventarios");
				error = "An exception occured while retrieving dameInfoEscalon.";
				throw new Exception(error);
			}
		}
	return rs;
	}



	public void cierraConexion (){
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerPro");
				q.printStackTrace();
			}
		}
	}

	public void cierraConexion2 (){
		if(con2 != null){
			try{
				con2.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion2 de ManagerPro");
				q.printStackTrace();
			}
		}
	}


	public ResultSet listadoGralProductos() throws SQLException, Exception {
		String complemento = "";
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try  {
				String queryString = ("SELECT ID_Pro, descripcion, genero, maxInv, minInv, invTienda, invAlmacen,  tipoPro FROM productos WHERE activo = 1 ORDER BY descripcion");
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				error = "SQLException: Could not execute the query listadoGralProductos.";
				sqle.printStackTrace();
				throw new SQLException(error);
			}
			catch (Exception e) {
				error = "An exception occured while retrieving listadoGralProductos.";
				throw new Exception(error);
			}
		}
		return rs;
	}



///////////////////////////////////
    ///////////////////////
        ////////////
          /////
		   //
	// Métodos Sin revisar


 public ResultSet Producto_Mes(String fecha0, String producto) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT orden_compra.claveOrden, proveedores.nombre, orden_compra.fechaEntrega, orden_compra.docAval, productos_orden.Cantidad,  productos_orden.Llegan, productos_orden.Tipo FROM orden_compra, productos_orden, proveedores  WHERE orden_compra.FechaEntrega like '"+fecha0+"%%' AND orden_compra.activo = 1 AND orden_compra.ClaveOrden = productos_orden.ClaveOrden AND productos_orden.ClaveProducto = "+producto+" AND proveedores.rfc = orden_compra.claveProveedor ORDER BY orden_compra.fechaEntrega");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Producto_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Producto_Mes.";
          throw new Exception(error);
        }
        return rs;
  }














/**
* El método existe verifica que el Producto solicitado existe dentro de nuestra Base de Datos.
*  	@param 	plu  		String con el RFC del cliente solicitado.
*	@return int		 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public int existe(String plu) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
  	  String activo = "1";
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select * from productos WHERE ACTIVO = 1");
  	  		while(rs.next()){

  	  			if(plu.equals(rs.getString("plu")) && activo.equals(rs.getString("activo"))) {
  	  				bandera = 1;//realiza comparación con la base de datos
  	  				}
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPro metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }


/**
* El método valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	plu  			String con el PLU del Producto solicitado.
*	@param 	textoarticulo	String con Descripción del Producto.
*	@param 	preciobase1		String con el Precio del Producto.
*	@param 	claseplu		String con el tipo de Producto.
*	@return boolean 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public boolean valida_add(String plu, String textoarticulo, String preciobase1, String claseplu) {
		return ((plu != null) && (plu.length() > 0) &&
				(textoarticulo != null) && (textoarticulo.length() > 0) &&
				(preciobase1 != null) && (preciobase1.length() > 0) &&
				(claseplu != null) && (claseplu.length() > 0));
  }


/**
* El método codBarrasR verifica que no se encuentre repetido dentro de nuestra BD el codigo de Barras.
*  	@param codBarras String que representa el codigo de barras a asignar a un producto
*	@return String	Representa el PLU del producto con el codigo de barras repetido.
*/

	public String codBarrasR(String codBarra) throws SQLException, Exception {
		Statement st = null;
		ResultSet rs= null;
		String productoRepetido = "";
		if(!(codBarra.equalsIgnoreCase(""))){
			con = new ConexionBD();
			if (con.miConnection !=null) {
				try {
					st = con.creaStatement();
					rs = st.executeQuery("select ID_Pro, codBarra from codigosB WHERE codBarra = '"+codBarra +"'");
					while(rs.next()){
						productoRepetido = "El producto con clave: " +rs.getInt("ID_Pro") +", repite el código de barras: " +rs.getString("codBarra")+". ";
					}
				}
				catch (Exception ex) {
					ex.printStackTrace();
				}
				finally{
					try{
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al cerrar conexion de ManagerPro metodo codBarrasR");
						q.printStackTrace();
					}
				}
			}
		}
		return productoRepetido;
	}

	public String codBarrasR(String codBarra, String ID_Pro) throws SQLException, Exception {
		int ID_Pro2 = cambiaAInt(ID_Pro);
		Statement st = null;
		ResultSet rs= null;
		String productoRepetido = "";
		if(!(codBarra.equalsIgnoreCase(""))){
			con = new ConexionBD();
			if (con.miConnection !=null) {
				try {
					st = con.creaStatement();
					rs = st.executeQuery("select ID_Pro, codBarra from codigosB WHERE codBarra = '"+codBarra +"' AND ID_Pro != "+ID_Pro2);
					while(rs.next()){
						productoRepetido = "El producto con clave: " +rs.getInt("ID_Pro") +", repite el código de barras: " +rs.getString("codBarra")+". ";
					}
				}
				catch (Exception ex) {
					ex.printStackTrace();
				}
				finally{
					try{
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al cerrar conexion de ManagerPro metodo codBarrasR");
						q.printStackTrace();
					}
				}
			}
		}
		return productoRepetido;
	}


/**
* El método dimeCodigoRepetido se encarga de añadir los datos de un nuevo Producto dentro de la Base de Datos.
*  	@param 	plu  			String con el PLU del Producto solicitado.
*	@param 	textoarticulo	String con Descripción del Producto.
*	@param 	preciobase1		String con el Precio del Producto.
*	@param 	claseplu		Entero con el tipo de Producto.
*/

	public boolean dimeCodigoRepetido(String  codBarras1,String  codBarras2,String  codBarras3, String  codBarras4,String  codBarras5,String  codBarras6,String  codBarras7,String  codBarras8,String  codBarras9,String  codBarras10,String  codBarras11, String  codBarras12) throws Exception{
		boolean hayRepetido = false;
		if(codBarras1.trim().length() > 0){
			if(codBarras1.equals(codBarras2.trim()) || codBarras1.equals(codBarras3.trim()) || codBarras1.equals(codBarras4.trim()) || codBarras1.equals(codBarras5.trim()) || codBarras1.equals(codBarras6.trim()) || codBarras1.equals(codBarras7.trim()) || codBarras1.equals(codBarras8.trim()) || codBarras1.equals(codBarras9.trim()) || codBarras1.equals(codBarras10.trim()) || codBarras1.equals(codBarras11.trim()) || codBarras1.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras2.trim().length() > 0 && !hayRepetido){
			if(codBarras2.equals(codBarras1.trim()) || codBarras2.equals(codBarras3.trim()) || codBarras2.equals(codBarras4.trim()) || codBarras2.equals(codBarras5.trim()) || codBarras2.equals(codBarras6.trim()) || codBarras2.equals(codBarras7.trim()) || codBarras2.equals(codBarras8.trim()) || codBarras2.equals(codBarras9.trim()) || codBarras2.equals(codBarras10.trim()) || codBarras2.equals(codBarras11.trim()) || codBarras2.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras3.trim().length() > 0  && !hayRepetido){
			if(codBarras3.equals(codBarras2.trim()) || codBarras3.equals(codBarras1.trim()) || codBarras3.equals(codBarras4.trim()) || codBarras3.equals(codBarras5.trim()) || codBarras3.equals(codBarras6.trim()) || codBarras3.equals(codBarras7.trim()) || codBarras3.equals(codBarras8.trim()) || codBarras3.equals(codBarras9.trim()) || codBarras3.equals(codBarras10.trim()) || codBarras3.equals(codBarras11.trim()) || codBarras3.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras4.trim().length() > 0  && !hayRepetido){
			if(codBarras4.equals(codBarras2.trim()) || codBarras4.equals(codBarras3.trim()) || codBarras4.equals(codBarras1.trim()) || codBarras4.equals(codBarras5.trim()) || codBarras4.equals(codBarras6.trim()) || codBarras4.equals(codBarras7.trim()) || codBarras4.equals(codBarras8.trim()) || codBarras4.equals(codBarras9.trim()) || codBarras4.equals(codBarras10.trim()) || codBarras4.equals(codBarras11.trim()) || codBarras4.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras5.trim().length() > 0  && !hayRepetido){
			if(codBarras5.equals(codBarras2.trim()) || codBarras5.equals(codBarras3.trim()) || codBarras5.equals(codBarras4.trim()) || codBarras5.equals(codBarras1.trim()) || codBarras5.equals(codBarras6.trim()) || codBarras5.equals(codBarras7.trim()) || codBarras5.equals(codBarras8.trim()) || codBarras5.equals(codBarras9.trim()) || codBarras5.equals(codBarras10.trim()) || codBarras5.equals(codBarras11.trim()) || codBarras5.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras6.trim().length() > 0  && !hayRepetido){
			if(codBarras6.equals(codBarras2.trim()) || codBarras6.equals(codBarras3.trim()) || codBarras6.equals(codBarras4.trim()) || codBarras6.equals(codBarras5.trim()) || codBarras6.equals(codBarras1.trim()) || codBarras6.equals(codBarras7.trim()) || codBarras6.equals(codBarras8.trim()) || codBarras6.equals(codBarras9.trim()) || codBarras6.equals(codBarras10.trim()) || codBarras6.equals(codBarras11.trim()) || codBarras6.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras7.trim().length() > 0  && !hayRepetido){
			if(codBarras7.equals(codBarras2.trim()) || codBarras7.equals(codBarras3.trim()) || codBarras7.equals(codBarras4.trim()) || codBarras7.equals( codBarras5.trim()) || codBarras7.equals(codBarras6.trim()) || codBarras7.equals(codBarras1.trim()) || codBarras7.equals(codBarras8.trim()) || codBarras7.equals(codBarras9.trim()) || codBarras7.equals(codBarras10.trim()) || codBarras7.equals(codBarras11.trim()) || codBarras7.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras8.trim().length() > 0  && !hayRepetido){
			if(codBarras8.equals(codBarras2.trim()) || codBarras8.equals(codBarras3.trim()) || codBarras8.equals(codBarras4.trim()) || codBarras8.equals(codBarras5.trim()) || codBarras8.equals(codBarras6.trim()) || codBarras8.equals(codBarras7.trim()) || codBarras8.equals(codBarras1.trim()) || codBarras8.equals(codBarras9.trim()) || codBarras8.equals(codBarras10.trim()) || codBarras8.equals(codBarras11.trim()) || codBarras8.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras9.trim().length() > 0 && !hayRepetido){
			if(codBarras9.equals(codBarras2.trim()) || codBarras9.equals(codBarras3.trim()) || codBarras9.equals(codBarras4.trim()) || codBarras9.equals(codBarras5.trim()) || codBarras9.equals(codBarras6.trim()) || codBarras9.equals(codBarras7.trim()) || codBarras9.equals(codBarras8.trim()) || codBarras9.equals(codBarras1.trim()) || codBarras9.equals(codBarras10.trim()) || codBarras9.equals(codBarras11.trim()) || codBarras9.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras10.trim().length() > 0 && !hayRepetido){
			if(codBarras10.equals(codBarras2.trim()) || codBarras10.equals(codBarras3.trim()) || codBarras10.equals(codBarras4.trim()) || codBarras10.equals(codBarras5.trim()) || codBarras10.equals(codBarras6.trim()) || codBarras10.equals(codBarras7.trim()) || codBarras10.equals(codBarras8.trim()) || codBarras10.equals(codBarras9.trim()) || codBarras10.equals(codBarras1.trim()) || codBarras10.equals(codBarras11.trim()) || codBarras10.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras11.trim().length() > 0  && !hayRepetido){
			if(codBarras11.equals(codBarras2.trim()) || codBarras11.equals(codBarras3.trim()) || codBarras11.equals(codBarras4.trim()) || codBarras11.equals(codBarras5.trim()) || codBarras11.equals(codBarras6.trim()) || codBarras11.equals(codBarras7.trim()) || codBarras11.equals(codBarras8.trim()) || codBarras11.equals(codBarras9.trim()) || codBarras11.equals(codBarras10.trim()) || codBarras11.equals(codBarras1.trim()) || codBarras11.equals(codBarras12.trim())){
				hayRepetido = true;
			}
		}

		if(codBarras12.trim().length() > 0  && !hayRepetido){
			if(codBarras12.equals(codBarras2.trim()) || codBarras12.equals(codBarras3.trim()) || codBarras12.equals(codBarras4.trim()) || codBarras12.equals(codBarras5.trim()) || codBarras12.equals(codBarras6.trim()) || codBarras12.equals(codBarras7.trim()) || codBarras12.equals(codBarras8. trim()) || codBarras12.equals(codBarras9.trim()) || codBarras12.equals(codBarras10.trim()) || codBarras12.equals(codBarras11.trim()) || codBarras12.equals(codBarras1.trim())){
				hayRepetido = true;
			}
		}
		return hayRepetido;
	}


// Checo si actualmente el producto posee un escalon.
  	public boolean existeEscalon(int ID_Pro) throws Exception{
		boolean bandera = false;
  		ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT ID_Pro FROM pescalonados WHERE ID_Pro = "+ID_Pro +" AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
          while (rs.next()){
			  if(rs.getInt("ID_Pro") == ID_Pro);
			  bandera = true;
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query existeEscalon.";
          sqle.printStackTrace();
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving existeEscalon.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerPro metodo existeEscalon");
		   		q.printStackTrace();
		  	}
		}
        return bandera;
	}



	public void bajaEscalon(String plu) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = "DELETE FROM pescalonados WHERE plu ='"+plu+"'";
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Could not execute the query bajaEscalon.";
			sqle.printStackTrace();
			throw new SQLException(error);
		} catch (Exception e) {
			error = "An exception occured while retrieving bajaEscalon.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerPro metodo bajaEscalon");
				q.printStackTrace();
			}
		}
	}


	public void addDatosProdEscalonado(String plu, String subDepto, String idOferta, String numOrden, String ca_peEscalon, String dCampoPrecio, String campoBit, String formaEscalon, String tipoEscalon){
		boolean salida = true;
		try{
			con = new ConexionBD();
			if (con.miConnection != null) {
				PreparedStatement updateTablaPreciosEscalonados;
				updateTablaPreciosEscalonados = con.miConnection.prepareStatement(	"INSERT INTO pescalonados VALUES(?,?,?,?,?,?,?,?,?,?);");
				updateTablaPreciosEscalonados.setString(1, plu);
				updateTablaPreciosEscalonados.setString(2, subDepto);
				updateTablaPreciosEscalonados.setString(3, idOferta);
				updateTablaPreciosEscalonados.setString(4, numOrden );
				updateTablaPreciosEscalonados.setString(5, ca_peEscalon );
				updateTablaPreciosEscalonados.setDouble(6, cambiaADouble(dCampoPrecio));
				updateTablaPreciosEscalonados.setString(7, campoBit );
				updateTablaPreciosEscalonados.setString(8, formaEscalon);
				updateTablaPreciosEscalonados.setString(9, tipoEscalon);
				updateTablaPreciosEscalonados.setInt(10, 1);
				updateTablaPreciosEscalonados.execute();
				salida=false;
			}
		}
		catch (SQLException sqle) {
			System.out.println("Error SQL dentro de InsercionesBD metodo addDatosProdEscalonado");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Error! Excepcion dentro de InsercionesBD metodo addDatosProdEscalonado");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de InsercionesBD metodo addDatosProdEscalonado");
					q.printStackTrace();
				}
			}
		}
	}


	public String acomodaLongitud(String muchosDecimales) throws Exception {
		StringBuffer sb = new StringBuffer (muchosDecimales);
		String decimales = new String();
		String decima = new String();
		String porfin = new String();

		if(sb.indexOf(".") != -1){
			decimales=sb.substring(sb.indexOf("."));
			decima = completaPrecioEntero(sb.substring(0, sb.indexOf(".")));
			sb.delete(0,sb.length());
			if (decimales.length()>3)
				decimales = decimales.substring(0,3);

			else
				decimales = completaPrecioDecimal(decimales);
			sb.append(decima);
			sb.append(decimales);
			porfin = remuevePuntuacion(sb.toString());
		}
		 else
		 	porfin = completaPrecioEntero(muchosDecimales)+"00";

//		System.out.println("Decima"+decima);
//		System.out.println(decimales);

//		System.out.println("sb"+sb);

//		System.out.println("Porfin"+porfin);
		return porfin;
	}


/**
* El método completaTexto se encarga de insertar los espacios suficientes para completar el tamaño de 55 del Texto de Productos.
*  	@param 	texto		String a completar.
*	@return valor 		String con el valor de la variable.
*/
	public String completaTexto(String texto) throws Exception{
		int valor;
		String finaltexto = texto;
		try{
			valor = texto.length();
			valor = 55 - valor;
			for(int i=0; i<valor; i++)
			{
				finaltexto = finaltexto+" ";
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finaltexto;
	}


/**
* El método completaTexto se encarga de insertar los espacios suficientes para completar el tamaño de 55 del Texto de Productos.
*  	@param 	texto		String a completar.
*	@return valor 		String con el valor de la variable.
*/
	public String completaPrecioEntero(String texto) throws Exception{
		int valor;
		String finaltexto = texto;
		try{
			valor = texto.length();
			valor = 4 - valor;
			for(int i=0; i<valor; i++)
			{
				finaltexto = "0"+finaltexto;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finaltexto;
	}



/**
* El método completaTexto se encarga de insertar los espacios suficientes para completar el tamaño de 55 del Texto de Productos.
*  	@param 	texto		String a completar.
*	@return valor 		String con el valor de la variable.
*/
	public String completaPrecioDecimal(String texto) throws Exception{
		int valor;
		String finaltexto = texto;
		try{
			valor = texto.length();
			valor = 3 - valor;
			for(int i=0; i<valor; i++)
			{
				finaltexto = finaltexto+"0";
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finaltexto;
	}



	public boolean esEscalonado(String plu){
//		System.out.println("Entre al Query de esEscalonado con plu: " +plu);
		boolean bandera = false;
		try{
			ResultSet rs = null;
			String nombre = null;
			String queryString = ("SELECT tipoPrecio FROM productos WHERE PLU = '" +plu +"' AND ACTIVO = 1" );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				nombre = rs.getString(1);
//				System.out.println("Valor de nombre: " +nombre);
			}
			if(nombre.equals("02")){
//				System.out.println("Si fue con precio escalonado");
				bandera = true;
			}
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta esEscalonado.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraia el tipo de Precio."+e;
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
		return bandera;
	}



 		       //
             /////
          ////////////
     ///////////////////////
///////////////////////////////////
	// Genericos



/**
* El método completaPlu se encarga de insertar los ceros suficientes para completar el tamaño de 6 del PLU de Productos.
*  	@param 	plu			String a completar.
*	@return valor 		String con el valor de la variable.
*/
	public String completaPlu(String plu) throws Exception{
		int valor;
		String finalplu = plu;
		try{
			valor = plu.length();
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



	public void creaPorcentuales() throws SQLException, Exception{
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				String query = "SELECT * FROM productos WHERE activo = 1 ORDER BY ID_Pro";
				Statement stmt = con.creaStatement();
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
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
								creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
									creaGananciaPorcentual = con.miConnection.prepareStatement("insert into ganancia_porcentual values(?,?,?,?);");
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
				con.realizaCommit();
			}
			catch(SQLException sqle){
				con.realizaRollback();
				sqle.printStackTrace();
			}
			catch(Exception e){
				con.realizaRollback();
				e.printStackTrace();
			}
			finally{
				con.habilitaAutoCommit();
				con.cierraConexion();
			}
		}
	}


	public static void main (String[] args) throws Exception {
		ManagerPro mp = new ManagerPro();
		mp.creaPorcentuales();
	}

}