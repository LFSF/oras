<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<script language="JavaScript" type="text/javascript">
function textarea()
{
    alert("he wé mec!!");
    document.news.testsaisi.value=1;
}

function verifform()
{

      //test date
      var d=document.news.date.value;
	  
	  
	  if(d=="")
	  {
	        alert("Date non saisie!!!!!\n"); 
			document.news.date.focus();
			return false;
			
	  }
	  
      var amin=2009; // année mini
      var amax=2100; // année maxi
      var separateur="/"; // separateur entre jour/mois/annee
      var j=(d.substring(0,2));
      var m=(d.substring(3,5));
      var a=(d.substring(6));
      var ok=true;
	  
      if ( ((isNaN(j))||(j<1)||(j>31)) && (ok==true) ) 
	  {
         alert("Le jour n'est pas correct."); 
		 ok=false;
		 return ok;
      }
      if ( ((isNaN(m))||(m<1)||(m>12)) && (ok==true) ) 
	  {
         alert("Le mois n'est pas correct."); 
		 ok=false;
		 return ok;
      }
      if ( ((isNaN(a))||(a<amin)||(a>amax)) && (ok==true) ) 
	  {
         alert("L'année n'est pas correcte.");
		 ok=false;
		 return ok;
      }
      if ( ((d.substring(2,3)!=separateur)||(d.substring(5,6)!=separateur)) && (ok==true) ) 
	  {
         alert("Les séparateurs doivent être des "+separateur); 
		 ok=false;
		 return ok;
      }
      if (ok) 
	  {
         var d2=new Date(a,m-1,j);
         var j2=d2.getDate();
         var m2=d2.getMonth()+1;
         var a2=d2.getFullYear();
         if (a2<=100) {a2=1900+a2}
         if ( (j!=j2)||(m!=m2)||(a!=a2) ) 
		 {
            alert("La date "+d+" n'existe pas !");
            ok=false;
			return ok;
         }
      }
	  

// Vérifie si le titre est bien indiqué
//if(document.news.message.value =="<br>" || document.news.message.value =="" )
  if(document.getElementById("message").innerHTML =="<br>" || document.getElementById("message").innerHTML =="" )
 {
  alert("\nMerci d'indiquer votre message." );
  
  return false;
 }
  return true;
  
  /*if(testsaisi.value!= 1)
  {
     alert("veuillez saisir un message!!");
     return false;
  }*/

}

</script>

<script type="text/javascript" src="scripts/wysiwyg.js"></script>
<script type="text/javascript" src="js/ajaxUpload.js"></script>
<script type="text/javascript">
WYSIWYG.attach('all');
</script>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<%

if Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/verif_p_admin_actu_insert.asp" then
    Response.Write "<body onload=""location.load()"">"
else
    Response.Write "<body>"
    session("titre")=""
    session("MessageActu")=""
end if

%>





<!-- #include file="connexion.asp"-->
<!-- #include file="admin_securite.asp"-->
<!-- #include file="FCKeditor/fckeditor.asp" -->
<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!--#include file="menu_deroulant.txt"--></div>


<div align="justify">
	<table border="0px" width="100%" cellpadding="10px">
	   <tr>
			<td><font color="#6faa06">Nouvel article ______________________________________________________</font></td>
	   </tr>
	   <tr>
			<td width="82%">
	   
			<!----AJOUT CORPS DE TEXTE IMPORTE DE ORAS---->
			
			<a href="p_admin_actu.asp"><font size="1"><b><< Retour Page Administration &nbsp;</b></font></a>
	
			</td>
		</tr>
	</table>  
</div>

<form name="news" id="news" method="POST"  enctype="application/x-www-form-urlencoded" action="verif_p_admin_actu_insert.asp" onsubmit="return verifform()">
          
	<table width="100%" border="0" cellspacing="0" cellpadding="3">
				  
		<tr> 
			<td width="100">Auteur:&nbsp;<%= session("admin_nom") %> &nbsp; <%= session("admin_prenom")%></td>
		</tr>
		     
		<tr> 
			<td width="100">Date:</td>
			<div id="__champ_date__">


			<td><input type="text" name="date" value="<% Response.Write "" & FormatDateTime(Now, vbShortDate)%>"  maxlength="10"></td>
		</tr>
				  
		<tr> 
			<td width="100">Titre:</td>
			<td><%
					 if session("titre")<>"" then
					 	Response.Write "<input name=""titre"" id=""title"" type=""text"" size=""60"" maxlength=""60"" value="""&Server.HtmlEncode(session("titre"))&""">"
					 else
					 	Response.Write "<input name=""titre"" id=""title"" type=""text"" size=""60"" maxlength=""60"" >"
					 end if
				%>
			</td>
		</tr>
	
		
	</table>
	 
	
	<table border="0" width="100%" cellpadding="10px">
		<tr > 
			<td>
			    <input type="hidden" id="testsaisi" value="0">
			      <textarea class="txt" id="message" name="message" rows="10" cols="60">
				  
	        		  <%
						 if session("MessageActu")<>"" then
						 Response.Write Server.HtmlEncode(session("MessageActu"))
						end if
					 %>
				  </textarea>
			</td>
		</tr>
	  
		<tr valign="top"> 
			 <td>&nbsp;</td>
			 <td><input type="submit" name="Action" value="Valider"></td>
		</tr>
	</table>

</form>

  
  <!--fin corps de texte-->
        
        
        
        <!--fin insertion  -->
        


 

<!-- Ne pas toucher à ce qui suit : placement du footer -->


<!-- #include file="grand_footer.txt"--> 
<!--#include file="deconnexion.asp"-->
</div>
</body>
</html>