<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="personalM" class="com.ult.bd.ManagerPersonal" scope="page" />

<html>
<head>
<title>Confirmación Almacenamiento Personal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

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
function MandaSubmit(){
	document.formaR.submit();
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
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String elUsuario = request.getParameter("claveu").trim();
	String laContra = request.getParameter("contrase");
	String laContra2 = request.getParameter("contrase2");
	String elTipo = request.getParameter("tipo");
	String elNombre = request.getParameter("nombre");
	String elAPaterno = request.getParameter("apaterno");
	String elAMaterno = request.getParameter("amaterno");
	String elArea = request.getParameter("select_1");
	String elPuesto = request.getParameter("select_2");

%>
<jsp:setProperty name="personalM" property="usuario" value="<%=elUsuario%>"/>
<jsp:setProperty name="personalM" property="contra" value="<%=laContra%>"/>
<jsp:setProperty name="personalM" property="contra2" value="<%=laContra2%>"/>
<jsp:setProperty name="personalM" property="tipo" value="<%=elTipo%>"/>
<jsp:setProperty name="personalM" property="nombre" value="<%=elNombre%>"/>
<jsp:setProperty name="personalM" property="AMaterno" value="<%=elAMaterno%>"/>
<jsp:setProperty name="personalM" property="APaterno" value="<%=elAPaterno%>"/>
<jsp:setProperty name="personalM" property="area" value="<%=elArea%>"/>
<jsp:setProperty name="personalM" property="puesto" value="<%=elPuesto%>"/>
<%
	boolean entrada = personalM.llenadoCompleto();
	boolean iguales = personalM.contrasEquals();
	boolean existe = personalM.yaExiste();
	if(entrada && iguales && !existe){
		boolean guardado = personalM.add_Personal();
		if (guardado){
%>
 <h1 align="center">Los Datos fueron almacenados Correctamente!,</h1>
 <div align="center"> Da un Click en Regresar para volver al Menú de Personal.</div>
<table width="419" border="1" align="center">
  <tr>
      <th width="196" bgcolor="#DFE1EC">Clave del Usuario:</th>
    <td width="213"><input readonly="true" name="claveu" type="text" value="<%=elUsuario%>"></td>
  </tr>
  <tr>
      <th bgcolor="#DFE1EC">Contrase&ntilde;a asignada:</font></th>
    <td><input readonly="true" name="contrase" type="password" value="<%=laContra%>"></td>
  </tr>
  <tr>
      <th bgcolor="#DFE1EC">Tipo de Usuario:</th>
    <td><input type="text" readonly="true" name="tipo" value="<%=elTipo%>"></td>
  </tr>
  <tr>
      <th bgcolor="#DFE1EC">Nombre:</th>
    <td><input name="nombre" type="text" readonly="true" value="<%=elNombre%>"></td>
  </tr>
  <tr>
      <th bgcolor="#DFE1EC">Apellido Paterno:</th>
    <td><input name="apaterno" type="text" value="<%=elAPaterno%>" readonly="true"></td>
  </tr>
  <tr>
      <th bgcolor="#DFE1EC">Apellido Materno:</th>
    <td><input name="amaterno" type="text" value="<%=elAMaterno%>" readonly="true"></td>
  </tr>
    <tr>
      <th bgcolor="#DFE1EC">El Area:</th>
    <td><input name="amaterno" type="text" value="<%=elArea%>" readonly="true"></td>
  </tr>
  <tr>
      <th bgcolor="#DFE1EC">El Puesto:</th>
    <td><input name="amaterno" type="text" value="<%=elPuesto%>" readonly="true"></td>
  </tr>
</table>  
<p><a href="Menu_Personal.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" alt="Regresar" name="Regresar" width="152" height="36" border="0"></a></p>
<%		
		}
		else{
%>
 <h1 align="center"><font color="#FF0000">¡Los Datos no pudieron ser almacenados!, Da un Click en Regresar para volver al Menú de Personal.</font></h1>		
<p><a href="Menu_Personal.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" alt="Regresar" name="Regresar" width="152" height="36" border="0"></a></p>
<%		
		}
%>
<p align="center">
</p>
<%			
	}
	else{
%>
<form method="post" name="formaR" action="Alta_Personal.jsp">
<input type="hidden" name="elUsuario" value="<%=elUsuario%>">
<input type="hidden" name="elTipo" value="<%=elTipo%>">
<input type="hidden" name="elNombre" value="<%=elNombre%>">
<input type="hidden" name="elAPaterno" value="<%=elAPaterno%>">
<input type="hidden" name="elAMaterno" value="<%=elAMaterno%>">
<input type="hidden" name="elArea" value="<%=elArea%>">
<input type="hidden" name="uno" value="falto">
<%	
		if(!entrada){
%>
 <p align="center"><font color="#FF0000">Se deben llenar todos los campos para dar de Alta un Usuario, Da un click en Regresar para reingresar todos los datos.</font></p>		
<%		
		}
		else if(!iguales){
%>
 <p align="center"><font color="#FF0000">No concordo la confirmación de la contraseña, vuelve a escribirlas.</font></p>		
<%			
		}
		else if(existe){
%>
 <p align="center"><font color="#FF0000">Ya existe otro Usuario Registrado con esa Clave, especifique otra.</font></p>		
<%			
		}
%>				
<p align="center">
  <a onClick="MandaSubmit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
</form>
<%		
	}
%>
<img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
