<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="div" class="com.ult.bd.ManagerDivisiones" scope="page" />

<html>
<head>
<title>Selecciona Division</title>
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

function MandaForma0(forma) {
	document.form1.submit();

}

function MandaSubmit(f){
	document.form2.submit();
}
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 10px}
-->
</style>
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
%>	
<%
String area1 = "1";
%>
<form name="form1" method="post" action="Selecciona_AlimentoS.jsp">
  <input type="hidden" name="area" value="<%= area1%>">
 <h1>Selecciona una División</h1>
<table width="464" border="1">
      <th width="80"><div align="left">División:</div></th>
      <td width="468" >
        <select name="division" onChange="MandaForma0(this.form)">
 <option selected value="0">Seleccione ...</option>
            <% 
			//System.out.println("6.1");
			ResultSet rs3 = div.divisionesXArea(area1);
			//System.out.println("6.2");
			while(rs3.next()){
			//System.out.println("6.3");%>
            <option value="<%=rs3.getString("clave")%>"><%=rs3.getString("nombre")%></option>
            <%}%>		
		</select>
   </td>
	</tr>
  </table>
  <p> </p>
  </form>
<% div.cierraConexion();%>
<p align="center"><font color="#FFFFFF"><a href="Menu_AlimentosS.jsp" target="_self" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></font></p>
<p align="center"><font size="2"><img src="imagenes/barraN.jpg" width="532" height="82"></font> 
</body>
</html>