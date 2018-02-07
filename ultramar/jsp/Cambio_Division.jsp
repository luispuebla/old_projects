<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="div" class="com.ult.bd.ManagerDivisiones" />

<html>
<head>
<title>Modifica Division</title>
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
 function emailCheck() {
  txt=document.form1.email.value;
  if (txt.indexOf("@")<3){
   alert("La direccion e-mail no es valida. Por favor"
   +" introduzca una direccion que contenga el simbolo '@'.");
   }
  if ((txt.indexOf(".com")<5)&&(txt.indexOf(".org")<5)
  &&(txt.indexOf(".gov")<5)&&(txt.indexOf(".net")<5)
  &&(txt.indexOf(".mil")<5)){
   alert("La direccion e-mail no es valida."
   +" La direccion e-mail debe contener un sufijo del tipo "
   +".com,.net,.org,.gov or .mil");
  }
 }

//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String area = request.getParameter("area");
	String division = request.getParameter("division");
	String vacio = "";

	boolean exis = true;
	
	if(exis){ %>

<form name="form1" method="post" action="Conf_Cambio_Division.jsp">   
<input type="hidden" name="division" value="<%=division%>">    
<h1>Realiza las modificaciones necesarias y da Click en el bot&oacute;n de Guardar </h1>
	<table width="433" align="center">
		<tr align="left">
			<th width="188" align="left"><b>Campo NO Editable --></b></th>
			<td width="233" align="left"><b class="roj">**</b></td>			
		</tr>
  </table>
  <% 
	ResultSet rs = div.datos_Division(division);
	while (rs.next()) {
	String nom = "";
	if(area.equalsIgnoreCase("1"))
		nom = "Alimentos";
		if(area.equalsIgnoreCase("2"))
		nom = "Bebidas";
%>		
  <table width="453" border="1" align="center">
    <tr> 
      <th width="150" bgcolor="#CCCCCC">&Aacute;rea:</th>
      <td width="482"><input type="text" name="area1" value="<%= nom %>" readonly="true" size="15" maxlength="13"> 
        <b class="roj">**</b></td>
    </tr>
    <tr> 
      <th width="150" bgcolor="#CCCCCC">Nombre:</th>
      <td width="482"><input type="text" name="nombre" value="<%= rs.getString("nombre") %>" size="30" maxlength="30"></td>
    </tr>
  </table>
		
        <p>
		<div align="center">
          <input type="submit" name="Submit" value="Guardar">
  </div>
          </p>
</form>
<p> 
  <% }}
  div.cierraConexion();
 %>
</p>
<p align="center"><a href="Selecciona_Division.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
