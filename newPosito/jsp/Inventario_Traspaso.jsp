<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>
<jsp:useBean id="inv" class="com.alpha.bd.ManagerInventarios" scope="page" />

<html>
<head>
<title>Inventario de Productos</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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


function setFocus(){
	if(document.form1 != null){
		document.form1.incrementar.select();
	}
}

function seleccionaTodo(objeto){
	objeto.select();
}

//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); setFocus()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String tipoT = request.getParameter("tipoT");	
	if(request.getParameter("elProducto") == null || request.getParameter("elProducto").trim().equals("")){
%>		
			<b class="roj">NO SELECCIONO EL PRODUCTO.</b>
			<form name="regreso" action="Selecciona_Producto_Traspaso.jsp" method="post" target="_self">
				  <input type="hidden" name="tipoT" value="<%=tipoT%>">
				<input type="submit" name="Volver" value="Volver">
			</form>
<%	
	}
	else{
		String elProducto = request.getParameter("elProducto").trim();
		boolean existeProducto = inv.existe(elProducto);
		if(!existeProducto){ %>
			<b class="roj">EL PRODUCTO NO EXISTE.</b>
			<form name="regreso" action="Selecciona_Producto_Traspaso.jsp" method="post" target="_self">
				  <input type="hidden" name="tipoT" value="<%=tipoT%>">
				<input type="submit" name="Volver" value="Volver">
			</form>		
<%		}
		else{ 
%>	
<h1>INVENTARIO DE PRODUCTO </h1>
<form name="form1" method="post" action="Conf_Inventario_Traspaso.jsp">
  <input type="hidden" name="elProducto" value="<%= elProducto%>">
  <input type="hidden" name="tipoT" value="<%=tipoT%>">
<table align="center" border="1" width="500">
<caption>Escribe en el recuadro la Cantidad a traspasar para este Producto</caption>
<%
			ResultSet rs = inv.dameExistenciaProducto(elProducto);
			String tipoProducto = "Unidades";
			String existenciaTienda = "";
			String existenciaAlmacen = "";
			while(rs.next()){
				existenciaTienda = rs.getInt("invTienda")+"";
				existenciaAlmacen = rs.getInt("invAlmacen")+"";
				if(rs.getInt("tipoPro") == 1){
					tipoProducto = "Kg.";
					existenciaTienda = rs.getDouble("invTienda")+"";
					existenciaAlmacen = rs.getDouble("invAlmacen")+"";
				}
%>
	<tr>
		<th colspan="2"><div align="center"><%=elProducto+" --> "+rs.getString("descripcion")%></div></th>
	</tr>
	<tr>
		<th width="255"><div align="center"><%if(tipoT.equals("1")){ %>Actual en Almac&eacute;n <% }else{ %>Actual en Tienda <% } %></div></th>
		<th width="229"><div align="center"><%if(tipoT.equals("1")){ %>Traspasar a Tienda<% }else{ %>Traspasar a Almac&eacute;n <% } %></div></th>
	</tr>
	<tr>
		<td><div align="center"><%if(tipoT.equals("1")){ %><b><%=existenciaAlmacen%><% }else{ %><%=existenciaTienda%><% } %>&nbsp; &nbsp;<%=tipoProducto%><input type="hidden" name="canOriginal" value="<%if(tipoT.equals("1")){%><%=existenciaAlmacen%><% }else{ %><%=existenciaTienda%><% } %>"></b></div></td>
		<td><div align="center"><input type="text" size="7" maxlength="7" name="incrementar" onFocus="seleccionaTodo(this)" value="0" onKeypress="
	<% if(tipoProducto.equals("Kg.")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" >&nbsp;<%=tipoProducto%></div></td>
	</tr>
<%
		}
		if(rs != null){
			rs.close();		
		}
		inv.cierraConexion();	
%>
</table>
  <p>
    <input type="submit" name="Submit" value="Traspasar">
  </p>
</form>
<% 		}
	}%>
<p><a href="Tipo_Traslados_Inventario.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>