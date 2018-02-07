<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alProd" class="com.alpha.bd.ManagerProduccion" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Impresi&oacute;n Orden Trabajo</title>
<link href="baseMiniCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--


function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
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
<%
	String claveOrden = "";
	String fAlta = "";
	String usuario = "";
	String observaciones = "&nbsp;";
	claveOrden = request.getParameter("claveOrden");
	usuario = request.getParameter("usuario");
	ResultSet rs = alProd.datosOrdenImp(claveOrden);
	while (rs.next()){
		String tempOb = rs.getString("ObsAlta");
		if(! tempOb.trim().equals("")){
			observaciones = rs.getString("ObsAlta");
		}
		fAlta = rs.getString("fechaAlta");
	}
	if(rs != null){
		rs.close();
	}
	alProd.cierraConexion();		// de ResultSet Complex											
	
%>
<body onLoad="imprimirPagina(); Cerrar()" topmargin="0">
<table cellpadding="0" cellspacing="0" border="0">
  <tr>
	<td>	  <div align="center"><b class="titulos2">Clave Orden de Trabajo: # <%=claveOrden%></b><br/>
	        <b class="titulos"> </b></div>
	  <table width="100%" cellpadding="0" cellspacing="0" border="1">
	<tr>
		<th width="101">Fecha Alta:</th>
		<td colspan="2"><div align="center"><%=fAlta%></div></td>		
		<th width="130">Fecha Entrega:</th>		
		<td width="333" colspan="2"><div align="center">&nbsp;</div></td>		
	</tr>
</table>
<% 
	ResultSet rs3 = alProd.DameProductosOrdenAlta(claveOrden);
	boolean hayProducto = false;
	while(rs3.next()){
		hayProducto = true;
	}
	if (hayProducto){ 
		rs3.beforeFirst();%>

	<table width="100%" cellpadding="0" cellspacing="0" border="1">
		<caption>Productos</caption>
		<tr>
			<th width="138">Cantidad</th>
			<th width="574">Producto</th>
		</tr>
<%		while (rs3.next()){%>
			<tr>
				<td><div align="center"><%=rs3.getString("Cantidad")%>&nbsp; Kg.</div></td>
				<td><%=alProd.dameDescripcionProducto(rs3.getString("clave_Producto"))%></td>
			</tr>
<% 		}%>				
	</table> 
<%	} 
	rs3.close();
	alProd.cierraConexion();		// de ResultSet Complex				
%>												
<br/>
	<table width="100%" height="90" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th>Observaciones</th>
		</tr>
		<tr>
		  <td height="65"><div align="center">
		    <p align="left"><%=observaciones%></p>
		    <p align="left">&nbsp;</p>
		    <p align="left">&nbsp;</p>
		  </div></td>
		</tr>
	</table>				
	<br/>
	<table width="100%" cellpadding="0" cellspacing="0" border="1">
		<tr>
			<th width="346"><div align="center">
			  <p>&nbsp;</p>
			  <p>&nbsp;</p>
			  _____________________________________
			</div></th>
			<th width="346"><div align="center">
			  <p>&nbsp;</p>
			  <p>&nbsp;</p>
			  _____________________________________
			</div></th>
		</tr>
			<tr>
				<td><div align="center"><strong>SOLICITO</strong></div></td>
			  <td><div align="center"><strong>AUTORIZO</strong></div></td>
			</tr>
	</table> 
	</td>
  </tr>
</table>									
</body>
</html>
