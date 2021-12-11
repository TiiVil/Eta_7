<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<link rel="stylesheet" href="css/style.css" type="text/css" />
<title>Asiakkaan lisääminen</title>
</head>
<body onkeydown="tutkiKey(event)">
<form id="tiedot">
	<table>
	<thead>
		<tr>
			<th colspan="3" id="ilmoitus"></th>
			<th colspan="2" class="oikealle"><a href="listaaasiakkaat.jsp" id="takaisin">Takaisin asiakaslistaukseen</a></th>
		</tr>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><input type="text" name="etunimi" id="etunimi"></td>
			<td><input type="text" name="sukunimi" id="sukunimi"></td>
			<td><input type="text" name="puhelin" id="puhelin"></td>
			<td><input type="text" name="sposti" id="sposti"></td> 
			<td><input type="button" name="nappi" id="tallenna" value="Lisää" onclick="lisaaTiedot()"></td>
		</tr>
	</tbody>
</table>
</form>
<span id="ilmoitus"></span>
<script>
function tutkiKey(event){
	if(event.keyCode==13){
		lisaaTiedot();
	}
	
}
document.getElementById("etunimi").focus();
function lisaaTiedot(){	
	var ilmoitus="";
	if(document.getElementById("etunimi").value.length<3){
		ilmoitus="Etunimi ei kelpaa!";		
	}else if(document.getElementById("sukunimi").value.length<3){
		ilmoitus="Sukunimi ei kelpaa!";		
	}else if(document.getElementById("puhelin").value.length<4){
		ilmoitus="Puhelin ei kelpaa!";		
	}else if(document.getElementById("sposti").value.length<4){
		ilmoitus="Sähköposti ei ole kelpaa!";			
	}
	if(ilmoitus!=""){
		document.getElementById("ilmoitus").innerHTML=ilmo;
		setTimeout(function(){ document.getElementById("ilmoitus").innerHTML=""; }, 3000);
		return;
	}
	document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
	document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
	document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
	document.getElementById("sposti").value=siivoa(document.getElementById("sposti").value);	
		
	var formJsonStr=formDataToJSON(document.getElementById("tiedot"));

	fetch("asiakkaat",{
	      method: 'POST',
	      body:formJsonStr
	    })
	.then( function (response) {		
		return response.json()
	})
	.then( function (responseJson) {
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmoitus").innerHTML= "Asiakkaan lisääminen epäonnistui";
      	}else if(vastaus==1){	        	
      		document.getElementById("ilmoitus").innerHTML= "Asiakkaan lisääminen onnistui";			      	
		}
		setTimeout(function(){ document.getElementById("ilmoitus").innerHTML=""; }, 5000);
	});	
	document.getElementById("tiedot").reset(); 
}
</script>
</body>
</html>