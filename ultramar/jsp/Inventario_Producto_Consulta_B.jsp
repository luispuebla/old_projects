<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="inv" class="com.ult.bd.ManagerInventarios" scope="page" />

<html>
<head>
<title>Inventario de Productos</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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

function roundOff(value)
{
        value = "" + value //convert value to string
        var precision = 2;

        var whole = "" + Math.round(value * Math.pow(10, precision));

        var decPoint = whole.length - precision;

        if(decPoint != 0)
        {
                result = whole.substring(0, decPoint);
                result += ".";
                result += whole.substring(decPoint, whole.length);
        }
        else
        {
                result = 0;
                result += ".";
                result += whole.substring(decPoint, whole.length);
        }
        return result;
}

//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
String clave = request.getParameter("clave");
double costoB1 = 0.00;
double costoB2 = 0.00;
double cantidadB1 = 0.00;
double cantidadB2 = 0.00;
String tipoB = "Botella(s)";
String tipoC = "Lt.";
	String tipoTodo = "";
	
		if(clave.substring(clave.length()-1).equalsIgnoreCase("A")){
			tipoTodo = " --> Kg.";
			tipoB = "A";
			}
		if(clave.substring(clave.length()-1).equalsIgnoreCase("B")){
			tipoTodo = " --> Unidades";
			tipoB = "B";
			}
		if(clave.substring(clave.length()-1).equalsIgnoreCase("C")){
			tipoTodo = " --> Botella1";
			tipoB = "C";
			}
		if(clave.substring(clave.length()-1).equalsIgnoreCase("D")){
			tipoTodo = " --> Botella2";
			tipoB = "D";
			}
//System.out.println("2");
			
		clave = clave.substring(0, clave.length()-1);
ResultSet producto = inv.Inventario_Producto(clave);
%>	
<h1>INVENTARIO DE PRODUCTO </h1>
<table align="center" border="1" width="483">
<%
while(producto.next()){
	costoB1 = producto.getDouble("costoBotella1");
	costoB2 = producto.getDouble("costoBotella2");
	cantidadB1 = producto.getDouble("litrosXBotella1");
	cantidadB2 = producto.getDouble("litrosXBotella2");	
%>
	<tr>
		<th colspan="3"><div align="center"><%=clave+" --> "+producto.getString("nombre")%></div></th>
	</tr>
	<tr>
		<td><div align="center"><strong>Tipo</strong></div></td>
		<td><div align="center"><strong>Existencia<br/>
	    Actual</strong></div></td>
		<td><div align="center"><strong>Tama&ntilde;o</strong></div></td>
	</tr>	
<%	if(costoB1 > 0.00){%>		
	<tr>
		<th width="228"><div align="left">Inventario Botella 1</div></th>
		<td width="239"><div align="center"><%=producto.getString("inventarioBotella1")%>  --> Botella (s)</div></td>
		<td width="93"><div align="center"><%=cantidadB1%> Lt. </div></td>		
	</tr>
<%	}if(costoB2 > 0.00){%>	
	<tr>
		<th width="228"><div align="left">Inventario Botella 2</div></th>
		<td width="239"><div align="center"><%=producto.getString("inventarioBotella2")%>  --> Botella (s)</div></td>
		<td width="93"><div align="center"><%=cantidadB2%> Lt. </div></td>	
	</tr>
<%	}%>		
	<tr>
		<th width="228"><div align="left">Existencia Inventario Copeo</div></th>
		<td width="239"><div align="center"><%=producto.getString("inventarioCopeo")%>  --> Lt.</div></td>
		<td width="93"><div align="center"> --- </div></td>			
	</tr>
<%
}
%>
</table>
<p><a href="Consultas_Inventarios.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<% inv.cierraConexion();%>
</body>
</html>