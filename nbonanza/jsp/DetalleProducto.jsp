<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="proveedor" class="com.alpha.bd.ManagerProveedores" scope="page" />
<jsp:useBean id="pro" class="com.alpha.bd.ManagerPro"  scope="page"/>

<html>
<head>
<title>Detalle Proveedor</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String ID_Pro = request.getQueryString();
	String descripcion = "";
	String tipo = "0";
	String iva = "";
	String genero = "1";
	String mp = "";
	String cortes = "";
	String codBarras1 = "";
	String codBarras2 = "";
	String codBarras3 = "";
	String codBarras4 = "";
	String codBarras5 = "";
	String codBarras6 = "";
	String codBarras7 = "";
	String codBarras8 = "";
	String codBarras9 = "";
	String codBarras10 = "";
	String codBarras11 = "";
	String codBarras12 = "";
	String proveedor1 = "";	
	String proveedor2 = "";	
	String proveedor3 = "";
	String proveedor4 = "";
	String proveedor5 = "";
	String uniCompra = "1";
	String preUniCompra = "0.00";
	String preCaCompra = "0.00";
	String piezasc = "";	
	String preKgCompra = "0.00";
	String kgXUni = "";
	String tipoPrecio = "0";
	String manejo = "0";
	String precioMenu = "0.00";
	String precioMenuC = "0.00";
	String precioMM = "0.00";
	String precioMMC = "0.00";	
	String precioM = "0.00";
	String precioMC = "0.00";
	String pieza1 = "1";
	String precioE1 = "0.00";
	String pieza2 = "";
	String precioE2 = "0.00";
	String pieza3 = "";
	String precioE3 = "0.00";
	String pieza4 = "";
	String precioE4 = "0.00";
	String pieza5 = "";
	String precioE5 = "0.00";
	String maxInv = "";
	String minInv = "";
	String invTienda = "0";
	String invAlmacen = "0";	
	ResultSet rsCod = pro.datos_Codigo(ID_Pro);
	while (rsCod.next()){
		if(! rsCod.wasNull()){
			codBarras1 = rsCod.getString("codBarra");
			if(!rsCod.isLast()){
				rsCod.next();
				codBarras2 = rsCod.getString("codBarra");
				if(!rsCod.isLast()){
					rsCod.next();
					codBarras3 = rsCod.getString("codBarra");
					if(!rsCod.isLast()){
						rsCod.next();
						codBarras4 = rsCod.getString("codBarra");
						if(!rsCod.isLast()){
							rsCod.next();
							codBarras5 = rsCod.getString("codBarra");
							if(!rsCod.isLast()){
								rsCod.next();
								codBarras6 = rsCod.getString("codBarra");
								if(!rsCod.isLast()){
									rsCod.next();
									codBarras7 = rsCod.getString("codBarra");
									if(!rsCod.isLast()){
										rsCod.next();
										codBarras8 = rsCod.getString("codBarra");
										if(!rsCod.isLast()){
											rsCod.next();
											codBarras9 = rsCod.getString("codBarra");
											if(!rsCod.isLast()){
												rsCod.next();
												codBarras10 = rsCod.getString("codBarra");
												if(!rsCod.isLast()){
													rsCod.next();
													codBarras11 = rsCod.getString("codBarra");
													if(!rsCod.isLast()){
														rsCod.next();
														codBarras12 = rsCod.getString("codBarra");
													}
												}
											}													
										}
									}
								}										
							}
						}
					}
				}
			}
		}
	}
	pro.cierraConexion();
	ResultSet rs = pro.datos_Producto(ID_Pro);
	while (rs.next()){			
		descripcion = rs.getString("descripcion");
		tipo = rs.getString("tipoPro");
		iva = rs.getString("gravaIVA");
		genero = rs.getString("genero");
		mp = rs.getString("materiaPrima");
		cortes = rs.getString("cortes");
		proveedor1 = rs.getString("id_prov1");
		proveedor2 = rs.getString("id_prov2");
		proveedor3 = rs.getString("id_prov3");
		proveedor4 = rs.getString("id_prov4");
		proveedor5 = rs.getString("id_prov5");				
		uniCompra = rs.getString("uniCompra");
		preUniCompra = rs.getString("precioUniCompra");				
		preCaCompra = rs.getString("preCaCompra");
		piezasc = rs.getString("cantidadXCaja");
		preKgCompra = rs.getString("precioUnidadKG");
		kgXUni = rs.getString("kgXUnidad");				
		tipoPrecio = rs.getString("tipoPrecio");
		manejo = rs.getString("manejoPrecio");
		precioMenu = rs.getString("precioMenu");
		precioMenuC = rs.getString("precioMenuC");				
		precioMM =  rs.getString("precioMM");
		precioMMC = rs.getString("precioMMC");
		precioM =  rs.getString("precioM");
		precioMC = rs.getString("precioMC");
		maxInv =  rs.getString("maxInv");
		minInv = rs.getString("minInv");
		invTienda = rs.getString("invTienda");
		invTienda = rs.getString("invAlmacen");
		if(rs.getInt("tipoPrecio") == 2){
			ResultSet rs2 = pro.datos_Escalonado(ID_Pro);
			String[] piezas = new String [5];
			String[] precios= new String [5];
			for (int i = 0; i<5; i++){
				piezas[i] = "";
				precios[i] = "";
			}
			int contador = 0;
			while (rs2.next()){
				piezas[contador] = (rs2.getInt("ca_peEscalon")+1)+"";
				precios[contador] = rs2.getDouble("campoPrecio")+"";
				contador ++;
			}
			pro.cierraConexion2();
			pieza1 = piezas[0];
			precioE1 = precios[0];
			pieza2 = piezas[1];
			precioE2 = precios[1];
			pieza3 = piezas[2];
			precioE3 = precios[2];
			pieza4 = piezas[3];
			precioE4 = precios[3];
			pieza5 = piezas[4];
			precioE5 = precios[4];	
		}				
	}	
	pro.cierraConexion();
%>
<h1>Detalle de Producto <strong> #<%=ID_Pro%> <%="("+descripcion+")"%> </strong></h1>
  <table align="center" cellpadding="0" cellspacing="0" width="750" border="0">
  	<tr>
		<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0">
		  <caption><b class="aviso">Datos Genéricos</b></caption>
		  	<tr>
			  <th colspan="2">Nombre Producto:</th>
			  <td colspan="2"><div align="center"><%=descripcion%></div></td>				
			  <th>Tipo de Producto:</th>
			  <td> <div align="center"> <% if(tipo.equals("0")){%> Por Unidad <%}else{%> Por Pesaje <%}%> </div></td>
			</tr>			
		  	<tr>
			  <th colspan="2">Grava I.V.A.:</th>
			  <td><div align="center"> <% if(iva.equalsIgnoreCase("1")){%> S&iacute;<%} else{%> No <%}%> </div></td>
			  <th colspan="2">Genero de Producto:</th>
			  <td> <div align="center"> <%if(genero.equalsIgnoreCase("1")){%> Cremer&iacute;a <%} else if(genero.equals("2")){%>Refresco <%} else{%> Abarrote <%}%> </div></td>
			<tr>
		  	<tr>
			  <th colspan="2">Producto Materia Prima:</th>
			  <td><div align="center"> <% if(mp.equalsIgnoreCase("1")){%> S&iacute;<%} else{%> No <%}%> </div></td>
			  <th colspan="2">Producto Cort&eacute;s:</th>
			  <td><div align="center"> <% if(cortes.equalsIgnoreCase("1")){%> S&iacute;<%} else{%> No <%}%> </div></td>
			<tr>
		      <th colspan="6" bgcolor="#CCCCCC"> -- S&aacute;bana de C&oacute;digos de Barras -- </th>			  
			</tr>	
			<tr>
			  <th>Código #1:</th>
			  <td><div align="center"><% if(codBarras1.equals("")){ %>&nbsp; <%}else{%> <%=codBarras1%> <%}%></div></td>
			  <th>Código #2:</th>
			  <td><div align="center"><% if(codBarras2.equals("")){ %>&nbsp; <%}else{%> <%=codBarras2%> <%}%></div></td>
			  <th>Código #3:</th>
			  <td><div align="center"><% if(codBarras3.equals("")){ %>&nbsp; <%}else{%> <%=codBarras3%> <%}%></div></td>
			</tr>
			<tr>
			  <th>Código #4:</th>
			  <td><div align="center"><% if(codBarras4.equals("")){ %>&nbsp; <%}else{%> <%=codBarras4%> <%}%></div></td>
			  <th>Código #5:</th>
			  <td><div align="center"><% if(codBarras5.equals("")){ %>&nbsp; <%}else{%> <%=codBarras5%> <%}%></div></td>
			  <th>Código #6:</th>
			  <td><div align="center"><% if(codBarras6.equals("")){ %>&nbsp; <%}else{%> <%=codBarras6%> <%}%></div></td>
			</tr>
			<tr>
			  <th>Código #7:</th>
			  <td><div align="center"><% if(codBarras7.equals("")){ %>&nbsp; <%}else{%> <%=codBarras7%> <%}%></div></td>
			  <th>Código #8:</th>
			  <td><div align="center"><% if(codBarras8.equals("")){ %>&nbsp; <%}else{%> <%=codBarras8%> <%}%></div></td>
			  <th>Código #9:</th>
			  <td><div align="center"><% if(codBarras9.equals("")){ %>&nbsp; <%}else{%> <%=codBarras9%> <%}%></div></td>
			</tr>
			<tr>
			  <th>Código #10:</th>
			  <td><div align="center"><% if(codBarras10.equals("")){ %>&nbsp; <%}else{%> <%=codBarras10%> <%}%></div></td>
			  <th>Código #11:</th>
			  <td><div align="center"><% if(codBarras11.equals("")){ %>&nbsp; <%}else{%> <%=codBarras11%> <%}%></div></td>
			  <th>Código #12:</th>
			  <td><div align="center"><% if(codBarras12.equals("")){ %>&nbsp; <%}else{%> <%=codBarras12%> <%}%></div></td>
			</tr>
		  </table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0">
		  <caption><b class="aviso">Datos Compra</b></caption>
		  	<tr>
			  <th colspan="3">Proveedor 1:</th>
			  <td colspan="3"><div align="center"><%if(proveedor1.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor1)%> <%}%></div></td>
			</tr>		 
		  	<tr>
			  <th colspan="3">Proveedor 2:</th>
			  <td colspan="3"><div align="center"><%if(proveedor2.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor2)%> <%}%></div></td>
			</tr>		 
		  	<tr>
			  <th colspan="3">Proveedor 3:</th>
			  <td colspan="3"><div align="center"><%if(proveedor3.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor3)%> <%}%></div></td>
			</tr>
		  	<tr>
			  <th colspan="3">Proveedor 4:</th>
			  <td colspan="3"><div align="center"><%if(proveedor4.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor4)%> <%}%></div></td>
			</tr>
		  	<tr>
			  <th colspan="3">Proveedor 5:</th>
			  <td colspan="3"><div align="center"><%if(proveedor5.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor5)%> <%}%></div></td>
			</tr>
			<tr>
			  <th colspan="3">Unidad de Compra:</th>
			  <td colspan="3"><div align="center"> <% if(uniCompra.equals("1")){%>Por pieza y/o Caja<%} else{ %> Por pieza de Kilogramo <%}%> </div> </td>
			</tr> 
<%			if(uniCompra.equals("1")){ %>					
			<tr>
			  <th colspan="6">-- Compra por Unidad y/o Caja -- </th>
			</tr>			  
			<tr>
				<th>Precio por Unidad:</th>
				<td><div align="center"> <% if (pro.cambiaADouble(preUniCompra) <= 0){%> No aplica <%} else{ %> $ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(preUniCompra)+""))%> <%}%></div></td>
				<th>Precio por Caja:</th>
				<td><div align="center"> <% if (pro.cambiaADouble(preCaCompra) <= 0){%> No aplica <%} else{ %> $ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(preCaCompra)+""))%> <%}%> </div></td>
				<th>Unidades por Caja:</th>
				<td><div align="center">  <% if (pro.cambiaAInt(piezasc) <= 0){%> No aplica <%} else{ %> <%=pro.cambiaAInt(piezasc)%> <%}%> </div></td>
		 	</tr>
<%			} else { %>				
			<tr>
			  <th colspan="6">-- Compra por Pieza de Kilo -- </th>
			</tr>			  
			<tr>
			  <th colspan="2">Precio de 1 Kg:</th>
				<td><div align="center"> $ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(preKgCompra)+""))%> </div></td>
			  <th colspan="2">Kilos por Pieza:</th>
				<td><div align="center"> <%=pro.cambiaADouble(kgXUni)%> </div></td>
		 	</tr>		
<%			} %>					
		  </table>
		</td>	
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>	
	<tr>
		<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0">
		  <caption><b class="aviso">Datos Venta</b></caption>

		  	<tr>
      		  <th colspan="2">Tipo de Precio: </th>
			  
			  <td width="22%"><div align="center"> <% if(tipoPrecio.equals("0")){%>Solo Base<%} else if(tipoPrecio.equals("1")){ %>Grupo de Precios<%} else{%>Escalonado<%}%></div> </td>
			  <th colspan="2">Manejo de Precio:</th>
			  <td width="25%"><div align="center"> <% if(manejo.equals("0")){%>
			  Solo por unidad o Kg.
			      <%} else if(manejo.equals("1")){ %> Por unidad y Caja <%} else{%>Por Kg. y Pieza <%}%> </div> </td>
			</tr>
<%			if(manejo.equals("0")){ %>			
    		<tr>
			  <th colspan="4">Precio Menudeo <br />
			    			    (Unidad / 1Kg.):</th>
			  <td colspan="2"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMenu)+""))%> </div></td>
			 </tr>
<%			} else { %>			  
			<tr>
			  <th colspan="2">Precio Menudeo <br />
			  (Unidad / 1Kg.):</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMenu)+""))%> </div></td>
			  <th colspan="2">Precio Menudeo<br/>(Caja / Pieza):</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMenuC)+""))%> </div></td>
			</tr>
<%			} if(tipoPrecio.equals("1")){%>			
    		<tr>
			  <th colspan="6"><div align="center">-- Grupo de Precios --</div></th>
			</tr>
<%				if(manejo.equals("0")){ %>
			<tr>
			  <th colspan="4">Precio Medio Mayoreo :<br/>
			    			    (Unidad/1Kg)</th>
			  <td colspan="2"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMM)+""))%> </div></td>
		    </tr>
			 <tr>
			  <th colspan="4">Precio Mayoreo :<br/>
			    			    (Unidad/1Kg)</th>
			  <td colspan="2"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioM)+""))%> </div></td>
			 </tr>
<%				} else{ %>
			<tr>
			  <th colspan="2">Precio Medio Mayoreo:<br/>			    
		      (Unidad/1Kg)</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMM)+""))%> </div></td>
			  <th colspan="2">Precio Medio Mayoreo:<br/>		        
		      (Caja / Pieza)</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMMC)+""))%> </div></td>
		    </tr>
			 <tr>
			  <th colspan="2">Precio Mayoreo:<br/>			    
		       (Unidad/1Kg)</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioM)+""))%> </div></td>
			  <th colspan="2">Precio Mayoreo:<br/>		        
		       (Caja / Pieza)</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMC)+""))%> </div></td>
			 </tr>
<%				}	
			}	else if(tipoPrecio.equals("2")){%>						
			<tr>
			  <th colspan="6" bgcolor="#CCCCCC">-- Precios Escalonados --</th>
			</tr>
			<tr>
			  <th colspan="3" bgcolor="#CCCCCC">Cantidad Piezas:</th>
			  <th colspan="3" bgcolor="#CCCCCC">Precio:</th>
			</tr>
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza1)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE1)+""))%></div></td>
			</tr>
<%				if(pro.cambiaAInt(pieza2) > 0 ){ %>
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza2)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE2)+""))%></div></td>
			</tr>
<%				}
				if(pro.cambiaAInt(pieza3) > 0 ){ %>			
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza3)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE3)+""))%></div></td>
			</tr>
<%				}
				if(pro.cambiaAInt(pieza4) > 0 ){ %>						
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza4)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE4)+""))%></div></td>
			</tr>
<%				}
				if(pro.cambiaAInt(pieza5) > 0 ){ %>						
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza5)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE5)+""))%></div></td>
			</tr>			
<%			}}  %>			
		  </table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>	

	<tr>
		<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0">
		  <caption><b class="aviso">Datos Inventario</b></caption>
		  	<tr>
			  <th>M&aacute;ximo:</th>
			  <td><div align="center"><%=pro.cambiaADouble(maxInv)%> Unidades/Kg.</div></td>
			  <th>M&iacute;nimo:</th>
			  <td><div align="center"><%=pro.cambiaADouble(minInv)%> Unidades/Kg.</div></td>
			</tr>
			<tr valign="bottom" >
			  <th rowspan="2" colspan="2" >Existencia Actual:<br />			  </th>
			  <th>En Tienda</th>
			  <th>En Almacen</th>
			</tr>			
			<tr>
			  <td><div align="center"><%=pro.cambiaADouble(invTienda)%> Unidades/Kg.</div></td>			  
			  <td><div align="center"><%=pro.cambiaADouble(invAlmacen)%> Unidades/Kg.</div></td>			  							
			</tr>
		  </table>
		</td>
	</tr>  
  </table>			
<p align="center"><a href="Consulta_Productos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
