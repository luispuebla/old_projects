<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>

<jsp:useBean id="en" class="com.vas.bd.ManagerEntregas" />

<html>
<head>
<title>Baja Venta</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

   String clave = request.getParameter("clave");%>

<form name="form1" method="post" action="Conf_Baja_Venta.jsp">
<input type="hidden" name="clave" value="<%= clave%>">
<%
//System.out.println("la clave que llego: "+clave);
 if(clave == null){%>
  <font>
  <%
 // System.out.println("Entro al vacio");
		out.print("Debes seleccionar una Venta."); %>
  </font> 
  <%
}
else{
//System.out.println("Entro en la clave");
%>
  <h1>BAJA DE VENTA </h1>
  <p><font>&iquest; Esta seguro de que desea eliminar </font>
  la Venta <br/>
  <font>
  <%
  	ResultSet rs = en.todasLasVentasXClienteBaja2(clave);
	while(rs.next()){
		String documento = new String();
		if(rs.getInt("tipo") == 1){
			documento = "F --> "+rs.getString("factura");
		}
		else{
			documento = "R --> "+rs.getString("remision");
		}
		out.print(documento);
	}
	if(rs != null){
		rs.close();
	}
	en.cierraConexion();		
  %> ?</font></p>
  <p><font> 
    <input type="submit" name="Submit" value="SI">
    </font> </p>
</form>
	<%}%>
<p align="center"><font color="#FFFFFF"><a href="Escoge_Cliente_Venta_Baja.jsp" target="mainFrame" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></font></p>
<p align="center"><font size="2"><img src="imagenes/barraN.jpg" width="532" height="82"></font> 
</body>
</html>