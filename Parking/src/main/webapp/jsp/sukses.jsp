<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Form Parkir</title>

<spring:url value="/resources/css/jquery-ui.css" var="jqueryUICss" />
<link rel="stylesheet" href="${jqueryUICss}">

<spring:url value="/resources/css/jquery.dataTables.min.css" var="jqueryDataTablesCss" />
<link rel="stylesheet" href="${jqueryDataTablesCss}">

<spring:url value="/resources/js/jquery-1.12.4.js" var="jquery" />
<script src="${jquery}"></script>

<spring:url value="/resources/js/jquery-ui.js" var="jqueryUIJs" />
<script src="${jqueryUIJs}"></script>

<spring:url value="/resources/js/jquery.dataTables.min.js" var="jqueryDataTablesJs" />
<script src="${jqueryDataTablesJs}"></script>

<spring:url value="/resources/js/jquery.tablesorter.min.js" var="jqueryTableSorterJs" />
<script src="${jqueryTableSorterJs}"></script>

<script>
$( 
	function() {
    	$("#dialog").dialog();
  	} 
);
</script>
 
<script>  
$(document).ready(function() {
	var simpleSort = false;
	if (simpleSort) {
		$('#dataParkir').tablesorter();
	} else {
    	$('#dataParkir').DataTable( 
    		{
        		"order": [[ 0,"asc"]]
    		} 
    	);
	}
});
</script>

<script>
window.setTimeout('repaintTableAfterSort()',1000);
function repaintTableAfterSort() {
	var colMax = 2;
	var colCount = 0;
	var css = 'bgDetail2';
	var lastRow = '';
	var rows = document.getElementsByTagName('td'); 
	if (rows!=null) {
		if (rows.length>0) {
			for (var i=0;i<rows.length;i++) {
				if (rows[i].id!==null) {
					if (rows[i].id.indexOf('row_')!=-1) { 
						if (lastRow=='') {
							lastRow = rows[i].id;
						}
						if (lastRow!=rows[i].id) {
							if (colCount>=colMax) {
								colCount = 1;
								lastRow = rows[i].id;	
								if (css=='bgDetail1') {
									css = 'bgDetail2';
								} else {
									css = 'bgDetail1'; 
								}
								rows[i].className = css;
							}	
						} else {
							rows[i].className = css;	
							colCount++;
						}
					}
				}
			}
		}
	}
	window.setTimeout('repaintTableAfterSort()',1000);
}
</script>    
    
<style>
.bodyText {font-family:arial;font-size:15px;color:steelblue}
.bgColor {background-color:#eeeeee;border:1px solid #cccccc;color:green;font-weight:bold}
.bgHeader {background-color:steelblue;border:1px solid black;width:150px;color:white}
.bgDetail1 {background-color:#cccccc;border:1px solid black;width:150px;color:navy;font-size:12px}
.bgDetail2 {background-color:#eeeeee;border:1px solid black;width:150px;color:navy;font-size:12px}
.tableBorder {border:1px solid white;padding:10px}
</style>
	
</head>

<body class="bodyText">

	<h2>Form Parkir</h2>

	<div id="dialog" title="Parkir Sukses!">
  		<p>	Selamat, <b>${data.noPlatKendaraan}</b> telah mendapat lokasi parkir di <b>${data.lokasiParkir}</b>!</p>
	</div>
 
	Selamat, <b>${data.noPlatKendaraan}</b> telah mendapat lokasi parkir di <b>${data.lokasiParkir}</b>!
	<br /><br />

	<form id="formParkir" action="tambah" method="get">
	
    	<table id="dataParkirBaru" align="left">
        	<tr>
            	<td>No. Plat Kendaraan</td>
            	<td align="center">:&nbsp;</td>
                <td><input type="text" size="10" value="${data.noPlatKendaraan}" class="bgColor" readonly name="noPlatKendaraan" id="noPlatKendaraan" /></td>
            </tr>
        	<tr>
            	<td>Lokasi Parkir</td>
            	<td align="center">:&nbsp;</td>
                <td>
					<c:if test = "${data.lokasiParkir=='Gedung A'}">                
                		<input readonly checked type="radio" name="lokasiParkir" id="lokasiParkir" value="Gedung A" />Gedung A
                		<input readonly type="radio" name="lokasiParkir" id="lokasiParkir" value="Gedung B" />Gedung B
                		<input readonly type="radio" name="lokasiParkir" id="lokasiParkir" value="Gedung C" />Gedung C
					</c:if>
					<c:if test = "${data.lokasiParkir=='Gedung B'}">                					
                		<input readonly type="radio" name="lokasiParkir" id="lokasiParkir" value="Gedung A" />Gedung A
                		<input readonly checked type="radio" name="lokasiParkir" id="lokasiParkir" value="Gedung B" />Gedung B
                		<input readonly type="radio" name="lokasiParkir" id="lokasiParkir" value="Gedung C" />Gedung C
					</c:if>
					<c:if test = "${data.lokasiParkir=='Gedung C'}">                					
                		<input readonly type="radio" name="lokasiParkir" id="lokasiParkir" value="Gedung A" />Gedung A
                		<input readonly type="radio" name="lokasiParkir" id="lokasiParkir" value="Gedung B" />Gedung B
                		<input readonly checked type="radio" name="lokasiParkir" id="lokasiParkir" value="Gedung C" />Gedung C
					</c:if>       	
                </td>
            </tr>
            <tr>
            	<td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3"><input type="submit" name="tambahLagi" id="tambahLagi" value=" Tambah Lagi " />&nbsp;&nbsp;
				<a href="lihat">Update Parkir</a></td>
            </tr>
            <tr>
            	<td colspan="3">&nbsp;</td>
            </tr>
            <tr>
            	<td colspan="3">            	
    				<table id="dataParkir" align="left" class="tableBorder">
    					<thead>
        					<tr>
            					<th class="bgHeader">No. Plat Kendaraan</th>
            					<th class="bgHeader">Lokasi Parkir</th>
        					</tr>
        				</thead>
        				<tbody>
        					<c:set var="count" value="0" scope="page" />
        					<c:forEach items="${data.dataParkir}" var="dataParkir">
        						<c:set var="count" value="${count+1}" scope="page" />
    							<c:choose>
    								<c:when test = "${count%2=='0'}">
    									<tr>
            								<td id="row_${count}" class="bgDetail1"><c:out value="${dataParkir.noPlatKendaraan}" /></td>
            								<td id="row_${count}" class="bgDetail1"><c:out value="${dataParkir.lokasiParkir}" /></td>
        								</tr>
            						</c:when>
            						<c:otherwise>
    									<tr>
            								<td id="row_${count}" class="bgDetail2"><c:out value="${dataParkir.noPlatKendaraan}" /></td>
            								<td id="row_${count}" class="bgDetail2"><c:out value="${dataParkir.lokasiParkir}" /></td>
        								</tr>            							
            						</c:otherwise>
            					</c:choose>
							</c:forEach>   
						</tbody> 		
   					</table>
            	</td>
            </tr>
        </table>
       
    </form>
    
</body>
</html>


