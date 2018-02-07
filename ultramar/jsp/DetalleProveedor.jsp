<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="prov" class="com.ult.bd.ManagerProveedores" scope="page" />

<html>
<head>
<title>Detalle Proveedor</title>
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
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin"))){
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	
	}
	String rfc = request.getQueryString();	
	ResultSet rs = prov.datos_Proveedor(rfc);
	while(rs.next()){
%>
<h1>Detalle de<strong> <%=rs.getString("nombre")%></strong></h1>
<table width="458" border="1" align="center">
  <tr> 
    <td width="71" bgcolor="#DFE1EC" ><div align="center">RFC</div></td>
    <td width="242" bgcolor="#DFE1EC" ><div align="center">Nombre</div></td>
    <td width="123" bgcolor="#DFE1EC" ><div align="center">Alta</div></td>
  </tr>
</table>
<table width="458" border="1" align="center">
  <tr> 
    <td width="71"><div align="center"><%=rfc%></div></td>
    <td width="242" ><div align="center"><%=rs.getString("nombre")%></div></td>
    <td width="123" ><div align="center"><%=rs.getString("alta")%></div></td>
  </tr>
</table>
<p></p>
<h1>Direcci&oacute;n:</h1>
<table width="585" border="1" align="center">
  <tr> 
    <td width="170" bgcolor="#DFE1EC" ><div align="center">Direcci&oacute;n</div></td>
    <td width="106" bgcolor="#DFE1EC" ><div align="center">Colonia</div></td>
    <td width="137" bgcolor="#DFE1EC" ><div align="center">Municipio/Delegaci&oacute;n</div></td>
    <td width="42" bgcolor="#DFE1EC" ><div align="center">CP</div></td>
    <td width="96" bgcolor="#DFE1EC" ><div align="center">Ciudad</div></td>
  </tr>
</table>
<table width="585" border="1" align="center">
  <tr> 
    <td width="170" ><div align="center"><%=rs.getString("direccion")%></div></td>
    <td width="106" ><div align="center"><%=rs.getString("colonia")%></div></td>
    <td width="137" ><div align="center"><%=rs.getString("delegacion")%></div></td>
    <td width="42" ><div align="center"><%=rs.getString("cp") %></div></td>
    <td width="96" ><div align="center"><%=rs.getString("Ciudad") %></div></td>
  </tr>
</table>
<p></p>
<h1>Tel&eacute;fonos:</h1>
<table width="446" border="1" align="center">
  <tr> 
    <td width="124" bgcolor="#DFE1EC" ><div align="center">Tel&eacute;fono 1</div></td>
    <td width="155" bgcolor="#DFE1EC" ><div align="center">Tel&eacute;fono 2</div></td>
    <td width="145" bgcolor="#DFE1EC" ><div align="center">Fax</div></td>
  </tr>
</table>
<table width="446" border="1" align="center">
  <tr> 
    <td width="124"><div align="center"><%
	if(rs.getString("tel1").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("tel1"));
		}%></div></td>
    <td width="155" ><div align="center"><%
	if(rs.getString("tel2").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("tel2"));
		}%></div></td>
    <td width="145" ><div align="center"><%
	if(rs.getString("fax").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("fax"));
		}%></div></td>
  </tr>
</table>
<p></p>
<h1>Correo Electr&oacute;nico :</h1>
  <div align="center">
    <table width="586" border="1">
      <tr> 
        <td width="84" bgcolor="#DFE1EC">Página Web</td>
        <td width="486"><div align="center"><%
	if(rs.getString("pagina").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("pagina"));
		}%></div></td>
      </tr>
      <tr> 
        <td width="84" bgcolor="#DFE1EC">e-mail</td>
        <td width="486"><div align="center"><%
	if(rs.getString("email").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("email"));
		}%></div></td>
      </tr>
    </table>
<p></p>
<h1>Varios:</h1>
<table width="572" border="1" align="center">
  <tr> 
    <td width="108" bgcolor="#DFE1EC" ><div align="center">Forma de Pago </div></td>
    <td width="220" bgcolor="#DFE1EC" ><div align="center">Vendedor</div></td>
    <td width="222" bgcolor="#DFE1EC" ><div align="center">Cuentas</div></td>
    </tr>
</table>
<table width="572" border="1" align="center">
  <tr> 
    <td width="108" ><div align="center"><%
	if(rs.getString("formaPago").equals("")){
			out.print("&nbsp;");
		}
	else{
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

			out.print(enLetra);
		}%></div></td>
    <td width="220" ><div align="center"><%
	if(rs.getString("vendedor").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("vendedor"));
		}%></div></td>
    <td width="222" ><div align="center"><%
	if(rs.getString("cuentas").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("cuentas"));
		}		%></div></td>
    </tr>
</table>
<p></p>
<h1>Cr&eacute;ditos:</h1>
<table width="357" border="1" align="center" >
  <tr> 
    <td width="80" bgcolor="#DFE1EC" ><div align="center">Cr&eacute;dito</div></td>
    <td width="104" bgcolor="#DFE1EC" ><div align="center">Paga a</div></td>
    <td width="151" bgcolor="#DFE1EC" ><div align="center">Saldo Disponible </div></td>
    </tr>
</table>
<table width="357" border="1" align="center">
  <tr> 
    <td width="80" ><div align="center"> $ <%=prov.formatoDinero(rs.getDouble("credito")+"")%></div></td>
    <td width="104" ><div align="center"><%=rs.getString("diasPago") %> D&iacute;as </div></td>
    <td width="151" ><div align="center"> $ <%=prov.formatoDinero(rs.getDouble("saldoDisponible")+"") %></div></td>
    </tr>
</table>
<p></p>
<h1>Descuentos:</h1>
<table width="357" border="1" align="center" >
  <tr> 
    <td bgcolor="#DFE1EC" ><div align="center">1</div></td>
    <td bgcolor="#DFE1EC" ><div align="center">2</div></td>
    <td bgcolor="#DFE1EC" ><div align="center">3</div></td>
    </tr>
</table>
<table width="357" border="1" align="center">
  <tr> 
    <td><div align="center"><%
	if(rs.getString("descuento1").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("descuento1"));
		}		%> % </div></td>
    <td><div align="center"><%
	if(rs.getString("descuento2").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("descuento2"));
		}		%> % </div></td>
    <td><div align="center"><%
	if(rs.getString("descuento3").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("descuento3"));
		}		%> %  </div></td>
    </tr>
</table>
    <%
	}
	prov.cierraConexion();
%>
  </div>
  <p>&nbsp;</p>
<p align="center"><a href="Todos_Proveedores.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
