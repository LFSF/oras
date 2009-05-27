<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<% if not(Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_interview_modif.asp") then
	response.redirect("http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp")
else
%>
<!-- #include file="connexion.asp"-->

<%


'Dim rsCat
'Set rsCat = Conn.Execute("SELECT * FROM t_actualites WHERE auteur = " & Request.Querystring("auteur") & "")



Dim rsE

'edP = "SELECT * FROM t_actualites WHERE N° = " & Request.Querystring("N°") & ""

Set rsE = Conn.Execute("SELECT * FROM INTERVIEW WHERE  NumItw = " & Request.Querystring("num") & "")

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

<script language="JavaScript">
function verifform()
{
 if(document.intw.rs.value == "")
  {
   alert("Merci d'indiquer le nom de l'entreprise ou organisme.");
   document.intw.rs.focus();
   return false;
  }
 if(document.intw.adresse.value == "")
  {
   alert("Merci d'indiquer une adresse.");
   document.intw.adresse.focus();
   return false;
  }
   if(document.intw.cp.value == "")
  {
   alert("Merci d'indiquer le code postal (99 si hors de france).");
   document.intw.cp.focus();
   return false;
  }
   if(document.intw.ville.value == "")
  {
   alert("Merci d'indiquer la ville.");
   document.intw.ville.focus();
   return false;
  }
   if(document.intw.pays.value == "")
  {
   alert("Merci d'indiquer le pays.");
   document.intw.pays.focus();
   return false;
  }
   if(document.intw.responsable.value == "")
  {
   alert("Merci d'indiquer le nom de responsable .");
   document.intw.responsable.focus();
   return false;
  }
  if(document.intw.prenom_responsable.value == "")
  {
   alert("Merci d'indiquer le prénom du responsable .");
   document.intw.prenom_responsable.focus();
   return false;
  }
   if(document.intw.email.value == "")
  {
   alert("Merci d'indiquer une adresse email.");
   document.intw.email.focus();
   return false;
  }
 adresse_email = document.intw.email.value;
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
    document.intw.email.focus();
	return false;
	}
   if(document.intw.tel.value == "")
  {
   alert("Merci d'indiquer un téléphone.");
   document.intw.tel.focus();
   return false;
  }
   if(document.proposer.intitule.value == "")
  {
   alert("Merci d'indiquer l'intitulé de l'offre.");
   document.proposer.intitule.focus();
   return false;
  }
   if(document.proposer.description.value == "")
  {
   alert("Merci d'indiquer la description de l'offre.");
   document.proposer.description.focus();
   return false;
  }
   if(document.proposer.duree_contrat.value == "")
  {
   alert("Merci d'indiquer la durée du contrat de l'offre.");
   document.proposer.duree_contrat.focus();
   return false;
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
<style type="text/css">
div.alien{cursor:hand}

</style>
</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Modification Interview ______________________________________________________</font></td>
    </tr>
				<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin_interview_modif.asp"><font size=1><b>
                         << Retour Menu Interview &nbsp;</b></font>
                          </a></td></tr></table>


<form action="p_admin_interview_modif_editbis.asp" method="post"id="intw" name="intw" OnSubmit="return verifform()">
<input type="hidden" name="test" value="oui">
<table  border="0" align="center">
	
	<tr>
	<td>
  
	
	
	
			<table  border="0" align="center">
		<tr valign="top">
			
                  <td width="100"><STRONG>L'interviewé :</STRONG></td>		
	</tr >
				  
				  </td>
	</tr>			
</table>

    <br>
 <br> 

			
			
			<tr> 
                    <td align="left">Vous êtes un(e)</td>
                    <td> <table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
						<% if rsE("StatutEnt")= "Entreprise" then %>
                          <td> <input name="statut" type="radio" value="Entreprise" checked="checked"></td>
						   <td>Entreprise&nbsp; </td>
						<%else%>
						    <td> <input name="statut" type="radio" value="Entreprise" ></td>
						
                          <td>Entreprise&nbsp; </td>
						  <%end if%>
						  
						 <% if rsE("StatutEnt")= "ONG" then %>
						 <td> <input type="radio" name="statut" value="ONG" checked="checked"></td>
						 <td>ONG&nbsp; </td>
						<%else%>
                          <td><input type="radio" name="statut" value="ONG" ></td>
                          <td>ONG&nbsp; </td>
						  <%end if%>
						  
						  <% if rsE("StatutEnt")= "Collectivité locale" then %>
						    <td><input type="radio" name="statut" value="Collectivité locale" checked="checked" ></td>
                          <td>Collectivité locale&nbsp; </td>
						  <%else%>
						  <td><input type="radio" name="statut" value="Collectivité locale" ></td>
                          <td>Collectivité locale&nbsp; </td>
						  <%end if%>
						  
						  <% if rsE("StatutEnt")= "Autre" then %>
						  <td><input type="radio" name="statut" value="Autre" checked="checked" ></td>
						  <td>Autre&nbsp; </td>
						  <%else%>
						 <td><input type="radio" name="statut" value="Autre"  ></td>
						  <td>Autre&nbsp; </td>
						  <%end if%>
						  
						
						 
                        </tr>
                      </table></td>
                  </tr>

                  <tr> 
                    <td align="left" class="txt1">Raison sociale *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="rs" id="rs" type="text" checked  Maxlength="30" value="<%=rsE("RaiSocEnt")%>"> </td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Adresse *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="adresse" type="text" Maxlength="50" value="<%=rsE("AdrEnt")%>"></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Code Postal *&nbsp;&nbsp;</td>
                          <td><input  onkeypress="return fonc2()" style="width:90%" name="cp" type="text" Maxlength="7" value="<%=rsE("CPEnt")%>"></td>
				</tr>
				<tr>
                   <td align="left" class="txt1">Ville *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="ville" type="text" id="ville" Maxlength="30" value="<%=rsE("VilleEnt")%>"></td>
                     </tr>
					<tr>
                   <td align="left" class="txt1">Pays *&nbsp;&nbsp;</td>
                          <td><input style="width:90%" name="pays" type="text" id="pays" Maxlength="30" value="<%=rsE("PaysEnt")%>"></td>
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
						
						<% if rsE("CiviliteRespEnt")= "Madame" then %>
						  <td> <input name="civilite" type="radio" value="Madame" checked="checked"></td>
                          <td>Mme&nbsp; </td>
						  <%else%>
						 <td> <input name="civilite" type="radio" value="Madame" ></td>
                          <td>Mme&nbsp; </td>
						  <%end if%>
						
						<% if rsE("CiviliteRespEnt")= "Mademoiselle" then %>
						 <td><input type="radio" name="civilite" value="Mademoiselle" checked="checked" ></td>
                          <td>Mlle&nbsp; </td>
						  <%else%>
						 <td><input type="radio" name="civilite" value="Mademoiselle" ></td>
                          <td>Mlle&nbsp; </td>
						  <%end if%>
						  
						  <% if rsE("CiviliteRespEnt")= "Monsieur" then %>
					 <td><input type="radio" name="civilite" value="Monsieur" checked="checked"  ></td>
                          <td>Mr&nbsp; </td>
						  <%else%>
						 <td><input type="radio" name="civilite" value="Monsieur"  ></td>
                          <td>Mr&nbsp; </td>
						  <%end if%>
						  
                          
                         
                          
                        </tr>
                      </table></td>
                  </tr>
				  


				  
                  <tr> 
                    <td align="left" class="txt1">Nom du responsable *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="responsable" type="text" Maxlength="30" value="<%=rsE("NomRespEnt")%>"></td>
                  </tr>
				  
				  <tr> 
                    <td align="left" class="txt1">Prénom du responsable *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="prenom_responsable" type="text" Maxlength="30" value="<%=rsE("PrenomRespEnt")%>"></td>
                  </tr>
				  <tr> 
                    <td align="left" class="txt1">Email *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="email" type="num" Maxlength="30" value="<%=rsE("MailRespEnt")%>"></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Téléphone *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="tel" type="num" Maxlength="30" value="<%=rsE("TelRespEnt")%>"></td>
                  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
				  <tr> 
                    <td align="left" class="txt1">Titre de l'interview *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="titre_interview" type="text"  value="<%=rsE("DescriptionItw")%>"></td>
                 
					
				 </tr>
				  <tr> 
                  <td align="left" class="txt1">Date de l'interview *&nbsp;&nbsp;</td>
                  <td><input style="width:90%" type="text" name="date_interview" value="<%=rsE("DateItw")%>"></td>
                </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" align="center" valign="top">__________________________________________________</td>
				  </tr></table>
				   <br>
 <br> <%session("num")=rsE("NumItw")%>
				  <center>
                   <input type="hidden" name="num" value="<%=rsE("NumItw")%>"><INPUT style="WIDTH: 153px; HEIGHT: 24px;color:blue;" type=submit size=51 value=Suivant id=submit1 name=submit1></center>
                   
	
	<br>
 <br>
	
	
</form>						  
						  

            </td>
        </tr>
      </table></td>
  </tr>
  
  <!--fin corps de texte-->
		
		
		
		<!--           fin insertion  -->
		


 
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  


</body>
</html>
<% end if %>
<%end if %>