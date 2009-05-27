<html>
<head>
<title>Rhône-solidarité</title>

<link rel="stylesheet" href="style.css" type="text/css">
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
 
 function fonc_print()
{
window.print();
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

<body  bgcolor="#bcbaa6" onLoad="init()" leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >

<!-- #include file="tmoitiehaute1.asp"-->





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




	Verif = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= " & Server.MapPath("bd/bd_rs.mdb")

 Set connv = Server.CreateObject("ADODB.Connection")
 connv.Open Verif
 Set rsv = Server.CreateObject("ADODB.RecordSet")
       

 'SQL1 = "Select * from contact_organisme where journee12mai='non'"
 
 'SQL1 = "Select * from t_depotcv where visible_sur_site='oui' order by profil "
 
 
 'SQL1 = "Select * from t_depotcv where num='" & request("num") 

  SQL1 = "Select * from T_proposer where num= " & request("num") 
 
  rsv.PageSize=100
  rsv.open SQL1,connv,1,3 
  rsv.AbsolutePage =session("numeropage")





for i=1 to rsv.PageSize
					
					'id_login = rsv.fields("login").value
					'id_password =rsv.fields("passe").value
					num =rsv.fields("num").value
					duree_offre =rsv.fields("duree_offre").value
					statut =rsv.fields("statut").value
					raison_sociale =rsv.fields("raison_sociale").value
					adresse =rsv.fields("adresse").value
					cp= rsv.fields("cp").value
					ville = rsv.fields("ville").value
					civilite = rsv.fields("civilite").value
					nom = rsv.fields("nom_responsable").value
					prenom = rsv.fields("prenom_responsable").value
					email = rsv.fields("email")
					tel = rsv.fields("tel")
					profil = rsv.fields("profil")
					
					intitule = rsv.fields("intitule")
					lieu = rsv.fields("lieu")
					precision_lieu = rsv.fields("precision_lieu")
					description = rsv.fields("description")
					duree_contrat = rsv.fields("duree_contrat")
					indemnite = rsv.fields("indemnite")
					doc_a_fournir = rsv.fields("doc_a_fournir")
					montant_indemnite = rsv.fields("montant_indemnite")
					autres_indemnites = rsv.fields("autres_indemnites")
					date_inscription = rsv.fields("date_inscription")		
					
				
			'session("dest_numcv")=numcv
			'session("dest_nom")=nom
			'session("dest_prenom")=prenom
			'session("dest_civilite")=civilite
			'session("dest_email")=email
			'session("dest_poste_recherche")=intitule




	
if rsv.fields("duree_contrat")="1000" then
   session("duree_offre_emploi")="C.D.I"
end if

if rsv.fields("duree_contrat")="15" then
   session("duree_offre_emploi")="15 jours"
end if
		
		if rsv.fields("duree_contrat")="30" then
   session("duree_offre_emploi")="1 mois"
end if
		
		if rsv.fields("duree_contrat")="60" then
   session("duree_offre_emploi")="2 mois"
end if
		
		if rsv.fields("duree_contrat")="90" then
   session("duree_offre_emploi")="3 mois"
end if
		
		if rsv.fields("duree_contrat")="120" then
   session("duree_offre_emploi")="4 mois"
end if
		
		if rsv.fields("duree_contrat")="150" then
   session("duree_offre_emploi")="5 mois"
end if
		
		if rsv.fields("duree_contrat")="180" then
   session("duree_offre_emploi")="6 mois"
end if
		
		if rsv.fields("duree_contrat")="270" then
   session("duree_offre_emploi")="9 mois"
end if
		if rsv.fields("duree_contrat")="360" then
   session("duree_offre_emploi")="1 an minimum"
end if			
					
							
				
				
					
						

		
					 
					
					%>


<table background="img/p_annonce4.gif" style="background-repeat:no-repeat;" 
width="650" border="0" cellspacing="0" cellpadding="0" 
 class="txt2" valign="top">

<tr >
<td colspan="2" class="style"><br>
<h5>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
<tr><td>&nbsp;Réf. offre : &nbsp;</td><td>&nbsp;<% =raison_sociale%> &nbsp;P08001</td></tr>
</table>

</h5>




</td>
</tr>



<tr>
<td><br>   <center>
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
					&nbsp;&nbsp;<font color="black"><%=profil%>&nbsp;&nbsp;<% =intitule%>&nbsp;&nbsp;&nbsp;<%=rsv.fields("duree_contrat")%>&nbsp</font> 
					
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
                    <td><font color="#969696">Lieu du poste :</font></td>
                    <td><% =lieu%></td>
                  </tr>
				  
				   <tr> 
                    <td><font color="#969696">Précision du Lieu du poste :</font></td>
                    <td><% =precision_lieu%></td>
                  </tr>
				  
				  
				  <tr> 
                    <td><font color="#969696">Duée du contrat :</font></td>
                    <td><% =rsv.fields("duree_contrat")%></td>
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
				  
				  
				   <tr> 
                    <td><font color="#969696">Disponibilite à partir du :</font></td>
                    <td>
					
					
					</td>
                  </tr>  
					<tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Expériences professionnelles : </font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2">
					
					</td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Commentaires : </font><br><br><br>&nbsp;
                  </td>
				  </tr>
				  
				  <tr>
                    <td colspan="2">
					
					</td>
                  </tr>
				  
				  
				  
				  
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  

				  
				  <tr>
					<td class="textes"><font color="#969696">Fichier joint &nbsp;</font><br><br>&nbsp;</td><td>&nbsp;</td></tr>
					<tr>
					<td colspan="2"><% =joindre_fichier%></td>
					<td></td>
				  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  <tr> 
                    <td colspan="2" style="margin-top:2px;"><font color="#969696">Liens HTTP vers mes projets, E-CV , etc... :</font><br><br>&nbsp;
                  </td>
				  <td >&nbsp;
                  </td>
				  </tr>
				  <tr>
				  
                    <td colspan="2"><% =lien_http%></td>
					 <td></td>
                  </tr>
				  
				  
				  ---->
				  
				  <%
					
					session("lecompteur")=compteur	
						'Response.Write(session("lecompteur"))
					
					rsv.MoveNext 
					
		if rsv.EOF  then exit for
	next
	 set connv=nothing%>
				  
				  
				  
				  
				  
				  
				  
                  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
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
				  
                </table>
				
				
				<!------------------------------ENVOI  MESSAGE------------------------------------------------->
			

			<div onClick="return fonc_print()"><img src="img/gif_anime/gifs_imprimante.gif"> </div>&nbsp;&nbsp;&nbsp;


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
<a href="javascript:visibilite('divid');"><u><font color="blue" size=2px><b>ENVOYER UN MESSAGE à  <% =civilite%> &nbsp;&nbsp;<% =prenom%> &nbsp; <% =mid(nom,1,1)%>.&nbsp;&nbsp;</b> </font></u></a>

<div id="divid" style="display:none;">
<form action="pa_consulter_cvter.asp" method="post" name="mess" OnSubmit="return verifformbis()">
               
			 <table width="550" border="1"  cellpadding="0" cellspacing="0" class="txt">
                  <tr> <td>&nbsp;&nbsp;<center>
			   <table width="500"   cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td align="right"><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
				 
				 
				 
				
                  <tr> 
                    <td align="left">Structure</td>
                    <td> <table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td> <input name="statut" type="radio" value="Entreprise" checked ></td>
                          <td>Entreprise&nbsp; </td>
                          <td><input type="radio" name="statut" value="ONG"></td>
                          <td>ONG&nbsp; </td>
						  <td><input type="radio" name="statut" value="Collectivité local"></td>
                          <td>Collectivité locale&nbsp; </td>
						  <td><input type="radio" name="statut" value="Autre"></td>
						  <td>Autre&nbsp; </td>
                        </tr>
                      </table></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Raison social *&nbsp;&nbsp;</td>
                    <td><input style="width:100%" name="rs" id="rs" type="text" checked  Maxlength="30"> </td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Adresse *&nbsp;&nbsp;</td>
                    <td><input style="width:100%" name="adresse" type="text" Maxlength="50"></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Code Postal *&nbsp;&nbsp;</td>
                          <td><input style="width:100%" name="cp" onKeyPress="return fonc2()" type="text" Maxlength="7"></td>
				</tr>
                   <td align="left" class="txt1">Ville *&nbsp;&nbsp;</td>
                          <td><input style="width:100%" name="ville" type="text" id="ville" Maxlength="30"></td>
                        </tr>
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




				  
                  <tr> 
                    <td align="left" class="txt1">Nom du responsable *&nbsp;&nbsp;</td>
                    <td><input style="width:100%" name="nom_responsable" type="text" Maxlength="30"></td>
                  </tr>
				  
				  <tr> 
                    <td align="left" class="txt1">Prénom du responsable *&nbsp;&nbsp;</td>
                    <td><input style="width:100%" name="prenom_responsable" type="text" Maxlength="30"></td>
                  </tr>
				  <tr> 
                    <td align="left" class="txt1">Email *&nbsp;&nbsp;</td>
                    <td><input style="width:100%" name="email" type="num" Maxlength="30"></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Téléphone *&nbsp;&nbsp;</td>
                    <td><input style="width:100%" name="tel" onKeyPress="return fonc2()" type="num" Maxlength="30"></td>
                  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" align="center" valign="top">__________________________________________________</td>
				  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	


			
				  
				   <tr> 
                    <td align="left" class="txt1">Votre message *&nbsp;&nbsp;</td>
                    <td><textarea style="width:100%" name="message" rows="7"></textarea></td>
                  </tr>
				 
						  
				  
				  
				  
				  
				  
                  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td align="center">
				
					</td>
					<td align="center">  
					 <input name="effacer" type="reset" value="Effacer"id="effacer" >
				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="valider" type="submit" value="Valider" id="valider" >
				
					 
					</td>
                  </tr>
                </table>
				</center>
				&nbsp;&nbsp;</td></tr></table>
			 </form>
				
				
				
				</div>
				
				
				<!---------------------------FIN ENVOI MESSAGE------------------------------------------------->
				
				
			
				
				
				</center>
	</td></tr><tr><td colspan="2"></td></tr></table>

<table width="670" border="0" align="center" valign="center" class="txt">
	<tr>
		<td width="670" valign="bottom">_______________________________________________________________________________________________________________</td>
	</tr>
	<tr>
		<td valign="center">
		
		</td>
	</tr>
</table>

 <center><DIV class=paragraphe1  ></center>
 
                        <!------ fin corps de texte-------------------->
                         
  </td></tr><tr><td><!----#include file="Tmoitiebasse.asp"----></td></tr>
  
  <div id="bulle"></div> 
  
 </body>
</html>