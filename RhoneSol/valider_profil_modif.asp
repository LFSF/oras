<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.rg/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<!-- #include file="grand_meta.txt"-->

<!-- #include file="connexion.asp"-->
    <title>Rhône-solidarité</title>

    <link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
<!-- #include file="grand_header.txt"-->
    <div id="contenu">
<!-- #include file="fichier_menu.txt"-->
    <div id="bandeau_orange">Vérification Adhesion avant enregistrement</div>

<table border="0px" width="100%" cellpadding="10px">
    <tr>
        <td colspan="2"><font color="#6faa06">Validation adhesion _____________________________________________________</font> 
        </td>
    </tr>
</table>

<table background="img/haut_epingle.gif" style="background-repeat:no-repeat;" width="650" border="0" cellspacing="0" cellpadding="0" align="center" valign="center" class="txt2">

<tr>
    <td>



<%
    espace="&#034;"
    simplecot="&#039;"

    if (request.form("PartenaireProfil")<>"") then
        part="oui"
    else
        part="non"
    end if
    
    if(request.form("CooperationProfil")<>"") then
        part_coop="oui"
    else
        part_coop="non"
    end if
    
    if(request.form("SolidaireProfil")<>"") then
        part_solidaire="oui"
    else
        part_solidaire="non"
    end if
    
    if(request.form("FormationProfil")<>"") then
        part_form="oui"
    else
        part_form="non"
    end if
    
    if(request.form("AutreProfil")<>"") then
        part_autre="oui"
    else
        part_autre="non"
    end if

    if (request.form("RedacteurProfil")<>"") then
        actu="oui"
    else
        actu="non"
    end if
    
    if(request.form("InterviewProfil")<>"") then
        itw="oui"
    else
        itw="non"
    end if
    
    if(request.form("CreationsiteProfil")<>"") then
        Site="oui"
    else
        Site="non"
    end if
    
    if(request.form("AutresProfil")<>"") then
        Autres="oui"
    else
        Autres="non"
    end if
    
    if(request.form("NewsProfil")<>"") then
        News="oui"
    else
        News="non"
    end if

Dim sql

sql=""
if Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_profil_part.asp" then

     mdp=request.form("MdpProfil")
     if request.form("MdpProfil2")<>"" then
        mdp=request.form("MdpProfil2")
     end if



    sql = "UPDATE MEMBRE SET TelMembre= '"&request.form("TelProfil")&"', AdrMembre= '"&request.form("AdrProfil")&"' "& _
          ", MdpMembre='"&mdp&"', News='"&News&"', AgeMembre='"&request.form("AgeProfil")&"', VilleMembre='"&request.form("VilleProfil")&"', CPMembre='"&request.form("CPProfil")&"'"& _
          ", FonctionMembre='"&request.form("FonctionProfil")&"', OrganismeMembre='"&request.form("OrganismeProfil")&"', PaysMembre='"&request.form("PaysProfil")&"', PartenaireMembre='"&part&"'"& _
          ", CooperationMembre='"&part_coop&"', SolidaireMembre='"&part_solidaire&"', FormationMembre='"&part_form&"', AutreMembre='"&part_autre&"', RedacteurMembre='"&actu&"'"& _
          ", InterviewMembre='"&itw&"', CreationsiteMembre='"&Site&"', AutresMembre='"&Autres&"'   WHERE  NumMembre = "&session("admin_id")
    Conn.execute(sql)
end if


if Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_profil_org.asp" then
    mdp=""
    if request.form("MdpProfil2")<>"" then
       mdp=request.form("MdpProfil2")
    end if

    sql = "UPDATE MEMBRE SET TelMembre= "&request.form("TelProfil")&"',MailMembre='"&request.form("MailProfil")&"', AdrMembre='"&request.form("AdrProfil")&"'"& _
              ", MdpMembre='"&mdp&"', News='"&News&"', AgeMembre='"&request.form("AgeProfil")&"', VilleMembre='"&request.form("VilleProfil")&"', CPMembre='"&request.form("CPProfil")&"'"& _
              ", FonctionMembre='"&request.form("FonctionProfil")&"', OrganismeMembre='"&request.form("OrganismeProfil")&"', PaysMembre='"&request.form("PaysProfil")&"', PartenaireMembre='"&part&"'"& _
              ", CooperationMembre='"&part_coop&"', SolidaireMembre='"&part_solidaire&"', FormationMembre='"&part_form&"', AutreMembre='"&part_autre&"', RedacteurMembre='"&actu&"'"& _
              ", InterviewMembre='"&itw&"', CreationsiteMembre='"&Site&"', AutresMembre='"&Autres&"'   WHERE  NumMembre = "&session("admin_id")
        Conn.execute(sql)
end if
				%>
				  <script language="javascript" >
                  alert("Modification du profil reussi");
				  window.location="p_admin.asp" 
                  </script>
				<%

'response.redirect("p_admin.asp")
%>
 

                  
    </td>
</tr>
              
                </table>

<!-- #include file="grand_footer.txt"-->
                
<!-- #include file="deconnexion.asp"-->
</div>

</body>
</html>