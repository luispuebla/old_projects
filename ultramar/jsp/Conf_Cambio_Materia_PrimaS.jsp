<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="mp" class="com.ult.bd.ManagerMateriasPrimas" />

<html>
<head>
<title>Confirmaci&oacute;n de modificaciones de la Materia Prima</title>
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
<p>&nbsp;</p>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (!usuario.equalsIgnoreCase("producto") || !tipou.equalsIgnoreCase("Simple"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%		
	}
//System.out.println("1");
	String map = request.getParameter("map");
	String nombre = request.getParameter("nombre");
	String tipo = request.getParameter("tipo");
	String tipoA = request.getParameter("tipoA");
	String costoKg = request.getParameter("costoKg");
	String costoU = request.getParameter("costoU");
	String kgxu = request.getParameter("kgxu");
	String invKg = request.getParameter("invKg");
	String invU = request.getParameter("invU");
	String costoB = request.getParameter("costoB");
	String costoB2 = request.getParameter("costoB2");
	String lxb = request.getParameter("lxb");
	String lxb2 = request.getParameter("lxb2");
	String invB = request.getParameter("invB");
	String invB2 = request.getParameter("invB2");
	String invC = request.getParameter("invC");

	boolean resultado = false;

	int llenado = 0;
	//System.out.println("tipoa "+tipoA);

	if(tipo.equalsIgnoreCase("1")){
	//System.out.println("3");
		if(tipoA.equalsIgnoreCase("1")){
				llenado = mp.valida_add1(nombre, tipo, costoKg, invKg);
//System.out.println("4");
			}
			if(tipoA.equalsIgnoreCase("2")){
				llenado = mp.valida_add3(nombre, tipo, costoU, kgxu, invU);
//System.out.println("5");
			}
	}
	if(tipo.equalsIgnoreCase("2")){
//System.out.println("4");
			//System.out.println(nombre+" - "+tipo+" - "+costo+" - "+lxb+" - "+invB+" - "+invC);
			llenado = mp.valida_add3(nombre, tipo, costoB, lxb, invB);
	}
//System.out.println("llenado "+llenado);
	
		if(llenado == 1) {
//System.out.println("5");
			if(tipo.equalsIgnoreCase("1")){
//System.out.println("6");
				resultado = mp.update_Materia_Prima3(map, nombre, tipo, tipoA, costoKg, costoU, invKg, kgxu, invU);
//System.out.println("7");
			}
//System.out.println("6");
			if(tipo.equalsIgnoreCase("2")){
				resultado = mp.update_Materia_Prima4(map, nombre, tipo, costoB, costoB2, lxb, lxb2, invB, invB2, invC);
			}
//System.out.println("8");

			if(resultado){
%>
				<jsp:forward page="Menu_Materias_PrimasS.jsp" />
<% 
			}
			else{  %>
				<b class="roj">Ocurrio un Error al Guardar en la Base de Datos</b>		
				<p>&nbsp;</p>
				<p><a href="Selecciona_Materia_PrimaS.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
				<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 

<%
			}
		}  
		if (llenado == 2){
%>	
			<b class="roj">Se Deben llenar todos los campos.</b>
			<p>&nbsp;</p>
			<p align="center"><a href="Selecciona_Materia_PrimaS.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()"  onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
			<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<%
		} 
%>	
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
	
