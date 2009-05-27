<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->

<link href="styles.css" rel="stylesheet" type="text/css" />
<script>
function visibilite(thingId)
{
var targetElement;
targetElement = document.getElementById(thingId) ;
if (targetElement.style.display == "none" )
{
targetElement.style.display = "" ;
} else {
targetElement.style.display = "none" ;
}
}
</script>
<SCRIPT LANGUAGE="Javascript1.1">
function fonc_print() { 
window.print(); 
} 

</SCRIPT>

<SCRIPT LANGUAGE="Javascript1.1">
function lightUp() { 
document.images["homeButton"].src="img racine/imp_no_border.jpg"
} 
function dimDown() { 
document.images["homeButton"].src="img racine/imp_no_border.jpg"
} 
</SCRIPT>


<script language="JavaScript">
function verifform()
{
 // Vérifie si l'âge est bien indiqué
  if(document.cv.age.value == "")
 {
  alert("\nMerci d'indiquer votre age.");
  document.cv.age.focus();
  return false;
 }

 // Vérifie si nom est bien indiqué
  if(document.cv.nom.value == "")
 {
  alert("\nMerci d'indiquer votre nom.");
  document.cv.nom.focus();
  return false;
 }

  // Vérifie si le prénom est bien indiqué
 if(document.cv.prenom.value == "")
 {
  alert("\nMerci d'indiquer votre prenom.");
  document.cv.prenom.focus();
  return false;
 }

  // Vérifie si l'adresse est bien indiqué
 if(document.cv.adresse.value == "")
 {
  alert("\nMerci d'indiquer votre adresse.");
  document.cv.adresse.focus();
  return false;
 }
 
   // Vérifie si le code postal est bien indiqué
 if(document.cv.cp.value == "")
 {
  alert("\nMerci d'indiquer votre code postal.");
  document.cv.cp.focus();
  return false;
 }
 
   // Vérifie si la ville est bien indiqué
 if(document.cv.ville.value == "")
 {
  alert("\nMerci d'indiquer votre ville.");
  document.cv.ville.focus();
  return false;
 }
 
   // Vérifie si le mail est bien indiqué
 if(document.cv.email.value == "")
 {
  alert("\nMerci d'indiquer votre mail.");
  document.cv.email.focus();
  return false;
 }
 
   // Vérifie si le tel est bien indiqué
 if(document.cv.tel.value == "")
 {
  alert("\nMerci d'indiquer votre numéro de téléphone.");
  document.cv.tel.focus();
  return false;
 }
 
    // Vérifie si le diplome en cours est bien indiqué
 if(document.cv.diplome_en_cour.value == "")
 {
  alert("\nMerci d'indiquer le diplome que vous êtes sur le point d'obtenir.");
  document.cv.diplome_en_cour.focus();
  return false;
 }
 
    // Vérifie si le dernier diplôme obtenu est bien indiqué
 if(document.cv.diplome_obtenu.value == "")
 {
  alert("\nMerci d'indiquer le dernier diplome que vous avez obtenu.");
  document.cv.diplome_obtenu.focus();
  return false;
 }
 
 
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





<script type="text/javascript" language="javascript" src="infobulle.js"></script>

</head>



<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_orange">CONSULTATION OFFRE</div>




<%

 if Request.QueryString("num") <> "" then
 
  sql="Select * from OFFRES,REGIONS where NumOff= " & Request.QueryString("num") & " and REGIONS.idRegion= OFFRES.LieuOff; "
  Response.Write sql     
  set RsOffreVisu = conn.execute(sql)
  
  
 if not RsOffreVisu.eof then

					  if RsOffreVisu("ProfilOff")=1 then 
							Profiloff="Emploi"
					  end if
					   if RsOffreVisu("ProfilOff")=2 then 
							Profiloff="Stage"
					  end if
					   if RsOffreVisu("ProfilOff")=3 then 
							Profiloff="Benevolat"
					  end if
					   if RsOffreVisu("ProfilOff")=4 then 
							Profiloff="Autre"
					  end if
					  
					  if RsOffreVisu("IndemniteOff")=1 then    
						indemnite="oui"  
					  else 
						indemnite="non"
					  end if
					  
 session("NumOff")=RsOffreVisu("NumOff")	  
  
  else 
  response.write("ce Cv n'existe pas dans notre base de donnée ")
  Response.Redirect("http://www.rhone-solidarite.com/pa_rech_emploi_stage.asp")

					  
 end if 
						  
 else 
					Response.Redirect("http://www.rhone-solidarite.com/pa_rech_emploi_stage.asp")
 end if

%>

<table style="background-repeat:no-repeat;" 
width="650" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">

<tr >
<td colspan="2" class="style"><br>
<h5>
<table class="txt">
<tr><td valign="top">&nbsp;Offre de : &nbsp;</td><td>&nbsp;<%=RsOffreVisu("RaisonSocEntOff")%> &nbsp;
<br>

&nbsp;<% =RsOffreVisu("AdrEntOff")%> &nbsp; 

<br>
&nbsp;<% =RsOffreVisu("CPEntOff")%>&nbsp; <%=RsOffreVisu("VilleEntOff")%>. &nbsp; 

</td></tr>

<tr><td >Contact :</td><td>&nbsp;<%=RsOffreVisu("CivilliteRespOff")%>&nbsp;<%=RsOffreVisu("NomRespOff")%>&nbsp;<%=RsOffreVisu("PrenomRespOff")%>  &nbsp; </td></tr>
<tr><td ></td><td>&nbsp;<font color="blue"><u><a href="mailto:<% =RsOffreVisu("MailRespOff")%>"><% =RsOffreVisu("MailRespOff")%></a></u></font>&nbsp; <br>&nbsp;<%=RsOffreVisu("TelRespOff")%>&nbsp;</td></tr>
<tr><td>&nbsp;Réf. offre : &nbsp;</td><td>&nbsp;<% =RsOffreVisu("RaisonSocEntOff")%> &nbsp;P08001</td></tr>
</table>
</h5>

</td>
</tr>

<tr>
<td><br> <div align="justify"><br />
                <table width="200" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  
                   <tr> 
                    
                    <td colspan="2">
                    </td>
                    <td></td>
                  </tr>
                  
                  <tr> 
                    
                    <td colspan="2" align="center">
                    <div class="paragraphebordseul">
                    &nbsp;&nbsp;<font color="black"><%=Profiloff%>&nbsp;&nbsp;<%=RsOffreVisu("IntituleOff")%>&nbsp;&nbsp;&nbsp;<%=RsOffreVisu("DureeOff")%>&nbsp</font> 
                    
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
                    <td><%=RsOffreVisu("DescOff")%></td>
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
                    <td><% =RsOffreVisu("nomRegion")%></td>
                  </tr>
                  
                   <tr> 
                    <td><font color="#969696">Précision du Lieu du poste :</font></td>
                    <td><% =RsOffreVisu("VilleOff")%></td>
                  </tr>
               
                  
                  <tr> 
                    <td><font color="#969696">Durée du contrat :</font></td>
                    <td><% =RsOffreVisu("DureeOff")%></td>
                  </tr>
                  <tr> 
                    <td><font color="#969696">Indemnité :</font></td>
                    <td><%=indemnite%></td>
                  </tr>
                  <tr> 
                    <td><font color="#969696">Montant de l'indemnité :</font></td>
                    <td><% =RsOffreVisu("MontantOff")%></td>
                  </tr>
                  
     
                  <tr> 
                    <td class="txt1"><font color="#969696">Autres indemnités :</font></td>
                    <td><% =RsOffreVisu("AutIndOff")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Document à fournir :</font></td>
                    <td><% =RsOffreVisu("DocOff")%></td>
                  </tr>
                  
                   <tr> 
                    <td class="txt1"><font color="#969696">Date parution de l'annonce  :</font></td>
                    <td><%=RsOffreVisu("DateOff")%></td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
        
                  
                  
                   <tr>
                    <td colspan="2">
                    <table width=100%>
                    <tr>
                    <td align="center">
                    
                


                     </td>
                      </td></tr>
                      </table>
                    </td>
                  </tr>
                  
                  <tr><td> <br>
    
 
 <br><div align="right" >
<IMG SRC="img racine/imp_no_border.jpg" onclick= "return fonc_print()" name="homeButton"  border="0"  onmouseOver="lightUp();" onmouseOut="dimDown();">
 
 </div></td></tr>
                  
                  
                </table>
                
                 <br> <br>
                
<a href="javascript:visibilite('divid');"><u><font color="blue" size=2px><b>ENVOYER VOTRE CV A  <%=RsOffreVisu("CivilliteRespOff")%> &nbsp;&nbsp;<%=RsOffreVisu("NomRespOff")%> &nbsp; <% =RsOffreVisu("PrenomRespOff")%>&nbsp;&nbsp;</b> </font></u></a>

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
                  
                  
                  <!--age-->
        

                    <tr>
                        <td class="textes">Age *</td>
                        <td><input style="width:90%" name="age" class="txt" id="age" size="30" maxlength="2"  value="<%=session("age")%>" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/></td>
                    </tr>
                  <!--fin age--->
                      
                  <tr> 
                    <td class="txt1">Nom *</td>
                    <td><input style="width:90%" name="nom" type="text" value="<%=session("admin_nom")%>"></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1">Prenom *</td>
                    <td><input style="width:90%" name="prenom" type="text" value="<%=session("admin_prenom")%>"></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1">Adresse *</td>
                    <td><input style="width:90%" name="adresse" type="text" value="<%=session("admin_adresse")%>"></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1">Code Postal *</td>
                    <td><input style="width:90%" name="cp" class="txt" id="cp" size="30" maxlength="6" value="<%=session("admin_cp")%>" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/></td>
                  </tr>
                    
                  <tr>
                    <td class="txt1">Ville *</td>
                    <td><input style="width:90%" name="ville" id="ville" type="text" value="<%=session("admin_ville")%>"></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1">Email *</td>
                    <td><input style="width:90%" name="email" type="text" value="<%=session("admin_email")%>"></td>
                  </tr>
                 
                  <tr> 
                    <td class="txt1">Téléphone *</td>
                    <td><input style="width:90%" name="tel" class="txt" id="te" size="30" value="<%=session("admin_tel")%>" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/></td>
                  </tr>
                    
                  <tr> 
                    <td>Niveau de formation</td>
                    <td><table  border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td>
                                <select name="niveau_formation" id="niveau_formation">
                    
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
                    <td colspan="2">&nbsp;</td>
                  </tr> 
                    
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