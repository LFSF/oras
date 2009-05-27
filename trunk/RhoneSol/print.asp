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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<SCRIPT language=JavaScript> 
function MM_openBrWindow(theURL,winName,features) 
{ //v2.0
  window.open(theURL,winName,features);
}

function print_art() {
  var url=escape('<%=request.servervariables("SCRIPT_NAME")%>');
  var title=escape(document.title);
  window.open("print.asp",'',
'toolbar=no,location=no,directories=no,status=no,scrollbars=yes,
resizable=yes,copyhistory=no,height=350,width=550');
}
</SCRIPT>
<title>Rh&#244;ne-solidarit&#233;</title>
<script type="text/javascript" src="js/prototype.js"></script>
<script type="text/javascript" src="js/scriptaculous.js?load=effects,builder"></script>
</head>

<body>
<div id="contenu">
<div id="bandeau_orange">Interview du mois</div>
<%
if rsED.EOF then
%>
<table border="0px" width="100%" cellpadding="10px">
    
    
    
    <tr>
        <td colspan="2"><font color="#6faa06">Interviewss______________________________________________________</font></td>
    </tr>





    <tr>
        <td width=82%>
            <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
      <div align="justify">
        <br/>
        <h1>Il n'y a pas d'interview ce mois ci</h1>
      </div></td>
    </tr>
</table>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>


<%
else
%>


<table border="0px" width="100%" cellpadding="10px">
    
    
    <tr>
        <td colspan="2" align="right"><a href="javascript:window.print();" ><img src="./img racine/imp_no_border.gif" alt="Imprimer" title="Imprimer" border="0"/> Imprimer</a></td>
    </tr>
    <tr>
        <td colspan="2"><font color="#6faa06">Interview______________________________________________________</font></td>
    </tr>
                <tr>
                <td width=82%>
                     
      
      
      <div align="justify">
        <br/>
        
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->

<!--debut article-->        
<table>
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
Dim tab(20)
for i=1 to 20 
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
        <tr align="justify">
        

<%
    if compteur=5 then  
%>
            
            
            
            
            <td width="220px" align="center"  class="news_image_gauche" >
                <img class="image" src="UploadFolder/<%=tab(4)%>"   />
            </td>
            
            
            
<%
    end if      
%>

        <%
    if compteur=13 then 
%>
            
            <td width="220px" align="center"  class="news_image_gauche">
                <img class="image" src="UploadFolder/<%=tab(10)%>"   />
            </td>
<%
    end if      
%>      
            <td><h3 style="font-size:11px;font-weight:bold;font-style:italic;color:#006699;">&#149;<%=rsQuestRep("Question")%></h3>
        <%=rsQuestRep("Reponse")%>
            </td>
<%
            if compteur=1 then  
%>
            <td width="220px" align="Right">
                <img class="image" src="UploadFolder/<%=tab(1)%>"   />
            </td>
<%
    end if      
%>
            <%
            if compteur=9 then
%>
            
            <td width="220px" align="Right">
                <img class="image" src="UploadFolder/<%=tab(7)%>"   />
            </td>
<%
            end if
            
%>      

<%
            if compteur=17 then
%>
            
            <td width="220px" align="Right">
                <img class="image" src="UploadFolder/<%=tab(13)%>"   />
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

<div>
<%=rsED("StatutEnt")%>&nbsp;<%=rsED("RaiSocEnt")%>
<br/>
<%=rsED("AdrEnt")%>, <%=rsED("CPEnt")%>&nbsp; <%=rsED("VilleEnt")%>
<br/>
<%=rsED("MailRespEnt")%>
</div>



</body>
</html>


<%
end if
%>

<!-- #include file="deconnexion.asp"-->