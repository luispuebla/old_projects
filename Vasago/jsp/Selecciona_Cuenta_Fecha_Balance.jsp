<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="ban" class="com.vas.bd.ManagerBancos" scope="page" />

<html>
<head>
<title>Balance</title>
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

function MandaForma0(forma) {
	if(document.form1.mes.value == 0 || document.form1.ano.value == 0){
	}
	else{
		forma.submit();
	}
}

function MandaForma1(forma) {
	if(document.form1.numero.value == 0 || document.form1.ano.value == 0){
	}
	else{
		forma.submit();
	}
}

function MandaForma2(forma) {
	if(document.form1.mes.value == 0 || document.form1.numero.value == 0){
	}
	else{
		forma.submit();
	}
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
	String banco = request.getParameter("banco");
%>	
<p>&nbsp;</p>
<form name="form1" method="post" action="Balance.jsp">
<input type="hidden" name="banco" value="<%=banco%>">
<table width="459" border="0" align="center">
  <tr> 
    <th width="448"> <h1>Selecciona la Cuenta para su Balance: </h1>
      </th>
  </tr>
  <tr>
  	<td><div align="center">
  	          <select name="numero" onChange="MandaForma0(this.form)">
			  <option value="0" selected>SELECCIONA..</option>
            <% ResultSet cuentas = ban.dameCuentas(banco);
			while(cuentas.next()){%>
            <option value="<%=cuentas.getString("numero")%>"><%=cuentas.getString("numero")%></option>
            <%}
			if(cuentas != null){
				cuentas.close();
			}
			ban.cierraConexion();			  		 									
			%>		
		</select>
	  </div></td>
  </tr>
  <tr>
  	<td><p>&nbsp;</p>  </td>
  </tr>
  <tr> 
    <th> <h1>Selecciona el Mes Deseado </h1>      </th>
  </tr>
  <tr>
  	<td><div align="center">
  	          <select name="mes" id="mes" onChange="MandaForma1(this.form)">
			  <option value="0" selected>SELECCIONA..</option>
			  <option value="1" >Enero</option>
			  <option value="2" >Febrero</option>
			  <option value="3" >Marzo</option>
			  <option value="4" >Abril</option>
			  <option value="5" >Mayo</option>
			  <option value="6" >Junio</option>
			  <option value="7" >Julio</option>
			  <option value="8" >Agosto</option>
			  <option value="9" >Septiembre</option>
			  <option value="10" >Octubre</option>
			  <option value="11" >Noviembre</option>
			  <option value="12" >Diciembre</option>
		</select>
	  </div></td>
  </tr>
  <tr>
  	<td><p>&nbsp;</p>  </td>
  </tr>
  <tr> 
    <th> <h1>Selecciona el Año Deseado </h1>      </th>
  </tr>
  <tr>
  	<td><div align="center">
  	          <select name="ano" id="ano" onChange="MandaForma2(this.form)">
			  <option value="0" selected>SELECCIONA..</option>
			  <option value="2006" >2006</option>
			  <option value="2007" >2007</option>
			  <option value="2008" >2008</option>
			  <option value="2009" >2009</option>
			  <option value="2010" >2010</option>
			  <option value="2011" >2011</option>
			  <option value="2012" >2012</option>
			  <option value="2013" >2013</option>
			  <option value="2014" >2014</option>
			  <option value="2015" >2015</option>
		</select>
	  </div></td>
  </tr>
</table>
</form>
<p align="center"><a href="Selecciona_Banco_Balance.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
