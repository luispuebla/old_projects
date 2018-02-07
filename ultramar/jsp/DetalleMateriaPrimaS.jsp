<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<jsp:useBean id="mp" class="com.ult.bd.ManagerMateriasPrimas" scope="page" />

<html>
<head>
<title>Detalle Materia Prima</title>
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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (!usuario.equalsIgnoreCase("producto") || !tipou.equalsIgnoreCase("Simple"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}

	String cla = request.getQueryString();	
	ResultSet rs = mp.datos_Materia_Prima(cla);
	while(rs.next()){

		String ti = rs.getString("tipo");
		if( ti.equals("1")){
			ti = "Alimento";
		}
		if( ti.equals("2")){
			ti = "Bebida";
		}
		
		String tia = rs.getString("tipoA");
		if( tia.equals("1")){
			tia = "Kilo";
		}
		if( tia.equals("2")){
			tia = "Unidad";
		}
		if( tia.equals("0")){
			tia = "Bebida";
		}
		
		String nombre = mp.dameNombreMP(cla);

		String cu = "$ "+rs.getString("costounidad");
		if( cu.equals("$ 0.00")){
			cu = "&nbsp;";
		}

		String ck = "$ "+rs.getString("costokg");
		if( ck.equals("$ 0.00")){
			ck = "&nbsp;";
		}

		String cb = "$ "+rs.getString("costoBotella1");
		if( cb.equals("$ 0.00")){
			cb = "&nbsp;";
		}

		String cb2 = "$ "+rs.getString("costoBotella2");
		if( cb2.equals("$ 0.00")){
			cb2 = "&nbsp;";
		}

		String kgxu = rs.getString("kgXUnidad");
		if( kgxu.equals("0.000")){
			kgxu = "&nbsp;";
		}

		String iu = rs.getString("inventarioUnidad");
		if( iu.equals("0")){
			iu = "&nbsp;";
		}

		String ik = rs.getString("inventarioKG");
		if( ik.equals("0.000")){
			ik = "&nbsp;";
		}

		String ib = rs.getString("inventarioBotella1");
		if( ib.equals("0")){
			ib = "&nbsp;";
		}

		String ic = rs.getString("inventarioCopeo");
		if( ic.equals("0.000")){
			ic = "&nbsp;";
		}

		String ib2 = rs.getString("inventarioBotella2");
		if( ib2.equals("0")){
			ib2 = "&nbsp;";
		}

		String lxb = rs.getString("litrosXBotella1");
		if( lxb.equals("0.000")){
			lxb = "&nbsp;";
		}

		String lxb2 = rs.getString("litrosXBotella2");
		if( lxb2.equals("0.000")){
			lxb2 = "&nbsp;";
		}

%>
<table width="488" border="1" align="center">
  <tr> 
    <td width="96" bgcolor="#DFE1EC" ><div align="center">Tipo</div></td>
    <td width="131" bgcolor="#DFE1EC" ><div align="center">Tipo Alimento</div></td>
    <td width="239" bgcolor="#DFE1EC" ><div align="center">Nombre</div></td>
  </tr>
</table>
<table width="489" border="1" align="center">
  <tr> 
    <td width="96"><div align="center"><%=ti%></div></td>
    <td width="131" ><div align="center"><%=tia%></div></td>
    <td width="240" ><div align="center"><%=nombre%></div></td>
  </tr>
</table>
<p></p>
<h1>Por Unidad:</h1>
<table width="463" border="1" align="center">
  <tr> 
    <td width="176" bgcolor="#DFE1EC" ><div align="center">Kg. por Unidad</div></td>
    <td width="127" bgcolor="#DFE1EC" ><div align="center">Inventario Unidad</div></td>
    <td width="138" bgcolor="#DFE1EC" ><div align="center">Costo Unidad </div></td>
  </tr>
</table>
<table width="463" border="1" align="center">
  <tr> 
    <td width="176" ><div align="center"><%=kgxu%></div></td>
    <td width="127" ><div align="center"><%=iu%></div></td>
    <td width="138" ><div align="center"><%=cu%></div></td>
  </tr>
</table>
<p></p>
<h1>Por Kilo:</h1>
<table width="295" border="1" align="center">
  <tr> 
    <td width="124" bgcolor="#DFE1EC" ><div align="center">Inventario Kg.</div></td>
    <td width="155" bgcolor="#DFE1EC" ><div align="center">Costo Kilo</div></td>
  </tr>
</table>
<table width="295" border="1" align="center">
  <tr> 
    <td width="124"><div align="center"><%=ik%></div></td>
    <td width="155"><div align="center"><%=ck%></div></td>
  </tr>
</table>
<p></p>
<h1>Por Botella 1:</h1>
<table width="463" border="1" align="center">
  <tr> 
    <td width="176" bgcolor="#DFE1EC" ><div align="center">Lt. por Botella 1</div></td>
    <td width="127" bgcolor="#DFE1EC" ><div align="center">Inventario Botella 
        1 </div></td>
    <td width="138" bgcolor="#DFE1EC" ><div align="center">Costo Botella 1</div></td>
  </tr>
</table>
<table width="463" border="1" align="center">
  <tr> 
    <td width="176" ><div align="center"><%=lxb%></div></td>
    <td width="127" ><div align="center"><%=ib%></div></td>
    <td width="138" ><div align="center"><%=cb%></div></td>
  </tr>
</table>
<p></p>
<table width="140" border="1" align="center">
  <tr> 
    <td width="140" bgcolor="#DFE1EC" ><div align="center">Inventario Copeo</div></td>
  </tr>
</table>
<table width="140" border="1" align="center">
  <tr> 
    <td width="140" ><div align="center"><%=ic%></div></td>
  </tr>
</table>
<div align="center">
<h1>Por Botella 2:</h1>
  <table width="463" border="1" align="center">
    <tr> 
      <td width="176" bgcolor="#DFE1EC" ><div align="center">Lt. por Botella 2</div></td>
      <td width="127" bgcolor="#DFE1EC" ><div align="center">Inventario Botella 
          2</div></td>
      <td width="138" bgcolor="#DFE1EC" ><div align="center">Costo Botella 2</div></td>
    </tr>
  </table>
  <table width="463" border="1" align="center">
    <tr> 
      <td width="176" ><div align="center"><%=lxb2%></div></td>
      <td width="127" ><div align="center"><%=ib2%></div></td>
      <td width="138" ><div align="center"><%=cb2%></div></td>
    </tr>
  </table>
<%
	}
	mp.cierraConexion();
%>
  </div>
  <p>&nbsp;</p>
<p align="center"><a href="Todos_Materias_PrimasS.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
