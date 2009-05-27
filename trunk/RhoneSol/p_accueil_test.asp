<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<SCRIPT LANGUAGE="JavaScript">
function fonc1()
{
window.location.href='p_infos_historique.asp'
}
function fonc2()
{
window.location.href='p_infos_definition.asp'
}
function fonc3()
{
window.location.href='p_infos_cadre.asp'
}
function fonc4()
{
window.location.href='p_infos_financements.asp'
}
</SCRIPT>


<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>


<%
		
		  
		  dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
		  
		  
		  
		  Set rsED1 = Conn.Execute("SELECT * FROM t_depotcv where visible_sur_site='oui' and profil='emploi' ORDER BY date_inscription DESC")
		Set rsED2 = Conn.Execute("SELECT * FROM t_depotcv where visible_sur_site='oui' and profil='stage' ORDER BY  date_inscription  DESC")
		 Set rsED3 = Conn.Execute("SELECT * FROM t_depotcv where visible_sur_site='oui' and profil='autre'  ORDER BY  date_inscription  DESC")
					%>

<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Accueil  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SITE EN CONSTRUCTION   SITE EN CONSTRUCTION</div>

<!--
<div id="post-it"><b><i>Sommaire</i></b><br />
_________________________________________________________<br /><br />

   ><em onclick="return fonc1()" onMouseOver="this.style.cursor='hand'; "> Historique</em><br />
   > <em onclick="return fonc2()" onMouseOver="this.style.cursor='hand'; ">Définition et principe</em><br />
   > <em onclick="return fonc3()" onMouseOver="this.style.cursor='hand'; ">Cadre législatif et réglementaire</em><br />
   > <em onclick="return fonc4()" onMouseOver="this.style.cursor='hand'; ">Où trouver des financements ?</em><br /></div>
-->
<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Présentation_____________________________________________________________</font></td>
    </tr>
	
	<tr>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	</tr>
	
	</table>
	

<div id="accueil_tableau1">

<table border="0x" width="440px"><tr><td>

	<table  border="0px">
		<tr>
    		<td width="40px"><img src="img/post_it/accueil/postit_1.jpg" /></td><td width="400px"><font face="Lucida Handwriting" color="#6faa07" size="2"><a href="p_presentation.asp">Bienvenue sur Rhône Solidarité !</a></font><br /><font color="#6faa07"> ___________________________________________________________________</font></td>
    	</tr>
    </table>
    <table  border="0px" cellspacing="5px">
	    <tr>
    		<td width="295px" align="justify" valign="top">Rhône solidarité est LA plate-forme d’échanges destinée aux associations de la région Rhône-Alpes crée par l’association ORAS (www.oras-conseil.com)</td><td width="145px"><img src="img/accueil/1.jpg" /></td>
	    </tr>
    </table>
    
    <table border="0px">
		<tr>
    		<td width="40px"><img src="img/post_it/accueil/postit_2.jpg" /></td><td width="400px"><font face="Lucida Handwriting" color="#6faa07" size="2"><a href="p_creer.asp">Valorisez votre projet avec un site Internet !</a></font><br /><font color="#6faa07"> ___________________________________________________________________</font></td>
    	</tr>
    </table>
    <table  border="0px" cellspacing="5px">
	    <tr>
    		<td width="295px" align="justify" valign="top">Associations, Vous avez un projet ? Vous voulez le valoriser? Rhône-Solidarité s’engage à vous créer un site Internet attractif.</td><td width="145px">&nbsp;</td>
	    </tr>
    </table>
    
    <table>
		<tr>
    		<td width="40px"><img src="img/post_it/accueil/postit_3.jpg" /></td><td width="400px"><font face="Lucida Handwriting" color="#6faa07" size="2"><a href="p_interview.asp">Interview du mois</a></font><br /><font color="#6faa07"> ___________________________________________________________________</font></td>
    	</tr>
    </table>
    <table cellspacing="5px">
	    <tr>
    		<td width="295px" align="justify" valign="top">Mise en place d’une coopérative avicole au Cameroun par l’association ASSEQUI.</td><td width="145px"><img src="img/accueil/2.jpg" /></td>
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
    		<td width="180px" align="justify"><font face="Lucida Handwriting" color="#6faa07">Actualités</font><font color="#6faa07"> __________________</font><br /><br /><!-- #include file="p_accueil_actualites.asp"--></td>
	    </tr>
    </table>
</div>
</p>

<p>

<div id="accueil_tableau22" align="center">
<table border="0px" cellpadding="10px">
	    <tr>
    		<td width="180px" align="justify"><font face="Lucida Handwriting" color="#6faa07">Dernières annonces</font><font color="#6faa07"> _________</font><br /><br /><marquee scrollamount="1" scrolldelay="20" direction="up" width="200" height="50" style="font-family: Verdana; font-size: 8pt">
<a href="pa_consulter_cvbis.asp?num=<%=rsED1("num")%>"><%=mid(rsED1("date_inscription"),4,8)%> - <%=rsED1("intitule")%> (emploi)</a> 
 <br /><br /><br />

<a href="pa_consulter_cvbis.asp?num=<%=rsED2("num")%>"><%=mid(rsED2("date_inscription"),4,8)%> - <%=rsED2("intitule")%> (stage)</a> 
<br /><br /><br />
<a href="pa_consulter_cvbis.asp?num=<%=rsED3("num")%>"><%=mid(rsED3("date_inscription"),4,8)%> - <%=rsED3("intitule")%> (autre)</a>

</marquee>
</td>
	    </tr>
    </table>
</div>
</p>
</div>
 


 



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>