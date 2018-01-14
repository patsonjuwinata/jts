<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Form Parkir</title>

<spring:url value="/resources/css/jquery-ui.css" var="jqueryUICss" />
<link rel="stylesheet" href="${jqueryUICss}">

<spring:url value="/resources/js/jquery-1.12.4.js" var="jquery" />
<script src="${jquery}"></script>

<spring:url value="/resources/js/jquery-ui.js" var="jqueryUIJs" />
<script src="${jqueryUIJs}"></script>

<spring:url value="/resources/js/jquery.validate.min.js" var="jqueryValidationJs" />
<script src="${jqueryValidationJs}"></script>

<script>
$(document).ready(
	function ($) {
    	$('#formParkir').validate(
    		{ 
        		rules: {
            		noPlatKendaraan: {
                		required: true,
                		minlength: 5,
                		maxlength: 10
            		}
        		}
    		}
    	);
	}
);
</script>

<script>
$( 
	function() {
		$("#semuaNoPlat").hide();
	} 
);
$( 
	function() {
		$("#noPlatSudahAda").hide();
	} 
);
$( 
	function() {
		$("#kapasitasParkirPenuh").hide();
	} 
);
</script>

<script>
var sudahAda = false;
window.setTimeout('cekKapasitasParkir()',1000);
function cekNoPlatKendaraan(obj) {
	sudahAda = false;
	var dataParkir = document.getElementById('dataParkir');
	if (dataParkir.value.length>0) {
		var semua = dataParkir.value.split('|'); 
		if (semua.length>0) {
			for (var i=0;i<semua.length;i++) {
				if (obj.value.trim().toUpperCase()==semua[i].trim().toUpperCase()) {
					sudahAda = true;
					i = semua.length;
				}
			}
		}
	}
	if (sudahAda) {
		errPlat = true;
		$( 
			function() {
				$("#noPlatSudahAda").html('Maaf, No. Plat "'+obj.value.trim().toUpperCase()+'" sudah ada!');
				$("#noPlatSudahAda").show();
				$("#noPlatSudahAda").dialog();
				$("#tambahBaru").prop("disabled",true);
			} 
		);
		obj.focus();
	} 
}
function cekKapasitasParkir() {
	var dataParkir = document.getElementById('dataParkir');
	var lokasiParkirA = document.getElementById('lokasiParkirA');	
	var lokasiParkirB = document.getElementById('lokasiParkirB');
	var lokasiParkirC = document.getElementById('lokasiParkirC');
	var kapasitasGedungA = document.getElementById('kapasitasGedungA');
	var kapasitasGedungB = document.getElementById('kapasitasGedungB');
	var kapasitasGedungC = document.getElementById('kapasitasGedungC');
	$( 
		function() {
			$("#semuaNoPlat").html('<p>'+dataParkir.value+'</p>');
			if (!sudahAda) {
				$("#noPlatSudahAda").text('');
				$("#noPlatSudahAda").hide();
				$("#noPlatSudahAda").dialog();
				$("#noPlatSudahAda").dialog('close');
			}
			$("#kapasitasParkirPenuh").text('');
			$("#kapasitasParkirPenuh").hide();
			$("#kapasitasParkirPenuh").dialog();
			$("#kapasitasParkirPenuh").dialog('close');
			$("#tambahBaru").prop("disabled",true);
		} 
	);
	if (kapasitasGedungA.value=='0' && kapasitasGedungB.value=='0' && kapasitasGedungC.value=='0') {
		$( 
			function() {
				$("#kapasitasParkirPenuh").html('<p>Maaf, parkir di semua gedung sudah penuh!</p>');
				$("#kapasitasParkirPenuh").show();
				$("#kapasitasParkirPenuh").dialog();
			} 
		);
	} else {
		if (lokasiParkirA.checked) {
			if (kapasitasGedungA.value=='0') {
				$( 
					function() {
						$("#kapasitasParkirPenuh").html('<p>Maaf, parkir di <b>Gedung A</b> sudah penuh!</p>');
						$("#kapasitasParkirPenuh").show();
						$("#kapasitasParkirPenuh").dialog();
					} 
				);				
			} else {
				if (!sudahAda) {
					$( 
						function() {
							$("#tambahBaru").prop("disabled",false);
						} 
					);	
				}
			}
		} 
		if (lokasiParkirB.checked) {
			if (kapasitasGedungB.value=='0') {
				$( 
					function() {
						$("#kapasitasParkirPenuh").html('<p>Maaf, parkir di <b>Gedung B</b> sudah penuh!</p>');
						$("#kapasitasParkirPenuh").show();
						$("#kapasitasParkirPenuh").dialog();
					} 
				);				
			} else {
				if (!sudahAda) {
					$( 
						function() {
							$("#tambahBaru").prop("disabled",false);
						} 
					);	
				}
			}
		} 
		if (lokasiParkirC.checked) {
			if (kapasitasGedungC.value=='0') {
				$( 
					function() {
						$("#kapasitasParkirPenuh").html('<p>Maaf, parkir di <b>Gedung C</b> sudah penuh!</p>');
						$("#kapasitasParkirPenuh").show();
						$("#kapasitasParkirPenuh").dialog();
					} 
				);				
			} else {
				if (!sudahAda) {
					$( 
						function() {
							$("#tambahBaru").prop("disabled",false);
						} 
					);	
				}
			}
		}
	}
}
</script>

<style>
.bodyText {font-family:arial;font-size:15px;color:steelblue}
.bgColor  {background-color:#eeeeee;border:1px solid #cccccc;color:green;font-weight:bold}
</style>

</head>

<body class="bodyText">

	<h2>Form Parkir</h2>
	
	<div id="semuaNoPlat" title="Semua No. Plat Kendaraan">
  		<p></p>
	</div> 
	
	<div id="noPlatSudahAda" title="No. Plat Kendaraan">
  		<p>Maaf, No. Plat ini sudah ada!</p>
	</div> 
	
	<div id="kapasitasParkirPenuh" title="Kapasitas Parkir">
  		<p>Maaf, parkir di gedung ini sudah penuh!</p>
	</div> 

	<input type="hidden" id="dataParkir" name="dataParkir" value="${data.dataParkir}" /> 
	<input type="hidden" id="kapasitasGedungA" name="kapasitasGedungA" value="${data.kapasitasParkir.get(0)}" /> 
	<input type="hidden" id="kapasitasGedungB" name="kapasitasGedungB" value="${data.kapasitasParkir.get(1)}" /> 
	<input type="hidden" id="kapasitasGedungC" name="kapasitasGedungC" value="${data.kapasitasParkir.get(2)}" /> 

	<form:form id="formParkir" modelAttribute="parkir" action="prosesParkir" method="post">
	
	
    	<table align="left">
        	<tr>
            	<td><form:label path="noPlatKendaraan">No. Plat Kendaraan</form:label></td>
            	<td align="center">:&nbsp;</td>
                <td><form:input size="10" 
                onchange="javascript:this.value = this.value.toUpperCase();cekNoPlatKendaraan(this);" 
                onkeyup="javascript:this.value = this.value.toUpperCase();" 
                class="bgColor" path="noPlatKendaraan" name="noPlatKendaraan" id="noPlatKendaraan" /></td>
            </tr>
        	<tr>
            	<td><form:label path="lokasiParkir">Lokasi Parkir</form:label></td>
            	<td align="center">:&nbsp;</td>
                <td>
                	<form:radiobutton 
                	onchange="javascript:cekKapasitasParkir();" 
                	onclick="javascript:cekKapasitasParkir();" 
                	path="lokasiParkir" checked="checked" name="lokasiParkir" 
                	id="lokasiParkirA" value="Gedung A" />Gedung A (${data.kapasitasParkir.get(0)})
                	<form:radiobutton 
                	onchange="javascript:cekKapasitasParkir();" 
                	onclick="javascript:cekKapasitasParkir();" 
                	path="lokasiParkir" name="lokasiParkir" 
                	id="lokasiParkirB" value="Gedung B"/>Gedung B (${data.kapasitasParkir.get(1)})
                	<form:radiobutton 
                	onchange="javascript:cekKapasitasParkir();" 
                	onclick="javascript:cekKapasitasParkir();" 
                	path="lokasiParkir" name="lokasiParkir" 
                	id="lokasiParkirC" value="Gedung C"/>Gedung C (${data.kapasitasParkir.get(2)})
                </td> 
            </tr>
            <tr>
            	<td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3"><form:button id="tambahBaru" name="tambahBaru">Tambah Baru</form:button>&nbsp;&nbsp;
				<a href="lihat">Lihat Semua</a></td>
            </tr>
       </table>
       
    </form:form>
    
</body>
</html>

