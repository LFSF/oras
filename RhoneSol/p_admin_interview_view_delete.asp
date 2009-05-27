<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<SCRIPT language="JavaScript"> 
function MM_openBrWindow(theURL,winName,features) 
{ //v2.0
  window.open(theURL,winName,features);
}
</SCRIPT>
<script language="javascript" type="text/javascript">
function pop_it(the_form) {
   my_form = eval(the_form)
   window.open("./wait.php", "popup", "height=220,width=320,menubar='no',toolbar='no',location='no',status='no',scrollbars='no'");
   my_form.target = "popup";
   my_form.submit();
}
</script>
<title>Rh&#244;ne-solidarit&#233;</title>
<script type="text/javascript" src="js/prototype.js"></script>
<script type="text/javascript" src="js/scriptaculous.js?load=effects,builder"></script>
<script type="text/javascript" src="js/lightbox.js"></script>
<link href="styles.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="css/lightbox.css" type="text/css" media="screen" />
</head>


<!--securité page admin-->
<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<% if not(Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_interview_modif.asp" or Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_interview_visualisation.asp") then
	response.redirect("http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp")
	else
%>
<!-- #include file="connexion.asp"-->
<%
espace="&#034;"
simplecot="&#039;"
idInterview = request.querystring("idint")

'Requête qui récupère les données de l'interview (Titre, personne de l'interview, Nom organisation)
Set rsED = Conn.Execute("SELECT * FROM INTERVIEW WHERE NumItw=" & Request.Querystring("idint"))
'La prochaine interview
LeJour=Day(date)
LeMois=Month(date)
An=Year(date)
if JourItw>=16 then
	JourItw=1
	LeMois=Month(date)+1
	DateRecherche=LeMois&"/"&JourItw&"/"&An
    set rsItwNext = Conn.Execute("SELECT * FROM INTERVIEW WHERE DatePublicationItw=#"&DateRecherche&"#")
else
	JourItw=16
	DateRecherche=LeMois&"/"&JourItw&"/"&An
    set rsItwNext = Conn.Execute("SELECT * FROM INTERVIEW WHERE DatePublicationItw=#"&DateRecherche&"#")
end if 
%>


<body>


<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!--#include file="menu_deroulant.txt"--></div>


<div align="justify">
<table border="0px" width="100%" cellpadding="10px">
	<tr>
	  	<td><font color="#6faa06">Interview______________________________________________________</font></td>
    </tr>
	      
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->
</table>
</div>

<!--Titre de l'interview-->
	<!--
	<div><center>
	<%=rsED("DescriptionItw")%>
	<center></div> <br/>
	-->
<!--Fin Titre de l'interview-->
<div style="position:relative;margin-left:25px;font-family:Verdana, Arial, Helvetica, sans-serif;font-size:16px;font-weight:normal;margin-top:40px;"><font style="font-size:24px; font-style:italic;">I</font>NTERVIEW DE 
		<%=rsED("CiviliteRespEnt")%>&nbsp; <%=rsED("NomRespEnt")%>&nbsp; <%=rsED("PrenomRespEnt")%> : 
		<%=rsED("StatutEnt")%>&nbsp;<%=rsED("RaiSocEnt")%>
</div>


<p><i><%=rsED("IntroItw")%></i></p>
<br/>

<div id="test">&nbsp; </div>
<%
'Récupération des noms images	
Set rsNimg=Conn.Execute("SELECT NomImg FROM ListFiles WHERE NumItw="&rsED("NumItw"))
j=1
Dim tab(16)
for i=1 to 16 
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
			<td width="220px" align="center">
			<MARQUEE BEHAVIOR="scroll" height="120"loop="true" align="center" scrollamount="5" scrolldelay="100" onmouseover='this.stop()' onmouseout='this.start()'>
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(4)%>\' width=\'400\' height=\'260\'></div>');" onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(4)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			

			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(5)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(5)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(6)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(6)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</MARQUEE>
            </td>
	
<%
	end if		
%>

		<%
	if compteur=13 then	
%>
			<td width="220px" align="center">
			<MARQUEE BEHAVIOR="scroll" height="120"loop="true" align="center" scrollamount="5" scrolldelay="100" onmouseover='this.stop()' onmouseout='this.start()'>
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(10)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(10)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(11)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(11)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(12)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(12)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</MARQUEE>
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
			<MARQUEE BEHAVIOR="scroll" height="120"loop="true" align="center" scrollamount="5" scrolldelay="100" onmouseover='this.stop()' onmouseout='this.start()'>
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(1)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(1)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(2)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(2)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(3)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(3)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(7)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(7)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(8)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(8)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(9)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(9)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</MARQUEE>
            </td>
<%
			end if
			
%>		

<%
			if compteur=17 then
%>
			
    		<td width="220px" align="Right">
			<MARQUEE BEHAVIOR="scroll" height="120"loop="true" align="center" scrollamount="5" scrolldelay="100" onmouseover='this.stop()' onmouseout='this.start()'>
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(13)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(13)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(14)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(14)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<a href="#" onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'UploadFolder/<%=tab(15)%>\' width=\'400\' height=\'260\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="UploadFolder/<%=tab(15)%>" width="200" height="120" border="0" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</MARQUEE>
            </td>
<%
			end if
			
%>		
			</tr>
</table>	
<%
	rsQuestRep.MoveNext
			Wend
			rsQuestRep.Close 
			Set rsQuestRep = Nothing
			End If			
%>
<div id="test">&nbsp;</div>
<div align="center"><h3 style="font-size:11px;font-weight:bold;font-style:italic;color:#006699;">Galerie d'images</h3></div>
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
		<a href="UploadFolder/<%=nom_fichier%>" rel="lightbox[itw<%=idInterview%>]" title="<%=DescriptionImg%>" ><img src="UploadFolder/<%=nom_fichier%>" width='100px' height='80px' border="0"/></a>
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
<%=rsED("StatutEnt")%>&nbsp;<%=rsED("RaiSocEnt")%>
<br/>
<%=rsED("AdrEnt")%>, <%=rsED("CPEnt")%>&nbsp; <%=rsED("VilleEnt")%>
<br/>
<%=rsED("MailRespEnt")%>
</div>
<div>
<%
if rsItwNext.EOF then
else
%>
La prochaine interview à venir : <%=rsItwNext("DescriptionItw")%>
<%
end if
%>
</div>
<div align="center">
		  <h2>
			  
				<A href="javascript:;" onclick="MM_openBrWindow('envoyerami.asp','Envoyer','scrollbars=no,width=330,height=252')">Envoyer cette page &#224; un ami</A>
			 
		  </h2> 

</div>
<br>
<br>
<div align="center">
<Input Type="Button" Value="Supprimer l'interview" OnClick="window.location='InterviewDelete.asp?idint=<%=idInterview%>'">
		<Input Type="Button" Value="Valider l'interview" OnClick="window.location='Valid_Interview.asp?idint=<%=idInterview%>'">

</div>
<br>
<br>
<%
rsED.Close 
%>
<% if (session("admin_acces_admin")=1 or session("admin_validation_interview")="oui") then %>
<font color="#6faa06">Partie Administrateur______________________________________________________</font>
<br>
<br>
<!--Afficher les dates de publication--> 
<table align="center" width="100%" cellspacing="0" cellpadding="0" bordercolor="green" border="1">  
<tr><th>NumItw</th><th>Date publication</th></tr>
<%
Set rsDatePub = Conn.Execute("SELECT NumItw,DatePublicationItw FROM Interview order by NumItw asc")
		   IF rsDatePub.EOF Then
		  Response.Write("Il n'y a aucune date ")
		  Else
	  While Not rsDatePub.EOF 
%>	
		
			<tr><th><%=rsDatePub("NumItw")%></th><th><%=rsDatePub("DatePublicationItw")%></th></tr>
<%
		 
			rsDatePub.MoveNext
			Wend
			rsDatePub.Close 
			Set rsDatePub = Nothing
			End If  
%>
</table>
<br>
<!--Emplacement date publication--> 
<form action="verif_date_publication.asp" method="post" id="ITW" name="ITW">
<!--champ à cacher le numéro de l'interview ne doit pas apparaitre-->
<input name="ID_ITW" type="HIDDEN" value="<%=idInterview%>"> 
	<div align="center">
		Date de publication :
		<select id="dispo_jour" name="dispo_jour">
			<option value="01" selected>01</option>
			<option value="16">16</option>	
		</select>
								
		<select id="dispo_mois" name="dispo_mois">
			<option value="01" selected >Janvier</option>		
			<option value="02" >Février</option>
			<option value="03">Mars</option>
			<option value="04">Avril</option>
			<option value="05">Mai</option>
			<option value="06">Juin</option>
			<option value="07">Juillet</option>
			<option value="08">Août</option>
			<option value="09">Septembre</option>
			<option value="10">Octobre</option>
			<option value="11">Novembre</option>
			<option value="12">Décembre</option>
		</select>
								
							
		<select id="dispo_annee" name="dispo_annee">		
			<option value="2009" selected >2009</option>
			<option value="2010">2010</option>
			<option value="2011">2011</option>
			<option value="2012">2012</option>
			<option value="2013">2013</option>
		</select>
		<Input type="submit" Value="Valider la date de publication" onclick="pop_it(ITW);">
	</div>
</form>
<%end if%>
  <!-- Fin Emplacement date publication-->  
	   	    
  <!-- fin corps de texte-->
		
		
		
		<!--fin insertion  -->
		


 
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
<!-- #include file="deconnexion.asp"-->
</div>
</body>
<% end if %>
<% end if %>