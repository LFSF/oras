<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title><% =Server.HtmlEncode("Rhône-solidarité")%></title>

<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="connexion.asp"-->
<%
    Set rsED1 = Conn.Execute("SELECT TOP 5 * FROM CV,ANNONCES where cv.Visible=1 AND CV.NumCV=ANNONCES.NumCV ORDER BY DateCV DESC")
    ' Set rsED1 = Conn.Execute("SELECT * FROM ANNONCES where Visible=1 and ProfilAnn=1 ORDER BY DateAnn DESC")
    ' Set rsED2 = Conn.Execute("SELECT * FROM ANNONCES where Visible=1 and ProfilAnn=2 ORDER BY DateAnn DESC")
    ' Set rsED3 = Conn.Execute("SELECT * FROM ANNONCES where Visible=1 and ProfilAnn=3 ORDER BY DateAnn DESC")

LeJour=Day(date)
LeMois=Month(date)
An=Year(date)
    if LeJour>=16 then
    JourItw=16
else
    JourItw=1
end if
DateRecherche=LeMois&"/"&JourItw&"/"&An
Set rsED4 = Conn.Execute("SELECT * FROM INTERVIEW WHERE DatePublicationItw=#"&DateRecherche&"#")
if rsED4.EOF then 
    ITWMOIS="Il n'y a pas d'interview ce mois-ci"
else
    ITWMOIS=rsED4("DescriptionITW")
    'SetrsImageITW=Conn.Execute("SELECT * FROM LISTFILES where NumItw="&rsED4("NumITW")&" and NumImg=Select min(NumImg) from listfiles where NumItw="&rsED4("NumITW")")
    
    
'set rsImageITW=Conn.Execute("SELECT * FROM LISTFILES where NumItw="&rsED4("NumITW"))


            compteur_img=0
            Set rsEDimg = Conn.Execute("SELECT * FROM LISTFILES where NumItw="&rsED4("NumITW"))
                if rsEDimg.EOF Then
                    'Response.Write("Il n'y a aucune image")
                End if

                While Not rsEDimg.EOF
                compteur_img = compteur_img + 1
                numitw = rsEDimg("NumITW")
                filedir =  rsEDimg("NomImg")
                rsEDimg.MoveNext
                Wend



end if 

%>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Accueil  SITE EN CONSTRUCTION -*-*-*-*-*-*-*-*-*-*SITE EN CONSTRUCTION</div>

<div id="accueil_tableau1">
<br/><br/>
<table border="0x" width="440px"><tr><td>

    <table  border="0px">
        <tr>
            <td width="40px">
            
            
            
            
            
 <img src="img/menu/bouton_orange.gif" />
 
            <!--
            <img src="img/post_it/accueil/postit_1.jpg" />
            -->
            
            
            
            
            
            </td><td width="400px"><font face="Lucida Handwriting" color="#6faa07" size="2"><a href="p_presentation.asp"><% =Server.HtmlEncode("Bienvenue sur Rhône Solidarité !")%></a></font><br /><font color="#6faa07"> ___________________________________________________________</font></td>
        </tr>
    </table>
    <table  border="0px" cellspacing="5px">
        <tr>
            <td width="295px" align="justify" valign="top"><% =Server.HtmlEncode("Rhône solidarité est LA plate-forme d'échanges destinée aux associations de la région Rhône-Alpes crée par l'association ORAS (www.oras-conseil.com)")%></td><td width="145px"><img src="img/accueil/1.jpg" /></td>
        </tr>
    
    </table>
    <br/><br/>
    <table border="0px">
        <tr>
            <td width="40px">
            
            
            
                    
 <img src="img/menu/bouton_vert.gif"  />
 
            
                <!--
                <img src="img/post_it/accueil/postit_2.jpg" />
                -->
                
                
                
            </td>
            <td width="400px">
                <font face="Lucida Handwriting" color="#6faa07" size="2">
                    <a href="p_creer.asp">Valorisez votre projet avec un site Internet !</a>
                </font>
                <br/>
                <font color="#6faa07"> ___________________________________________________________</font>
            </td>
        </tr>
    </table>
    <table  border="0px" cellspacing="5px">
        <tr>
            <td width="295px" align="justify" valign="top">
                <% =Server.HtmlEncode("Associations, Vous avez un projet ? Vous voulez le valoriser? Rhône-Solidarité s'engage à  vous créer un site Internet attractif.")%>
            </td>
            <td width="145px">&nbsp;</td>
        </tr>
    </table>
    <br/><br/>
    <table>
        <tr>
            <td width="40px">
            
            
            
             <img src="img/menu/bouton_jaune.gif" />
            
            <!--
                <img src="img/post_it/accueil/postit_3.jpg" />
                -->
                
                
                
            </td>
            <td width="400px">
                <font face="Lucida Handwriting" color="#6faa07" size="2">
                    <a href="p_interview.asp">Interview du mois</a>
                </font>
                <br/>
                <font color="#6faa07"> _____________________________________________________________</font>
            </td>
        </tr>
    </table>
    <table cellspacing="5px">
        <tr>
            <td width="295px" align="justify" valign="top">
			<%
				if not (ITWMOIS="Il n'y a pas d'interview ce mois-ci") then
			%>
                <a href="p_interview.asp"> <%=Server.HtmlEncode(ITWMOIS)%> </a>
			<%
				else
			%>
					<%=Server.HtmlEncode(ITWMOIS)%> <br><br>
					<a href="p_interview.asp">Consulter l'interview du mois précédent</a>
			<%	
				end if 
			%>
            </td>
            <td width="145px">
            
            
                <%
                'if not rsImageITW.EOF Then
                %>
                
                <!--
                <img src="
                UploadFolder/
                <%
                '=rsImageITW("NOMIMG")
                %>
                " width="140" height="120" />
                -->
                
                <%
                if filedir<>"" then
                    Response.Write "<img src=""UploadFolder/"&filedir&""" width=""140"" height=""120"" />"
                else
                    Response.Write "<img src=""img/2_120-200.jpg"" width=""140"" height=""120"" />"
                end if





                'End if
                %>
                
                
                
            </td>
        </tr>
    </table>
    </td>
    </tr>
</table>

</div>

<div id="accueil_tableau2" align="center">
<p>
<div id="accueil_tableau21" align="center">
<table border="0px" cellpadding="10px">
        <tr>
            <td width="180px" align="justify">
                <font face="Lucida Handwriting" color="#6faa07">Espace Membre</font>
                <font color="#6faa07">___________</font>
                <br/><br/>
                <!-- #include file="p_accueil_espacemembre.asp"-->
            </td>
        </tr>
    </table>
</div>
</p>
<p>
<div id="accueil_tableau21" align="center">
<table border="0px" cellpadding="10px">
        <tr>
            <td width="180px" align="justify">
                <font face="Lucida Handwriting" color="#6faa07"><% =Server.HtmlEncode("Actualités")%></font>
                <font color="#6faa07"> __________________</font>
                <br/><br/>
                <marquee scrollamount="1" scrolldelay="20" direction="up" width="180" height="50" style="font-family: Verdana; font-size: 8pt">
                <%
                  Set rsED = Conn.Execute("SELECT * FROM ACTUALITE where Visible=1 ORDER BY DateActu DESC")


                  if rsED.EOF Then
                      Response.Write("Il n'y a pas de nouvelles actulitÃ©s")
                  End if
                  i=0
                  While (not rsED.EOF and i<3)

                  %>
                      <a class="ejs_scroll" href="p_actualitesbis.asp?num=<%=rsED("NumActu")%>"><span class="date_boite"><%=mid(rsED("DateActu"),4,8)%></span> - <%=rsED("TitreActu")%></a>
                      <br/><br/><br/>
                  <%

                  i=i+1
                  rsED.MoveNext
                  Wend
                  rsED.Close
                %>
                </marquee>
                <%'<!-- #include file="p_accueil_actualites.asp"-->%>
            </td>
        </tr>
    </table>
</div>
</p>

<p>

<div id="accueil_tableau22" align="center">
<table border="0px" cellpadding="10px">
        <tr>
            <td width="180px" align="justify"><font face="Lucida Handwriting" color="#6faa07"><% =Server.HtmlEncode("Dernières annonces")%></font><font color="#6faa07"> _________</font><br /><br />
            <marquee scrollamount="1" scrolldelay="20" direction="up" width="180" height="50" style="font-family: Verdana; font-size: 8pt">
            <%
            if rsED1.EOF Then
                Response.Write("Il n'y a pas de CV <br/> disponibles pour le moment")
            End if
            
            While not rsED1.EOF
                sDate = date
                sDiffDate = DateDiff("d", sDate, rsED1("FinCV"))
                    if sDiffDate > 0 Then
                %>
                    <a href="pa_consulter_cvbis.asp?num=<%=rsED1("NumCV")%>"><%=mid(rsED1("DateCV"),4,8)%> - <%=Server.HTMLEncode(rsED1("IntituleAnn"))%></a>
                    <br/><br/><br/>
                <%
                    End if

                rsED1.MoveNext
            Wend
            rsED1.Close
            %>
            </marquee>
            </td>
        </tr>

    </table>
</div>
</p>
</div>

<%
rsED4.close
%>

<!-- Ne pas toucher ÃƒÂ  ce qui suit : placement du footer -->

 <!-- #include file="grand_footer.txt"-->  



 
</div>

</body>
 <!-- #include file="deconnexion.asp"--> 
</html>