<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<!-- #include file="connexion.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
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
<SCRIPT LANGUAGE="Javascript1.1">
function fonc_print() {
window.print(); 
} 
</SCRIPT>

<SCRIPT LANGUAGE="Javascript1.1">
function lightUp() { 
document.images["homeButton"].src="./img racine/imp_no_border.gif"
} 
function dimDown() { 
document.images["homeButton"].src="./img racine/imp_no_border.gif"
} 
</SCRIPT>

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

<div id="bandeau_orange">CONSULTATION CV</div>
<%session("num")=Request.QueryString("num")
'Response.Write "SELECT * FROM ANNONCES,CV where CV.NumCV = "& Request.QueryString("num") &" AND ANNONCES.NumCV=CV.NumCV ;"
Set rsDI = Conn.Execute("SELECT * FROM ANNONCES,CV,REGIONS where CV.NumCV = "& Request.QueryString("num") &" AND ANNONCES.NumCV=CV.NumCV AND idRegion=LieuAnn ;")

'Set rsDI = Conn.Execute("SELECT * FROM ANNONCES where NumCV = "& Request.QueryString("num") &"")


'session("d_esperee")= rsDI("DureeEspereeAnn")

if rsDI("DureeEspereeAnn")="1000" then
   session("d_esperee")="C.D.I"
end if

if rsDI("DureeEspereeAnn")="15" then
   session("d_esperee")="15 jours"
end if

if rsDI("DureeEspereeAnn")="30" then
   session("d_esperee")="1 mois"
end if

if rsDI("DureeEspereeAnn")="60" then
   session("d_esperee")="2 mois"
end if

if rsDI("DureeEspereeAnn")="90" then
   session("d_esperee")="3 mois"
end if

if rsDI("DureeEspereeAnn")="120" then
   session("d_esperee")="4 mois"
end if

if rsDI("DureeEspereeAnn")="150" then
   session("d_esperee")="5 mois"
end if

if rsDI("DureeEspereeAnn")="180" then
   session("d_esperee")="6 mois"
end if

if rsDI("DureeEspereeAnn")="270" then
   session("d_esperee")="9 mois"
end if

if rsDI("DureeEspereeAnn")="360" then
   session("d_esperee")="1 an minimum"
end if

                    'filename = rsv.fields("filename")

            session("dest_numcv")=numcv
            session("dest_nom")=nom
            session("dest_prenom")=prenom
            session("dest_civilite")=civilite
            session("dest_email")=email
            session("dest_poste_recherche")=intitule


 'Set rsDI = Conn.Execute("SELECT * FROM MEMBRE where NumMembre=(select NumMembre from CV where NumCV="& Request.QueryString("num") &")")
 'Set rsInfosAnnonce = Conn.Execute("SELECT * FROM ANNONCES where NumCV="& Request.QueryString("num"))
 'Set rsInfosCV = Conn.Execute("SELECT * FROM CV  where NumCV="& Request.QueryString("num"))
 session("NumCV")=Request.QueryString("num")
 %>

<table style="background-repeat:no-repeat;" 
width="650" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">

    <!--INSERTION -->
    

<tr >
<td colspan="2" class="style"><br/>
<h2>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
CV de &nbsp; <%=rsDI("Nom")%> &nbsp;&nbsp;<%=rsDI("Prenom")%> &nbsp;.&nbsp;&nbsp; <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Age :&nbsp;<%=rsDI("age")%>&nbsp;ans

</h2>


</td>
</tr>



<tr>
<td><br/> <div align="justify"><br />
                <table width="500" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                   <tr>
                    <td><font color="#969696">Poste recherché : </font></td> <td><%=rsDI("IntituleAnn")%></td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center"></td>
                    <td></td>
                  </tr>
                   <tr>
                    <td colspan="2" align="center"></td>
                    <td></td>
                  </tr>
                   <tr> 
                    <td><font color="#969696">Date d'inscription :</font></td>
                    <td><%=date_inscription%></td>
                  </tr>
                  <tr> 
                    <td><font color="#969696">N° référence :</font></td>
                    <td><%=rsDI("NumCV")%></td>
                  </tr>
                  <tr> 
                    <td><font color="#969696">Niveau de formation :</font></td>
                    <td><%=rsDI("FormationAnn")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Diplôme en cours :</font></td>
                    <td><%=rsDI("DiplomeActuCV")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Dernier diplôme  obtenu :</font></td>
                    <td><%=rsDI("DiplomeObtenuCV")%></td>
                  </tr>
                   <tr> 
                    <td class="txt1"><font color="#969696">Autre diplôme  :</font></td>
                    <td><%=rsDI("AutreDiplomeCV")%></td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                 <tr> 
                    <td><font color="#969696">Lieu du poste recherché :</font></td>
                    <td><%=rsDI("nomRegion")%></td>
                  </tr>
                   <tr> 
                    <td><font color="#969696">Durée espérée :</font></td>
                    <td>
                    <%=session("d_esperee")%>
                    </td>
                  </tr>
                   <tr> 
                    <td><font color="#969696">Disponibilité à partir du :</font></td>
                    <td><%=rsDI("DispoJourAnn")%>&nbsp; <%=rsDI("DispoMoisAnn")%>&nbsp;
                    <%=rsDI("DispoAnneeAnn")%>
                    </td>
                  </tr>  
                    <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Expériences professionnelles : </font><br/><br/>&nbsp;
                    </td>
                  </tr>
                  <tr> 
                    <td colspan="2"><%=rsDI("ExperienceProCV")%></td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Commentaires : </font><br/><br/><br/>&nbsp;
                  </td>
                  </tr>
                  <tr>
                    <td colspan="2"><%=rsDI("CommAnn")%></td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                    <%if rsDI("PieceJointeCV")<>"" then%>
                   <tr>
                    <td class="textes"><font color="#969696">Fichier joint &nbsp;</font><br/><br/>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                    <td colspan="2"><a href="\fichiers_upload\upload_cv\<%=rsDI("PieceJointeCV")%>">voir mon fichier joint</a></td>
                    <td></td>
                  </tr>
                  
                  <%end if%> 
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                  <tr> 
                    <td colspan="2" style="margin-top:2px;"><font color="#969696">Liens HTTP vers mes projets, E-CV , etc... :</font><br/><br/>&nbsp;
                  </td>
                  <td >&nbsp;
                  </td>
                  </tr>
                  <tr>
                  
                    <td colspan="2"><%=rsDI("LienAnn")%></td>
                     <td></td>
                  </tr>
<%

session("lecompteur")=compteur

%>
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
                  
                  
                  
                  <tr><td> <br/>
    
 
 <br/><div align="right" >
<IMG SRC="./img racine/imp_no_border.jpg" onclick="return fonc_print()" name="homeButton" width="50" height="46" border="0" >
 
 </div></td></tr>
                </table>
                
                 <br/> <br/>
                <!--ENVOI  MESSAGE-->


<a href="javascript:visibilite('divid');"><font color="orange" size=2px><b>ENVOYER UN MESSAGE à  <%=rsDI("civilite")%> &nbsp;&nbsp;<%=rsDI("Prenom")%> &nbsp; <%=left(rsDI("Nom"),1)%>.&nbsp;&nbsp;</b></font></a>
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
                    <td><input style="width:90%" name="rs" id="rs" type="text" checked Maxlength="30"> </td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Adresse *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="adresse" type="text" Maxlength="50"></td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Code Postal *&nbsp;&nbsp;</td>
                          <td><input style="width:90%" name="cp"  type="text" Maxlength="7"
                            onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"
                
                          ></td>
                </tr>
                   <td align="left" class="txt1">Ville *&nbsp;&nbsp;</td>
                          <td><input style="width:90%" name="ville" type="text" id="ville" Maxlength="30"></td>
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
                      </table>
                    </td>
                  </tr>
                  <tr> 
                    <td align="left" class="txt1">Nom du responsable *&nbsp;&nbsp;</td>
                    <td><input style="width:90%" name="nom_responsable" type="text" Maxlength="30"></td>
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
                    <td><input style="width:90%" name="tel"  type="num" Maxlength="30"
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
                    <td align="left" class="txt1">Votre message *&nbsp;&nbsp;</td>
                    <td><textarea style="width:90%" name="message" rows="7"></textarea></td>
                  </tr>
                  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td align="center">
                    </td>
                    <td align="center">  
                     <input name="effacer" type="reset" value="Effacer"id="effacer" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input name="valider" type="submit" value="Valider" id="valider" />
                    </td>
                  </tr>
                </table>
                </center>
                &nbsp;&nbsp;</td></tr></table>
             </form>
                </div>
                
                <!--FIN ENVOI MESSAGE-->
    </td></tr><tr><td colspan="2"></td></tr></table>

    <!-- fin insertion  -->
 
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<% rsDI.Close %>
<!-- Ne pas toucher à ce qui suit : placement du footer -->

  <!-- #include file="grand_footer.txt"-->  
</div>
<!-- #include file="deconnexion.asp"-->
</body>
</html>