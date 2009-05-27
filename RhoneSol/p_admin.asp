<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
<title>Rh&ocirc;ne-solidarit&eacute;</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<% if session("admin_id")="" Then 
 response.redirect "p_membres.asp"
 end if%>
 
<body>
<!-- #include file="admin_securite.asp"-->
<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->
<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<div align="justify">
<table border="0px" width="100%" cellpadding="10px">
   
    <tr>
        <td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
    <tr>
        <td width=82%>Bonjour &nbsp; <b><%=session("admin_nom")%>&nbsp;<%=session("admin_prenom")%></b>
        </td>
    </tr>
</table>
</div>

<br/>
<br/>


<div id="Info" style="border:1px solid green;">
    <% if (session("admin_acces_admin") = 1) then
    
    On Error Resume Next
      ' Set rsEDmembre = Conn.Execute("SELECT count(*) AS cptMembre FROM MEMBRE where DateMembre=#" & date & "#;")
	   
	   'response.Write("SELECT count(*) AS cptMembre FROM MEMBRE where DateMembre='" & date & "';")
		     Set rsEDmembre = Conn.Execute("SELECT count(*) AS cptMembre FROM MEMBRE where DateMembre='" & date & "';")
	If Err>0 Then
        Set rsEDmembre = 0
    End If
	
        On Error Resume Next
       ' Set rsEDnews = Conn.Execute("SELECT count(*) AS cptNews FROM ACTUALITE where DateActu=#" & date & "#;")
		 Set rsEDnews = Conn.Execute("SELECT count(*) AS cptNews FROM ACTUALITE where DateActu='" & date & "';")
    If Err>0 Then
        Set rsEDnews = 0
    End If
	
        On Error Resume Next
        Set rsEDitw = Conn.Execute("SELECT count(*) AS cptItw FROM INTERVIEW where DateItw='" & date & "';")
		'response.Write ("SELECT count(*) AS cptItw FROM INTERVIEW where DateItw='" & date & "';")
    If Err>0 Then
        Set rsEDitw = 0
    End If
	
        On Error Resume Next
       'Set rsEDcv = Conn.Execute("SELECT count(*) AS cptCV FROM CV where DateCV=#" & date & "#;")
	     Set rsEDcv = Conn.Execute("SELECT count(*) AS cptCV FROM CV where DateCV='" & date & "';")
    If Err>0 Then
        Set rsEDcv = 0
    End If
	
        On Error Resume Next
        Set rsEDoffre = Conn.Execute("SELECT count(*) AS cptOffre FROM ANNONCES where DateAnn='" & date & "';")
    If Err>0 Then
        Set rsEDoffre = 0
    End If
        
        %>
		
    <u><b>Nouvelles du jour :</b></u><br/><br/>
    <b><%response.Write(rsEDmembre("cptMembre"))%></b> personnes se sont inscrites aujourd'hui<br/>
    <b><%response.Write(rsEDnews("cptNews"))%></b> Actualit&eacute;s<br/>
    <b><%response.Write(rsEDitw("cptItw"))%></b> Interview<br/>
    <b><%response.Write(rsEDcv("cptCV"))%></b> CV<br/>
    <b><%response.Write(rsEDOffre("cptOffre"))%></b> Offres<br/>
<%end if%>
</div>


<br/>
<br/>

<div align="justify">
<table border="0" cellspacing="0" cellpadding="0" align="center" valign="left" class="txt2">

<%
'vÃ©rification particulier ou organisme
Set rsEDverifstat = Conn.Execute("SELECT * FROM Membre where NumMembre=" & session("admin_id"))
if rsEDverifstat("Entreprise")=1 then
%>
    <tr>
                <td><IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
					<A href="p_profil_org.asp">Mon Profil &nbsp;</a></td>
    </tr>
<%
else
%>
    <tr>
            <td><IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
					<A href="p_profil_part.asp">Mon Profil &nbsp;</a></td>
    </tr>
<%
end if
set rsEDverifstat=nothing 
%>  


        <% if (session("admin_acces_admin") = 1 or session("acces_cv") = 1)then %>
            <tr>
                <td>
                    <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_cv_validation.asp">
                    <!--<A class=lien href="p_admin_derniers_post.asp">-->
                    Visualisation et validation des derniers CV &nbsp;
                    </a>
                </td>
            </tr>
        <%end if %>

        <% if (session("admin_acces_admin")=1 or session("acces_off")= 1) then %>
            <tr>
                <td>
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_offre_validation.asp"><!--<A class=lien href="p_admin_offres_emplois_stages.asp">-->Visualisation et validation des derni&egrave;res offres emplois-stages-b&eacute;n&eacute;volat</a>
                </td>
            </tr>
        <%end if %> 

        <% if (session("admin_acces_admin")= 1 ) then %>
            <tr>
                <td> 
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_adhesion_validation.asp">
                   Visualisation et validation des derni&egrave;res adh&eacute;sions
                    </a>
                </td>
            </tr>
        <%end if %> 
        
        <% if (session("admin_acces_admin")= 1 ) then %>
            <tr>
                <td> 
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_adhesion_message.asp">
                    Visualisation et validation des messages adh&eacute;sions
                    </a>
                </td>
            </tr>
        <%end if %> 

        <% if (session("admin_acces_admin")= 1 or session("acces_id")= 1 ) then %>
            <tr>
                <td>
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <!--<A class=lien href="p_admin_visualitation_idees.asp">
                    <A class=lien href="p_admin_suggestion_comments.asp">-->
                    <A class=lien href="p_admin_idees.asp">
                    Visualisation et validation des derni&egrave;res id&eacute;es / suggestions 
                    </a>
                </td>
            </tr>
        <%end if %> 

        <% if (session("admin_acces_admin")= 1 ) then %>
            <tr>
                <td>
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_demandes_site.asp">
                    Visualisation et validation des derni&egrave;res demandes de cr&eacute;ation de site
                    </a>
                </td>
            </tr>
        <%end if %>

        <% if (session("admin_acces_admin")= 1 or session("acces_actu")= 1) then %>
            <tr>
                <td>
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_actu.asp">
                    Menu "ACTUALITES" &nbsp;
                    </a>
                </td>
            </tr>
        <%end if %> 

        <% if (session("admin_acces_admin")= 1 or session("acces_itw")= 1) then %>
            <tr>
                <td>
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_interview.asp">
                    Menu "INTERVIEW" &nbsp;
                    </a>
                </td>
            </tr>
        <%end if %>

        <% if (session("admin_acces_admin")= 1 ) then %>
            <tr>
                <td> 
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_suppression_de_fichiers.asp">
                    Suppression de fichiers sur le serveur &nbsp;
                    </a>                         
                </td>
            </tr>
        <%end if %>

        <% if (session("admin_acces_admin")= 1 ) then %>
            <tr>
                <td> 
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_suppression.asp">
                    Menu "Suppression de fichiers sur le serveur"  &nbsp;
                    </a>                         
                </td>
            </tr>
        <%end if %>

        <% if (session("admin_acces_admin")= 1 ) then %>
            <tr>
                <td> 
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_admin_gestion_login.asp">
                    Visualisation des logins &nbsp;
                    </a>                         
                </td>
            </tr>
        <%end if %>

        <% if (session("admin_acces_admin")= 1 or session("acces_news")= 1)  then %>
            <tr>
                <td> 
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="http://www.rhone-solidarite.com/p_admin_newsletter_insert.asp">
                    Ecrire une news pour la newsletter  &nbsp;
                    </a>                         
                </td>
            </tr>
        <%end if %> 

        <tr>
            <td> 
          <br/>
                <IMG height=9 src="img/communs/puceflch.gif" width=7>
                <IMG height=9 src="img/communs/puceflch.gif" width=7>
                &nbsp; <A class=lien href="accueil.asp">
                <b><A href="deconnect.asp">D&eacute;connexion</a></b>                         
            </td>
        </tr>
    
    <!--fin corps de texte-->
</table>
</div>
<br /><br /><br /><br /><br /><br /><br /><br /><br/><br /><br /><br /><br /><br /><br />

<!-- Ne pas toucher Ã  ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
 </div>

 <!-- #include file="deconnexion.asp"-->

</body>
</html>