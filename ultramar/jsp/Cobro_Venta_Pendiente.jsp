<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="co" class="com.ult.bd.ManagerCobros" />
<jsp:useBean id="ven" class="com.ult.bd.ManagerVentas" />

<html>
<head>
<title>Cobro Pendiente Agregado</title>
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
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	//System.out.println("s "+tipou);
	if (usuariou == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
	//System.out.println("s "+tipou);
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String mesa = request.getParameter("mesa");

  	if(mesa.equalsIgnoreCase("B1")){
		mesa = "25";
	}
	else if(mesa.equalsIgnoreCase("B2")){
		mesa = "26";
	}
	else if(mesa.equalsIgnoreCase("B3")){
		mesa = "27";
	}
	else if(mesa.equalsIgnoreCase("B4")){
		mesa = "28";
	}
	else if(mesa.equalsIgnoreCase("B5")){
		mesa = "29";
	}
	
	// Si llenado = 1 OK, llenado = 2 FALTO 1 CAMPO POR LLENAR;  llenado = 3 MAL FORMATO DEL DOUBLE.

	boolean resultado = false;
	boolean exis = true;
	
	int llenado = 0;
	llenado = co.valida_add3(mesa);
//System.out.println("agente 1 "+agente);
	if (llenado==1){
		if(ven.tieneComanda(mesa)){
			int ClaveVen = ven.dameComanda(mesa);
			resultado = co.add_Cobro_Pendiente(mesa,ClaveVen);
			if(resultado){
				if(tipou.equalsIgnoreCase("Caja")){
%>
					<jsp:forward page="Menu_Ventas_Cash.jsp" />
<% 
				}
				else{
%>
					<jsp:forward page="Menu_Cobros.jsp" />
<% 
				}
			}
			else{  %>
		<b class="roj">Ocurrio un Error al Guardar en la Base de Datos</b>		
<p>&nbsp;</p>
<p><a href="Menu_Cobros.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
			<% 
			} 
		}
		else{
%>	
	<b class="roj">La Mesa no cuenta con una Comanda Activa.</b>	

    <p>&nbsp;</p>
<p><a href="Menu_Cobros.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<%
		
		}
	} 
	else if (llenado == 2){ 
%>	
	<b class="roj">Se Deben llenar todos los campos necesarios</b>	

<p>&nbsp;</p>
<p><a href="Menu_Cobros.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<%
	} 
%>
</body>
</html>

