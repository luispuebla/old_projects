<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pro" class="com.vas.bd.ManagerProductos" scope="page" />
<jsp:useBean id="mar" class="com.vas.bd.ManagerMarcas" />
<jsp:useBean id="lin" class="com.vas.bd.ManagerLineas" />
<jsp:useBean id="prov" class="com.vas.bd.ManagerProveedores" />

<html>
<head>
<title>Detalle del Producto</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
	if (usuario == null || !tipou.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}

	String queryString = request.getQueryString();
	//System.out.println("queryString: "+queryString);
%>
   <%
	ResultSet datos = pro.datos_Producto(queryString);
while(datos.next()){
	String pXc = "No Aplica.";
%>
 <h1 align="center">Detalle del Producto <%=queryString%></h1>

 <div align="center">
	<table width="700" border="1">
		<tr>
	      <th width="124" bgcolor="#DFE1EC"><div align="left">Marca:</div></th>
    	  <td colspan="2"><div align="center">
    	    <input name="marca" type="text" size="40" maxlength="40" readonly="true" value="<%=mar.nombreMarca(datos.getString("marca"))%>">
  	    </div></td>
	      <th width="143" bgcolor="#DFE1EC"><div align="left">Línea:</div></th>
    	  <td colspan="2"><div align="center">
    	    <input name="linea" type="text" size="20" maxlength="20" readonly="true" value="<%=lin.nombreLinea(datos.getString("linea"))%>">
  	    </div></td>
		</tr>
		<tr>
	      <th bgcolor="#DFE1EC"><div align="left">Tipo Producto:</div></th>
    	  <td width="91"><font color="#000000">
            <div align="center">
              <%
			if (datos.getInt("tipo") == 1){
				out.print("Por Caja");
				pXc = datos.getString("piezasXcaja");
			}
			else{
				out.print("Por Pesaje");			
			}
%>		  
		      </div></font></td>
    	  <th width="154"  bgcolor="#DFE1EC"><div align="left">Piezas por Caja :</div></th>
    	  <td ><div align="center">
    	    <input name="sublinea" type="text" size="10" maxlength="8" readonly="true" value="<%=pXc%>">
  	    </div></td>
	 	  <th width="84" bgcolor="#DFE1EC"><div align="left">Grava IVA :</div></th>
	      <td width="64" ><div align="center">
	        <input name="iva" type="text" size="5" maxlength="1" readonly="true" value="<%
		if(datos.getInt("iva") == 1){
			out.print("SI");
		}
		else{
			out.print("NO");
		}
		%>"> 
          </div></td>		
	</tr>
  </table>
	<p></p>
	<table width="700" border="1">
	<tr>
      <th width="125" bgcolor="#DFE1EC"><div align="left">Descripción:</div></th>
      <td width="559" ><div align="center"><font color="#000066"> 
		  <input name="descripcion" type="text" size="80" maxlength="80" readonly="true" value="<%=datos.getString("descripcion")%>">        
	    </font></div></td>
    </tr>
</table>
<p></p>
	<table width="700" border="1">
	<tr>
      <th width="124" bgcolor="#DFE1EC"><div align="left">Proveedor 1 :</div></th>
      <td width="560" ><font color="#000066"> 
		<input name="descripcion" type="text" size="80" maxlength="80" readonly="true" value="<%=prov.nombreProveedor(datos.getString("proveedor1"))%>">        
		</font></td>
    </tr>
	<tr>
      <th bgcolor="#DFE1EC"><div align="left">Proveedor 2 :</div></th>
      <td ><font color="#000066"> 
		<input name="descripcion" type="text" size="80" maxlength="80" readonly="true" value="<%
		if(datos.getString("proveedor2").equalsIgnoreCase("0")){
			out.println("Ninguno");
		}
		else{
			out.println(prov.nombreProveedor(datos.getString("proveedor2")));
		}
		%>">        
		</font></td>
    </tr>
	<tr>
      <th bgcolor="#DFE1EC"><div align="left">Proveedor 3 :</div></th>
      <td ><font color="#000066"> 
		<input name="descripcion" type="text" size="80" maxlength="80" readonly="true" value="<%
		if(datos.getString("proveedor3").equalsIgnoreCase("0")){
			out.println("Ninguno");
		}
		else{
			out.println(prov.nombreProveedor(datos.getString("proveedor3")));
		}
		%>">        
		</font></td>
    </tr>
	<tr>
      <th bgcolor="#DFE1EC"><div align="left">Proveedor 4:</div></th>
      <td><font color="#000066"> 
		<input name="descripcion" type="text" size="80" maxlength="80" readonly="true" value="<%
		if(datos.getString("proveedor4").equalsIgnoreCase("0")){
			out.println("Ninguno");
		}
		else{
			out.println(prov.nombreProveedor(datos.getString("proveedor4")));
		}
		%>">        
		</font></td>
    </tr>
	<tr>
      <th bgcolor="#DFE1EC"><div align="left">Proveedor 5:</div></th>
      <td ><font color="#000066"> 
		<input name="descripcion" type="text" size="80" maxlength="80" readonly="true" value="<%
		if(datos.getString("proveedor5").equalsIgnoreCase("0")){
			out.println("Ninguno");
		}
		else{
			out.println(prov.nombreProveedor(datos.getString("proveedor5")));
		}
		%>">        
		</font></td>
    </tr>
  </table>
	<p></p>
	<table width="382" border="1">
	<tr>
      <th width="67" bgcolor="#DFE1EC"><div align="left">M&aacute;ximo:</div></th>
      <td width="102" ><font color="#000066"> 
		<input name="maximo" type="text" readonly="true" size="6" maxlength="4" value="<%=datos.getString("maximo")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">        
		</font></td>
      <th width="69" bgcolor="#DFE1EC"><div align="left">M&iacute;nimo:</div></th>
      <td width="116" ><font color="#000066"> 
		<input name="minimo" type="text" size="6" readonly="true" maxlength="4" value="<%=datos.getString("minimo")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">        
		</font></td>
      </tr>
  </table>
  <%}
  if(datos != null){
  	datos.close();
  }
  pro.cierraConexion();
  
  %>
	<p></p>
     <p align="center"><a href="Todos_Productos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
 </div>
 <p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
