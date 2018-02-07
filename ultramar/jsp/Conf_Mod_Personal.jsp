<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="personalMain" class="com.ult.bd.ManagerPersonal" scope="page" />

<html>
<head>
<title>Confirmación Modificación Personal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
<%
	String elUsuario = request.getParameter("claveu").trim();	
%>
<jsp:setProperty name="personalMain" property="usuario" value="<%=elUsuario%>"/>
<%	
	String elTipo = "";
	String laContra = "";
	String elNombre = "";
	String elAPaterno = "";
	String elAMaterno = "";
	String elPuesto = "";
	String elArea = "";	
	boolean existe = personalMain.yaExiste();	
	if(request.getParameter("uno")!=null){
		elUsuario = request.getParameter("elUsuario").trim();
		elTipo = request.getParameter("elTipo");
		elNombre = request.getParameter("elNombre");
		elAPaterno = request.getParameter("elAPaterno");
		elAMaterno = request.getParameter("elAMaterno");
		elArea = request.getParameter("elArea");		
		elPuesto = request.getParameter("elPuesto");
	}
	else if(existe){
		ResultSet datosU = personalMain.datosUsuario();
		while (datosU.next()){		
			elUsuario = datosU.getString("ClaveU");
			laContra = datosU.getString("Contrasena");
			elTipo = datosU.getString("Tipo");
			elNombre = datosU.getString("Nombre");
			elAPaterno = datosU.getString("APaterno");
			elAMaterno = datosU.getString("AMaterno");
			elArea = datosU.getString("Area");		
			elPuesto = datosU.getString("Puesto");
		}
	}
%>
<script language="JavaScript" type="text/JavaScript">
<!--
var valores_select_1 = new Array("Cobros", "Operativa", "Ventas");
var fila1 = new Array("Caja");
var fila2 = new Array("Cocinero","Bartender","Ayudante");
var fila3 = new Array("Hostes","Mesera");
var valores_select_2 = new Array(fila1, fila2, fila3);
var numero = new Number();
numero = 0;

function escribir_opciones_select(valores, nombre){
	var elpuesto = new String (nombre);
	for(var i = 0; i < valores.length; i++){
		if(elpuesto==valores[i]){
			numero = i;
			window.document.writeln('<OPTION VALUE= "'+valores[i] +'" defaultSelected>'+valores[i]+'</OPTION>');
		}
		else{
			window.document.writeln('<OPTION VALUE= "'+valores[i] +'">'+valores[i]+'</OPTION>');
		}
	}		
	document.form1.select_2[numero].selected;
}

function cambiar_select_2(formulario, valores_select_1, valores_select_2){
	var indice = formulario.select_1.selectedIndex;
	formulario.select_2.disabled = false;
	formulario.select_2.length=valores_select_2[indice].length;
	for(var i = 0; i < valores_select_2[indice].length; i++){
		formulario.select_2.options[i].text = valores_select_2[indice][i];
		formulario.select_2.options[i].value = valores_select_2[indice][i];
		formulario.select_2.selectedIndex=numero;
	}
}

function funcionFoco(){
	var contenido = document.form1.claveu.value;
	if(contenido==""){
		document.form1.claveu.focus();
	}
	else{
		document.form1.contrase.focus();
	}
}

function funcionFoco(){
	var contenido = document.form1.claveu.value;
	if(contenido==""){
		document.form1.claveu.focus();
	}
	else{
		document.form1.contrase.focus();
	}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body  onLoad="MM_preloadImages('imagenes/Regresar2.jpg');funcionFoco(); cambiar_select_2(document.form1, valores_select_1, valores_select_2)"> 
<%
if(elUsuario.equalsIgnoreCase("super") || elUsuario.equalsIgnoreCase("super")){
%>
	<p align="center">Los Usuarios SUPER no se le pueden realizar modificaciones.</p>		
<%
}
else{
	if(existe){
%>
 <h1>Modifique los Datos:</h1>
 <div align="center">La Clave de Usuario, no se puede modificar.</div>
<form name="form1" method="post" target="_self" action="Conf_Mod_Personal2.jsp">				
<table width="433" border="1" align="center">
  <tr>
    <th width="157" bgcolor="#DFE1EC">Clave del Usuario:</th>
    <td width="166"><input readonly="true" name="claveu" type="text" maxlength="8" value="<%=elUsuario%>"></td>
  </tr>
  <tr>
    <th bgcolor="#DFE1EC">Contrase&ntilde;a asignada:</th>
    <td><input name="contrase" type="text" maxlength="4" value="<%=laContra%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
  </tr>
  <tr>
    <th bgcolor="#DFE1EC">Confirmaci&oacute;n Contrase&ntilde;a:</th>
    <td><input name="contrase2" type="text" maxlength="4" value="<%=laContra%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
  </tr>  
  <tr>
    <th bgcolor="#DFE1EC">Tipo de Usuario:</th>
    <td><input name="tipo2" maxlength="8" value="Simple" readonly="true">
  </tr>
  <tr>
    <th bgcolor="#DFE1EC">Nombre:</th>
    <td><input name="nombre" type="text" maxlength="30" value="<%=elNombre%>"></td>
  </tr>
  <tr>
    <th bgcolor="#DFE1EC">Apellido Paterno:</th>
    <td><input name="apaterno" type="text" maxlength="30" value="<%=elAPaterno%>"></td>
  </tr>
  <tr>
    <th bgcolor="#DFE1EC">Apellido Materno:</th>
    <td><input name="amaterno" type="text" maxlength="30" value="<%=elAMaterno%>"></td>
  </tr>
  <tr>
    <th bgcolor="#DFE1EC">Area:</th>
    <td><select name="select_1" onChange="cambiar_select_2(this.form, valores_select_1, valores_select_2)">
		<option value="Cobros"
		<% if(elArea.equalsIgnoreCase("Cobros")){%> selected <%}%>		
		>Cobros</option>
		<option value="Operativa"
		<% if(elArea.equalsIgnoreCase("Operativa")){%> selected <%}%>		
		>Operativa</option>
		<option value="Ventas"
		<% if(elArea.equalsIgnoreCase("Ventas")){%> selected <%}%>		
		>Ventas</option>
<!--		<script language="javascript">
			escribir_opciones_select(valores_select_1);
		</script> -->
	</select>
	</td>
  </tr>
  <tr>
	<th bgcolor="#DFE1EC">Puesto:</th>
      <td><select name="select_2">
		<script language="javascript">
			var indice = form1.select_1.selectedIndex;
			escribir_opciones_select(valores_select_2[indice], '<%=elPuesto%>');
		</script>	  
	  </select>
	  </td> 
  </tr>		 
</table>
<p>
<table width="217" border="0" align="center">
  <tr>
    <td width="219"><div align="center"> 
          <input type="reset" name="Submit2" value="Recuperar">
        </div></td>
    <td width="221"><div align="center">
          <input name="Submit" type="submit" value="Guardar">
        </div></td>
  </tr>
</table></p>
</form>
<%
	}
	else{
%>
<p align="center">No existe ningun Usuario con la clave especificada <br/> 
  verifique e intente de nuevo.</p>		
<%		
	}
}
personalMain.cierraConexion();
%>
<p align="center"><a href="Modificacion_Personal.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache1" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> </p>
</body>
</html>
