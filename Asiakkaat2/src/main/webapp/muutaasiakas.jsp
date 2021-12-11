<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<link rel="stylesheet" href="css/style.css" type="text/css" />
<title>Asiakkaan tietojen muutos</title>
</head>
<body onkeydown="tutkiKey(event)">
<form id="tiedot">
	<table class="table">
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
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td>			
				<td><input type="button" id="tallenna" value="Päivitä" onclick="vieTiedot()"></td>
			</tr>
		<tbody>
		</tbody>
	</table>
	<input type="hidden" name="asiakas_id" id="asiakas_id">
</form>
<span id="ilmoitus"></span>
</body>
<script>
function tutkiKeyX(event){
	if(event.keyCode==13){
		vieTiedot();
	}		
}
var tutkiKey = (event) => {
	if(event.keyCode==13){
		vieTiedot();
	}	
}
document.getElementById("etunimi").focus(); 
var asiakas_id = requestURLParam("asiakas_id");  
fetch("asiakkaat/haeyksi/" + asiakas_id,{
    method: 'GET'	      
  })
.then( function (response) {
	return response.json()
})
.then( function (responseJson) {
	console.log(responseJson);
	document.getElementById("etunimi").value = responseJson.etunimi;		
	document.getElementById("sukunimi").value = responseJson.sukunimi;	
	document.getElementById("puhelin").value = responseJson.puhelin;	
	document.getElementById("sposti").value = responseJson.sposti;	
	document.getElementById("asiakas_id").value = responseJson.asiakas_id;	
});

function vieTiedot(){	
	var ilmoitus="";
	if(document.getElementById("etunimi").value.length<2){
		ilmoitus="Etunimi on liian lyhyt";
	}else if(document.getElementById("sukunimi").value.length<2){
		ilmoitus="Sukunimi on liian lyhyt";
	}else if(document.getElementById("puhelin").value.length<5){
		ilmoitus="Puhelinnumero on liian lyhyt";
	}else if(document.getElementById("sposti").value == ""){
			ilmoitus="Sähköposti puuttuu";		
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
	console.log(formJsonStr);
	
	fetch("asiakkaat",{
	      method: 'PUT',
	      body:formJsonStr
	    })
	.then( function (response) {
		return response.json();
	})
	.then( function (responseJson) {	
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmoitus").innerHTML= "Tietojen päivitys epäonnistui";
        }else if(vastaus==1){	        	
        	document.getElementById("ilmoitus").innerHTML= "Tietojen päivitys onnistui";			      	
		}	
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("tiedot").reset();
}
</script>
</html>