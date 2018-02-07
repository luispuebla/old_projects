<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="mp" class="com.ult.bd.ManagerMateriasPrimas" />

<html>
<head>
<title>Modifica Materia Prima</title>
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

function Habilitador(f){
	var ti = f.tipo.value;
	if(ti == 1){
		f.costoKg.disabled = true;
		f.costoU.disabled = true;
		f.kgxu.disabled=true;
		f.invKg.disabled=true;
		f.invU.disabled=true;
		f.costoB.disabled=true;
		f.costoB2.disabled=true;
		f.lxb.disabled=true;
		f.lxb2.disabled=true;
		f.invB.disabled=true;
		f.invB2.disabled=true;
		f.invC.disabled=true;
		f.costoB.value="";
		f.costoB2.value="";
		f.lxb.value="";
		f.lxb2.value="";
		f.invB.value="";
		f.invB2.value="";
		f.invC.value="";
	}
	else if(ti == 2){
		f.costoKg.disabled = true;
		f.costoU.disabled = true;
		f.kgxu.disabled=true;
		f.invKg.disabled=true;
		f.invU.disabled=true;
		f.costoB.disabled=false;
		f.costoB2.disabled=false;
		f.lxb.disabled=false;
		f.lxb2.disabled=false;
		f.invB.disabled=false;
		f.invB2.disabled=false;
		f.invC.disabled=false;
	}	
}

function Habilitador2(f){
	var ti = f.tipoA.value;
	if(ti == 1){
		f.costoKg.disabled = false;
		f.costoU.disabled = true;
		f.kgxu.disabled=true;
		f.invKg.disabled=false;
		f.invU.disabled=true;
		f.costoU.value="";
		f.kgxu.value="";
		f.invU.value="";
	}
	else if(ti == 2){
		f.costoKg.disabled = true;
		f.costoU.disabled = false;
		f.kgxu.disabled=false;
		f.invKg.disabled=false;
		f.invU.disabled=false;
		f.costoKg.value="";
	}	
}

//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'),Habilitador(document.form1),Habilitador2(document.form1)">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (!usuario.equalsIgnoreCase("producto") || !tipou.equalsIgnoreCase("Simple"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String tipo = request.getParameter("tipo");
	String map = request.getParameter("mp");
	String vacio = "";

	boolean exis = true;
	
	if(exis){ %>

<form name="form1" method="post" action="Conf_Cambio_Materia_PrimaS.jsp">   
<input type="hidden" name="map" value="<%=map%>"> 
<input type="hidden" name="tipo" value="<%=tipo%>"> 
<h1>Realiza las modificaciones necesarias y da Click en el bot&oacute;n de Guardar </h1>
	<table width="433" align="center">
		<tr align="left">
			<th width="188" align="left"><b>Campo NO Editable --></b></th>
			<td width="233" align="left"><b class="roj">**</b></td>			
		</tr>
  </table>
  <% 
	ResultSet rs = mp.datos_Materia_Prima(map);
	while (rs.next()) {
	String nom = "";
	if(tipo.equalsIgnoreCase("1"))
		nom = "Alimentos";
	if(tipo.equalsIgnoreCase("2"))
		nom = "Bebidas";
	//System.out.println("tipo1 "+tipo);
		
	String nomA = "";
	String tipoA = rs.getString("tipoA");
	if(tipoA.equalsIgnoreCase("1"))
		nomA = "Kilo";
	if(tipoA.equalsIgnoreCase("2"))
		nomA = "Unidad";
%>		
  <table width="528" border="1" align="center">
    <tr> 
      <th width="211" bgcolor="#CCCCCC">Nombre:</th>
      <td width="265"><input type="text" name="nombre" value="<%= rs.getString("nombre") %>" readonly="true" size="30" maxlength="30">
        <b class="roj">**</b></td>
    </tr>
<tr> 
      <th bgcolor="#CCCCCC">Tipo :</th>
      <td> <div align="left"> 
          <select name="tipo2" onChange="Habilitador(this.form)" disabled>
   		 <option value="<%=tipo%>"><%=nom%></option>
		<% //	System.out.println("tipo2 "+tipo);
			if(tipo.equalsIgnoreCase("1")){%>
            <option value="2">Bebidas</option>
            <%}
			if(tipo.equalsIgnoreCase("2")){%>		
            <option value="1">Alimentos</option>
			<%}
			%>
          </select>
          <b class="roj">**</b></div></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Tipo Alimento :</th>
      <td> <div align="left"> 
          <select name="tipoA" onChange="Habilitador2(this.form)">
   		 <option value="<%=tipoA%>"><%=nomA%></option>
		<%	if(tipoA.equalsIgnoreCase("1")){%>
            <option value="2">Unidad</option>
            <%}
			if(tipoA.equalsIgnoreCase("2")){%>		
            <option value="1">Kilo</option>
			<%}
			%>
          </select>
          <span class="style1">**</span></div></td>
    </tr>    <tr> 
      <th bgcolor="#CCCCCC">Costo por Kilo :</th>
      <td>$ 
        <input name="costoKg" type="text" id="costoKg" value="<%=rs.getString("costoKg")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="12" maxlength="10">
        <span class="style1">**</span> </td>
    </tr>
<tr> 
      <th bgcolor="#CCCCCC">Costo por Unidad :</th>
      <td>$ 
        <input name="costoU" type="text" id="costoU" value="<%=rs.getString("costoUnidad")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="12" maxlength="10">
        <span class="style1">**</span> </td>
    </tr><tr> 
      <th bgcolor="#CCCCCC">Kg. por Unidad :</th>
      <td> <input name="kgxu" type="text" id="kgxu" value="<%=rs.getString("KgxUnidad")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="12" maxlength="10">
        <span class="style1">kg. **</span> </td>
    </tr>    <tr> 
      <th bgcolor="#CCCCCC">Inventario en Kg. :</th>
      <td> <input name="invKg" type="text" id="invKg" value="<%=rs.getString("inventarioKg")%>" onKeyPress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="15" maxlength="13">
        <span class="style1">kg. **</span> </td>
    </tr>
<tr> 
      <th bgcolor="#CCCCCC">Inventario Unidad :</th>
      <td> <input name="invU" type="text" id="invU" value="<%=rs.getString("inventarioUnidad")%>" onKeyPress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;" size="15" maxlength="13">
        <span class="style1">unidad **</span> </td>
    </tr><tr> 
      <th bgcolor="#CCCCCC">Costo Botella 1 : </th>
      <td>$ 
        <input name="costoB" type="text" id="costoB" value="<%=rs.getString("costoBotella1")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="12" maxlength="10">
        <span class="style1">**</span> </td>
    </tr><tr> 
      <th bgcolor="#CCCCCC">Costo Botella 2 :</th>
      <td>$ 
        <input name="costoB2" type="text" id="costoB2" value="<%=rs.getString("costoBotella2")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="12" maxlength="10">
      </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Litros por Botella 1:</th>
      <td> <input name="lxb" type="text" id="lxb" value="<%=rs.getString("litrosXBotella1")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="12" maxlength="10">
        <span class="style1">lt. **</span> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Litros por Botella 2:</th>
      <td> <input name="lxb2" type="text" id="lxb2" value="<%=rs.getString("litrosXBotella2")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="12" maxlength="10">
        <span class="style1">lt. </span></td>
    </tr>
	    <tr> 
      <th bgcolor="#CCCCCC">Inventario en Botella 1 :</th>
      <td> <input name="invB" type="text" id="invB" size="13" maxlength="11" value="<%=rs.getString("inventarioBotella1")%>" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
        <span class="style1">unidad **</span></td>
    </tr>
<tr> 
      <th height="30" bgcolor="#CCCCCC">Inventario en Botella 2 :</th>
      <td> <input name="invB2" type="text" id="invB2" size="13" maxlength="11" value="<%=rs.getString("inventarioBotella2")%>" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
        <span class="style1">unidad </span></td>
    </tr>    <tr> 
      <th bgcolor="#CCCCCC">Inventario por Copeo :</th>
      <td> <input name="invC" type="text" id="invC" size="20" maxlength="18" value="<%=rs.getString("inventarioCopeo")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        <span class="style1">lt. </span></td>
    </tr>

  </table>
		
        <p>
		<div align="center">
          <input type="submit" name="Submit" value="Guardar">
  </div>
          </p>
</form>
<p> 
  <% }}
  mp.cierraConexion();
 %>
</p>
<p align="center"><a href="Selecciona_Materia_PrimaS.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
