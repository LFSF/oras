<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="connexion.asp"-->
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<link href="styles.css" rel="stylesheet" type="text/css" />

<SCRIPT LANGUAGE="Javascript1.1">
function fonc_print() { 
window.print(); 
} 

</SCRIPT>

<SCRIPT LANGUAGE="Javascript1.1">
function lightUp() { 
document.images["homeButton"].src="img/print_click.jpg" 
} 
function dimDown() { 
document.images["homeButton"].src="img/print_noclick.jpg"
} 
</SCRIPT>


<script language="JavaScript">
function verifform()
{
 if(document.deposer.intitule.value == "")
  {
   alert("Merci d'indiquer l'intitulé de l'offre.");
   document.deposer.intitule.focus();
   return false;
  }
 if(document.deposer.nom.value == "")
  {
   alert("Merci d'indiquer votre nom.");
   document.deposer.nom.focus();
   return false;
  }
 if(document.deposer.prenom.value == "")
  {
   alert("Merci d'indiquer votre prenom.");
   document.deposer.prenom.focus();
   return false;
  }
 if(document.deposer.adresse.value == "")
  {
   alert("Merci d'indiquer votre adresse.");
   document.deposer.adresse.focus();
   return false;
  }
   if(document.deposer.cp.value == "")
  {
   alert("Merci d'indiquer votre code postal (99 si hors de france).");
   document.deposer.cp.focus();
   return false;
  }
   if(document.deposer.ville.value == "")
  {
   alert("Merci d'indiquer votre ville.");
   document.deposer.ville.focus();
   return false;
  }
   if(document.deposer.email.value == "")
  {
   alert("Merci d'indiquer votre adresse email.");
   document.deposer.email.focus();
   return false;
  }
 adresse_email = document.deposer.email.value;
arobase = adresse_email.indexOf("@");
point = adresse_email.indexOf(".",arobase);
mauvais_endroit_point = arobase+1;
double_point = adresse_email.indexOf("..",arobase);
nbre_carac = adresse_email.length - point;
double_arobase = adresse_email.indexOf("@",arobase+1);
	
// dans l'ordre:			
// si l'arobase est absente ou en 1ere position
// ou si le . suivant l'arobase est juste derriere ou absent
// si la longueur de l'adresse est inferieure a 5 (grand minimum -> x@x.x)
// si il ya pas 2 . qui se suive deriere l'arobase
// si il y a bien 2 caractere minimum apres le . situe derriere l'arobase
// si il y a pas une arobase deriere la premiere arobase
if ( (arobase < 1) ||  
	 (point <= mauvais_endroit_point) || 
	 (adresse_email.length < 5) || 
	 (double_point >= 0) ||
	 (nbre_carac < 3) ||
	 (double_arobase >= 0) )
	{
	alert ("l'adresse email est invalide.");
    document.deposer.email.focus();
	return false;
	}
   if(document.deposer.tel.value == "")
  {
   alert("Merci d'indiquer votre numéro de telephone.");
   document.deposer.tel.focus();
   return false;
  }
   if(document.deposer.diplome_en_cour.value == "")
  {
   alert("Merci d'indiquer votre diplôme en cour.");
   document.deposer.diplome_en_cour.focus();
   return false;
  }
   if(document.deposer.diplome_obtenu.value == "")
  {
   alert("Merci d'indiquer vos diplômes obtenus.");
   document.deposer.diplome_obtenu.focus();
   return false;
  }
   if(document.deposer.poste.value == "")
  {
   alert("Merci d'indiquer le poste recherché.");
   document.deposer.poste.focus();
   return false;
  }
   if(document.deposer.experience_pro.value == "")
  {
   alert("Merci d'indiquer votre expérience professionnelle.");
   document.deposer.experience_pro.focus();
   return false;
  }
 }
 
 
 
 
 function verifformbis()
{
  if(document.mess.rs.value == "")
  {
   alert("Merci de mettre votre raison sociale.");
   document.mess.rs.focus();
   return false;
  }
  
  if(document.mess.adresse.value == "")
  {
   alert("Merci d'indiquer votre adresse.");
   document.mess.adresse.focus();
   return false;
  }
   if(document.mess.cp.value == "")
  {
   alert("Merci d'indiquer votre code postal (99 si hors de france).");
   document.mess.cp.focus();
   return false;
  }
   if(document.mess.ville.value == "")
  {
   alert("Merci d'indiquer votre ville.");
   document.mess.ville.focus();
   return false;
  }
  
  
  
 if(document.mess.nom_responsable.value == "")
  {
   alert("Merci d'indiquer votre nom.");
   document.mess.nom_responsable.focus();
   return false;
  }
 if(document.mess.prenom_responsable.value == "")
  {
   alert("Merci d'indiquer votre prenom.");
   document.mess.prenom_responsable.focus();
   return false;
  }
 
   if(document.mess.email.value == "")
  {
   alert("Merci d'indiquer votre adresse email.");
   document.mess.email.focus();
   return false;
  }
 adresse_email = document.mess.email.value;
arobase = adresse_email.indexOf("@");
point = adresse_email.indexOf(".",arobase);
mauvais_endroit_point = arobase+1;
double_point = adresse_email.indexOf("..",arobase);
nbre_carac = adresse_email.length - point;
double_arobase = adresse_email.indexOf("@",arobase+1);
	
// dans l'ordre:			
// si l'arobase est absente ou en 1ere position
// ou si le . suivant l'arobase est juste derriere ou absent
// si la longueur de l'adresse est inferieure a 5 (grand minimum -> x@x.x)
// si il ya pas 2 . qui se suive deriere l'arobase
// si il y a bien 2 caractere minimum apres le . situe derriere l'arobase
// si il y a pas une arobase deriere la premiere arobase
if ( (arobase < 1) ||  
	 (point <= mauvais_endroit_point) || 
	 (adresse_email.length < 5) || 
	 (double_point >= 0) ||
	 (nbre_carac < 3) ||
	 (double_arobase >= 0) )
	{
	alert ("l'adresse email est invalide.");
    document.mess.email.focus();
	return false;
	}
   if(document.mess.tel.value == "")
  {
   alert("Merci d'indiquer votre numéro de telephone.");
   document.mess.tel.focus();
   return false;
  }
  
   if(document.mess.message.value == "")
  {
   alert("Merci de laisser un message.");
   document.mess.message.focus();
   return false;
  }
  
 }
 
  
 </script>
 <script language="JavaScript">

function fonc2()
{
if((event.keyCode<48)||(event.keyCode>57))

	{
	// alert(window.event.keyCode);
	alert("Attention uniquement des chiffres !");
	event.returnValue=false;
	}
}

</script>
<script language="JavaScript">
<!--
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>

<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if 
(win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} 
else 
{ document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// -->
</script>

<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>



<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_orange">CONSULTATION OFFRE</div>




<%
         select case Request.QueryString("sens")
		case""
			if session("numeropage")<>1 then
				if session("numeropage")="" then
							session("numeropage")=1
				end if
			end if
			case"suivant"
		session("numeropage")=session("numeropage")+1
			case"precedent"
		session("numeropage")=session("numeropage")-1
		end select


 Set rsv = Server.CreateObject("ADODB.RecordSet")
 Set rsmembre = Server.CreateObject("ADODB.RecordSet")
       

 'SQL1 = "Select * from contact_organisme where journee12mai='non'"
 
 'SQL1 = "Select * from t_depotcv where visible_sur_site='oui' order by profil "
 
 
 'SQL1 = "Select * from t_depotcv where num='" & request("num") 

  SQL1 = "Select * from OFFRES where NumOff= " & Request.QueryString("num") & ""
 
  rsv.PageSize=100
  rsv.open SQL1,conn,1,3 
  rsv.AbsolutePage =session("numeropage")

  SQL2 = "SELECT * FROM MEMBRE WHERE NumMembre= " & rsv("NumMembre") & ""


  rsmembre.open SQL2,conn,1,3 


for i=1 to rsv.PageSize
					
					'id_login = rsv.fields("login").value
					'id_password =rsv.fields("passe").value
					num =rsv.fields("NumOff").value
					duree_offre =rsv.fields("DureeOff").value
					statut =rsmembre.fields("StatutMembre").value
					raison_sociale =rsmembre.fields("NomMembre").value
					adresse =rsmembre.fields("AdrMembre").value
					cp= rsmembre.fields("CPMembre").value
					ville = rsmembre.fields("VilleMembre").value
					civilite = rsmembre.fields("CivMembre").value
					email = rsmembre.fields("MailMembre")
					tel = rsmembre.fields("TelMembre")
					profil = rsv.fields("ProfilOff")
					
					intitule = rsv.fields("IntituleOff")
					lieu = rsv.fields("LieuOff")
					description = rsv.fields("DescOff")
					duree_contrat = rsv.fields("DureeOff")
					indemnite = rsv.fields("IndemniteOff")
					doc_a_fournir = rsv.fields("DocOff")
					montant_indemnite = rsv.fields("MontantOff")
					autres_indemnites = rsv.fields("AutIndOff")
					date_inscription = rsv.fields("DateOff")		
					
				
			session("dest_numcv")=num
			session("dest_raison_sociale")=raison_sociale
			session("dest_nom")=nom
			session("dest_prenom")=prenom
			session("dest_civilite")=civilite
			session("dest_email")=email
			session("dest_poste_recherche")=intitule
			session("dest_lieu")=lieu



	
if rsv.fields("dureeOff")="def" then
   session("duree_offre_emploi")="C.D.I"
   else
   response.write(rsv.fields("dureeOff"))
end if

				
							
							
				
				
					
						
		
					 
					
					%>




<table style="background-repeat:no-repeat;" 
width="650" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">
	
	
	
	
	

	
  
	
	<!--       INSERTION -->
	

<tr >
<td colspan="2" class="style"><br>
<h5>
<table class="txt">
<tr><td valign="top">&nbsp;Offre de : &nbsp;</td><td>&nbsp;<% =raison_sociale%> &nbsp;
<br>

<!--
</td></tr>
<tr><td ></td><td>
-->
&nbsp;<% =adresse%> &nbsp; 
<!--
</td></tr>
<tr><td ></td><td>
-->
<br>
&nbsp;<% =cp%>&nbsp; <% =ville%>. &nbsp; 


</td></tr>



<tr><td >Contact :</td><td>&nbsp;<% =civilite%>&nbsp;<%=prenom%>&nbsp;<%=nom%>  &nbsp; </td></tr>
<tr><td ></td><td>&nbsp;<font color="blue"><u><a href="mailto:<% =email%>"><% =email%></a></u></font>&nbsp; <br>&nbsp;<% =tel%>&nbsp;</td></tr>
<tr><td>&nbsp;Réf. offre : &nbsp;</td><td>&nbsp;<% =raison_sociale%><%session("dest_rs")=raison_sociale%> &nbsp;P08001</td></tr>
</table>
</h5>


</td>
</tr>



<tr>
<td><br> <div align="justify"><br />
                <table width="500" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
				  
				   <tr> 
                    
                    <td colspan="2"><% 
					'=profil
					%></td>
					<td></td>
                  </tr>
				  
                  <tr> 
                    
                    <td colspan="2" align="center">
					<div class="paragraphebordseul">
					&nbsp;&nbsp;<font color="black"><%=profil%>&nbsp;&nbsp;<% =intitule%>&nbsp;&nbsp;&nbsp;<%=rsv.fields("dureeOff")%>&nbsp</font> 
					
					</div>
					</td>
					<td></td>
                  </tr>
                  <tr> 
                    
                    <td colspan="2" align="center">&nbsp;</td>
					<td></td>
                  </tr>
				   <tr> 
                    
				 <tr> 
                    
                    <td colspan="2" align="center">&nbsp;</td>
					<td></td>
                  </tr>
				   <tr> 
											

					
                    <td colspan="2" align="center"></td>
					<td></td>
                  </tr>
				   <tr> 
                    <td valign="top"><font color="#969696">Description du poste :</font></td>
                    <td><% =description%></td>
                  </tr>
				  <tr> 
                    
                    <td colspan="2" align="center">&nbsp;</td>
					<td></td>
                  </tr><tr> 
                    
                    <td colspan="2" align="center">&nbsp;</td>
					<td></td>
                  </tr>
				  <tr> 
                    <td><font color="#969696">Lieu du poste :</font></td>
                    <td><% =lieu%></td>
                  </tr>
				  
				   <tr> 
                    <td><font color="#969696">Précision du Lieu du poste :</font></td>
                    <td><% =precision_lieu%></td>
                  </tr>
				  
				  
				  <tr> 
                    <td><font color="#969696">Duée du contrat :</font></td>
                    <td><% =rsv.fields("dureeOff")%></td>
                  </tr>
				  <tr> 
                    <td><font color="#969696">Indemnité :</font></td>
                    <td><% =indemnite%></td>
                  </tr>
				  <tr> 
                    <td><font color="#969696">montant de l'ndemnité :</font></td>
                    <td><% =montant_indemnite%></td>
                  </tr>
				  <tr> 
                    <td class="txt1"><font color="#969696">Autres indemnités :</font></td>
                    <td><% =autres_indemnites%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Document à fournir :</font></td>
                    <td><% =doc_a_fournir%></td>
                  </tr>
                  
                   <tr> 
                    <td class="txt1"><font color="#969696">Date parution de l'annonce  :</font></td>
                    <td><% =date_inscription%></td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  
				  
				  
			
				
				  <!--
				  
				
				  
				  ---->
				  
				  <%
					
					session("lecompteur")=compteur	
						'Response.Write(session("lecompteur"))
					
					rsv.MoveNext 
					
		if rsv.EOF  then exit for
	next
	 set connv=nothing%>
				  
				  
				  
				  
				  
				  
				  
                   <tr>
                    <td colspan="2">
					<table width=100%>
					<tr>
					<td align="center">
					
					<!--
					  <INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier"
               onClick="history.back()">
					  <input name="valider" style="width:75" type="button" OnClick="window.location.href='valider_deposer.asp'" value="Valider">
					 -->


					 </td>
					  </td></tr>
					  </table>
					</td>
                  </tr>
				  
				  <tr><td> <br>
	
 
 <br><div align="right" >
<IMG SRC="img/print_noclick.jpg" onclick= "return fonc_print()" name="homeButton" width="100" height="50" border="0"  onmouseOver="lightUp();" onmouseOut="dimDown();"> 
 
 </div></td></tr>
				  
				  
                </table>
				
				 <br> <br>
				<!------------------------------ENVOI  MESSAGE------------------------------------------------->
				<script>
function visibilite(thingId)
{
var targetElement;
targetElement = document.getElementById(thingId) ;
if (targetElement.style.display == "none")
{
targetElement.style.display = "" ;
} else {
targetElement.style.display = "none" ;
}
}
</script>
<a href="javascript:visibilite('divid');"><u><font color="blue" size=2px><b>ENVOYER VOTRE CV A  <% =civilite%><%session("dest_civilite")=civilite%> &nbsp;&nbsp;<% =mid(nom,1,1)%><%session("dest_nom")=mid(nom,1,1)%>. &nbsp; <% =prenom%><%session("dest_prenom")=prenom%>&nbsp;&nbsp;</b> </font></u></a>

<div id="divid" style="display:none;">
<form action="verif_pa_consulter_emploi_stage_deposer.asp" method="post" id="cv" name="cv" OnSubmit="return verifform()" >
	 
                <table width="500" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  
                  
                  <tr> 
                    <td>Civilité</td>
                    <td><table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td> <input name="civilite" type="radio" value="madame" checked></td>
                          <td>Mme&nbsp; </td>
                          <td><input type="radio" name="civilite" value="mademoiselle"></td>
                          <td>Mlle&nbsp; </td>
                          <td><input type="radio" name="civilite" value="monsieur"></td>
                          <td>Mr&nbsp; </td>
                        </tr>
                      </table></td>
                  </tr>
				  
				  
				  <!----------------------age------------------->
				  
				  	 <tr>
				   <td align="left">Votre âge*&nbsp;&nbsp;</td>
				   <td>
				   <input style="width:30%" onkeypress="return fonc2()" name="age" type="text" maxlength="2">&nbsp;&nbsp;ans
				   <!--
				  <select id="dispo_jour" name="dispo_jour">
			    	<option value="01" selected>01</option>
					<option value="02" >02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
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
						
				-->
				   
				
						
					
				 
					</td>
					</tr>
				  
				  <!------------------ fin age--------------->
				  
				  
				  
				  
				  
				  
                  <tr> 
                    <td class="txt1">Nom *</td>
                    <td><input style="width:90%" name="nom" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Prenom *</td>
                    <td><input style="width:90%" name="prenom" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Adresse *</td>
                    <td><input style="width:90%" name="adresse" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Code Postal *</td>
					<td><input onkeypress="return fonc2()" style="width:90%" name="cp" type="text" maxlength="5"></td>
				  <tr> 
                    <td class="txt1">Ville *</td>
                    <td><input style="width:90%" name="ville" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Email *</td>
                    <td><input style="width:90%" name="email" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Téléphone *</td>
                    <td><input onkeypress="return fonc2()" style="width:90%" name="tel" type="num"></td>
                  </tr>
                  <tr> 
                    <td>Niveau de formation</td>
                    <td><table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td>
								<select name="niveau_formation">
					
					<option value="bac+1">Bac+1</option>
					<option value="bac+2" selected>Bac+2</option>
					<option value="bac+3">Bac+3</option>
					<option value="bac+4">Bac+4</option>
					<option value="bac+5_sup">Bac+5 ou sup</option>
					<option value="autres">Autres</option>
					</select>
						  </td>
                        </tr>
                      </table></td>
                  </tr>
				  <tr> 
                    <td class="txt1">Diplôme en cours *</td>
                    <td><input style="width:90%" name="diplome_en_cour" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Dernier diplôme  obtenu *</td>
                    <td><input style="width:90%" name="diplome_obtenu" type="text"></td>
                  </tr>
                  
                   <tr> 
                    <td class="txt1">Autre diplôme  </td>
                    <td><input style="width:90%" name="autre_diplome" type="text"></td>
                  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>
				  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
                  
                  <tr> 
                    <td>Intitulé de l'offre &nbsp;&nbsp;</td>
                    <td>&nbsp;&nbsp;<% =intitule%><%session("intitule_poste") = intitule%></td>
                  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				    <!--<tr> 
                    <td>Lieu du poste *&nbsp;&nbsp;</td>
                    <td>
					 <select id="lieu_du_poste" name="lieu_du_poste">
					 	
					<option value="Alsace" >Région Alsace</option>		
					<option value="Aquitaine" >Région Aquitaine</option>
					<option value="Auvergne">Région Auvergne</option>
					<option value="Basse-Normandie">Région Basse-Normandie</option>
					<option value="Bourgogne">Région Bourgogne</option>
					<option value="Bretagne">Région Bretagne</option>
					<option value="Centre">Région Centre</option>
					<option value="Champagne-Ardenne">Région Champagne-Ardenne</option>
					<option value="Corse">Région Corse</option>
					<option value="Franche-Comté">Région Franche-Comté</option>
					<option value="Guadeloupe">Région Guadeloupe</option>
					<option value="Guyane">Région Guyane</option>
					<option value="Haute-Normandie">Région Haute-Normandie</option>
					<option value="Ile-de-France">Région Ile-de-France</option>
					<option value="Languedoc-Roussillon">Région Languedoc-Roussillon</option>
					<option value="Limousin">Région Limousin</option>
					<option value="Lorraine">Région Lorraine</option>
					<option value="Martinique">Région Martinique</option>
					<option value="Midi-Pyrénées">Région Midi-Pyrénées</option>
					<option value="Nord-Pas-de-Calais">Région Nord-Pas-de-Calais</option>
					<option value="Pays-de-la-Loire">Région Pays-de-la-Loire</option>
					<option value="Picardie">Région Picardie</option>
					<option value="Poitou-Charentes">Région Poitou-Charentes</option>
					<option value="Provence-Alpes-Côte d'Azur">Région Provence-Alpes-Côte d'Azur</option>
					<option value="Réunion">Région Réunion</option>
					<option value="Rhône-Alpes" selected  >Région Rhône-Alpes</option>
					<option value="France entière" >France entière</option>
					<option value="Etranger" >Etranger</option>
					</select>
					
					
					</td>
                  </tr>
				  <tr>
				   <td align="left">Durée esperée*&nbsp;&nbsp;</td>
				   <td>
				  <select id="duree_esperee" name="duree_esperee">
					<option value="1000" selected >C.D.I</option>		
					<option value="15" >15 jours</option>
					<option value="30">1 mois</option>
					<option value="60">2 mois</option>
					<option value="90">3 mois</option>
					<option value="120">4 mois</option>
					<option value="150">5 mois</option>
					<option value="180">6 mois</option>
					<option value="270">9 mois</option>
					<option value="360">1 an et +</option>
						</select>
					</td>
					</tr>---->
					
					
					<!-----------------------test date--------------------------------------->
					
					
						 <tr>
				   <td align="left">Disponible à partir du*&nbsp;&nbsp;</td>
				   <td>
				  <select id="dispo_jour" name="dispo_jour">
			    	<option value="01" selected>01</option>
					<option value="02" >02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
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
						
				
				   
				  <select id="dispo_mois" name="dispo_mois">
					<option value="Janvier" selected >Janvier</option>		
					<option value="Février" >Février</option>
					<option value="Mars">Mars</option>
					<option value="Avril">Avril</option>
					<option value="Mai">Mai</option>
					<option value="Juin">Juin</option>
					<option value="Juillet">Juillet</option>
					<option value="Août">Août</option>
					<option value="Septembre">Septembre</option>
					<option value="Octobre">Octobre</option>
					<option value="Novembre">Novembre</option>
					<option value="Décembre">Décembre</option>
						</select>
						
					
				  <select id="dispo_annee" name="dispo_annee">
					<option value="2008" selected >2008</option>		
					<option value="2009" >2009</option>
					<option value="2010">2010</option>
					<option value="2011">2011</option>
					<option value="2012">2012</option>
				</select>
					</td>
					</tr>
					
					
					<!-----------------------------fin test date disponibilite------------------------>
					
					
				
				  
                  
                
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>                  
                  <tr> 
                    <td valign="top">Expériences professionnelles : <br/>
					</td>
					<td></td>
				  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>				  
				  <tr>
                    <td colspan="2" align="center"><textarea  
						onkeyup="this.value = this.value.slice(0, 10)" onchange="this.value = this.value.slice(0, 10)"

					type="text" style="width:90%" name="experience_pro" rows="10" maxlength="800"></textarea>
					
					</td>
                  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td valign="top">Commentaires : <br>
                  </td>
				  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
				  <tr>
                    <td colspan="2" align="center"><textarea  type="text" style="width:90%" name="commentaire" rows="10" maxlength="800"></textarea>
					
					</td>
                  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>
				  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td style="margin-top:2px;">Liens HTTP: <br>(liens vers vos projets, E-CV, etc...)<br>
                  </td>
                    <td><textarea type="text" style="width:90%" name="lien_http" rows="2"  maxlength="800"></textarea></td>
                  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
                   <!--<tr>
					<td colspan="2" width="670" valign="center">

	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester.asp">
	-->
	
	 <!--<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadT.asp">
	
	<B>Joindre un fichier <font color=red>( < 2Mo)</font></B><br><br>
     <input name="attach1" type="file" size=35><br>
	 </td>
                  </tr>	
	 <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>-->	
				  <tr>
					<td>&nbsp;
                    </td>					
                  <td>
					<table width=100%>
					<tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
					<tr>
					<td align="center">
					  <INPUT TYPE="BUTTON" style="width:75" VALUE="Retour"
               onClick="history.back()">
			   </td>
			   <td align="center">
					  <input name="valider" style="width:75" type="submit" value="Valider">
					  
					  </td></tr></table>
					</td>
                  </tr>
				  
                </table>
			 </form>
				
				
				
				</div>
				
				
				<!---------------------------FIN ENVOI MESSAGE------------------------------------------------->
				
				
			
				
				
				
	</td></tr><tr><td colspan="2"></td></tr></table>

	<!--           fin insertion  -->
		

 
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->
</html>