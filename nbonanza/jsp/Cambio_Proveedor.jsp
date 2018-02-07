<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="prov" class="com.alpha.bd.ManagerProveedores" scope="page" />

<html>
<head>
<title>Modifica Proveedor</title>
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

function Habilitador (f){
	var tieneCredito = f.idCredito.value;
	if(tieneCredito == 1){
		f.credito.disabled = false;
		f.credito.select;
	}
	else{
		f.credito.value = "0.00";
		f.credito.disabled = true;
	}
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

function seleccionaTodo(objeto){
	objeto.select();
}

//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 			
	String rfc = "";
	rfc = request.getParameter("rfc");	
	if(rfc == null){
%>
		<b class="roj">Debes seleccionar un Proveedor de la lista para modificar sus Datos</b>
<%	
	}
	else{
		String nombre = "";
		String direccion = "";
		String colonia = "";
		String delegacion = "";
		String cp = "";
		String ciudad = "";
		String tel1 = "";
		String tel2 = "";
		String fax = "";
		String pagina = "";
		String email = "";
		String vendedor = "";
		String formaPago = "";
		String cuentas = "";
		String idCredito = "";
		String credito = "0.00";
		String pagoA = "";
		String des1 = "";
		String des2 = "";
		String des3 = "";	
		String saldoActual = "";
		if(request.getParameter("interno") != null){
			rfc = request.getParameter("rfc");
			nombre = request.getParameter("nombre");
			direccion = request.getParameter("direccion");
			colonia = request.getParameter("colonia");
			delegacion = request.getParameter("delegacion");
			cp = request.getParameter("cp");
			ciudad = request.getParameter("ciudad");
			tel1 = request.getParameter("tel1");
			tel2 = request.getParameter("tel2");
			fax = request.getParameter("fax");
			pagina = request.getParameter("pagina");
			email = request.getParameter("email");
			vendedor = request.getParameter("vendedor");
			formaPago = request.getParameter("formaPago");
			cuentas = request.getParameter("cuentas");
			idCredito = request.getParameter("idCredito");
			credito = request.getParameter("credito");
			pagoA = request.getParameter("pagoA");
			des1 = request.getParameter("des1");
			des2 = request.getParameter("des2");
			des3 = request.getParameter("des3");
			saldoActual = request.getParameter("saldoActual");
		}
		else{
			rfc = request.getParameter("rfc");
			ResultSet rs = prov.datos_Proveedor(rfc);
			while (rs.next()) {
				rfc = rs.getString("rfc");
				nombre = rs.getString("nombre");
				direccion = rs.getString("direccion");
				colonia = rs.getString("colonia");
				delegacion = rs.getString("delegacion");
				cp = rs.getString("cp");
				ciudad = rs.getString("ciudad");
				tel1 = rs.getString("tel1");
				tel2 = rs.getString("tel2");
				fax = rs.getString("fax");
				pagina = rs.getString("pagina");
				email = rs.getString("email");
				vendedor = rs.getString("vendedor");
				formaPago = rs.getString("formaPago");
				cuentas = rs.getString("cuentas");
				credito = rs.getString("credito");
				if(prov.cambiaADouble(credito) > 0.00){
					idCredito = "1";
				}
				else{
					idCredito = "0";
					credito = "0.00";
				}			
				pagoA = rs.getString("diasPago");
				des1 = rs.getString("descuento1");
				des2 = rs.getString("descuento2");
				des3 = rs.getString("descuento3");
				saldoActual = prov.formatoDinero(prov.acortaLongitud(rs.getString("saldoDisponible")));
			}
			prov.cierraConexion();
		}
%>
	<form name="form1" method="post" action="Conf_Cambio_Proveedor.jsp">     
<h1>Realiza las modificaciones necesarias y da Click en el bot&oacute;n de Guardar </h1>
	<table width="550" align="center">
		<tr align="left">
			<th width="177" align="left"><b>Campo NO Editable --></b></th>
			<td width="357" align="left"><b class="roj">++</b></td>			
		</tr>
  </table>		
<table width="650" border="1" align="center">
    <tr> 
      <th width="93"> RFC:</th>
      <td width="598"> <input name="rfc" type="text" size="15" maxlength="13" value="<%=rfc%>" readonly="true"> 
        <b class="roj">++</b>  </td>
    </tr>
    <tr> 
      <th> Nombre:</th>
      <td> <input name="nombre" type="text" size="80" maxlength="75" value="<%=nombre%>">
        <b class="roj">**</b> </td>
    </tr>
    <tr> 
      <th>Dirección:</th>
      <td> <input name="direccion" type="text" size="65" maxlength="50" value="<%=direccion%>"> </td>
    </tr>
    <tr> 
      <th>Colonia:</th>
      <td> <input name="colonia" type="text" size="30" maxlength="25" value="<%=colonia%>"></td>
    </tr>
    <tr> 
      <th>Delegación / Municipio:</th>
      <td><input name="delegacion" type="text" size="25" maxlength="20" value="<%=delegacion%>"></td>
    </tr>
    <tr> 
      <th>Código Postal:</th>
      <td> <input name="cp" type="text" size="6" maxlength="5" value="<%=cp%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
    <th>Ciudad:</th>
      <td> <input name="ciudad" type="text" size="35" maxlength="30" value="<%=ciudad%>"></td>
    </tr>
    <tr> 
    <th>Teléfono 1:</th>
      <td> <input name="tel1" type="text" size="25" maxlength="20" value="<%=tel1%>">   <b class="roj">**</b></td>
    </tr>
    <tr> 
    <th>Teléfono 2:</th>
      <td> <input name="tel2" type="text" size="25" maxlength="20" value="<%=tel2%>"></td>
    </tr>
    <tr> 
    <th>Fax:</th>
      <td> <input name="fax" type="text" size="25" maxlength="20" value="<%=fax%>"></td>
    </tr>    
	<tr> 
    <th>Página Web:</th>
      <td> <input name="pagina" type="text" size="80" maxlength="75" value="<%=pagina%>"></td>
    </tr>
    <tr> 
    <th>e-mail:</th>
      <td> <input name="email" type="text" size="85" maxlength="80" onChange="emailCheck()" value="<%=email%>"></td>
    </tr>
    <tr> 
      <th>Vendedor:</th>
      <td> <input name="vendedor" type="text" id="contacto" size="65" maxlength="50" value="<%=vendedor%>"></td>
	</tr>	
    <tr> 
      <th bgcolor="#CCCCCC">Forma de Pago:</th>
      <td> <select name="formaPago">
		  <option <%if (formaPago.equals("") || formaPago.equals("1")){%> selected <% } %>value="1">Efectivo</option>
          <option <%if (formaPago.equals("2")){%> selected <% } %> value="2">Cheque</option>
          <option <%if (formaPago.equals("3")){%> selected <% } %> value="3">Depósito</option>
          <option <%if (formaPago.equals("4")){%> selected <% } %> value="4">Tarjeta de Crédito</option>
          <option <%if (formaPago.equals("5")){%> selected <% } %> value="5">Tarjeta de Débito</option>
        </select></td>
	</tr>	
     <tr> 
      <th bgcolor="#CCCCCC">Cuentas del Banco:</th>
      <td><textarea name="cuentas" cols="70" rows="4" ><%=cuentas%></textarea>
      </td>
	</tr>
    <tr> 
      <th>Cr&eacute;dito:</th>
      <td><select name="idCredito" onChange="Habilitador(this.form)">
	  		<option <%if (idCredito.equals("") || idCredito.equals("0")){%> selected <% } %> value="0">No</option>
			<option <%if (idCredito.equals("1")){%> selected <% } %> value="1">Si</option>
	  	</select>  $ 
        <input <%if (idCredito.equals("0") || idCredito.equals("")){%> disabled <% } %> onFocus="seleccionaTodo(this)" name="credito" value="<%=credito%>" type="text" id="credito" size="15" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
	</tr>	
    <tr> 
      <th bgcolor="#CCCCCC">Se le Paga a:</th>
      <td> <select name="pagoA" id="pagoA">
          <option <%if (pagoA.equals("") || pagoA.equals("0")){%> selected <% } %> value="0">0</option>
		  <option <%if (pagoA.equals("1")){%> selected <% } %> value="1">1</option>
          <option <%if (pagoA.equals("2")){%> selected <% } %> value="2">2</option>
          <option <%if (pagoA.equals("3")){%> selected <% } %> value="3">3</option>
          <option <%if (pagoA.equals("4")){%> selected <% } %> value="4">4</option>
          <option <%if (pagoA.equals("5")){%> selected <% } %> value="5">5</option>
          <option <%if (pagoA.equals("6")){%> selected <% } %> value="6">6</option>
          <option <%if (pagoA.equals("7")){%> selected <% } %> value="7">7</option>
          <option <%if (pagoA.equals("8")){%> selected <% } %> value="8">8</option>
          <option <%if (pagoA.equals("9")){%> selected <% } %> value="9">9</option>
          <option <%if (pagoA.equals("10")){%> selected <% } %> value="10">10</option>
          <option <%if (pagoA.equals("11")){%> selected <% } %> value="11">11</option>
          <option <%if (pagoA.equals("12")){%> selected <% } %> value="12">12</option>
          <option <%if (pagoA.equals("13")){%> selected <% } %> value="13">13</option>
          <option <%if (pagoA.equals("14")){%> selected <% } %> value="14">14</option>
          <option <%if (pagoA.equals("15")){%> selected <% } %> value="15">15</option>
          <option <%if (pagoA.equals("16")){%> selected <% } %> value="16">16</option>
          <option <%if (pagoA.equals("17")){%> selected <% } %> value="17">17</option>
          <option <%if (pagoA.equals("18")){%> selected <% } %> value="18">18</option>
          <option <%if (pagoA.equals("19")){%> selected <% } %> value="19">19</option>
          <option <%if (pagoA.equals("10")){%> selected <% } %>  value="20">20</option>
          <option <%if (pagoA.equals("21")){%> selected <% } %> value="21">21</option>
          <option <%if (pagoA.equals("22")){%> selected <% } %> value="22">22</option>
          <option <%if (pagoA.equals("23")){%> selected <% } %> value="23">23</option>
          <option <%if (pagoA.equals("24")){%> selected <% } %> value="24">24</option>
          <option <%if (pagoA.equals("25")){%> selected <% } %> value="25">25</option>
          <option <%if (pagoA.equals("26")){%> selected <% } %> value="26">26</option>
          <option <%if (pagoA.equals("27")){%> selected <% } %> value="27">27</option>
          <option <%if (pagoA.equals("28")){%> selected <% } %> value="28">28</option>
          <option <%if (pagoA.equals("29")){%> selected <% } %> value="29">29</option>
          <option <%if (pagoA.equals("30")){%> selected <% } %> value="30">30</option>
		  <option <%if (pagoA.equals("60")){%> selected <% } %> value="60">60</option>
		  <option <%if (pagoA.equals("90")){%> selected <% } %> value="90">90</option>
        </select> &nbsp; Días</td>
	</tr>	
    <tr> 
      <th>Descuentos:</th>
      <td>1--&gt;
        <input name="des1" onFocus="seleccionaTodo(this)" type="text" size="8" value="<%=des1%>" maxlength="6" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        %  &nbsp; 
		2--&gt;
		<input name="des2" onFocus="seleccionaTodo(this)" type="text" value="<%=des2%>" id="des2" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="8" maxlength="6">
		% &nbsp; 3--&gt;
		<input name="des3" onFocus="seleccionaTodo(this)" type="text" value="<%=des3%>" id="des3" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="8" maxlength="6">
	  % &nbsp; </td>
	</tr>	
  <tr>
  	<th>Saldo Disponible:</th>
	<td>$ <input name="saldoDisponible" type="text" id="saldoDisponible" value="<%=saldoActual%>" size="12" maxlength="10" readonly="true"> 
	<b class="roj">++</b></td>
  </tr>
</table>		
<br />
<b class="roj">**</b> Campos Obligatorios.  
        <p>
		<div align="center">
          <input type="submit" name="Submit" value="Guardar">
  </div>
          </p>
</form>
<%}%>
<p align="center"><a href="Existe_Proveedor_Cambio.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
