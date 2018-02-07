<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="cliente" class="com.vas.bd.ManagerClientes" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" />
<jsp:useBean id="co" class="com.vas.bd.ManagerCobros" />
<jsp:useBean id="ti" class="com.vas.bd.TimeStamp" />

<html>
<head>
<title>Clientes por Agente</title>
<link href="vasagoMiniCSS.css" rel="stylesheet" type="text/css">
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
<body onLoad="imprimirPagina(); Cerrar()">
<%
	String usuario = (String) session.getAttribute("UsuarioActual");
	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	} 
	String agente = request.getParameter("agente"); 
	String hoy = ti.date;	
%>
<jsp:setProperty name="personal" property="usuario" value="<%=agente%>"/>
<%
	if (personal.yaExiste()) {
		ResultSet nom = personal.dameNombreAgente(agente);
		String nombreAgente = new String();
		while(nom.next()){
			nombreAgente = nom.getString("NombreCompleto");
		}
		if(nom != null){
			nom.close();
		}
		personal.cierraConexion();									
%>
		<h1>Clientes de <%= nombreAgente%> para Cobros,<br/> D&iacute;a: <%=hoy%></h1>
		<table width="750" border="1" align="center">
			<tr bgcolor="#CCCCCC"> 
				<th width="336"><div align="center"><strong>Nombre</strong></div></th>
				<th width="101"><div align="center"><strong>Documento</strong></div></th>
				<th width="87"><div align="center">D&iacute;a <br/>Entrega</div></th>
				<th width="99"><div align="center"><strong>Debe</strong></div></th>
				<th width="159"><div align="center">Cobro</div></th>
			</tr>
<%

		ResultSet cliXagen = cliente.ClientesXAgente(agente);
		while (cliXagen.next()){  
			ResultSet ventas = co.ventasXclientePorCobrarListado(cliXagen.getString("rfc"));
			while(ventas.next()){
				String documento = new String();
				double total = 0.0;
				double pagado = 0.0;
				double resta = 0.0;
%>
				<tr> 
					<td><%= cliXagen.getString("nombre")%></td>
					<td><div align="center"><%
					if(ventas.getInt("tipo") == 1){
						documento = "F --> "+ventas.getString("factura");
					}
					else{
						documento = "R --> "+ventas.getString("remision");
					}
					out.print(documento);%></div></td>
					<td><div align="center"><%=ventas.getString("fechaEntrega")%></div></td>
					<td><div align="center">$ <%
					total = ventas.getDouble("total");
					pagado = co.dameSumaCobrados(ventas.getString("claveVenta"));
					resta = total - pagado;
					out.print(co.formatoDinero(co.acortaLongitud(resta+"")));
					%></div></td>
					<td><div align="center"><%= "&nbsp;"%></div></td>
				</tr>
<%	      
			} 
		if(ventas != null){
			ventas.close();
		}
		co.cierraConexion();									
	}
	if(cliXagen != null){
		cliXagen.close();
	}
	cliente.cierraConexion();										
	}
%>
</table>
</body>
</html>

