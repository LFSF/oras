<!-- #include file="connexion.asp"-->

<%
espace="&#034;"
simplecot="&#039;"
idInterview = request.querystring("idint")

'Requête qui récupère les données de l'interview (Titre, personne de l'interview, Nom organisation) en fonction de la date
LeJour=Day(date)
LeMois=Month(date)
An=Year(date)


'SELECT INTERVIEW.NumItw, INTERVIEW.DatePublicationItw
'FROM INTERVIEW
'WHERE (((INTERVIEW.DatePublicationItw)=#1/16/2009#)); * MM/JJ/AAAA *

'interview du mois
'Récupérer le jour
if LeJour>=16 then
    JourItw=16
else
    JourItw=1
end if

DateRecherche=LeMois&"/"&JourItw&"/"&An
Set rsED = Conn.Execute("SELECT * FROM INTERVIEW WHERE DatePublicationItw=#"&DateRecherche&"#")


if rsED.EOF then
        JourItw=1
        DateRecherche=LeMois&"/"&JourItw&"/"&An
        'interview précédente
        Set rsED = Conn.Execute("SELECT * FROM INTERVIEW WHERE DatePublicationItw=#"&DateRecherche&"#")
        
        if rsED.EOF then
            LeMois=Month(date)
            LeMois=LeMois-1
            JourItw=16
            DateRecherche=LeMois&"/"&JourItw&"/"&An
            Set rsED = Conn.Execute("SELECT * FROM INTERVIEW WHERE DatePublicationItw=#"&DateRecherche&"#")
        end if
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" media="print" href="print.css" />
<script type="text/javascript" src="js/prototype.js"></script>
<script type="text/javascript" src="js/scriptaculous.js?load=effects,builder"></script>
<script type="text/javascript" src="js/lightbox.js"></script>
<link rel="stylesheet" href="css/lightbox.css" type="text/css" media="screen" />

</head>
<body>
<!-- #include file="grand_header.txt"-->
<SCRIPT LANGUAGE="Javascript1.1">
function fonc_print() { 
window.print(); 
} 

</SCRIPT>
<SCRIPT language="JavaScript"> 
function MM_openBrWindow(theURL,winName,features) 
{ //v2.0
  window.open(theURL,winName,features);
}
</SCRIPT>
<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="banniere">Interview du mois</div>

<%
if rsED.EOF then
%>

    <table id="banniere" border="0px" width="100%" cellpadding="10px">

        <tr>
            <td colspan="2"><font color="#6faa06">Interviews______________________________________________________</font></td>
        </tr>
        <tr>
            <td width=82%>
                <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
            </td>
        </tr>
    </table>
    <div align="justify">
        <br/>
        <h1>Il n'y a pas d'interview ce mois ci</h1>
    </div>
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>  <br/><br/><br/><br/>

<%
else
%>
    <table  border="0px" width="100%" cellpadding="10px">
         <table id = "banniere" width="100%" cellpadding="10px">
        <tr>
            <td colspan="2" align="right"><a href="javascript:;" value = 'Imprimer le tableau actuel' onclick="javascript:window.print()" ><img src="./img racine/imp_no_border.jpg" alt="Imprimer" title="Imprimer" border="0" height="25"  width="23"/> Imprimer</a><a href="javascript:;" onclick="MM_openBrWindow('envoyerami.asp','Envoyer','scrollbars=no,width=330,height=252')"><img src="./img racine/part_no_border.gif" alt="Envoyer cette page &#224; un ami" title="Envoyer cette page &#224; un ami" border="0"/> Partager</a></td>
        </tr>
        <tr>
            <td colspan="2"><font color="#6faa06">Interview______________________________________________________</font></td>
        </tr>
         </table>            <tr>
                    <td width=82%>
                         
             
           <div align="justify">
		<br/>
        
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->

		
<table id="tableau">
<br/>
<!--Titre de l'interview-->
	<!--
	<div><center><%=rsED("DescriptionItw")%><center></div> <br/>
	-->
<!--Fin Titre de l'interview-->
	<div style="position:relative;margin-left:25px;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:16px;font-weight:normal;margin-top:40px;">
		<font style="font-size:24px; font-style:italic;">I</font>NTERVIEW DE 
				<%=rsED("CiviliteRespEnt")%>&nbsp; <%=rsED("NomRespEnt")%>&nbsp; <%=rsED("PrenomRespEnt")%> : 
				<%=rsED("StatutEnt")%>&nbsp;<%=rsED("RaiSocEnt")%>
	</div>
				<div id="test">&nbsp;</div>

				
    <tr align="justify">

    	<td>
       
	   	    <p><i><%=rsED("IntroItw")%></i></p>

        </td>
    
    </tr>
</table>

</p><br/>
</div>

        
<%
'Récupération des noms images	
Set rsNimg=Conn.Execute("SELECT NomImg FROM ListFiles WHERE NumItw="&rsED("NumItw"))
j=1
Dim tab(12)
for i=1 to 12 
if rsNimg.EOF then 
else
 tab(i)= rsNimg("NomImg")
rsNimg.MoveNext
end if
next 



	
'Récupération des Questions Réponses
Set rsQuestRep=Conn.Execute("SELECT Question,Reponse FROM QUESTION WHERE NumItw="&rsED("NumItw"))



 IF rsQuestRep.EOF Then
		  Response.Write("Il n'y a ni question ni réponse ")
		  Else
		  While Not rsQuestRep.EOF
			'affichage des questions et réponses de l'interview
			compteur=compteur+1
		%>	
    <table>
            <tr >
            

    <%
        if compteur=5 then  
    %>
                
                
                
                
                <td width="220px" align="center"  class="news_image_gauche" align="justify">
                
                <!--
                <td width="220px" align="justify"  class="news_image_gauche" >
            -->
                
                
                    <MARQUEE BEHAVIOR="scroll" height="120"loop="true" align="center" scrollamount="5" scrolldelay="100" onmouseover='this.stop()' onmouseout='this.start()'>
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(4)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(4)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(5)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(5)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(6)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(6)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </MARQUEE>
            
            
            
            
            
                </td>
                
                
                
    <%
        end if      
    %>

            <%
        if compteur=13 then 
    %>
                
                <td width="220px" align="center"  class="news_image_gauche" align="justify">
                
                
                
                
                
                    <MARQUEE BEHAVIOR="scroll" height="120"loop="true" align="center" scrollamount="5" scrolldelay="100" onmouseover='this.stop()' onmouseout='this.start()'>
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(10)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(10)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(11)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(11)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(12)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(12)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </MARQUEE>
                </td>
    <%
        end if      
    %>      
                <td align="justify"><h3 style="font-size:11px;font-weight:bold;font-style:italic;color:#006699;">&#149;<%=Server.HtmlEncode(rsQuestRep("Question"))%></h3>
            <div align="justify"><%=Server.HtmlEncode(rsQuestRep("Reponse"))%></div>
                </td>
    <%
                if compteur=1 then  
    %>
                <td width="220px" align="Right" >
                    <MARQUEE BEHAVIOR="scroll" height="120"loop="true" align="center" scrollamount="5" scrolldelay="100" onmouseover='this.stop()' onmouseout='this.start()'>
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(1)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(1)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(2)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(2)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(3)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(3)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </MARQUEE>
                </td>
    <%
        end if      
    %>
                <%
                if compteur=9 then
    %>
                
                <td width="220px" align="Right">
                    <MARQUEE BEHAVIOR="scroll" height="120"loop="true" align="center" scrollamount="5" scrolldelay="100" onmouseover='this.stop()' onmouseout='this.start()'>
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(7)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(7)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(8)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(8)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(9)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(9)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </MARQUEE>
                </td>
    <%
                end if
                
    %>      

    <%
                if compteur=17 then
    %>
                
                <td width="220px" align="justify">
                    <MARQUEE BEHAVIOR="scroll" height="120"loop="true" align="center" scrollamount="5" scrolldelay="100" onmouseover='this.stop()' onmouseout='this.start()'>
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(13)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(13)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(14)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(14)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
                <a href="#"
    onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(15)%>\' width=\'400\' height=\'260\'></div>');" 
    onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(15)%>" width="180" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </MARQUEE>
                </td>
    <%
                end if
                
    %>      
            </tr>
        </table>
    <!--fin article-->    
    <%
        
                
                rsQuestRep.MoveNext
                Wend
                rsQuestRep.Close 
                Set rsQuestRep = Nothing
                End If          
    %>
    <div id="test">&nbsp;</div>
    <center><h3 style="font-size:11px;font-weight:bold;font-style:italic;color:#006699;">Galerie d'images</h3></center>
    <div>
    <%
    'affichage des images de l'interview
    Set rsImg = Conn.Execute("SELECT * FROM ListFiles WHERE NumItw="&rsED("NumItw"))
               IF rsImg.EOF Then
              Response.Write("Il n'y a aucun fichier ")
              Else
              While Not rsImg.EOF 

                nom_fichier=rsImg("NomImg")
    %>  
            <a href="UploadFolder/<%=nom_fichier%>" rel="lightbox[itw<%=idInterview%>]" title="<%=DescriptionImg%>" >
            <img src="UploadFolder/<%=nom_fichier%>" width='100px' height='80px' border="0"/>
            </a>
    <%
             
                rsImg.MoveNext
                Wend
                rsImg.Close 
                Set rsImg = Nothing
                End If
                
    %>  
    </div>      
            
            
    <br/>
    <br/>   
    <br/>
    <br/>
    <div>
    <%=Server.HTMLEncode(rsED("StatutEnt"))%>&nbsp;<%=Server.HTMLEncode(rsED("RaiSocEnt"))%>
    <br/>
    <%=Server.HTMLEncode(rsED("AdrEnt"))%>, <%=Server.HTMLEncode(rsED("CPEnt"))%>&nbsp; <%=Server.HTMLEncode(rsED("VilleEnt"))%>
    <br/>
    <%=Server.HTMLEncode(rsED("MailRespEnt"))%>
    </div>
    <div>
    <%
    'La prochaine interview
    if Day(date)>=16 then
        JourItw=1
        LeMois=Month(date)+1
        DateRecherche=LeMois&"/"&JourItw&"/"&An
        set rsItwNext = Conn.Execute("SELECT * FROM INTERVIEW WHERE DatePublicationItw=#"&DateRecherche&"#")
    else
        JourItw=16
        DateRecherche=LeMois&"/"&JourItw&"/"&An
        set rsItwNext = Conn.Execute("SELECT * FROM INTERVIEW WHERE DatePublicationItw=#"&DateRecherche&"#")
    end if 
    if rsItwNext.EOF then
    else
    %>
    La prochaine interview &#224; venir : <%=rsItwNext("DescriptionItw")%>
    <%
    end if
    %>
    </div>

    <div id="banniere">
              <h2> 
                    <A href="p_interview_archive_visualisation.asp">
                        Acc&#233;der aux Interviews archiv&#233;s
                    </A>
              </h2> 

    </div>
    <br/>
    <br/>


<%
end if
%>

<!-- Ne pas toucher à ce qui suit : placement du footer -->

<div id="banniere">

  <!-- #include file="grand_footer.txt"--> 
  </div>
</body>
</html>

<!-- #include file="deconnexion.asp"-->