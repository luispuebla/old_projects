<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="pro" class="com.alpha.bd.ManagerPro" />

<html>
<head>
<title>Cambio datos de Producto</title>
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

function funcionFoco(){
	document.form2.ID_Pro.focus();
}

//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); funcionFoco()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>
<form name="form2" method="post" action="Mermas_Producto.jsp">
	<h1>Escribe la clave del productos para especificar su merma: </h1>
	<table width="500" align="center" border="1">
		<tr>
			<th>Clave:</th>
			<td><div align="center">
			  <input type="text" name="ID_Pro" maxlength="6" size="8" onKeyPress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
			  </div></td>
		</tr>
	</table>
	<p><input type="submit" name="Enviar" value="Enviar"></p>
</form>

<%	
	String formatoBusqueda = "1";
	if(request.getParameter("orden") != null){
		formatoBusqueda = request.getParameter("orden");
	}
	ResultSet rs = pro.listado_productoXCat(formatoBusqueda);
%>	
_______________________________________________________________________________
<h1>O bien seleccione de la siguiente lista el producto para especificar merma:</h1>
<form name="form0" method="post" action="Selecciona_Producto_Mermas.jsp">
	<table width="500" cellpadding="0" cellspacing="0" align="center">
	  <caption>
	  Modifique el ordenamiento de productos en la lista: 
	  </caption>
		<tr>
			<td><div align="center"><input type="radio" name="orden" checked value="1" > </div>  </td>
			<td><b>Por Nombre y Genero</b></td>
		</tr>
		<tr>
			<td><div align="center"> <input type="radio" name="orden" value="2" ></div>  </td>
			<td><b>Por Genero y Nombre</b></td>						
		</tr>
	</table>
	<p><input type="submit" name="Cambiar" value="Cambiar"></p>
</form>
<form name="form1" method="post" action="Mermas_Producto.jsp">
	<h1>Selecciona el producto de la lista: </h1>
	<table width="500" align="center" border="1">
		<tr>
			<th>&nbsp;</th>
			<% if(formatoBusqueda.equalsIgnoreCase("1")) {%>
			<th>Nombre</th>
			<th>G&eacute;nero</th>
			<% } else{ %>
			<th>G&eacute;nero</th>
			<th>Nombre</th>
			<% } %>
		</tr>
<%
		while(rs.next()){
			String elGenero = "Cremeria";
			if(rs.getInt("genero") == 2){
				elGenero = "Refresco";
			}
			else if(rs.getInt("genero") == 3){
				elGenero = "Abarrote";
			}
%>			
		<tr>
			<td><div align="center">
			  <input type="radio" name="ID_Pro" value="<%=rs.getString("ID_Pro")%>">
			  </div></td>
			<% if(formatoBusqueda.equalsIgnoreCase("1")){ %>
			<th><div align="left"><%=rs.getString("descripcion")%></div></th>
			<th><%=elGenero%></th>
			<% } else{ %>
			<th><%=elGenero%></th>			
			<th><div align="left"><%=rs.getString("descripcion")%></div></th>
			<% } %>
		</tr>
<%
		} 
		pro.cierraConexion();
%>				
	</table>
	<p><input type="submit" name="Enviar" value="Enviar"></p>
</form>
<p align="center"><a href="Menu_Inventarios.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0" align="middle"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
