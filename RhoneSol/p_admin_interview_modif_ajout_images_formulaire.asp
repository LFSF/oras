
<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />



<%

var_time_securite  = Request.Querystring("num")

if var_time_securite="" then
response.redirect("p_admin_interview_modif_ajout_images.asp")
end if

dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
  

'Dim rsCat
'Set rsCat = Conn.Execute("SELECT * FROM t_actualites WHERE auteur = " & Request.Querystring("auteur") & "")



Dim rsE

'edP = "SELECT * FROM t_actualites WHERE N° = " & Request.Querystring("N°") & ""

Set rsE = Conn.Execute("SELECT * FROM t_interviews WHERE  num = " & Request.Querystring("num") & "")

session("img1")= rsE("img1")
session("img2")= rsE("img2")
session("img3")= rsE("img3")
session("img4")= rsE("img4")
session("img5")= rsE("img5")
session("img6")= rsE("img6")
session("img7")= rsE("img7")
session("img8")= rsE("img8")
session("img9")= rsE("img9")
session("img10")= rsE("img10")

session("img11")= rsE("img11")
session("img12")= rsE("img12")
session("img13")= rsE("img13")
session("img14")= rsE("img14")
session("img15")= rsE("img15")
session("img16")= rsE("img16")
session("img17")= rsE("img17")
session("img18")= rsE("img18")
session("img19")= rsE("img19")
session("img20")= rsE("img20")

session("img21")= rsE("img21")
session("img22")= rsE("img22")
session("img23")= rsE("img23")
session("img24")= rsE("img24")
session("img25")= rsE("img25")
session("img26")= rsE("img26")
session("img27")= rsE("img27")
session("img28")= rsE("img28")
session("img29")= rsE("img29")
session("img30")= rsE("img30")

session("img31")= rsE("img31")
session("img32")= rsE("img32")
session("img33")= rsE("img33")
session("img34")= rsE("img34")
session("img35")= rsE("img35")
session("img36")= rsE("img36")
session("img37")= rsE("img37")
session("img38")= rsE("img38")
session("img39")= rsE("img39")
session("img40")= rsE("img40")

session("img41")= rsE("img41")
session("img42")= rsE("img42")
session("img43")= rsE("img43")
session("img44")= rsE("img44")
session("img45")= rsE("img45")
session("img46")= rsE("img46")
session("img47")= rsE("img47")
session("img48")= rsE("img48")
session("img49")= rsE("img49")
session("img50")= rsE("img50")

session("num_line") = Request.Querystring("num")

%>







<script language="JavaScript">
function verifform()
{
 if(document.proposer.rs.value == "")
  {
   alert("Merci d'indiquer le nom de votre entreprise ou organisme.");
   document.proposer.rs.focus();
   return false;
  }
 if(document.proposer.adresse.value == "")
  {
   alert("Merci d'indiquer votre adresse.");
   document.proposer.adresse.focus();
   return false;
  }
   if(document.proposer.cp.value == "")
  {
   alert("Merci d'indiquer votre code postal (99 si hors de france).");
   document.proposer.cp.focus();
   return false;
  }
   if(document.proposer.ville.value == "")
  {
   alert("Merci d'indiquer votre ville.");
   document.proposer.ville.focus();
   return false;
  }
   if(document.proposer.responsable.value == "")
  {
   alert("Merci d'indiquer le nom de responsable .");
   document.proposer.responsable.focus();
   return false;
  }
  if(document.proposer.prenom_responsable.value == "")
  {
   alert("Merci d'indiquer le prénom du responsable .");
   document.proposer.prenom_responsable.focus();
   return false;
  }
   if(document.proposer.email.value == "")
  {
   alert("Merci d'indiquer votre adresse email.");
   document.proposer.email.focus();
   return false;
  }
 adresse_email = document.proposer.email.value;
arobase = adresse_email.indexOf("@");
point = adresse_email.indexOf(".",arobase);
mauvais_endroit_point = arobase+1;
double_point = adresse_email.indexOf("..",arobase);
nbre_carac = adresse_email.length - point;
double_arobase = adresse_email.indexOf("@",arobase+1);
	
// dans l'ordre:			
// si l'arobase est absente ou en 1ere position
// ou si le . suivant l'arobase est juste derriere ou absent
// si la longueur de l'adresse est inferieure a 5 (grand minimum -> x@x.x)
// si il ya pas 2 . qui se suive deriere l'arobase
// si il y a bien 2 caractere minimum apres le . situe derriere l'arobase
// si il y a pas une arobase deriere la premiere arobase
if ( (arobase < 1) ||  
	 (point <= mauvais_endroit_point) || 
	 (adresse_email.length < 5) || 
	 (double_point >= 0) ||
	 (nbre_carac < 3) ||
	 (double_arobase >= 0) )
	{
	alert ("l'adresse email est invalide.");
    document.proposer.email.focus();
	return false;
	}
   if(document.proposer.tel.value == "")
  {
   alert("Merci d'indiquer votre téléphone.");
   document.proposer.tel.focus();
   return false;
  }
   if(document.proposer.intitule.value == "")
  {
   alert("Merci d'indiquer l'intitulé de l'offre.");
   document.proposer.intitule.focus();
   return false;
  }
   if(document.proposer.description.value == "")
  {
   alert("Merci d'indiquer la description de l'offre.");
   document.proposer.description.focus();
   return false;
  }
   if(document.proposer.duree_contrat.value == "")
  {
   alert("Merci d'indiquer la durée du contrat de l'offre.");
   document.proposer.duree_contrat.focus();
   return false;
  }
 }
 

 
 
 </script>
<script language="JavaScript">
<!--
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>

<script language="Javascript1.2">
<!-- // load htmlarea
_editor_url = "";                     
// URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if 
(win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} 
else 
{ document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// -->
</script>

<script language="JavaScript">

function fonc2()
{
if((event.keyCode<48)||(event.keyCode>57))

	{
	// alert(window.event.keyCode);
	alert("Attention uniquement des chiffres !");
	event.returnValue=false;
	}
}



 function fonc_delete(id)
{
foo=id
//alert(id);
}

function affichage(id)
{
foo=id
alert(foo);
}

</script>


<script type="text/javascript" language="javascript" src="infobulle.js"></script>
<style type="text/css">
div.alien{cursor:hand}

</style>
</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>


<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Choix des images_______________________________________________________________</font></td>
    </tr>
				<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin_interview_modif_ajout_images.asp"><font size=1><b>
                         << Retour Menu Interview &nbsp;</b></font>
                          </a></td></tr></table>
                <table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>

<%session("num")=rsE("num")%>


<form name="frmSend" method="POST" enctype="multipart/form-data" action="upload_p_admin_interview_modif_ajout_images.asp">


<B><font color=red>Attention! La limite par Upload est de 10Mo</font></B><br><br><br><br><br><br>

	
	
	
	
		 <%
	zecompteur=1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img1")<>"" then%>
	 <B><font color=green><%=rsE("img1")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img1")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img1")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
		 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img2")<>"" then%>
	 <B><font color=green><%=rsE("img2")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img2")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img2")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	
		 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img3")<>"" then%>
	 <B><font color=green><%=rsE("img3")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img3")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img3")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
		 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img4")<>"" then%>
	 <B><font color=green><%=rsE("img4")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img4")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img4")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	
		 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img5")<>"" then%>
	 <B><font color=green><%=rsE("img5")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img5")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img5")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	
		 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img6")<>"" then%>
	 <B><font color=green><%=rsE("img6")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img6")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img6")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
		 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img7")<>"" then%>
	 <B><font color=green><%=rsE("img7")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img7")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img7")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	
	
		 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img8")<>"" then%>
	 <B><font color=green><%=rsE("img8")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img8")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img8")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img9")<>"" then%>
	 <B><font color=green><%=rsE("img9")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img9")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img9")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img10")<>"" then%>
	 <B><font color=green><%=rsE("img10")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img10")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img10")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img11")<>"" then%>
	 <B><font color=green><%=rsE("img11")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img11")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img11")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img12")<>"" then%>
	 <B><font color=green><%=rsE("img12")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img12")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img12")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img13")<>"" then%>
	 <B><font color=green><%=rsE("img13")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img13")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img13")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img14")<>"" then%>
	 <B><font color=green><%=rsE("img14")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img14")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img14")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img15")<>"" then%>
	 <B><font color=green><%=rsE("img15")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img15")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img15")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img16")<>"" then%>
	 <B><font color=green><%=rsE("img16")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img16")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img16")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img17")<>"" then%>
	 <B><font color=green><%=rsE("img17")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img17")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img17")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img18")<>"" then%>
	 <B><font color=green><%=rsE("img18")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img18")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img18")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img19")<>"" then%>
	 <B><font color=green><%=rsE("img19")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img19")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img19")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img20")<>"" then%>
	 <B><font color=green><%=rsE("img20")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img20")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img20")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img21")<>"" then%>
	 <B><font color=green><%=rsE("img21")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img21")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img21")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img22")<>"" then%>
	 <B><font color=green><%=rsE("img22")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img22")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img22")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img23")<>"" then%>
	 <B><font color=green><%=rsE("img23")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img23")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img23")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img24")<>"" then%>
	 <B><font color=green><%=rsE("img24")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img24")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img24")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img25")<>"" then%>
	 <B><font color=green><%=rsE("img25")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img25")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img25")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img26")<>"" then%>
	 <B><font color=green><%=rsE("img25")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img26")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img26")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img27")<>"" then%>
	 <B><font color=green><%=rsE("img27")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img27")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img27")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img28")<>"" then%>
	 <B><font color=green><%=rsE("img28")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img28")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img28")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img29")<>"" then%>
	 <B><font color=green><%=rsE("img29")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img29")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img29")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img30")<>"" then%>
	 <B><font color=green><%=rsE("img30")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img30")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img30")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img31")<>"" then%>
	 <B><font color=green><%=rsE("img31")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img31")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img31")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img32")<>"" then%>
	 <B><font color=green><%=rsE("img32")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img32")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img32")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img33")<>"" then%>
	 <B><font color=green><%=rsE("img33")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img33")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img33")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img34")<>"" then%>
	 <B><font color=green><%=rsE("img34")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img34")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img34")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img35")<>"" then%>
	 <B><font color=green><%=rsE("img35")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img35")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img35")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img36")<>"" then%>
	 <B><font color=green><%=rsE("img36")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img36")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img36")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img37")<>"" then%>
	 <B><font color=green><%=rsE("img37")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img37")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img37")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img38")<>"" then%>
	 <B><font color=green><%=rsE("img38")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img38")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img38")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img39")<>"" then%>
	 <B><font color=green><%=rsE("img39")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img39")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img39")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img40")<>"" then%>
	 <B><font color=green><%=rsE("img40")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img40")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img40")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img41")<>"" then%>
	 <B><font color=green><%=rsE("img41")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img41")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img41")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	 
	 
	  <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img42")<>"" then%>
	 <B><font color=green><%=rsE("img42")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img42")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img42")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	


	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img43")<>"" then%>
	 <B><font color=green><%=rsE("img43")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img43")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img43")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>

	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img44")<>"" then%>
	 <B><font color=green><%=rsE("img44")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img44")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img44")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img45")<>"" then%>
	 <B><font color=green><%=rsE("img45")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img45")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img45")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img46")<>"" then%>
	 <B><font color=green><%=rsE("img46")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img46")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img46")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img47")<>"" then%>
	 <B><font color=green><%=rsE("img47")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img47")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img47")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img48")<>"" then%>
	 <B><font color=green><%=rsE("img48")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img48")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img48")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img49")<>"" then%>
	 <B><font color=green><%=rsE("img49")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img49")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img49")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
	
	
	 <%
	zecompteur=zecompteur +1
	response.write("<font color='blue'>Image : " & zecompteur & "</font>")
	%>
	 <% if rsE("img50")<>"" then%>
	 <B><font color=green><%=rsE("img50")%>&nbsp;________________________</font></B>
	 <img src="fichiers_upload/upload_interviews/<%=rsE("img50")%>" width="100px" >&nbsp;&nbsp;&nbsp;
	 <div  name="img<%=zecompteur%>"  id="img<%=zecompteur%>"  onclick="window.location='p_admin_interview_modif_ajout_images_delete.asp?var_img=<%=rsE("img50")%>&var_id=<%=session("num_line")%>&var_cell=<%=zecompteur%>'"><img src="img/postdelete.gif" border="0"></div>
	 <br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
     <input name="img<%=zecompteur%>"  onclick="return affichage('img<%=zecompteur%>')" id="img<%=zecompteur%>" type="file" size=35><br><br><br>
	 <%else%>
	 <B><font color=green>Emplacement vide&nbsp;_________________</font></B><br><br>
	 <B>Joindre un fichier à cet emplacement <font color=red>( < 2Mo)</font></B><br><br>
	 <input name="img<%=zecompteur%>" id="img<%=zecompteur%>"   type="file" size=35><br><br><br>
	 <%end if%>
	
    <br>
	
	
	<input type="hidden" name="num" value="<%=rsE("num")%>"><input   style="margin-top:4"  type=submit  value="Upload">	<br>


	</form>
	

					
				  
				  
					</td>
                  </tr>
				  
                </table></center>
	</td></tr><tr><td colspan="2"></td></tr></table>

<!------ fin corps de texte-------------------->
		
		
		
		<!--           fin insertion  -->
		


 
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>
<% end if %>