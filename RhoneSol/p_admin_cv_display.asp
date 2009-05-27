                    <%@ Language=VBScript %>

<?xml version="1.0" encoding="iso-8859-1"?>
<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->
<link href="styles.css" rel="stylesheet" type="text/css" />

<SCRIPT language=JavaScript> 
function fonctest()
{
window.location.href="espaceadh.asp"
}
function fonc100()
{
window.location.href='testd.asp'
}
function fonc1()
{
window.location.href='ndambog.asp'
}


<!--Hide JavaScript from Java-Impaired Browsers 
//--> 


</SCRIPT>
<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>

<body>
<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<%
session ("num")=Request.QueryString("num")

'Set rsDI = Conn.Execute("SELECT * FROM CV where NumCV = "& Request.QueryString("num") &";")
'Response.Write "SELECT * FROM ANNONCES,CV,REGIONS where CV.NumCV = "& Request.QueryString("num") &" AND ANNONCES.NumCV=CV.NumCV AND idRegion=LieuAnn ;"

SQL = "SELECT * FROM CV where NumCV = "& Request.QueryString("num") & ";"
'SQL = "SELECT * FROM ANNONCES,CV WHERE CV.NumCV ="& Request.QueryString("num") &" AND ANNONCES.NumCV=CV.NumCV"
'SQL = "SELECT * FROM ANNONCES,CV WHERE CV.NumCV ="& Request.QueryString("num") &" AND ANNONCES.NumCV=CV.NumCV;"
'SQL = "SELECT * FROM ANNONCES,CV,REGIONS WHERE CV.NumCV ="& Request.QueryString("num") &" AND ANNONCES.NumCV=CV.NumCV AND idRegion=LieuAnn ;"

Set rsDI = Conn.Execute(SQL)

%>

<table border="0px" width="100%" cellpadding="10px">
<tr>
<td colspan="2"><font color="#6FAA06">Aperçu du CV____________________________________________________________________</font></td>
</tr>
</table>

<!-- //
INSERTION  TABLE FORMULAIRE A MODIFIER
 // -->
 
 <%
 'Set rsDI = Conn.Execute("SELECT * FROM MEMBRE where NumCV = "& Request.QueryString("num") &"")
 'SQL = "SELECT * FROM ANNONCES,CV,REGIONS where CV.NumCV = "& Request.QueryString("num") &" AND ANNONCES.NumCV=CV.NumCV AND idRegion=LieuAnn ;"
 SQL = "SELECT * FROM CV where NumCV = "& Request.QueryString("num") & ";"
 Set rsDI = Conn.Execute(SQL)
 if not rsDI.eof then
 %>
 
<table width="583" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">
<tr>
<td width="439" valign="top" class="txt">
<div align="justify"><br />
                <table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr> 
                    <td><font color="#969696">Civilité :</font></td>
                    <td><% =rsDI("civilite")%></td>
                        </tr>
                  </tr>
                   <tr> 
                    <td><font color="#969696">Votre âge :</font></td>
                    <td><% =rsDI("age")%>  &nbsp;ans</td>
                        </tr>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Nom :</font></td>
                    <td><% =rsDI("Nom")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Prenom :</font></td>
                    <td><% =rsDI("Prenom")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Adresse :</font></td>
                    <td><% =rsDI("Adresse")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Code Postal :</font></td>
                    <td><% =rsDI("cp")%></td>
                  <tr> 
                    <td class="txt1"><font color="#969696">Ville :</font></td>
                    <td><% =rsDI("Ville")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Email :</font></td>
                    <td><% =rsDI("email")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Téléphone :</font></td>
                    <td><% =rsDI("tel")%></td>
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
				  <%
					rsDI.Close
					'Set rsDI = Conn.Execute("SELECT * FROM MEMBRE where NumCV = "& Request.QueryString("num") &"")
					SQL = "SELECT * FROM ANNONCES,CV,REGIONS where CV.NumCV = "& Request.QueryString("num") &" AND ANNONCES.NumCV=CV.NumCV AND idRegion=LieuAnn ;"
					'SQL = "SELECT * FROM CV where NumCV = "& Request.QueryString("num") & ";"
					Set rsDI = Conn.Execute(SQL)
					if not rsDI.eof then
					
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
				  %>
				  
                   <tr> 
                    <td><font color="#969696">Votre recherche :</font></td>
                    <td><% =rsDI("ProfilAnn")%></td>
                  </tr>
                  <tr> 
                    <td><font color="#969696">Intitulé du poste :</font></td>
                    <td><%=rsDI("IntituleAnn")%></td>
                  </tr> 
                 <tr> 
                    <td><font color="#969696">Lieu du poste :</font></td>
                    <td><%=rsDI("nomRegion")%></td>
                  </tr> 
                   <tr> 
                    <td><font color="#969696">Durée espérée :</font></td>
                    <td>
                    <%= session("d_esperee")
                    %>
                    </td>
                  </tr>  
                   <tr> 
                    <td><font color="#969696">Vous êtes disponible à partir du :</font></td>
                    <td><% =rsDI("DispoJourAnn")%>&nbsp; <% =rsDI("DispoMoisAnn")%>&nbsp;
                    <% =rsDI("DispoAnneeAnn")%>
                    </td>
                  </tr>  
                    <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Expériences professionnelles : </font><br/><br/>&nbsp;
                    </td>
                  </tr>
                  
    
                  
                  
                  <tr> 
                    <td colspan="2"><% =rsDI("ExperienceProCV")%></td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Commentaires : </font><br/><br/><br/>&nbsp;
                  </td>
                  </tr>
                
                  <tr>
                    <td colspan="2"><% =rsDI("CommAnn")%></td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td colspan="2" style="margin-top:2px;"><font color="#969696">Liens HTTP (liens vers vos projets, E-CV, etc...) :</font><br/><br/>&nbsp;
                  </td>
                  <td >&nbsp;
                  </td>
                  </tr>
                  <tr>
                    <td colspan="2"><% =rsDI("LienAnn")%></td>
                     <td></td>
                  </tr>
                    <td colspan="2" width="670" valign="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2" width="670" valign="center">&nbsp;</td>
                  </tr>
                  <%if rsDI("FinCV")<>"" Then %>
                  <tr>
                    <td colspan="2">
                    Votre CV sera valide jusqu'au : <%=rsDI("FinCV")%></td>
                  </tr>
<%
end if
end if
end if
rsDI.Close


%>
    <br/>
 <br/>
                    </td>
                  </tr>
                  
                </table></center>
    </td></tr><tr><td colspan="2"> <br/>
 <br/><div align="right">
 <INPUT TYPE="BUTTON" style="width:75" VALUE="Valider" OnClick="window.location.href='p_admin_cv_validbis.asp'" >
 <INPUT TYPE="BUTTON" style="width:75" VALUE="Retour" onClick="history.back()" >
 <INPUT TYPE="BUTTON"  style="width:75" VALUE="Supprimer" OnClick="window.location.href='p_admin_cv_deletebis.asp'" ></div></td></tr></table>

 <!-- 
Ne pas toucher Ã  ce qui suit : placement du footer 
-->
<!-- #include file="grand_footer.txt"-->
<br>
<br>
<br>
<br>
<br>
<br>
</div>
</div>
</body>
<!-- #include file="deconnexion.asp"-->
</html>