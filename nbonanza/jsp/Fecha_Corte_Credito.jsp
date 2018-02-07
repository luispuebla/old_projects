<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>

<html>
<head>
<title>Consulta de por Fechas</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script>
<!--
function formatoDia(f){
	f.dia.disabled=false;
}
function formatoMes(f){
	f.dia.disabled=true;
}

function Checador (f){
	var elMes = f.mes.value;
	var elAnio = f.aaaa.value;
	var elDia = f.dia.value;
	if (elMes == 4 || elMes == 6 || elMes == 9 || elMes == 11  ){
		if(elDia > 30){
			alert ("El mes seleccionado es de 30 días..., reintroducir dia.");
			f.dia.value=30;
		}
	}
	else if (elMes == 1 || elMes == 3 || elMes == 5 || elMes == 7 || elMes == 8 || elMes == 10 || elMes == 12  ){
	}
	else{
		if(elAnio%4 == 0){
			if(elDia > 29){
				alert ("El mes de Febrero es de 29 días para este año..., reintroducir dia.");
				f.dia.value=29;
			}
		}
		else {
			if(elDia > 28){
				alert ("El mes de Febrero es de 28 días para este año..., reintroducir dia.");
				f.dia.value=28;				
			}
		}
	}
}
function setFecha(){
	var fechaHoy = new Date();
	var mesHoy = new String();
	var anioHoy = new String();
	var diaHoy = new String();
	var ndiaHoy =  new Number();
	var nmesHoy = new Number();		
	nmesHoy = (fechaHoy.getMonth()+1);
	anioHoy = (fechaHoy.getYear());
	ndiaHoy = (fechaHoy.getDate());
	diaHoy = ndiaHoy +"";
	mesHoy = nmesHoy +"";
	if(diaHoy.length==1){
		diaHoy = "0"+diaHoy;
	}
	if(mesHoy.length==1){
		mesHoy = "0"+mesHoy;
	}
	document.form1.dia.value=diaHoy;
	document.form1.mes.value=mesHoy;
	document.form1.aaaa.value=anioHoy;
}

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
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg');setFecha()" >
<h1>Por favor selecciona el peri&oacute;do de tiempo a realizar el corte de Cr&eacute;ditos:</h1>
<form name="form1" method="post" action="CorteCredito.jsp">
  <div align="center">
    <table width="200">
      <tr> 
        <th> <label> <input type="radio" name="tipoCon" value="dia" checked onClick="formatoDia(this.form)"> Consulta Por D&iacute;a</label> </th>
      </tr>
      <tr> 
        <th><label> <input type="radio" name="tipoCon" value="mes" onClick="formatoMes(this.form)">  Consulta Mensual</label></th>
	  </tr>
		<tr>
		 <td height="20"></td>
      </tr>
    </table>
    <table width="250" border="1">
      <tr> 
        <th>Día:</th>
        <td>
          <select name="dia" onChange="Checador(this.form)">
            <option value="01">1</option>
            <option value="02">2</option>
            <option value="03">3</option>
            <option value="04">4</option>
            <option value="05">5</option>
            <option value="06">6</option>
            <option value="07">7</option>
            <option value="08">8</option>
            <option value="09">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
            <option value="19">19</option>
            <option value="20">20</option>
            <option value="21">21</option>
            <option value="22">22</option>
            <option value="23">23</option>
            <option value="24">24</option>
            <option value="25">25</option>
            <option value="26">26</option>
            <option value="27">27</option>
            <option value="28">28</option>
            <option value="29">29</option>
            <option value="30">30</option>
            <option value="31">31</option>		  
          </select>
        </td>
      </tr>
      <tr> 
        <th >Mes:</th>
        <td>
          <select name="mes" onChange="Checador(this.form)">
            <option value="01">Enero</option>
            <option value="02">Febrero</option>
            <option value="03">Marzo</option>
            <option value="04">Abril</option>
            <option value="05">Mayo</option>
            <option value="06">Junio</option>
            <option value="07">Julio</option>
            <option value="08">Agosto</option>
            <option value="09">Septiembre</option>
            <option value="10">Octubre</option>
            <option value="11">Noviembre</option>
            <option value="12">Diciembre</option>
          </select>
        </td>
      </tr>
      <tr> 
        <th>A&ntilde;o:</th>
        <td>
          <select name="aaaa" onChange="Checador(this.form)">
            <option value="2005">2005</option>
            <option value="2006">2006</option>
            <option value="2007">2007</option>
            <option value="2008">2008</option>
            <option value="2009">2009</option>
            <option value="2010">2010</option>
          </select>
        </td>	  
	  </tr>
    </table>
  </div>
  <p align="center"><input type="submit" name="Submit" value="Enviar"> </p>
</form>
<p align="center"><a href="Menu_Consul_Ventas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>