<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="mar" class="com.vas.bd.ManagerMarcas" />
<jsp:useBean id="prod" class="com.vas.bd.ManagerProductos" />
<html>
<head>
<title>Selección de Productos que gravan IVA</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

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
//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/regr.gif')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	
	ResultSet rs = prod.todosLosProductos();
	String inva = new String();
	String peso = new String();

%>
      <p><h1>Selecciona los Productos que gravan IVA 
        y da Click en el bot&oacute;n de Guardar
        </p>
      </h1>
      <form name="form1" method="post" action="Conf_Seleccion_Iva.jsp">
        <table width="650" border="1">
          <tr> 
		  	<th width="3%"></th>
            <th width="8%">Clave:</th>
            <th width="26%">Marca:</th>
            <th width="63%">Descripción:</th>
          </tr>

		  <%
	
	while (rs.next()) {
	boolean ivas = false;
if(rs.getString("iva").equals("1"))
	ivas = true;
else
	ivas = false;
		  %>
		  
		  <tr>
		  	<td><div align="center">
          <input type="checkbox" name="iva" value="<%= rs.getString("claveProducto") %>" <%if(ivas){%>checked<%}%>>
        </div></td>
		      <td width="8%"> 
              <input type="text" name="plu" value="<%= rs.getString("claveProducto") %>" readonly="true" size="10" 
			  maxlength="8">
              </td>
		      <td width="26%"> 
              <input type="text" name="plu" value="<%= mar.nombreMarca(rs.getString("marca")) %>" readonly="true" size="40" 
			  maxlength="40">
              </td>
            <td>
              <input type="text" name="descripcion" value="<%= rs.getString("descripcion") %>" readonly="true"
			   size="100" maxlength="100"
			  >
              </td>
		  </tr>
		    <% } 
			if(rs != null){
				rs.close();
			}
			prod.cierraConexion();
			%>
</table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
    <input type="reset" name="Submit2" value="Limpiar Forma">
</p>
  </form>
<p><a href="Menu_Productos2.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="152" height="36" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82">
</body>
</html>
