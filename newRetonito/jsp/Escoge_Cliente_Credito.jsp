<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" session = "true" %> 
<jsp:useBean id="inv" class="com.alpha.bd.ManagerClientes" />

<html>
<head>
<title>Selecci�n de Cliente</title>
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

function OnSubmitForm(){
	if(form1.nombre != null){
		var valor = 'Ninguno';
		for(var i=0; i<form1.nombre.length; ++i){
			if(form1.nombre[i].checked){
				valor = form1.nombre[i].value;
			}
		}	
		if(valor == 'Ninguno'){
			alert("Debes seleccionar al menos un cliente para proseguir.");
			return false;
		}
		else{
			document.form1.action ="Conf_Existe_Cliente_Credito.jsp";		
		}
	}
	else{
		return false;	
	}
}

//-->
</script>
  </head>

    <body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String clientes = request.getParameter("rfc");	
%>
<h1>Selecciona el Cliente para cr&eacute;dito y da Click en el bot&oacute;n de Enviar</h1>
<form name="form1" method="post" onSubmit="return OnSubmitForm();">
<table width="500" border="1">
  <tr>  
	<th><input type="radio" name="nombre"  readonly="true" disabled></td>
	<th>Nombre:</td>
	<th>Tipo de Cliente:</td>
  </tr>
<%
	ResultSet rs = inv.datos_Cliente(clientes);
	while (rs.next()) {
		tipo = rs.getString("tipoCliente");
		if (tipo.equalsIgnoreCase("1")){
			tipo = "Con Cr�dito";
		}
		else {
			tipo = "De Contado";
		}	
%>
  <tr>
	<td><div align="center"><input type="radio" name="nombre" value="<%= rs.getString("nombre") %>"></div></td>
	<td> <input type="text" name="nombr" value="<%= rs.getString("nombre") %>" readonly="true" size="50" >	</td>
	<td> <div align="center">
	  <input type="text" name="tipo" value="<%=tipo %>" readonly="true" size="30" > 
	  </div></td>
  </tr>
<% 
	}
	rs.close();
	inv.cierraConexion(); 
%>
</table>
<input type="hidden" name="rfc" value="<%=clientes%>">
 <p> <div align="center"> <input type="submit" name="Submit" value="Enviar">  </div>  </p>
</form>
<p><a href="Existe_Cliente_Credito.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
