<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="div" class="com.ult.bd.ManagerDivisiones" scope="page" />
<jsp:useBean id="mp" class="com.ult.bd.ManagerMateriasPrimas" scope="page" />
<jsp:useBean id="ali" class="com.ult.bd.ManagerAlimentos" scope="page" />

<html>
<head>
<title>Cambio de Alimento</title>
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

<body  onLoad="MM_preloadImages('imagenes/Regresar2.jpg')" >
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String clave = request.getParameter("alimento");
	//System.out.println("1");
%>	
<h1>CAMBIO DE ALIMENTOS</h1>
<p align="center">Realiza los Cambio deseados y da un clic en el Bot&oacute;n 
  Guardar:</p>
<form name="form1" method="post" action="Conf_Cambio_Alimentos.jsp">
<input type="hidden" name="clave" value="<%=clave%>">
  <table width="724" border="1">
  <% ResultSet datos = ali.datos_Alimento(clave);
  while(datos.next()){
  	//System.out.println("2");
%>
    <tr> 
      <th width="93" height="52" bgcolor="#CCCCCC"> Nombre:</th>
      <td width="598"> <input name="nombre" type="text" size="50" maxlength="50" value="<%=datos.getString("nombre")%>" readonly="true"> 
        <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th height="52" bgcolor="#CCCCCC"> Descripci&oacute;n:</th>
      <td> <input name="descripcion" type="text" id="descripcion" size="100" maxlength="100" value="<%=datos.getString("descripcion")%>"> </td>
    </tr>
</table>
<table width="724" border="1">
    <tr> 
      <th width="96" bgcolor="#CCCCCC">Materia 1:</th>
      <td width="321"> <select name="m1">
	  <%
	  	//System.out.println("3");

	  	String claveM = datos.getString("materia0");
		String nombre = mp.dameNombreMP(claveM);
		String tip = mp.dameTipoMP(claveM);
		if(tip.equalsIgnoreCase("1"))
			tip = "kg.";
		if(tip.equalsIgnoreCase("2"))
			tip = "lt.";
	  %>
          <option value="<%=claveM%>"><%out.print(nombre+" --> "+tip);%></option>	  
	  <% ResultSet mp1 = mp.dameMateriasPrimas();
	  	//System.out.println("4");
	  		while(mp1.next()){

			String uni = "";
			if(mp1.getInt("tipo") == 1)
				uni = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni = "lt.";

				if(mp1.getString("clave").equalsIgnoreCase(claveM)){
				//System.out.println("4.2");
				}
				else{
				//System.out.println("4.3");
	  %>
          	<option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni);%></option>
		<%		}	
			}
		%>
        </select>
        <span class="style1">**</span> </td>
      <th width="115" bgcolor="#CCCCCC">Cantidad 1:</th>
      <td width="164"> <input name="c1" type="text" size="12" maxlength="11" value="<%=datos.getString("cantidad0")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 2:</th>
      <td> <select name="m2" id="m2">
	  <%	//System.out.println("5");

	  	String claveM2 = datos.getString("materia1");
		String nombre2 = mp.dameNombreMP(claveM2);
		String tip2 = mp.dameTipoMP(claveM2);
		if(tip2.equalsIgnoreCase("1"))
			tip2 = "kg.";
		if(tip2.equalsIgnoreCase("2"))
			tip2 = "lt.";
		if(claveM2.equalsIgnoreCase("0")){
	  %>
	  		<option value="0">SELECCIONE..</option>
		<%}
		else{%>
          <option value="<%=claveM2%>"><%out.print(nombre2+" --> "+tip2);%></option>	  
	  <% }
	  	//System.out.println("6");

	     mp1.beforeFirst();
	  		while(mp1.next()){
			String uni2 = "";
			if(mp1.getInt("tipo") == 1)
				uni2 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni2 = "lt.";
				if(mp1.getString("clave").equalsIgnoreCase(claveM2)){
				}
				else{
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni2);%></option>
		<%	}
		}
		%>
  		<option value="0">SELECCIONE..</option>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 2:</th>
      <td> <input name="c2" type="text" id="c2" size="12" maxlength="11" value="<%=datos.getString("cantidad1")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 3:</th>
      <td> <select name="m3" id="m3">
	  <%	//System.out.println("7");

	  	String claveM3 = datos.getString("materia2");
		//System.out.println(claveM3);
		String nombre3 = mp.dameNombreMP(claveM3);
		//System.out.println(nombre3);
		String tip3 = mp.dameTipoMP(claveM3);
		if(tip3.equalsIgnoreCase("1"))
			tip3 = "kg.";
		if(tip3.equalsIgnoreCase("2"))
			tip3 = "lt.";
		if(claveM3.equalsIgnoreCase("0")){
		//System.out.println("adentro if");
	  %>
	  		<option value="0">SELECCIONE..</option>
		<%}
		else{
		//System.out.println("adentro else");%>
          <option value="<%=claveM3%>"><%out.print(nombre3+" --> "+tip3);%></option>	  
	  <% }
	  	//System.out.println("8");

	     mp1.beforeFirst();
		 //System.out.println("iniciando");
	  		while(mp1.next()){
			//System.out.println("adentro while");
			String uni3 = "";
			if(mp1.getInt("tipo") == 1)
				uni3 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni3 = "lt.";
				if(mp1.getString("clave").equalsIgnoreCase(claveM3)){
				//System.out.println("adentro if2");
				}
				else{
				//System.out.println("adentro else2");
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni3);%></option>
		<%	}
		}
		%>
  		<option value="0">SELECCIONE..</option>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 3:</th>
      <td> <input name="c3" type="text" id="c3" size="12" maxlength="11" value="<%=datos.getString("cantidad2")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 4:</th>
      <td> <select name="m4" id="m4">
	  <% 	//System.out.println("9");

	  	String claveM4 = datos.getString("materia3");
		String nombre4 = mp.dameNombreMP(claveM4);
		String tip4 = mp.dameTipoMP(claveM4);
		if(tip4.equalsIgnoreCase("1"))
			tip4 = "kg.";
		if(tip4.equalsIgnoreCase("2"))
			tip4 = "lt.";
		if(claveM4.equalsIgnoreCase("0")){
	  %>
	  		<option value="0">SELECCIONE..</option>
		<%}
		else{%>
          <option value="<%=claveM4%>"><%out.print(nombre4+" --> "+tip4);%></option>	  
	  <% }
	  	//System.out.println("10");

	     mp1.beforeFirst();
	  		while(mp1.next()){
			String uni4 = "";
			if(mp1.getInt("tipo") == 1)
				uni4 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni4 = "lt.";
				if(mp1.getString("clave").equalsIgnoreCase(claveM4)){
				}
				else{
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni4);%></option>
		<%	}
		}
		%>
  		<option value="0">SELECCIONE..</option>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 4:</th>
      <td> <input name="c4" type="text" id="c4" size="12" maxlength="11" value="<%=datos.getString("cantidad3")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 5:</th>
      <td> <select name="m5" id="m5">
	  <%
	  	String claveM5 = datos.getString("materia4");
		String nombre5 = mp.dameNombreMP(claveM5);
		String tip5 = mp.dameTipoMP(claveM5);
		if(tip5.equalsIgnoreCase("1"))
			tip5 = "kg.";
		if(tip5.equalsIgnoreCase("2"))
			tip5 = "lt.";
		if(claveM5.equalsIgnoreCase("0")){
	  %>
	  		<option value="0">SELECCIONE..</option>
		<%}
		else{%>
          <option value="<%=claveM5%>"><%out.print(nombre5+" --> "+tip5);%></option>	  
	  <% }
	     mp1.beforeFirst();
	  		while(mp1.next()){
			String uni5 = "";
			if(mp1.getInt("tipo") == 1)
				uni5 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni5 = "lt.";
				if(mp1.getString("clave").equalsIgnoreCase(claveM5)){
				}
				else{
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni5);%></option>
		<%	}
		}
		%>
  		<option value="0">SELECCIONE..</option>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 5:</th>
      <td> <input name="c5" type="text" id="c5" size="12" maxlength="11" value="<%=datos.getString("cantidad4")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 6:</th>
      <td> <select name="m6" id="m6">
	  <%
	  	String claveM6 = datos.getString("materia5");
		String nombre6 = mp.dameNombreMP(claveM6);
		String tip6 = mp.dameTipoMP(claveM6);
		if(tip6.equalsIgnoreCase("1"))
			tip6 = "kg.";
		if(tip6.equalsIgnoreCase("2"))
			tip6 = "lt.";
		if(claveM6.equalsIgnoreCase("0")){
	  %>
	  		<option value="0">SELECCIONE..</option>
		<%}
		else{%>
          <option value="<%=claveM6%>"><%out.print(nombre6+" --> "+tip6);%></option>	  
	  <% }
	     mp1.beforeFirst();
	  		while(mp1.next()){
			String uni6 = "";
			if(mp1.getInt("tipo") == 1)
				uni6 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni6 = "lt.";
				if(mp1.getString("clave").equalsIgnoreCase(claveM6)){
				}
				else{
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni6);%></option>
		<%	}
		}
		%>
   		<option value="0">SELECCIONE..</option>
       </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 6:</th>
      <td> <input name="c6" type="text" id="c6" size="12" maxlength="11" value="<%=datos.getString("cantidad5")%>"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 7:</th>
      <td> <select name="m7" id="m7">
	  <%
	  	String claveM7 = datos.getString("materia6");
		String nombre7 = mp.dameNombreMP(claveM7);
		String tip7 = mp.dameTipoMP(claveM7);
		if(tip7.equalsIgnoreCase("1"))
			tip7 = "kg.";
		if(tip7.equalsIgnoreCase("2"))
			tip7 = "lt.";
		if(claveM7.equalsIgnoreCase("0")){
	  %>
	  		<option value="0">SELECCIONE..</option>
		<%}
		else{%>
          <option value="<%=claveM7%>"><%out.print(nombre7+" --> "+tip7);%></option>	  
	  <% }
	     mp1.beforeFirst();
	  		while(mp1.next()){
			String uni7 = "";
			if(mp1.getInt("tipo") == 1)
				uni7 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni7 = "lt.";
				if(mp1.getString("clave").equalsIgnoreCase(claveM7)){
				}
				else{
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni7);%></option>
		<%	}
		}
		%>
   		<option value="0">SELECCIONE..</option>
       </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 7:</th>
      <td> <input name="c7" type="text" id="c7" size="12" maxlength="11" value="<%=datos.getString("cantidad6")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 8:</th>
      <td> <select name="m8" id="m8">
	  <%
	  	String claveM8 = datos.getString("materia7");
		String nombre8 = mp.dameNombreMP(claveM8);
		String tip8 = mp.dameTipoMP(claveM8);
		if(tip8.equalsIgnoreCase("1"))
			tip8 = "kg.";
		if(tip8.equalsIgnoreCase("2"))
			tip8 = "lt.";
		if(claveM8.equalsIgnoreCase("0")){
	  %>
	  		<option value="0">SELECCIONE..</option>
		<%}
		else{%>
          <option value="<%=claveM8%>"><%out.print(nombre8+" --> "+tip8);%></option>	  
	  <% }
	     mp1.beforeFirst();
	  		while(mp1.next()){
			String uni8 = "";
			if(mp1.getInt("tipo") == 1)
				uni8 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni8 = "lt.";
				if(mp1.getString("clave").equalsIgnoreCase(claveM8)){
				}
				else{
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni8);%></option>
		<%	}
		}
		%>
  		<option value="0">SELECCIONE..</option>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 8:</th>
      <td> <input name="c8" type="text" id="c8" size="12" maxlength="11" value="<%=datos.getString("cantidad7")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 9:</th>
      <td> <select name="m9" id="m9">
	  <%
	  	String claveM9 = datos.getString("materia8");
		String nombre9 = mp.dameNombreMP(claveM9);
		String tip9 = mp.dameTipoMP(claveM9);
		if(tip9.equalsIgnoreCase("1"))
			tip9 = "kg.";
		if(tip9.equalsIgnoreCase("2"))
			tip9 = "lt.";
		if(claveM9.equalsIgnoreCase("0")){
	  %>
	  		<option value="0">SELECCIONE..</option>
		<%}
		else{%>
          <option value="<%=claveM9%>"><%out.print(nombre9+" --> "+tip9);%></option>	  
	  <% }
	     mp1.beforeFirst();
	  		while(mp1.next()){
			String uni9 = "";
			if(mp1.getInt("tipo") == 1)
				uni9 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni9 = "lt.";
				if(mp1.getString("clave").equalsIgnoreCase(claveM9)){
				}
				else{
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni9);%></option>
		<%	}
		}
		%>
   		<option value="0">SELECCIONE..</option>
       </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 9:</th>
      <td> <input name="c9" type="text" id="c9" size="12" maxlength="11" value="<%=datos.getString("cantidad8")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Materia 10:</th>
      <td> <select name="m10" id="m10">
	  <%
	  	String claveM10 = datos.getString("materia9");
		String nombre10 = mp.dameNombreMP(claveM10);
		String tip10 = mp.dameTipoMP(claveM10);
		if(tip10.equalsIgnoreCase("1"))
			tip10 = "kg.";
		if(tip10.equalsIgnoreCase("2"))
			tip10 = "lt.";
		if(claveM10.equalsIgnoreCase("0")){
	  %>
	  		<option value="0">SELECCIONE..</option>
		<%}
		else{%>
          <option value="<%=claveM10%>"><%out.print(nombre10+" --> "+tip10);%></option>	  
	  <% }
	     mp1.beforeFirst();
	  		while(mp1.next()){
			String uni10 = "";
			if(mp1.getInt("tipo") == 1)
				uni10 = "kg.";
			if(mp1.getInt("tipo") == 2)
				uni10 = "lt.";
				if(mp1.getString("clave").equalsIgnoreCase(claveM10)){
				}
				else{
	  %>
          <option value="<%=mp1.getString("clave")%>"><%out.print(mp1.getString("nombre")+" --> "+uni10);%></option>
		<%	}
		}
		%>
  		<option value="0">SELECCIONE..</option>
        </select> </td>
      <th bgcolor="#CCCCCC">Cantidad 10:</th>
      <td> <input name="c10" type="text" id="c10" size="12" maxlength="11" value="<%=datos.getString("cantidad9")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
</table>
<table width="724" border="1">
    <tr> 
      <th width="98" bgcolor="#CCCCCC">Precio:</th>
      <td width="610"> $  <input name="precio" type="text" id="contacto" size="12" maxlength="11" value="<%=datos.getString("precio")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Divisi&oacute;n:</th>
      <td> <select name="division">
	  <% 
	   String claveD = datos.getString("division");
		String nombreD = div.dameNombreDivision(claveD);
		%>
          <option value="<%=claveD%>"><%=nombreD%></option>	  		
		<%
	  ResultSet divi = div.divisionesXArea("1");
	  		while(divi.next()){
				if(divi.getString("clave").equalsIgnoreCase(claveD)){
				}
				else{
	  %>
          <option value="<%=divi.getString("clave")%>"><%=divi.getString("nombre")%></option>
		<%	}
		}
		%>
        </select>
        <span class="style1">**</span> </td>
    </tr>
	<%}%>
  </table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
    <input type="reset" name="Submit2" value="Limpiar Forma">
  </p>
</form>
<%mp.cierraConexion();%>
<p><a href="Selecciona_Division_AlimentoC.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>