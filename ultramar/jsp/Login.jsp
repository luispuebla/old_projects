<%@ page language="java" import="java.sql.*" %>

<html>
<head>
<title>Acceso</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function funcionFoco(){
	document.form1.usuario.focus();
}
//-->
</script>
</head>
<body onLoad="funcionFoco()">
<%
session.invalidate();
session.setMaxInactiveInterval(60*60*1);
%>
<form name="form1" method="post" target="_parent" action="LoginJ.jsp">
  <p>&nbsp;</p>
  <h1>¡Bienvenido!</h1>
<table width="304" border="0" align="center">
  <tr>
      <th width="108">Usuario:</th>
    <td width="186"><input type="text" name="usuario"></td>
  </tr>
  <tr>
      <th>Contrase&ntilde;a:</th>
    <td><input type="password" name="contrase"></td>
  </tr>
</table>
<p>
<table width="217" border="0" align="center">
  <tr>
    <td width="219"><div align="center"> 
          <input type="reset" name="Submit2" value="Limpiar">
        </div></td>
    <td width="221"><div align="center">
          <input name="Submit" type="submit" value="Accesar">
        </div></td>
  </tr>
</table></p>
  <p align="center">Para accesar al Sistema debes estar registrado.
  <div align="center">Si deseas cambiar tu contrase&ntilde;a actual, da un click <a href="Cambia_Pass.jsp">AQU&Iacute;</a>.</font> </p> 
  </div>
</form>
<div align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></div>
</body>
</html>