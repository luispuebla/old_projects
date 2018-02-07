<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" scope="page" />

<html>
<head>
<title>Todos los Clientes</title>
<link href="baseMiniCSS.css" rel="stylesheet" type="text/css">
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

function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}

function Cerrar() {
	parent.close(); 
}
//-->
</script>
</head>
<body onLoad="imprimirPagina(); Cerrar()">
<h1>Todos los Clientes registrados en Sistema (Ordenados Alfab&eacute;ticamente) son:</h1>
<table width="750" border="1" align="center" cellpadding="0" cellspacing="0">
  <tr bgcolor="#CCCCCC"> 
    <th width="83" ><div align="center">RFC / CURP </div></th>
    <th width="180" ><div align="center">Nombre</div></th>
    <th width="200" ><div align="center">Dirección</div></th>
    <th width="128" ><div align="center">Cont&aacute;cto <br />y Tel&eacute;fonos</div></th>
    <th width="147" ><div align="center">Tipo</div></th>
  </tr>
<%	
		ResultSet rs = cliente.dameClientes();
		while (rs.next()){  
			String contacto = rs.getString("contacto");
			String tel1 =  rs.getString("tel1");
			String tel2 = rs.getString("tel2");
			if(contacto.trim().equals("")){
				contacto = "&nbsp;";
			}
			if(tel1.trim().equals("")){
				tel1 = "&nbsp;";
			}	
			if(tel2.trim().equals("")){
				tel2 = "&nbsp;";
			}	
			
%>
  <tr> 
    <td align="center"><%= rs.getString("rfc")%>/ <br/><%=rs.getString("curp")%></td>
    <td><%= rs.getString("nombre")%></td>
    <td><%= rs.getString("direccion")%>, Col. <%=rs.getString("colonia")%>, Del.<%= rs.getString("delegacion")%>,Ciudad <%=rs.getString("ciudad")%> </td>
    <td align="center"><%= contacto%><br/><%= tel1%> <br /> <%=tel2 %></td>
<%
	String fraseTipoCliente = "";
	int tipoCliente = rs.getInt("tipoCliente");
	if (tipoCliente == 1){
		fraseTipoCliente = "Con Cr&eacute;dito";
		fraseTipoCliente += " <br /> " +"Cr&eacute;dito: $" +cliente.formatoDinero(rs.getString("credito"));
		fraseTipoCliente += " <br /> " +"Saldo Disponible: $" +cliente.formatoDinero(rs.getString("saldo"));
	}
	else{
		fraseTipoCliente = "Sin Cr&eacute;dito";
	}
%>	
    <td align="center"><div align="left"><%= fraseTipoCliente %></div></td>
  </tr>
<%	      
		        } 
%>
</table>
</body>
</html>


