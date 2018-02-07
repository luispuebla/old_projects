<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="div" class="com.ult.bd.ManagerDivisiones" scope="page" />
<jsp:useBean id="mp" class="com.ult.bd.ManagerMateriasPrimas" scope="page" />

<html>
<head>
<title>Alta de Bebidas</title>
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

function funcionFoco(){
	document.form1.nombre.focus();
}


//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body  onLoad="MM_preloadImages('imagenes/Regresar2.jpg'), funcionFoco()" >
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (!usuario.equalsIgnoreCase("producto") || !tipou.equalsIgnoreCase("Simple"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<h1>ALTA DE BEBIDAS</h1>
<p align="center">Llena todos los campos de la forma para dar de alta una Bebida:</p>
<form name="form1" method="post" action="Conf_Alta_BebidasS.jsp">
  <table width="724" border="1">
    <tr> 
      <th width="93" height="52" bgcolor="#CCCCCC"> Nombre:</th>
      <td width="598"> <input name="nombre" type="text" size="50" maxlength="50"> 
        <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th height="52" bgcolor="#CCCCCC"> Descripci&oacute;n:</th>
      <td> <input name="descripcion" type="text" id="descripcion" size="100" maxlength="100"> </td>
    </tr>
</table>
<table width="724" border="1">
    <tr> 
      <th width="96" bgcolor="#CCCCCC">Materia 1:</th>
      <td width="321"> <select name="m1">
	  <% ResultSet mp1 = mp.dameMateriasPrimas();
	  		while(mp1.next()){
			String uni = "";
			if(mp1.getInt("tipo") == 1)
				uni = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni);%></option>
		<%	}
		%>
        </select>
        <span class="style1">**</span> </td>
      <th width="115" bgcolor="#CCCCCC">Cantidad 1:</th>
      <td width="164"> <input name="c1" type="text" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 2:</th>
      <td> <select name="m2" id="m2">
	  		<option value="0">SELECCIONE..</option>
	  <% mp1.beforeFirst();
	  		while(mp1.next()){
			String uni2 = "";
			if(mp1.getInt("tipo") == 1)
				uni2 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni2 = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni2);%></option>
		<%	}
		%>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 2:</th>
      <td> <input name="c2" type="text" id="c2" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 3:</th>
      <td> <select name="m3" id="m3">
	  		<option value="0">SELECCIONE..</option>
	  <% mp1.beforeFirst();
	  		while(mp1.next()){
			String uni3 = "";
			if(mp1.getInt("tipo") == 1)
				uni3 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni3 = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni3);%></option>
		<%	}
		%>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 3:</th>
      <td> <input name="c3" type="text" id="c3" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 4:</th>
      <td> <select name="m4" id="m4">
	  		<option value="0">SELECCIONE..</option>
	  <% mp1.beforeFirst();
	  		while(mp1.next()){
			String uni4 = "";
			if(mp1.getInt("tipo") == 1)
				uni4 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni4 = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni4);%></option>
		<%	}
		%>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 4:</th>
      <td> <input name="c4" type="text" id="c4" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 5:</th>
      <td> <select name="m5" id="m5">
	  		<option value="0">SELECCIONE..</option>
	  <% mp1.beforeFirst();
	  		while(mp1.next()){
			String uni5 = "";
			if(mp1.getInt("tipo") == 1)
				uni5 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni5 = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni5);%></option>
		<%	}
		%>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 5:</th>
      <td> <input name="c5" type="text" id="c5" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 6:</th>
      <td> <select name="m6" id="m6">
	  		<option value="0">SELECCIONE..</option>
	  <% mp1.beforeFirst();
	  		while(mp1.next()){
			String uni6 = "";
			if(mp1.getInt("tipo") == 1)
				uni6 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni6 = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni6);%></option>
		<%	}
		%>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 6:</th>
      <td> <input name="c6" type="text" id="c6" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 7:</th>
      <td> <select name="m7" id="m7">
	  		<option value="0">SELECCIONE..</option>
	  <% mp1.beforeFirst();
	  		while(mp1.next()){
			String uni7 = "";
			if(mp1.getInt("tipo") == 1)
				uni7 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni7 = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni7);%></option>
		<%	}
		%>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 7:</th>
      <td> <input name="c7" type="text" id="c7" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 8:</th>
      <td> <select name="m8" id="m8">
	  		<option value="0">SELECCIONE..</option>
	  <% mp1.beforeFirst();
	  		while(mp1.next()){
			String uni8 = "";
			if(mp1.getInt("tipo") == 1)
				uni8 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni8 = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni8);%></option>
		<%	}
		%>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 8:</th>
      <td> <input name="c8" type="text" id="c8" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 9:</th>
      <td> <select name="m9" id="m9">
	  		<option value="0">SELECCIONE..</option>
	  <% mp1.beforeFirst();
	  		while(mp1.next()){
			String uni9 = "";
			if(mp1.getInt("tipo") == 1)
				uni9 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni9 = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni9);%></option>
		<%	}
		%>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 9:</th>
      <td> <input name="c9" type="text" id="c9" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 10:</th>
      <td> <select name="m10" id="m10">
	  		<option value="0">SELECCIONE..</option>
	  <% mp1.beforeFirst();
	  		while(mp1.next()){
			String uni10 = "";
			if(mp1.getInt("tipo") == 1)
				uni10 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni10 = "lt.";
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni10);%></option>
		<%	}
		%>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 10:</th>
      <td> <input name="c10" type="text" id="c10" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
</table>
<table width="724" border="1">
    <tr> 
      <th width="163" bgcolor="#CCCCCC">Precio por Copeo:</th>
      <td width="545"> $  <input name="precioC" type="text" id="contacto" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        <span class="style1">**</span> </td>
    </tr><tr> 
      <th width="163" bgcolor="#CCCCCC">Precio por Botella 1 :</th>
      <td width="545"> $  <input name="precioB" type="text" id="contacto" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        <span class="style1">**</span> </td>
    </tr>
<tr> 
      <th width="163" bgcolor="#CCCCCC">Precio por Botella 2:</th>
      <td width="545"> $  <input name="precioB2" type="text" id="contacto" size="12" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        <span class="style1">**</span> </td>
    </tr>
	    <tr> 
      <th bgcolor="#CCCCCC">Divisi&oacute;n:</th>
      <td> <select name="division">
	  <% ResultSet divi = div.divisionesXArea("2");
	  		while(divi.next()){
	  %>
          <option value="<%=divi.getString("clave")%>"><%=divi.getString("nombre")%></option>
		<%	}
		%>
        </select>
        <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Bebida Alcoholica:</th>
      <td> <select name="alco">
          <option value="1">SI</option>
          <option value="0">NO</option>
        </select>
        <span class="style1">**</span> </td>
    </tr>
<tr> 
      <th bgcolor="#CCCCCC">Conbinable:</th>
      <td> <select name="combinable">
          <option value="1">Si Combina</option>
          <option value="2">Para Combinar</option>
          <option value="0">No</option>
        </select>
        <span class="style1">**</span> </td>
    </tr>  
<tr> 
      <th bgcolor="#CCCCCC">Dimensionable:</th>
      <td> <select name="dimensionable">
          <option value="1">SI</option>
          <option value="0">NO</option>
        </select>
        <span class="style1">**</span> </td>
    </tr>	
</table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
    <input type="reset" name="Submit2" value="Limpiar Forma">
  </p>
</form>
<%
mp.cierraConexion();
%>
<p><a href="Menu_BebidasS.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>