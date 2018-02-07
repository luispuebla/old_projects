<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<jsp:useBean id="Clientes" class="com.vas.bd.ManagerClientes" scope="page" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" />

<html>
<head>
<title>Detalle Cliente</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

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
	String clie = request.getQueryString();	
	while(clie.lastIndexOf("%20")!= -1){
		int ocurrencia = clie.lastIndexOf("%20");
		clie=clie.replaceAll("%20"," ");
	}
	ResultSet rs = Clientes.datos_Cliente(clie);
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
    <td width="71"><div align="center"><%=clie%></div></td>
    <td width="242" ><div align="center"><%=rs.getString("nombre")%></div></td>
    <td width="123" ><div align="center"><%=rs.getString("alta")%></div></td>
  </tr>
</table>
<p></p>
<h1>Direcci&oacute;n:</h1>
<table width="724" border="1" align="center">
  <tr> 
    <td width="212" bgcolor="#DFE1EC" ><div align="center">Direcci&oacute;n</div></td>
    <td width="91" bgcolor="#DFE1EC" ><div align="center">Colonia</div></td>
    <td width="138" bgcolor="#DFE1EC" ><div align="center">Municipio/Delegaci&oacute;n</div></td>
    <td width="40" bgcolor="#DFE1EC" ><div align="center">CP</div></td>
    <td width="89" bgcolor="#DFE1EC" ><div align="center">Ciudad</div></td>
    <td width="114" bgcolor="#DFE1EC" ><div align="center">Tipo</div></td>
  </tr>
</table>
<table width="724" border="1" align="center">
  <tr> 
    <td width="212" ><div align="center"><%=rs.getString("direccion")%></div></td>
    <td width="91" ><div align="center"><%=rs.getString("colonia")%></div></td>
    <td width="138" ><div align="center"><%=rs.getString("delegacion")%></div></td>
    <td width="40" ><div align="center"><%=rs.getString("cp") %></div></td>
    <td width="89" ><div align="center"><%=rs.getString("Ciudad") %></div></td>
    <td width="114" ><div align="center">
	<% if(rs.getString("tipo").equals("")){
			out.print("&nbsp;");
		}
		else{
			if(rs.getString("tipo").equals("1")){
				out.print("Tipo 1");
			}	
			if(rs.getString("tipo").equals("2")){
				out.print("Tipo 2");
			}	
			if(rs.getString("tipo").equals("3")){
				out.print("Tipo 3");
			}	
			if(rs.getString("tipo").equals("4")){
				out.print("Tipo 4");
			}	
			if(rs.getString("tipo").equals("5")){
				out.print("Tipo 5");
			}	
		} %></div></td>
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
        <td width="65" bgcolor="#DFE1EC">e-mail</td>
        <td width="505"><div align="center"><%
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
<table width="651" border="1" align="center">
  <tr> 
    <td width="73" bgcolor="#DFE1EC" ><div align="center">Cierran</div></td>
    <td width="108" bgcolor="#DFE1EC" ><div align="center">Comida</div></td>
    <td width="220" bgcolor="#DFE1EC" ><div align="center">Contacto</div></td>
    <td width="222" bgcolor="#DFE1EC" ><div align="center">Agente</div></td>
    </tr>
</table>
<table width="651" border="1" align="center">
  <tr> 
    <td width="73" ><div align="center"><%
	if(rs.getInt("diaCierran") == 1){
		out.print("Lunes");
	}
	if(rs.getInt("diaCierran") == 2){
		out.print("Martes");
	}
	if(rs.getInt("diaCierran") == 3){
		out.print("Miercoles");
	}
	if(rs.getInt("diaCierran") == 4){
		out.print("Jueves");
	}
	if(rs.getInt("diaCierran") == 5){
		out.print("Viernes");
	}
	if(rs.getInt("diaCierran") == 6){
		out.print("Sábado");
	}
	if(rs.getInt("diaCierran") == 7){
		out.print("Domingo");
	}
	%></div></td>
    <td width="108" ><div align="center"><%
	if(rs.getString("horaComida").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("horaComida"));
		}%></div></td>
    <td width="220" ><div align="center"><%
	if(rs.getString("contacto").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("contacto"));
		}%></div></td>
    <td width="222" ><div align="center"><%
			ResultSet agen = personal.dameNombreAgente(rs.getString("agente"));
			String nombreAgente = new String();
			while(agen.next()){
				nombreAgente = agen.getString("NombreCompleto");
			}
			if(agen != null){
				agen.close();
			}
			personal.cierraConexion();
			
			out.print(nombreAgente);
		%></div></td>
    </tr>
</table>
<p></p>
<h1>Cr&eacute;ditos:</h1>
<table width="460" border="1" align="center" >
  <tr> 
    <td width="80" bgcolor="#DFE1EC" ><div align="center">Cr&eacute;dito</div></td>
    <td width="104" bgcolor="#DFE1EC" ><div align="center">Paga a</div></td>
    <td width="151" bgcolor="#DFE1EC" ><div align="center">Saldo Disponible </div></td>
    <td width="97" bgcolor="#DFE1EC" ><div align="center">Bloqueo </div></td>
    </tr>
</table>
<table width="460" border="1" align="center">
  <tr> 
    <td width="80" ><div align="center"> $ <%=Clientes.formatoDinero(rs.getDouble("credito")+"")%></div></td>
    <td width="104" ><div align="center"><%=rs.getString("pagoA") %> D&iacute;as </div></td>
    <td width="151" ><div align="center"> $ <%=Clientes.formatoDinero(rs.getDouble("saldoDisponible")+"") %></div></td>
    <td width="97" ><div align="center"><%
	if(rs.getInt("bloqueoXPagoV") == 0){
		out.print("No");
	}
	else{
		out.print("Si");
	}
	 %></div></td>
    </tr>
</table>
    <%
	}
	if(rs!=null){
		rs.close();
	}
	Clientes.cierraConexion();
%>
  </div>
  <p>&nbsp;</p>
<p align="center"><a href="TodosCli.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
