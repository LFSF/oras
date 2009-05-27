<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="header"><? include ("header.html"); ?></div>

<div id="contenu">

<div id="bandeau_orange">Interview du mois</div>

<div id="menu">
	<div id="accueil"><a href="index.php">Accueil</a></div>
    <div id="presentation"><a href="presentation.php">Pr&eacute;sentation</a></div>
    <div id="interview"><a href="interview.php">Interview du mois</a></div>
    <div id="actu"><a href="actu.php">Actualit&eacute;s</a></div>
    <div id="partenaires"><a href="partenaires.php">Nos partenaires</a></div>
    <div id="annonces"><a href="annonces.php">Annonces</a></div>
    <div id="infos"><a href="infos.php">Infos pratiques</a></div>
    <div id="rejoindre"><a href="#">Rejoignez-nous</a></div>
    <div id="blog"><a href="http://www.forum-equitable.com">Blog/Forum</a></div>
    <div id="creer_site"><a href="sites.php">Cr&eacute;ez votre site</a></div>
</div>



<%

dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
  

'Dim rsCat
'Set rsCat = Conn.Execute("SELECT * FROM t_actualites WHERE auteur = " & Request.Querystring("auteur") & "")

session("nummm")=86


Dim rsE

'edP = "SELECT * FROM t_actualites WHERE N° = " & Request.Querystring("N°") & ""

Set rsE = Conn.Execute("SELECT * FROM t_interviews WHERE  num = " & session("nummm") & "")

%>




<table border="10px" width="650px">
	
    <tr>
    	<td align="justify"><font face="Lucida Handwriting" color="#6faa07" size="2">Pr&eacute;sentation</font><font color="#6faa07"> __________________________________________________________________________________________</font>
        </td>
	</tr>
   



   
    <tr align="justify">
    	<td><h2>Mise en place d’une coopérative avicole au Cameroun par l’association ASSEQUI</h2>
   	    <p><i>
		
		
		<%=rsE("intro_interview")%>
		
		</i></p>
        </td>
    </tr>

	</table>
	
	
	
	<table  border="10px">
    	<tr align="justify">
    		<td><h3>&#149;

			<%=rsE("question1")%>
			
			
			
			</h3>

<p>
<%=rsE("reponse1")%>




</p>
			</td>
            <td width="220px" align="right"><object type="application/x-shockwave-flash" data="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top"" width="200" height="150"><param name="movie" value="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top"" /></object>
            </td>
		</tr>
    </table>
    
	
	
	<table border="10px">
	
    <tr align="justify">
    	<td><h3>&#149; <%=rsE("question2")%></h3>
   
<p>
<%=rsE("reponse2")%>

</p>

<h3>&#149;

<%=rsE("question3")%>
 
 </h3>

<p>

<%=rsE("reponse3")%>
 
 </p>
		</td>

	</tr>
    
	</table>
	
	
	<table border="10px">
	
	
	
    
    	<tr align="justify">
    		<td width="220px" align="left"><object type="application/x-shockwave-flash" data="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top"" width="200" height="150"><param name="movie" value="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top" /></object>
            </td>
		    <td>
			
			<h3>&#149; 
			
			<%=rsE("question4")%>
			
			</h3>

<p>

<%=rsE("reponse4")%>

 
 </p>
			</td>
			
		</tr>
    </table>
   


   
   <table border="10px">
   
    <tr align="justify">
    	<td>
		<h3>&#149; 
		
		<%=rsE("question5")%>
		
		
		</h3>

<p>

<%=rsE("reponse5")%>
 
 
 </p>


<h3>&#149;
<%=rsE("question6")%>
 </h3>

<p>

<%=rsE("reponse6")%>
 
 </p>
		</td>
	</tr>
	
	
	</table>
	
<table  border="10px">



	<tr align="justify">
    	<td><h3>&#149; 
		
		<%=rsE("question7")%>
		
		</h3>

<p>

<%=rsE("reponse7")%>
 
 
 </p></td>
		<td width="220px" align="right"><object type="application/x-shockwave-flash" data="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top"" width="200" height="150"><param name="movie" value="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top" /></object>
        </td>
    </tr>
</table>







<% if rsE("question8") <>"" then %>
 
   <table border="10px">
   
    <tr align="justify">
    	<td>
		<h3>&#149; 
		
		<%=rsE("question8")%>
		
		
		</h3>

<p>

<%=rsE("reponse8")%>
 
 
 </p>
 </td>
</tr></table>

 <%end if%>
 
 
 <% if rsE("question9") <>"" then %>
 
  <table border="10px">
   
    <tr align="justify">
    	<td>
 
<h3>&#149;
<%=rsE("question9")%>
 </h3>

<p>

<%=rsE("reponse9")%>
 
 </p>
		</td>
	</tr>
	
	
	</table>
	
	<% end if%>
	
	
	 
 <% if rsE("question10") <>"" then %>
	
<table  border="10px">



	<tr align="justify">
    	<td><h3>&#149; 
		
		<%=rsE("question10")%>
		
		</h3>

<p>

<%=rsE("reponse10")%>
 
 
 </p></td>
		<td width="220px" align="right"><object type="application/x-shockwave-flash" data="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top"" width="200" height="150"><param name="movie" value="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top" /></object>
        </td>
    </tr>
</table>

	<% end if%>

 
 	 
 <% if rsE("question11") <>"" then %>
   <table border="10px">
   
    <tr align="justify">
    	<td>
		<h3>&#149; 
		
		<%=rsE("question11")%>
		
		
		</h3>

<p>

<%=rsE("reponse11")%>
 
 
 </p>
</td></tr></table>
 
 	<% end if%>
	
	
	
	 <% if rsE("question12") <>"" then %>

	 
	<table border="10px">
   
    <tr align="justify">
    	<td>
		<h3>
<h3>&#149;
<%=rsE("question12")%>
 </h3>

<p>

<%=rsE("reponse12")%>
 
 </p>
		</td>
	</tr>
	
	
	</table>
	
	<% end if%>
	
	 <% if rsE("question13") <>"" then %>
	
<table  border="10px">



	<tr align="justify">
    	<td><h3>&#149; 
		
		<%=rsE("question13")%>
		
		</h3>

<p>

<%=rsE("reponse13")%>
 
 
 </p></td>
		<td width="220px" align="right"><object type="application/x-shockwave-flash" data="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top"" width="200" height="150"><param name="movie" value="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top" /></object>
        </td>
    </tr>
</table>
<% end if%>

 <% if rsE("question14") <>"" then %>
 
   <table border="10px">
   
    <tr align="justify">
    	<td>
		<h3>&#149; 
		
		<%=rsE("question14")%>
		
		
		</h3>

<p>

<%=rsE("reponse14")%>
 
 
 </p>


    </td>
    </tr>
</table>
<% end if%>
 
 
 <% if rsE("question15") <>"" then %>
 
   <table border="10px">
   
    <tr align="justify">
    	<td>
<h3>&#149;
<%=rsE("question15")%>
 </h3>

<p>

<%=rsE("reponse15")%>
 
 </p>
		</td>
	</tr>
	
	
	</table>
	
	<% end if%>
	

 <% if rsE("question16") <>"" then %>	
	
<table  border="10px">



	<tr align="justify">
    	<td><h3>&#149; 
		
		<%=rsE("question16")%>
		
		</h3>

<p>

<%=rsE("reponse16")%>
 
 
 </p></td>
		<td width="220px" align="right"><object type="application/x-shockwave-flash" data="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top"" width="200" height="150"><param name="movie" value="thierry_img_interview/dewslider.swf?xml=thierry_img_interview/diapo_1.xml&amp;randomstart=1&amp;transition=fade&amp;speed=20&amp;timer=5&amp;showbuttons=1&amp;alignbuttons="top" /></object>
        </td>
    </tr>
</table>
<% end if%>











<br /><br /><br />
<p>Association ASSEQUI<br />
<%=rsE("adresse")%><br />
<%=rsE("cp")%>&nbsp;&nbsp; <%=rsE("ville")%>Vénissieux<br />
<%=rsE("email")%></p>

<p>Propos recueilli par… « Fonction »</p>
		</td>
	</tr>

</table>

 



<!-- Ne pas toucher à ce qui suit : placement du footer -->

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

	<div id="footer"><? include ("footer.html"); ?></div>
    
</div>

</body>
</html>