<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
<title>Rh√¥ne-solidarit√©</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./z_menu.js"></script>
<script type="text/javascript" src="stmenu.js"></script></head>

<body>
<script type="text/javascript" src="./js/xhr.js"></script><script type="text/javascript" src="./js/xhr.js"></script><a href="http://www.dhtml-menu-builder.com"  style="display:none;visibility:hidden;">Javascript DHTML Drop Down Menu Powered by dhtml-menu-builder.com</a>
<script type="text/javascript">
<!--
stm_bm(["menu61b2",900,"","blank.gif",0,"","",0,0,250,0,1000,1,0,0,"","",0,0,1,2,"default","hand","",1,25],this);
stm_bp("p0",[0,4,0,0,0,0,0,0,100,"",-2,"",-2,50,0,0,"#799BD8","transparent","",3,0,0,"#000000"]);
stm_ai("p0i0",[0,"Mon Profil","","",-1,-1,0,"#","_self","","","","",0,0,0,"","",0,0,0,1,1,"#FFFFF7",1,"#FFFFF7",1,"bg5.gif","bg2.gif",3,3,0,0,"#FFFFF7","#000000","#FFFFFF","#009933","bold 8pt Verdana","bold 8pt Verdana",0,0,"bg4.gif","bg1.gif","bg6.gif","bg3.gif",6,6,24],80,24);
stm_aix("p0i1","p0i0",[0,"ActualitÈ"],80,24);
stm_aix("p0i2","p0i0",[0,"Interview","","",-1,-1,0,"#","_self","","","","",0,0,0,"","",-1,-1,0,1,1,"#FFFFFF",1,"#FFFFFF",1,"bg5.gif","bg2.gif",3,3,0,0,"#FFFFF7","#000000","#FFFFFF","#009933","bold 8pt Verdana","bold 11pt Verdana"],80,24);
stm_bp("p1",[1,4,0,0,4,0,10,0,100,"",-2,"",-2,80,0,0,"#799BD8","#CCCCCC","",0,1,1,"#CCCCCC #B2B2B2 #B2B2B2"]);
stm_ai("p1i0",[0,"Insertion nouvelle Interview","","",-1,-1,0,"#","_self","","","icon_01.gif","icon_01.gif",10,7,0,"","",0,0,0,0,1,"#B7B7B7",1,"#F2F2F2",0,"","",0,0,0,0,"#FFFFCC","#CCCC00","#333333","#009900","8pt Verdana","8pt Verdana",0,0,"","","","",0,0,0],140,18);
stm_aix("p1i1","p1i0",[0,"Ajouter une image ‡ une Interview","","",-1,-1,0,"#","_self","","","icon_01.gif","icon_01.gif",10,7,0,"","",0,0,0,0,1,"#B7B7B7",0],140,18);
stm_aix("p1i2","p1i0",[0,"Modifier "],140,18);
stm_aix("p1i3","p1i0",[0,"Visualiser/Effacer","","",-1,-1,0,""],140,0);
stm_ep();
stm_aix("p0i3","p0i0",[0,"Annonce","","",-1,-1,0,"#","_self","","","","",0,0,0,"","",-1,-1],80,24);
stm_bpx("p2","p1",[]);
stm_aix("p2i0","p1i1",[0,"Visualiser/Valider CV"],0,18);
stm_aix("p2i1","p1i1",[0,"Visualiser/Valider offres emplois-stages-bÈnÈvolat","","",-1,-1,0,"#","_self","","","icon_01.gif","icon_01.gif",10,7,0,"","",0,0,0,0,1,"#CCCCCC"],0,18);
stm_mc("p2",[3,"#000000",1,0,"",3]);
stm_ep();
stm_aix("p0i4","p0i3",[0,"Gestion"],120,24);
stm_bpx("p3","p1",[]);
stm_aix("p3i0","p1i0",[0,"Login","","",-1,-1,0,"#","_self","","","icon_01.gif","icon_01.gif",10,7,0,"","",0,0,0,0,1,"#FFCC00"],115,18);
stm_aix("p3i1","p1i1",[0,"AdhÈsions"],115,18);
stm_aix("p3i2","p1i1",[0,"Messages AdhÈsions","","",-1,-1,0,""],115,0);
stm_aix("p3i3","p3i2",[0,"IdÈes/Suggestions"],115,0);
stm_aix("p3i4","p3i2",[0,"Demande de crÈation site web"],115,0);
stm_ep();
stm_aix("p0i5","p0i3",[0,"Autre"],80,24);
stm_bpx("p4","p1",[]);
stm_aix("p4i0","p3i2",[0,"Suppression des fichiers"],115,0);
stm_aix("p4i1","p3i2",[0,"Ecrire une news pour la newsletter"],115,0);
stm_ep();
stm_ep();
stm_em();
//-->
</script>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_vert">Espace Membres</div>

<table border="0px" width="100%" cellpadding="10px">
    <tr>
        <td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
    <tr>
        <td width=82%>
            <div align="justify">Bonjour &nbsp; <b><%=session("admin_nom")%>&nbsp;
       <%=session("admin_prenom")%></b>
            </div>
        </td>
    </tr>
</table>

<br/>
<br/>

<div id="Info" style="border:1px solid green;">
    <% if (session("admin_acces_admin") = 1) then
    
    On Error Resume Next
        Set rsEDmembre = Conn.Execute("SELECT count(*) AS cptMembre FROM MEMBRE where DateMembre=#" & date & "#;")
    If Err>0 Then
        Set rsEDmembre = 0
    End If
        On Error Resume Next
        Set rsEDnews = Conn.Execute("SELECT count(*) AS cptNews FROM ACTUALITE where DateActu=#" & date & "#;")
    If Err>0 Then
        Set rsEDnews = 0
    End If
        On Error Resume Next
        Set rsEDitw = Conn.Execute("SELECT count(*) AS cptItw FROM INTERVIEW where DateItw='" & date & "';")
    If Err>0 Then
        Set rsEDitw = 0
    End If
        On Error Resume Next
        Set rsEDcv = Conn.Execute("SELECT count(*) AS cptCV FROM CV where DateCV=#" & date & "#;")
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
    <b><%response.Write(rsEDnews("cptNews"))%></b> Actualit√©s<br/>
    <b><%response.Write(rsEDitw("cptItw"))%></b> Interview<br/>
    <b><%response.Write(rsEDcv("cptCV"))%></b> CV<br/>
    <b><%response.Write(rsEDOffre("cptOffre"))%></b> Offres<br/>
    <%end if%>
</div>

<br/>
<br/>

<table   border="0" cellspacing="0" cellpadding="0" align=center valign=left class="txt2">
    <div align="justify">
<%
'v√©rification particulier ou organisme
Set rsEDverifstat = Conn.Execute("SELECT * FROM Membre where NumMembre=" & session("admin_id"))
if rsEDverifstat("Entreprise")=1 then
%>
    <tr>
                <td>
                <br/>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_profil_org.asp">
                    Mon Profil &nbsp;
                    </a>
                </td>
    </tr>
<%
else
%>
    <tr>
            <td>
            <br/>
                <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    <IMG height=9 src="img/communs/puceflch.gif" width=7>
                    &nbsp; <A class=lien href="accueil.asp">
                    <A class=lien href="p_profil_part.asp">
                    Mon Profil &nbsp;
                    </a>
            </td>
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
                    <A class=lien href="p_admin_offre_validation.asp">
                    <!--<A class=lien href="p_admin_offres_emplois_stages.asp">-->
                    <%=Server.HtmlEncode("Visualisation et validation des derniËres offres emplois-stages-bÈnÈvolat ")%>
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
                    <A class=lien href="p_admin_adhesion_validation.asp">
                    <%=Server.HtmlEncode("Visualisation et validation des derniËres adhÈsions ")%>
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
                    <%=Server.HtmlEncode("Visualisation et validation des messages adhÈsions ")%>
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
                    <%=Server.HtmlEncode("Visualisation et validation des derniËres idÈes / suggestions ")%>
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
                    <%=Server.HtmlEncode("Visualisation et validation des derniËres demandes de crÈation de site ")%>
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
                <b><A href=deconnect.asp class=lien>
                <%=Server.HtmlEncode("DÈconnexion ")%>
                </a></b>                         
            </td>
        </tr>
    
    <!--fin corps de texte-->
</table>

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<!-- Ne pas toucher √† ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->
</html>