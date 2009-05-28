<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!-- #include file="connexion.asp"-->
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Espace Membres</div>

<table border="0px" width="100%" cellpadding="10px">
    
    <tr>
        <td colspan="2"><font color="#6faa06">Validation Adhésion________________________________________________________</font></td>
    </tr>
   <tr>
                <td width=82%>
      <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
        
        <A href="p_accueil.asp"><font size=1><b>
                         << Retour à  l'Accueil &nbsp;</b></font>
                          </a></td></tr>
</table>
<table width="400" border="0" valign="center" align="center">
    <tr><td>
    Votre adhésion  a bien été enregistrée.
<br>Merci pour la confiance que vous nous accordez.
<br><% =Server.Htmlencode("Pour confirmer votre inscription veuillez l'activer via le mail envoyé à : ") %>
<font color="blue"><%=session("MailMembre")%></font>



<%

Dim ObjSendMail
    Set ObjSendMail = CreateObject("CDO.Message") 

    ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
    ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
    ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
    ObjSendMail.Configuration.Fields.Update

    
    
    'End remote SMTP server configuration section==
         
   envoi_lien ="<a href=http://www.rhone-solidarite.com/p_confirmation.asp?confirmation=" & session("MailMembre") & "&mdp=" & session("MdpMembre") & " >Lien confirmation adhesion</a>."

         
    ObjSendMail.To = session("MailMembre")
    ObjSendMail.Subject = "Confirmation inscription du " & date
    ObjSendMail.From = "contact@rhone-solidarite.com"
         
    
    ObjSendMail.HTMLBody = "Bonjour  <br/> Votre adh&eacute;sion a bien &eacute;t&eacute; enregistr&eacutee;.<br/><br/>Voici vos identifiants :<br/> -login : " & session("MailMembre") & "<br/>-Mot de passe : " & session("MdpMembre") & "<br/><br/>   Cliquez sur le lien suivant pour la valider! <br/><br/>" &  envoi_lien &" <br/><br/>Cordialement.<br/><br/> L'&eacute;quipe de Rh&ocirc;ne-solidarit&eacute;."
    
    
    ObjSendMail.Send

    Set ObjSendMail = Nothing  



%>


    </td></tr>
    

</table>

 

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />



<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

<!-- Ne pas toucher Ã  ce qui suit : placement du footer -->

 <!-- #include file="grand_footer.txt"-->  

<%

Session.Contents.Remove("NomMembre")
Session.Contents.Remove("PrenomMembre")
Session.Contents.Remove("TelMembre")
Session.Contents.Remove("MailMembre")
Session.Contents.Remove("AdrMembre")
Session.Contents.Remove("MdpMembre")
Session.Contents.Remove("News")
Session.Contents.Remove("AgeMembre")
Session.Contents.Remove("CivMembre")
Session.Contents.Remove("VilleMembre")
Session.Contents.Remove("CPMembre")
Session.Contents.Remove("FonctionMembre")
Session.Contents.Remove("OrganismeMembre")
Session.Contents.Remove("PaysMembre")
Session.Contents.Remove("PartenaireMembre")
Session.Contents.Remove("CooperationMembre")
Session.Contents.Remove("SolidaireMembre")
Session.Contents.Remove("FormationMembre")
Session.Contents.Remove("AutreMembre")
Session.Contents.Remove("RedacteurMembre")
Session.Contents.Remove("InterviewMembre")
Session.Contents.Remove("CreationsiteMembre")
Session.Contents.Remove("AutresMembre")
Session.Contents.Remove("MessageMembre")

%>

 
</div>

</body>
 <!-- #include file="deconnexion.asp"--> 
</html>