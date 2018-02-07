<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="prov" class="com.ult.bd.ManagerProveedores" />

<html>
<head>
<title>Modifica Proveedor</title>
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
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String rfc = request.getParameter("rfc");
	String vacio = "";

	boolean exis = true;
	exis = prov.existe(rfc);
	
	if(exis){ %>

<form name="form1" method="post" action="Conf_Cambio_Proveedor.jsp">
<% 
	ResultSet rs = prov.datos_Proveedor(rfc);
	while (rs.next()) {
%>
       
<h1>Realiza las modificaciones necesarias y da Click en el bot&oacute;n de Guardar </h1>
	<table width="550" align="center">
		<tr align="left">
			<th width="177" align="left"><b>Campo NO Editable --></b></th>
			<td width="357" align="left"><b class="roj">**</b></td>			
		</tr>
  </table>		
<table width="716" border="1" align="center">
  <tr> 
	<th width="177" bgcolor="#CCCCCC">RFC:</th>
	<td width="357"><input type="text" name="rfc" value="<%= rs.getString("rfc") %>" readonly="true" size="15" maxlength="13"> <b class="roj">**</b></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Nombre:</th>
	<td><input type="text" name="nombre" value="<% if(rs.getString("nombre") == null){ out.print(vacio);} else{out.print(rs.getString("nombre"));} %>" size="50" maxlength="45"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Dirección:</th>
	<td><input type="text" name="direccion" value="<% if(rs.getString("direccion") == null){ out.print(vacio);} else{out.print(rs.getString("direccion"));} %>" size="60" maxlength="50"> </td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Colonia:</th>
	<td><input type="text" name="colonia" value="<% if(rs.getString("colonia") == null){ out.print(vacio);} else{out.print(rs.getString("colonia"));} %>" size="35" maxlength="25"> </td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Delegaci&oacute;n / Municipio:</th>
	<td> <input type="text" name="delegacion" value="<% if(rs.getString("delegacion") == null){ out.print(vacio);} else{out.print(rs.getString("delegacion"));} %>" size="25" maxlength="20"> </td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Código Postal:</th>
	<td><input type="text" name="cp" value="<% if(rs.getString("cp") == null){ out.print(vacio);} else{out.print(rs.getString("cp"));} %>" size="7" maxlength="5" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Ciudad:</th>
	<td><input type="text" name="ciudad" value="<% if(rs.getString("ciudad") == null){ out.print(vacio);} else{out.print(rs.getString("ciudad"));} %>" size="40" maxlength="30"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Teléfono 1:</th>
	<td><input type="text" name="tel1" value="<% if(rs.getString("tel1") == null){ out.print(vacio);} else{out.print(rs.getString("tel1"));} %>" size="25" maxlength="20"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Teléfono 2:</th>
	<td><input type="text" name="tel2" value="<% if(rs.getString("tel2") == null){ out.print(vacio);} else{out.print(rs.getString("tel2"));} %>" size="25" maxlength="20"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Fax:</th>
	<td><input type="text" name="fax" value="<% if(rs.getString("fax") == null){ out.print(vacio);} else{out.print(rs.getString("fax"));} %>" size="25" maxlength="20"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Página Web:</th>
	<td><input type="text" name="pagina" value="<% if(rs.getString("pagina") == null){ out.print(vacio);} else{out.print(rs.getString("pagina"));} %>" size="100" maxlength="100"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">e-mail:</th>
	<td><input type="text" name="email" value="<% if(rs.getString("email") == null){ out.print(vacio);} else{out.print(rs.getString("email"));} %>" size="85" maxlength="80" onChange="emailCheck()"></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Vendedor:</th>
	<td><input type="text" name="vendedor" value="<% if(rs.getString("vendedor") == null){ out.print(vacio);} else{out.print(rs.getString("vendedor"));} %>" size="65" maxlength="50"></td>
  </tr>
  <tr>
	<th bgcolor="#CCCCCC">Forma de Pago:</th>
	<td>
<%
	int formaPago = rs.getInt("formaPago");
	String enLetra = new String();
	if(formaPago == 1){
		enLetra = "Efectivo";
	}
	if(formaPago == 2){
		enLetra = "Cheque";
	}
	if(formaPago == 3){
		enLetra = "Depósito";
	}
	if(formaPago == 4){
		enLetra = "Tarjeta de Crédito";
	}
	if(formaPago == 5){
		enLetra = "Tarjeta de Débito";
	}
%>			
	<select name="formaPago">
		<option selected value="<%=formaPago%>"><%=enLetra%></option>
<%
	for (int i = 1; i<=5; i++){
		if (i == formaPago){
%>			
		<option selected value="<%=formaPago%>"><%=enLetra%></option>
<%
		}
		else{
%>
		<option value="<%=i%>"><%
	String enLetra2 = new String();
	if(i == 1){
		enLetra2 = "Efectivo";
	}
	if(i == 2){
		enLetra2 = "Cheque";
	}
	if(i == 3){
		enLetra2 = "Depósito";
	}
	if(i == 4){
		enLetra2 = "Tarjeta de Crédito";
	}
	if(i == 5){
		enLetra2 = "Tarjeta de Débito";
	}
	out.print(enLetra2);
%></option>
<%
		}
	}
%>		  
	</select></td>
  </tr>
    <tr> 
	<th bgcolor="#CCCCCC">Cuentas:</th>
	<td><textarea name="cuentas" cols="70" rows="4"><% if(rs.getString("cuentas") == null){ out.print(vacio);} else{out.print(rs.getString("cuentas"));} %></textarea>
	</td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Crédito</th>
	<td>$ <input type="text" name="credito" value="<% if(rs.getString("credito") == null){ out.print(vacio);} else{out.print(prov.formatoDinero(rs.getString("credito")));} %>" size="15" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> </td>
  </tr>
     <tr> 
  <tr> 
	<th bgcolor="#CCCCCC">Se le Paga a:</th>
	<td width="104" ><div align="center"><select name="pagoA">
		<option selected value="<%=rs.getString("diasPago")%>"><%=rs.getString("diasPago")%></option>
<%	 int tempo = rs.getInt("diasPago");
	int sesenta = 60;
	int noventa = 90;
	
	for (int i = 0; i<=30; i++){
		if (i == tempo){
%>			
		<option selected value="<%=tempo%>"><%=tempo%></option>
<%
		}
		else{
%>
		<option value="<%=i%>"><%=i%></option>
<%
		}
	}
	if(tempo == sesenta){
%>			
		<option selected value="<%=tempo%>"><%=tempo%></option>
<%
	}
	else{
%>
		<option value="<%=sesenta%>"><%=sesenta%></option>
<%
	}
	if(tempo == noventa){
%>		  
		<option selected value="<%=tempo%>"><%=tempo%></option>
<%
	}
	else{
%>
		<option value="<%=noventa%>"><%=noventa%></option>
<%
	}
%>
	</select>   D&iacute;as </div></td>
  </tr>
      <th bgcolor="#CCCCCC">Descuentos:</th>
      <td>1--&gt;
        <input name="des1" type="text" size="8" maxlength="6" value="<% if(rs.getString("descuento1") == null){ out.print(vacio);} else{out.print(rs.getString("descuento1"));} %>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        %  &nbsp; 
		2--&gt;
		<input name="des2" type="text" id="des2" value="<% if(rs.getString("descuento2") == null){ out.print(vacio);} else{out.print(rs.getString("descuento2"));} %>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="8" maxlength="6">
		% &nbsp; 3--&gt;
		<input name="des3" type="text" id="des3" value="<% if(rs.getString("descuento3") == null){ out.print(vacio);} else{out.print(rs.getString("descuento3"));} %>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="8" maxlength="6">
		% &nbsp;</td>
	</tr>	
  <tr>
  	<th bgcolor="#CCCCCC">Saldo Actual:</th>
	<td>$ <input name="saldoDisponible" type="text" id="saldoDisponible" value="<%= prov.formatoDinero(rs.getDouble("saldoDisponible")+"") %>" size="12" maxlength="10" readonly="true"> <b class="roj">**</b></td>
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
 }
 else{ %>
 	<b class="roj">El Proveedor no se encuentra Registrado en el Sistema</b>	
<%
}
prov.cierraConexion();
%>
</p>
<p align="center"><a href="Existe_Proveedor_Cambio.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
