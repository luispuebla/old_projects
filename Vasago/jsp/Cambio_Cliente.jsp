<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="cliente" class="com.vas.bd.ManagerClientes" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" />

<html>
<head>
<title>Modifica Cliente</title>
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
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String clientes = request.getParameter("rfc");
	String vacio = "";

	boolean exis = true;
	exis = cliente.existe(clientes);
	
	if(exis){ %>

<form name="form1" method="post" action="Conf_Cambio_Cliente.jsp">
<% 
	ResultSet rs = cliente.datos_Cliente(clientes);
	while (rs.next()) {
%>
       
<h1>Realiza las modificaciones necesarias y da Click en el bot&oacute;n de Guardar </h1>
	<table width="550" align="center">
		<tr align="left">
			<th width="177" align="left"><b>Campo NO Editable --></b></th>
			<td width="357" align="left"><b class="roj">**</b></td>			
		</tr>
  </table>		
<table width="648" border="1" align="center">
  <tr> 
	<th width="177" bgcolor="#CCCCCC">RFC:</th>
	<td width="357"><input type="text" name="rfc" value="<%= rs.getString("rfc") %>" readonly="true" size="15" maxlength="13"> <b class="roj">**</b></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Nombre del Cliente:</th>
	<td><input type="text" name="nombre" value="<%= rs.getString("nombre") %>" size="80" maxlength="80"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Direcci�n:</th>
	<td><input type="text" name="direccion" value="<%= rs.getString("direccion")%>" size="80" maxlength="80"> </td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Colonia:</th>
	<td><input type="text" name="colonia" value="<%= rs.getString("colonia") %>" size="35" maxlength="25"> </td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Delegaci&oacute;n / Municipio:</th>
	<td> <input type="text" name="delegacion" value="<%= rs.getString("delegacion") %>" size="25" maxlength="20"> </td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">C�digo Postal:</th>
	<td><input type="text" name="cp" value="<%= rs.getString("cp") %>" size="7" maxlength="5" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Ciudad:</th>
	<td><input type="text" name="ciudad" value="<%= rs.getString("ciudad") %>" size="40" maxlength="30"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Tipo:</th>
	<td><%
	int ti = rs.getInt("tipo");
	if(ti == 1){
%>
	<select name="tipo">
		<option selected value="1">Tipo 1</option>
		<option value="2">Tipo 2</option>
		<option value="3">Tipo 3</option>
		<option value="4">Tipo 4</option>
		<option value="5">Tipo 5</option>
	</select>
<%	
	}
	if (ti ==2){
%>
	<select name="tipo">
		<option selected value="2">Tipo 2</option>
		<option value="1">Tipo 1</option>
		<option value="3">Tipo 3</option>
		<option value="4">Tipo 4</option>
		<option value="5">Tipo 5</option>
	</select>
<%	
	}
	if( ti == 3){
%>
	<select name="tipo">
		<option selected value="3">Tipo 3</option>
		<option value="1">Tipo 1</option>
		<option value="2">Tipo 2</option>
		<option value="4">Tipo 4</option>
		<option value="5">Tipo 5</option>
	</select>
<%	
	}
	if( ti == 4){
%>
	<select name="tipo">
		<option selected value="4">Tipo 4</option>
		<option value="1">Tipo 1</option>
		<option value="2">Tipo 2</option>
		<option value="3">Tipo 3</option>
		<option value="5">Tipo 5</option>
	</select>
<%	
	}
	if( ti == 5){
%>
	<select name="tipo">
		<option selected value="5">Tipo 5</option>
		<option value="1">Tipo 1</option>
		<option value="2">Tipo 2</option>
		<option value="3">Tipo 3</option>
		<option value="4">Tipo 4</option>
	</select>
<%
	}
%>
</td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Tel�fono 1:</th>
	<td><input type="text" name="tel1" value="<% if(rs.getString("tel1") == null){ out.print(vacio);} else{out.print(rs.getString("tel1"));} %>" size="25" maxlength="20"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Tel�fono 2:</th>
	<td><input type="text" name="tel2" value="<% if(rs.getString("tel2") == null){ out.print(vacio);} else{out.print(rs.getString("tel2"));} %>" size="25" maxlength="20"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Fax:</th>
	<td><input type="text" name="fax" value="<% if(rs.getString("fax") == null){ out.print(vacio);} else{out.print(rs.getString("fax"));} %>" size="25" maxlength="20"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">e-mail:</th>
	<td><input type="text" name="email" value="<% if(rs.getString("email") == null){ out.print(vacio);} else{out.print(rs.getString("email"));} %>" size="85" maxlength="80" onChange="emailCheck()"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Cierran:</th>
	<td>
<%
	int tipo = rs.getInt("diaCierran");
	if(tipo == 1){
%>
	<select name="diaCierran">
		<option selected value="1">Lunes</option>
		<option value="2">Martes</option>
		<option value="3">Miercoles</option>
		<option value="4">Jueves</option>
		<option value="5">Viernes</option>
		<option value="6">S�bado</option>
		<option value="7">Domingo</option>
	</select>
<%	
	}
	if (tipo ==2){
%>
	<select name="diaCierran">
		<option selected value="2">Martes</option>
		<option value="1">Lunes</option>
		<option value="3">Miercoles</option>
		<option value="4">Jueves</option>
		<option value="5">Viernes</option>
		<option value="6">S�bado</option>
		<option value="7">Domingo</option>
	</select>
<%	
	}
	if( tipo == 3){
%>
	<select name="diaCierran">
		<option selected value="3">Miercoles</option>
		<option value="1">Lunes</option>
		<option value="2">Martes</option>
		<option value="4">Jueves</option>
		<option value="5">Viernes</option>
		<option value="6">S�bado</option>
		<option value="7">Domingo</option>
	</select>
<%	
	}
	if( tipo == 4){
%>
	<select name="diaCierran">
		<option selected value="4">Jueves</option>
		<option value="1">Lunes</option>
		<option value="2">Martes</option>
		<option value="3">Miercoles</option>
		<option value="5">Viernes</option>
		<option value="6">S�bado</option>
		<option value="7">Domingo</option>
	</select>
<%	
	}
	if( tipo == 5){
%>
	<select name="diaCierran">
		<option selected value="5">Viernes</option>
		<option value="1">Lunes</option>
		<option value="2">Martes</option>
		<option value="3">Miercoles</option>
		<option value="4">Jueves</option>
		<option value="6">S�bado</option>
		<option value="7">Domingo</option>
	</select>
<%	
	}
	if( tipo == 6){
%>
	<select name="diaCierran">
		<option selected value="6">S�bado</option>
		<option value="1">Lunes</option>
		<option value="2">Martes</option>
		<option value="3">Miercoles</option>
		<option value="4">Jueves</option>
		<option value="5">Viernes</option>
		<option value="7">Domingo</option>
	</select>
<%	
	}
	if( tipo == 7){
%>
	<select name="diaCierran">
		<option selected value="7">Domingo</option>
		<option value="1">Lunes</option>
		<option value="2">Martes</option>
		<option value="3">Miercoles</option>
		<option value="4">Jueves</option>
		<option value="5">Viernes</option>
		<option value="6">S�bado</option>
	</select>
<%	
	}
%>
	</td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Comida:</th>
	<td><input type="text" name="horaComida" value="<% if(rs.getString("horaComida") == null){ out.print(vacio);} else{out.print(rs.getString("horaComida"));} %>" size="25" maxlength="20"> 
hrs. </td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Contacto</th>
	<td><input type="text" name="contacto" value="<% if(rs.getString("contacto") == null){ out.print(vacio);} else{out.print(rs.getString("contacto"));} %>" size="60" maxlength="50"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Cr�dito</th>
	<td>$ <input type="text" name="credito" value="<% if(rs.getString("credito") == null){ out.print(vacio);} else{out.print(rs.getString("credito"));} %>" size="15" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> </td>
  </tr>
  <tr>
	<th bgcolor="#CCCCCC">Paga a:</th>
	<td>
<%
	int diasCredito = rs.getInt("pagoA");
%>			
	<select name="pagoA">
		<option selected value="<%=diasCredito%>"><%=diasCredito%></option>
<%
	for (int i = 1; i<=30; i++){
		if (i == diasCredito){
%>			
		<option selected value="<%=diasCredito%>"><%=diasCredito%></option>
<%
		}
		else{
%>
		<option value="<%=i%>"><%=i%></option>
<%
		}
	}
%>		  
	</select> D�as </td>
  </tr>
  <tr>
	<th bgcolor="#CCCCCC">Agente</th> 
	<td> <select name="agente">
<%
	ResultSet agen = personal.dameNombreAgente(rs.getString("agente"));
	String nombreAgente = new String();
	String claveAgente = new String();
	while(agen.next()){
		claveAgente = agen.getString("ClaveU");
		nombreAgente = agen.getString("NombreCompleto");
	}
	if (agen != null){
		agen.close();
	}
	personal.cierraConexion();
%>
	<option selected value="<%=claveAgente%>"><%=nombreAgente%></option>
<%
	ResultSet agentes = personal.dameAgentes();
	while(agentes.next()){
		if(claveAgente.equalsIgnoreCase(agentes.getString("ClaveU"))){
		}
		else{
%>
	<option value="<%=agentes.getString("ClaveU")%>"><%=agentes.getString("NombreCompleto")%></option>
<%	
		}
	}
	if(agentes != null){
		agentes.close();
	}
	personal.cierraConexion();
%>
	</select> </td>
  </tr>
  <tr>
  	<th bgcolor="#CCCCCC">Saldo Actual:</th>
	<td>$ <input name="saldoDisponible" type="text" id="saldoDisponible" value="<%= cliente.formatoDinero(rs.getDouble("saldoDisponible")+"") %>" size="12" maxlength="10" readonly="true"> <b class="roj">**</b></td>
  </tr>
  <tr>
  	<th bgcolor="#CCCCCC">Bloqueo por pago(s) vencido(s):</th>
	<td>
<%
	int blo = rs.getInt("bloqueoXPagoV");
	String bloqueo = new String();
	if(blo == 1){
		bloqueo = "Si";
	}
	else{
		bloqueo = "No";
	}
%>			
<input name="bloqueoXPagoV" type="text" id="bloqueoXPagoV" value="<%= bloqueo %>" size="7" maxlength="5" readonly="true"> 
<b class="roj">**</b></td>
  </tr>
</table>
		
        <p>
		<div align="center">
          <input type="submit" name="Submit" value="Guardar">
  </div>
          </p>
</form>
<p> 
  <% }
  	if(rs != null){
		rs.close();
	}
	cliente.cierraConexion();
 }
 else{ %>
 	<b class="roj">El Cliente no se encuentra Registrado en el Sistema</b>	
<%
}
%>
</p>
<p align="center"><a href="Existe_Cliente_Cambio.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
