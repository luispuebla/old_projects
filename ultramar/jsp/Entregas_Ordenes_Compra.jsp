<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pro" class="com.ult.bd.ManagerProveedores" />
<jsp:useBean id="alCom" class="com.ult.bd.ManagerCompras" scope="page" />
<jsp:useBean id="produ" class="com.ult.bd.ManagerMateriasPrimas" scope="page" />

<html>
<head>
<title>Muestra Consulta Compras por Recibir</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

<script>

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
</script> 

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String tipoConsul = request.getParameter("tipoConsul");
	String anio = request.getParameter("anio");
	String mes = request.getParameter("mes");
	String dia = "";
	//System.out.println("tipoConsul: "+tipoConsul);
	//System.out.println("mes: "+mes);
	//System.out.println("anio: "+anio);
	if(tipoConsul.equals("dia")){
		dia = request.getParameter("dia");
		//System.out.println("dia: "+dia);
		ResultSet porDia = alCom.Ordenes_Dia(anio+"-"+mes+"-"+dia);
%>
<strong>El total de Compras para Recibir en el d&iacute;a son:  </strong>
<p>
<table width="726" border="1">
  <tr> 
    <th width="188">Fecha de Entrega</th>
    <th width="200">Compra</th>
    <th width="316">Proveedor</th>
  </tr>
<% 		while (porDia.next()){
			String nombreProveedor = pro.nombreProveedor(porDia.getString("ClaveProveedor"));
%>
  <tr> 
    <td><div align="center"><%=porDia.getString("FechaEntrega") %></div></td>
    <td><div align="center"><a href="DetalleOrdenCompraEntregas.jsp?<%=porDia.getString("ClaveOrden")%>-<%=anio%>,<%=mes%>*<%=dia%>+<%=tipoConsul%>"><%=porDia.getString("ClaveOrden")%></a></div></td>
    <td><div align="center"><%= nombreProveedor %></div></td>
  </tr>
</p>
<%}%>
</table>
<%
	}
	else if (tipoConsul.equals("semana")){
	String semana=request.getParameter("semana");
		ResultSet porSemana = alCom.Ordenes_Semana(semana, anio+"-"+mes);
%>	
<strong>El total de Compras para Recibir en la Semana son:  </strong>
<p>
<table width="726" border="1">
  <tr> 
    <th width="187">Fecha de Entrega</th>
    <th width="203">Compra</th>
    <th width="314">Proveedor</th>
  </tr>
<% 		while (porSemana.next()){
			String nombreProveedor = pro.nombreProveedor(porSemana.getString("ClaveProveedor"));
%>
  <tr> 
    <td><div align="center"><%=porSemana.getString("FechaEntrega") %></div></td>
    <td><div align="center"><a href="DetalleOrdenCompraEntregas.jsp?<%=porSemana.getString("ClaveOrden")%>-<%=anio%>,<%=mes%>*<%=dia%>+<%=tipoConsul%>"><%=porSemana.getString("ClaveOrden")%></a></div></td>
    <td><div align="center"><%= nombreProveedor %></div></td>
  </tr>
</p><%}%>
</table>
<%		
	}
	else{
		
		ResultSet porMes = alCom.Ordenes_Mes(anio+"-"+mes);
%>
<strong>El total de Compras para Recibir en el Mes son:  </strong>
<p>
<table width="726" border="1">
  <tr> 
    <th width="184">Fecha de Entrega</th>
    <th width="206">Compra</th>
    <th width="314">Proveedor</th>
  </tr>
<% 		while (porMes.next()){
			String nombreProveedor = pro.nombreProveedor(porMes.getString("ClaveProveedor"));
%>
  <tr> 
    <td><div align="center"><%=porMes.getString("FechaEntrega") %></div></td>
    <td><div align="center"><a href="DetalleOrdenCompraEntregas.jsp?<%=porMes.getString("ClaveOrden")%>-<%=anio%>,<%=mes%>*<%=dia%>+<%=tipoConsul%>"><%=porMes.getString("ClaveOrden")%></a></div></td>
    <td><div align="center"><%= nombreProveedor %></div></td>
  </tr>
</p><%}%>
</table>
<%
	}
	pro.cierraConexion();
%>
<p align="center"><font color="#FFFFFF"><a href="Seleccion_Entregas_Ordenes_Compra.jsp" target="_self" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></font></p>
<p align="center"><font size="2"><img src="imagenes/barraN.jpg" width="532" height="82"></font> 
</body>
</html>
