<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <!-- #include file="grand_meta.txt"-->
    <!-- #include file="connexion.asp"-->
    <title>Rh�ne-solidarit�</title>

    <link href="styles.css" rel="stylesheet" type="text/css" />
    <%
    'Connexion BD

    'Requ�te qui r�cup�re les donn�es de l'interview (Titre, personne de l'interview, Nom organisation)
    Set rsED = Conn.Execute("SELECT * FROM MEMBRE WHERE Entreprise=0")

%>

    <script language="JavaScript" type="text/javascript">

    function verifform()
    {

     if(document.cv.age.value == "")
      {
       alert(" Merci d'indiquer votre �ge.");
       document.cv.age.focus();
       return false;
      }

     if(document.cv.nom.value == "")
      {
       alert(" Merci d'indiquer votre nom.");
       document.cv.nom.focus();
       return false;
      }
      
      if(document.cv.prenom.value == "")
      {
       alert("Merci d'indiquer votre prenom.");
       document.cv.prenom.focus();
       return false;
      }
      
       if(document.cv.adresse.value == "")
      {
       alert("Merci d'indiquer votre adresse .");
       document.cv.adresse.focus();
       return false;
      }
       if(document.cv.cp.value == "")
      {
       alert("Merci d'indiquer votre code postal (99 si hors de france).");
       document.cv.cp.focus();
       return false;
      }
       if(document.cv.ville.value == "")
      {
       alert("Merci d'indiquer votre ville.");
       document.cv.ville.focus();
       return false;
      }
      
       if(document.cv.email.value == "")
      {
       alert("Merci d'indiquer votre adresse email.");
       document.cv.email.focus();
       return false;
      }
     if(document.cv.email.value.indexOf('@') == -1)
      {
       alert("Merci d'indiquer une adresse �lectronique valable.");
       document.cv.email.focus();
       return false;
      }
      
       if(document.cv.tel.value == "")
      {
       alert("Merci d'indiquer votre t�l�phone.");
       document.cv.tel.focus();
       return false;
      }
      
      
         if(document.cv.diplome_en_cour.value == "")
      {
       alert("Merci d'indiquer le dipl�me en cours.");
       document.cv.diplome_en_cour.focus();
       return false;
      }
      
         if(document.cv.diplome_obtenu.value == "")
      {
       alert("Merci d'indiquer le dipl�me que vous avez obtenu.");
       document.cv.diplome_obtenu.focus();
       return false;
      }
           if(document.cv.intitule_poste.value == "")
      {
       alert("Merci d'indiquer l'intitul� du poste.");
       document.cv.intitule_poste.focus();
       return false;
      }
      
       if(document.cv.mdp.value == "")
      {
       alert("Merci d'indiquer votre mot de passe.");
       document.cv.mdp.focus();
       return false;
      }
      
       //v�rifie la longueur du mot de passe 
     if(document.cv.mdp.value.length<5)
     {
      alert("\nAttention le mot de passe doit avoir 5 caracteres minimum!");
      document.cv.mdp.focus();
      return false;
     }
 
      
      //v�rifie si la confirmation est bien indiqu� 
     else if (document.cv.mdp2.value == "")
     {
     alert("\nMerci de confirmer votre mot de passe.");
     document.cv.mdp2.focus();
     return false;
     }
      
     //Met le mdp dans une variable   
     if(document.cv.mdp.value != "")
     {
     pw1=document.cv.mdp.value;
     }

 
    //met la confirmation dans une variable
     if(document.cv.mdp2.value !="")
     {
     pw2=document.cv.mdp2.value;
     }
 
       
    //compare les mdp 
     if(pw1 != pw2)
     {
     alert ("\nLe Mot de passe de confirmation ne correspond pas au \n mot de passe indiqu� pr�c�demment")
     document.cv.mdp2.focus();
     return false;
     }
	 
	 if(document.cv.lieu_du_poste.value == "")
	 {
	 alert("Merci de preciser le lieu du poste")
	 document.cv.lieu_du_poste.focus();
	 return false;
	 }
      
    }
    </script>

    <script type="text/javascript" language="javascript" src="infobulle.js" ></script>
</head>


<% date_format=(year(Date))
date_format_month=(month(Date))

if date_format_month ="1" then
zemonth="janvier"
end if

if date_format_month ="2" then
zemonth="f�vrier"
end if
if date_format_month ="3" then
zemonth="mars"
end if
if date_format_month ="4" then
zemonth="avril"
end if
if date_format_month ="5" then
zemonth="mai"
end if
if date_format_month ="6" then
zemonth="juin"
end if
if date_format_month ="7" then
zemonth="juillet"
end if
if date_format_month ="8" then
zemonth="ao�t"
end if
if date_format_month ="9" then
zemonth="septembre"
end if

if date_format_month ="10" then
zemonth="octobre"
end if

if date_format_month ="11" then
zemonth="novembre"
end if

if date_format_month ="12" then
zemonth="d�cembre"
end if
if session("numMembre") <> "" then
set rsfill = Conn.Execute("SELECT * FROM MEMBRE WHERE NumMembre = " & session("numMembre") & "")
end if


%>

 <body>
 


<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_orange">DEPOSER UN CV!</div>

<table border="0px" width="100%" cellpadding="10px">
<tr>
        <td colspan="2"><a class=lien href="p_annonces.asp"><font size=1><b><< Retour </b></font></a>
        </td>
</tr>
<tr>
<td colspan="2"><font color="#6FAA06">Formulaire CV____________________________________________________________________</font></td>
</tr>
</table>

<!-- //
INSERTION  TABLE FORMULAIRE A MODIFIER
 // -->
<table width="583" border="0" cellspacing="0" cellpadding="0" align="center" valign="center" class="txt2">
<tr>
<td width="439" valign="top" class="txt">
<div align="justify"><br />

     <form action="verif_deposer.asp" method="post" id="cv" name="cv" OnSubmit="return verifform()" >
     
                <table width="500" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>

                  <tr> 
                    <td>Civilit�</td>
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
                   <td align="left">Votre �ge*&nbsp;&nbsp;</td>
                   <td>
                   <input style="width:30%" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;" onkeypress="return fonc2()" name="age" type="text" maxlength="2"  >&nbsp;&nbsp;ans
                   
                    </td>
                    </tr>
                  
                  <tr> 
                    <td class="txt1">Nom *</td>
                    <td><input style="width:90%" name="nom" type="text" ></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Prenom *</td>
                    <td><input style="width:90%" name="prenom" type="text" ></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Adresse *</td>
                    <td><input style="width:90%" name="adresse" type="text" ></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Code Postal *</td>
                    <td><input  style="width:90%" name="cp" type="text" maxlength="5"  
                    
                    
                        onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"
                
                    
                    
                    ></td>
                  <tr> 
                    <td class="txt1">Ville *</td>
                    <td><input style="width:90%" name="ville" type="text" ></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Email *</td>
                    <td><input style="width:90%" name="email" type="text" ></td>
                  </tr>
                  <tr> 
                    <td class="txt1">T�l�phone *</td>
                    <td><input  style="width:90%" name="tel" type="num" 
                        onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"
                
                    ></td>
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
                    <td class="txt1">Dipl�me en cours *</td>
                    <td><input style="width:90%" name="diplome_en_cour" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Dernier dipl�me  obtenu *</td>
                    <td><input style="width:90%" name="diplome_obtenu" type="text"></td>
                  </tr>
                  
                  
                  
                   <tr> 
                    <td class="txt1">Autre dipl�me  </td>
                    <td><input style="width:90%" name="autre_diplome" type="text"></td>
                  </tr>
                  
                  
                  
                  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  
                  
                  
                   <tr> 
                    <td class="txt1">Mot de passe  </td>
                    <td><input style="width:90%" name="mdp" type="password"></td>
                  </tr>
                   <tr> 
                    <td class="txt1">Confirmer  mot de passe  </td>
                    <td><input style="width:90%" name="mdp2" type="password"></td>
                  </tr>
                  
                  
                  
                  
                  <tr>
                    <td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>
                  </tr>
                  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr> 
                   <td align="left">Validit� du CV</td>
                   <td>
                    <select name="duree_cv" id="duree_cv">
                        <option value="90" selected>3 mois</option>
                        <option value="180">6 mois</option>
                        <option value="270">9 mois</option>
                        <option value="360">1 an</option>
                    </select>
                    </td>
                    </tr>
                   <tr> 
                    <td>Votre recherche </td>
                    <td> <table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td> <input name="profil" type="radio" value="emploi" checked></td>
                          <td>Emploi&nbsp; </td>
                          <td><input type="radio" name="profil" value="stage"></td>
                          <td>Stage&nbsp; </td>
                          <td><input type="radio" name="profil" value="autre"></td>
                          <td>Autre&nbsp; </td>
                        </tr>
                      </table></td>
                  </tr>
                  <tr> 
                    <td>Intitul� du poste *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="intitule_poste" type="text"></td>
                  </tr>
                  
                   <tr> 
                    <td>Lieu du poste *&nbsp;&nbsp;</td>
                    <td>
                    <select id="lieu_du_poste" name="lieu_du_poste">
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

                                       Response.Write "<option value="""" selected>"&Server.HtmlEncode("France enti�re")&"</option>"
                                       
                                       for i=1 to UBound(lesRegions)
                                              Response.Write "<option value="""&i&""">"&Server.HtmlEncode(lesRegions(i))&"</option>"
                                       Next

                          %>
                    </select>
                    
                    </td>
                  </tr>
                  <tr>
                   <td align="left"><% =Server.HtmlEncode("Dur�e esp�r�e*  ")%></td>
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
                    </tr>
                    
                    <tr>
                   <td align="left">Disponible � partir du*&nbsp;&nbsp;</td>
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
                        <option value="F�vrier" >F�vrier</option>
                        <option value="Mars">Mars</option>
                        <option value="Avril">Avril</option>
                        <option value="Mai">Mai</option>
                        <option value="Juin">Juin</option>
                        <option value="Juillet">Juillet</option>
                        <option value="Ao�t">Ao�t</option>
                        <option value="Septembre">Septembre</option>
                        <option value="Octobre">Octobre</option>
                        <option value="Novembre">Novembre</option>
                        <option value="D�cembre">D�cembre</option>
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
                    <td valign="top">Exp�riences professionnelles : <br/>
                    </td>
                    <td></td>
                  </tr>
                  
                  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center">
                    <textarea type="text" style="width:100%" name="experience_pro" rows="10"></textarea>
                    <script language="javascript1.2" type="text/javascript">
//<![CDATA[
var config = new Object();    // create new config object

config.width = "100%";
config.height = "150px";
config.bodyStyle = 'background-color: white; font-family: "Verdana"; font-size: x-small;';
config.debug = 0;

// NOTE:  You can remove any of these blocks and use the default config!

config.toolbar = [
   ['fontname'],
   ['fontsize'],
   //['fontstyle'],
   ['linebreak'],
   ['bold','italic','underline','separator'],
//  ['strikethrough','subscript','superscript','separator'],
   ['justifyleft','justifycenter','justifyright','separator'],
   ['OrderedList','UnOrderedList','Outdent','Indent','separator'],
   ['forecolor','backcolor','separator'],
   ['HorizontalRule','Createlink','InsertImage','htmlmode','separator'],
   ['about','help','popupeditor'],
];

config.fontnames = {
   "Arial":           "arial, helvetica, sans-serif",
   "Courier New":     "courier new, courier, mono",
   "Georgia":         "Georgia, Times New Roman, Times, Serif",
   "Tahoma":          "Tahoma, Arial, Helvetica, sans-serif",
   "Times New Roman": "times new roman, times, serif",
   "Verdana":         "Verdana, Arial, Helvetica, sans-serif",
   "impact":          "impact",
   "WingDings":       "WingDings"
};
config.fontsizes = {
   "1 (8 pt)":  "1",
   "2 (10 pt)": "2",
   "3 (12 pt)": "3",
   "4 (14 pt)": "4",
   "5 (18 pt)": "5",
   "6 (24 pt)": "6",
   "7 (36 pt)": "7"
 };


editor_generate('experience_pro',config);

</script>
                    </td>
                  </tr>
                  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td valign="top">Commentaires : <br/>
                  </td>
                  </tr>
                  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center"><textarea  type="text" style="width:100%" name="commentaire" rows="10" maxlength="800"></textarea>
                    <script language="javascript1.2"type="text/javascript">
var config = new Object();    // create new config object

config.width = "100%";
config.height = "150px";
config.bodyStyle = 'background-color: white; font-family: "Verdana"; font-size: x-small;';
config.debug = 0;

config.toolbar = [
    ['fontname'],
    ['fontsize'],
    //['fontstyle'],
    ['linebreak'],
    ['bold','italic','underline','separator'],
    ['justifyleft','justifycenter','justifyright','separator'],
    ['OrderedList','UnOrderedList','Outdent','Indent','separator'],
    ['forecolor','backcolor','separator'],
    ['HorizontalRule','Createlink','InsertImage','htmlmode','separator'],
    ['about','help','popupeditor'],
];

config.fontnames = {
    "Arial":           "arial, helvetica, sans-serif",
    "Courier New":     "courier new, courier, mono",
    "Georgia":         "Georgia, Times New Roman, Times, Serif",
    "Tahoma":          "Tahoma, Arial, Helvetica, sans-serif",
    "Times New Roman": "times new roman, times, serif",
    "Verdana":         "Verdana, Arial, Helvetica, sans-serif",
    "impact":          "impact",
    "WingDings":       "WingDings"
};
config.fontsizes = {
    "1 (8 pt)":  "1",
    "2 (10 pt)": "2",
    "3 (12 pt)": "3",
    "4 (14 pt)": "4",
    "5 (18 pt)": "5",
    "6 (24 pt)": "6",
    "7 (36 pt)": "7"
  };

editor_generate('commentaire',config);
</script>
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
                    <td style="margin-top:2px;">Liens HTTP: <br/>(liens vers vos projets, E-CV, etc...)<br/>
                  </td>
                    <td><textarea type="text" style="width:90%" name="lien_http" rows="2"  maxlength="800"></textarea></td>
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
            
             
             
             
             
    </td></tr><tr><td colspan="2">* (mention obligatoire)</td></tr></table>

 <!-- 
Ne pas toucher �  ce qui suit : placement du footer 
-->
<!-- #include file="grand_footer.txt"-->
<!-- #include file="deconnexion.asp"-->
</div>
</body>
</html>