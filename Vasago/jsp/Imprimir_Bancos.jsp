<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="ban" class="com.vas.bd.ManagerBancos" />

<html>
<head>
<title>Todos los Bancos</title>
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
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin"))){
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
//System.out.println("Empezamos");
%>
<h1>Todas las Cuentas registradas en Sistema son:</h1>
<table width="628" border="1" align="center">
  <tr bgcolor="#CCCCCC"> 
    <th width="233" ><div align="center">Banco</div></th>
    <th width="138" ><div align="center">Numero</div></th>
    <th width="140" ><div align="center">Importe Inicial</div></th>
    <th width="125" ><div align="center">Importe Actual</div></th>
  </tr>
<%	
//System.out.println("2");
		ResultSet rs = ban.dameTodo();
		while (rs.next())
		{  
//System.out.println("3");
%>
  <tr> 
    <td align="center"><%= rs.getString("banco")%></td>
    <td align="center"><%= rs.getString("numero")%></td>
    <td align="center"> $ <%= ban.formatoDinero(rs.getString("importeInicial"))%></td>
    <td align="center"> $ <%= ban.formatoDinero(rs.getString("importeActual"))%></td>
  </tr>
<%	   
//System.out.println("4");    
		 } 
	if(rs != null){
		rs.close();
	}
	ban.cierraConexion();			  		 		 
//System.out.println("5");  		 
%>
</table>
<p></p>
</body>
</html> 


