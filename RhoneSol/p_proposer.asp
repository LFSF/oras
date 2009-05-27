<?xml version="1.0" encoding="iso-8859-1"?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <!-- #include file="grand_meta.txt"-->
    <!-- #include file="connexion.asp"-->
    <title>Rhône-solidarité</title>

    <link href="styles.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript">
    function verifform()
    {
     if(document.proposer.rs.value == "")
      {
       alert("Merci d'indiquer le nom de votre entreprise ou organisme.");
       document.proposer.rs.focus();
       return false;
      }
     if(document.proposer.adresse.value == "")
      {
       alert("Merci d'indiquer votre adresse.");
       document.proposer.adresse.focus();
       return false;
      }
       if(document.proposer.cp.value == "")
      {
       alert("Merci d'indiquer votre code postal (99 si hors de france).");
       document.proposer.cp.focus();
       return false;
      }
       if(document.proposer.ville.value == "")
      {
       alert("Merci d'indiquer votre ville.");
       document.proposer.ville.focus();
       return false;
      }
       if(document.proposer.responsable.value == "")
      {
       alert("Merci d'indiquer le nom de responsable .");
       document.proposer.responsable.focus();
       return false;
      }
      if(document.proposer.prenom_responsable.value == "")
      {
       alert("Merci d'indiquer le prénom du responsable .");
       document.proposer.prenom_responsable.focus();
       return false;
      }
       if(document.proposer.email.value == "")
      {
       alert("Merci d'indiquer votre adresse email.");
       document.proposer.email.focus();
       return false;
      }
     adresse_email = document.proposer.email.value;
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
        document.proposer.email.focus();
        return false;
        }
       if(document.proposer.tel.value == "")
      {
       alert("Merci d'indiquer votre téléphone.");
       document.proposer.tel.focus();
       return false;
      }
       if(document.proposer.intitule.value == "")
      {
       alert("Merci d'indiquer l'intitulé de l'offre.");
       document.proposer.intitule.focus();
       return false;
      }
	  
	  if(document.proposer.lieu.value == "")
	  {
	   alert("Merci de preciser le lieu de l'offre")
	   document.proposer.lieu.focus();
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
    <%
    'Requête qui récupère les données de l'entreprise afin de préremplir les champs
    if session("NumMembre") <> "" then
    Set rsED = Conn.Execute("SELECT * FROM MEMBRE WHERE NumMembre = " & session("NumMembre") & "")
    end if
    %>
    

</head>
 <body>


<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_orange">DEPOSER UNE OFFRE!</div>
<table border="0px" width="100%" cellpadding="10px">
<tr>
    <td><a class=lien href="p_annonces.asp">
               <font size=1><b><< Retour </b></font>
        </a>
    </td>
</tr>
<tr>
<td colspan="2"><font color="#6FAA06">Formulaire Offre____________________________________________________________________</font></td>
</tr>
</table>

<!-- //
INSERTION  TABLE FORMULAIRE A MODIFIER
 // -->
<table width="583" border="0" cellspacing="0" cellpadding="0" align="center" valign="center" class="txt2">
<tr>
<td width="439" valign="top" class="txt">
<div align="justify">

<form action="verif_proposer.asp" method="post" name="proposer" OnSubmit="return verifform()">
                <table width="500" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td align="right"><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                   <td align="left">Validité de l'offre</td>
                   <td>

                  <select name="duree_offre">
                    <option value="15" >15 jours</option>
                    <option value="30"selected="selected">1 mois</option>
                    <option value="60">2 mois</option>
                    <option value="90">3 mois</option>
                    <option value="120">4 mois</option>
                    <option value="180">6 mois</option>
                        </select>
                    </td>
                    </tr>

                  <tr> 
                    <td align="left">Vous êtes un(e)</td>
                    <td> <table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td> <input name="statut" type="radio" value="Entreprise"  checked="checked"></td>
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
                    <td align="left" class="txt1">Raison sociale *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="rs" id="rs" type="text" checked="checked"  Maxlength="30"> </td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Adresse *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="adresse" type="text" Maxlength="50" ></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Code Postal *&nbsp;&nbsp;</td>
                          <td><input   style="width:90%" name="cp" type="text" Maxlength="5" 
                          onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"
                    
                          ></td>
                </tr>
                   <td align="left" class="txt1">Ville *&nbsp;&nbsp;</td>
                          <td><input style="width:90%" name="ville" type="text" id="ville" Maxlength="30" ></td>
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
                          <td> <input name="civilite" type="radio" value="Madame" checked="checked" ></td>
                          <td>Mme&nbsp; </td>
                          <td><input type="radio" name="civilite" value="Mademoiselle"></td>
                          <td>Mlle&nbsp; </td>
                          <td><input type="radio" name="civilite" value="Monsieur"></td>
                          <td>Mr&nbsp; </td>
                        </tr>
                      </table></td>
                  </tr>
                  

                  
                  <tr> 
                    <td align="left" class="txt1">Nom du responsable *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="responsable" type="text" Maxlength="30"></td>
                  </tr>
                  
                  <tr> 
                    <td align="left" class="txt1">Prénom du responsable *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="prenom_responsable" type="text" Maxlength="30"></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Email *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="email" type="num" Maxlength="30"></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Téléphone *&nbsp;&nbsp;</td>
                    <td><input  style="width:90%" name="tel" type="num" Maxlength="30"
                    
                    onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"
                    
                    ></td>
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
                    <td align="left">Profil Recherché</td>
                    <td> <table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td> <input name="profil" type="radio" value="Emploi"></td>
                          <td>Emploi&nbsp; </td>
                          <td><input type="radio" name="profil" value="Stage"  checked="checked" ></td>
                          <td>Stage&nbsp; </td>
                           <td><input type="radio" name="profil" value="Benevolat"></td>
                          <td>Bénévolat&nbsp; </td>
                          <td><input type="radio" name="profil" value="Autre"></td>
                          <td>Offre divers&nbsp; </td>
                        </tr>
                      </table></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Intitulé du poste *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="intitule" type="text" Maxlength="50"></td>
                  </tr>
                  
                  <tr> 
                    <td align="left" class="txt1">Lieu du poste *&nbsp;&nbsp;</td>
                          

                               
                    <td>
                     <select id="lieu" name="lieu">
                     <%
                                       Dim lesRegions()
                                       taille=1

                                       Set rs = Conn.Execute("SELECT * FROM REGIONS;")

                                       While not rs.EOF
                                              redim preserve lesRegions(taille)
                                              taille=taille+1
                                              lesRegions(taille-1)=rs("nomRegion")
                                              

                                       Rs.MoveNext
                                       Wend

                                       rs.Close

                                       Response.Write "<option value="""" selected>"&Server.HtmlEncode("France entière")&"</option>"
                                       
                                       for i=1 to UBound(lesRegions)
                                              Response.Write "<option value="""&i&""">"&Server.HtmlEncode(lesRegions(i))&"</option>"
                                       Next

                    %>
                    </select>
                    
                    
                    </td>
                  </tr>
                  
                  
                   <tr> 
                    <td align="left" class="txt1">Précisez la ville ou le Pays *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="precision_lieu" type="text" Maxlength="20"></td>
                  </tr>
                  
                  
                  <tr>
                   <td align="left">Durée du contrat*&nbsp;&nbsp;</td>
                   <td>
                  <select name="duree_contrat">
                    <option value="15" >15 jours</option>
                    <option value="30"selected="selected">1 mois</option>
                    <option value="60">2 mois</option>
                    <option value="90">3 mois</option>
                    <option value="120">4 mois</option>
                    <option value="150">5 mois</option>
                    <option value="180">6 mois</option>
                    <option value="270">9 mois</option>
                    <option value="360">1 an et +</option>
                    <option value="1000">C.D.I</option>
                        </select>
                    </td>
                    </tr>
                  
                  
                  
                   <tr> 
                    <td align="left" class="txt1">Description du poste *&nbsp;&nbsp;</td>
                    <td><textarea style="width:90%" name="description" rows="5"></textarea></td>
                  </tr>
                 
                <!--
                 <tr> 
                    <td align="left" class="txt1">Durée du contrat *&nbsp;&nbsp;</td>
                    <td><input style="width:100%" name="duree_contrat" type="text"></td>
                  </tr>
                  -->
                  
                  
                   <tr> 
                    <td align="left" class="txt1">Documents à fournir &nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="doc_a_fournir" type="text" Maxlength="100"></td>
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
                    <td align="left">Indemnité </td>
                    <td> <table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td> <input name="indemnite" type="radio" value="oui" checked="checked"></td>
                          <td>Oui&nbsp; </td>
                          <td><input type="radio" name="indemnite" value="non"></td>
                          <td>Non&nbsp; </td>
                        </tr>
                        
                         
                        
                      </table></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Montant de l'indemnité&nbsp;&nbsp;</td>
                    <td><input style="width:30%" name="montant_indemnite" type="text" Maxlength="10" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;">&nbsp; euros / mois</td>
                  </tr>
                  
                  
                   <tr> 
                    <td align="left" class="txt1">Autres indemnités&nbsp;&nbsp;</td>
                    <td><input   style="width:90%" name="autres_indemnites" type="text" Maxlength="100"></td>
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
             </form></center>
    </td></tr>
    <tr><td colspan="2">* (mention obligatoire)</td></tr></table>


 <!-- 
Ne pas toucher Ã  ce qui suit : placement du footer 
-->
<!-- #include file="grand_footer.txt"-->

</div>
</body>
<!-- #include file="deconnexion.asp"-->
</html>