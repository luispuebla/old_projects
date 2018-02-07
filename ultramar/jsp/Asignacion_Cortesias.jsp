<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="ven" class="com.ult.bd.ManagerVentas" />
<jsp:useBean id="beb" class="com.ult.bd.ManagerBebidas" />
<jsp:useBean id="ali" class="com.ult.bd.ManagerAlimentos" />
<html>
<head>
<title>Selección de Cortesias por Comanda</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

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
 	String tipoU = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipoU.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

   String mesa = request.getParameter("mesa").trim();
   String nombreOriginal = "";
   if(mesa.length() <= 0){ %>
	<h1>Debes introducir una Mesa.</h1>
   <% }
  else{
	nombreOriginal = mesa;
  	if(mesa.equalsIgnoreCase("B1")){
		mesa = "25";
	}
	else if(mesa.equalsIgnoreCase("B2")){
		mesa = "26";
	}
	else if(mesa.equalsIgnoreCase("B3")){
		mesa = "27";
	}
	else if(mesa.equalsIgnoreCase("B4")){
		mesa = "28";
	}
	else if(mesa.equalsIgnoreCase("B5")){
		mesa = "29";
	}
	boolean tiene = ven.tieneComanda(mesa);
    if(tiene){
	
	int comanda = ven.dameComanda(mesa);
	ResultSet rs = ven.todosLosProductosComanda(comanda);

%>
      <p>
<h1>Selecciona los Productos que son Cortesia en la Mesa: <%=nombreOriginal%></p> </h1>
      <form name="form1" method="post" action="Conf_Seleccion_Cortesia.jsp">
	  <input type="hidden" name="comanda" value="<%=comanda%>">
        <table border="1" width="750">
          <tr> 
		  	<th width="52"></th>
            
      <th width="91">Cantidad:</th>
            
      <th width="77">Tipo:</th>
      <th width="83">Tamaño:</th>
            
      <th width="413">Producto:</th>
          </tr>

		  <%
String tipo = "";
String nombre ="";
String mando = "";	
String tamanio = "";
	while (rs.next()) {
tamanio = "NA";
if(rs.getInt("TB")==1 && rs.getInt("Ge") == 2){
	tamanio = "Sencilla";
}
else if(rs.getInt("TB")==2){
	tamanio = "Doble";
}
else if(rs.getInt("TB")==3){
	tamanio = "Triple";
}

if(rs.getInt("tipo")== 0)
	tipo = "No Aplica";
else if(rs.getInt("tipo")== 1)
	tipo = "Copa";
else if(rs.getInt("tipo")== 2)
	tipo = "Botella";
else if(rs.getInt("tipo")== 3)
	tipo = "Botella Grande";
else if(rs.getInt("tipo")== 4)
	tipo = "Botella Pequeña";
if(rs.getString("ge").equals("1"))
	nombre = ali.dameNombreAlimento(rs.getString("ClPro"));
else if(rs.getString("ge").equals("2"))
	nombre = beb.dameNombreBebida(rs.getString("ClPro"));
mando = rs.getString("tipo")+rs.getString("ClPro")+"*"+rs.getInt("TB");		
 %>
		  
		  <tr>
		  	
      <td>
<div align="center">
          <input type="checkbox" name="cortesia" value="<%=mando%>">
        </div></td>
		      
      <td> <div align="center">
          <%= rs.getString("CanPro") %>
        </div></td>		      
      <td> <div align="center">
          <%= tipo %>
        </div></td>
      <td> <div align="center">
		<%= tamanio %>
        </div></td>
            <td>
			<%= nombre %>
            </td>
		  </tr>
		    <% } %>
</table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
    <input type="reset" name="Submit2" value="Limpiar Forma">
</p>
  </form>
<% ven.cierraConexion();
}else{ %>
<h1>Esa mesa no tiene Asignada una Comanda.</h1>
<%}
}%>
<p><a href="Dame_Mesa_Cortesia.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="152" height="36" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82">
</body>
</html>
