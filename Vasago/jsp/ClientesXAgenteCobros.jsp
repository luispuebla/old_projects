<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="cliente" class="com.vas.bd.ManagerClientes" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" />
<jsp:useBean id="co" class="com.vas.bd.ManagerCobros" />
<jsp:useBean id="ti" class="com.vas.bd.TimeStamp" />

<html>
<head>
<title>Clientes por Agente</title>
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

function MandaSubmit(f){
	document.form1.submit();
}

//-->
</script>
</head>
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
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
%>
</table>
<table width="742" align="center">
<td width="280">
<p align="right"><a href="Consultas_Cobros.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar1" width="152" height="36" border="0" id="regresar1"></a></p>
</td>
<td width="186">&nbsp; </td>
<form name="form1" method="post" action="ImprimirCobrosXAgente.jsp" target="_blank">
<input type="hidden" name="agente" value="<%=agente%>">
<td width="260">
<img src="imagenes/Imprimir1.jpg" name="regresar" width="152" height="36" border="0" onClick="MandaSubmit(this.form)">
</td>
</form>
</table>
<%	     
	}
	 else{ %>
		<b class="roj">El Agente no se encuentra registrado en el Sistema.</b>

<p align="center"><a href="Consultas_Cobros.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p> 
<%
	}
%>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

