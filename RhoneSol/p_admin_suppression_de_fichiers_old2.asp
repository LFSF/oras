<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>




<link href="styles.css" rel="stylesheet" type="text/css" />
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

<SCRIPT language=JavaScript> 
function fonctest()
{
window.location.href="espaceadh.asp"
}
function fonc100()
{
window.location.href='testd.asp'
}
function fonc1()
{
window.location.href='ndambog.asp'
}
<!--Hide JavaScript from Java-Impaired Browsers 
//--> 


</SCRIPT>
<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>






<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>

<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Suppression des fichiers "Old" _______________________________________________________________</font></td>
    </tr>
				<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin.asp"><font size=1><b>
                         << Retour Page Administration &nbsp;</b></font>
                          </a></td></tr></table>                
                         
      
<center><FONT size=1><STRONG>Numero de la page : 1



<br></STRONG></font></center>

<br>

<form name=lesadh action="p_admin_suppression_de_fichiers_bis.asp" method="post"   id="p_admin_suppression_de_fichiers_bis.asp">
    
			
	
	
	
	
	
	<!------- autre methode----->


 <% Set FSO = Server.CreateObject("Scripting.FileSystemObject") %>


<% 
'dir = Server.MapPath("ublog_test/") 
'dir = Server.MapPath("/..")
'dir = Server.MapPath("/.")
dir = Server.MapPath("/Rhone1/.")

%>


<% set foldPt = FSO.GetFolder(dir) %>

<% set fc = foldPt.Files %>

<% set fc1 = foldPt.SubFolders %>


<% for each f in fc %>
<li>Nom : <a href="<%=f.Path%>/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>
<%

'La fonction InStr permet de rechercher si une chaîne de caractères existe à l’intérieur d’une autre chaîne de caractères. 
'Cette fonction retourne la position de la première occurrence de la chaîne recherchée. Syntaxe :
'InStr(Chaîne1, Chaîne2)
'Chaîne1 est la chaîne de caractères à traiter (sur laquelle porte la recherche).
'Chaîne2 est la chaîne de caractères recherchée dans Chaîne1.
'Exemple :
'Chaîne1 = "Sed lex dura lex" ’ Auteur inconnu
'Chaîne2 = "lex"
'Chaîne3 = "gex"
'La fonction InStr(Chaîne1,Chaîne2) retournera la valeur ".........."
'La fonction InStr(Chaîne1,Chaîne3) retournera la valeur 0.

mot_recherche="old"
'mot_recherche="tristan"
mot_recherche2="ancien"
'mot_recherche2="tristan"


leresultat =InStr(f.name, mot_recherche)
leresultat2 =InStr(f.name, mot_recherche2)


%>
<li>Mot recherché : <%=mot_recherche%> et <%=mot_recherche2%>
<li>Resultat Instr : <%=leresultat%>  et <%=leresultat2%> 
<%
if leresultat<>0 or  leresultat2<>0 then
%>
<li><font color=red>Fichier à effacer</font>
<%
end if
%>
<br><br>
<% next%>


<% for each f in fc1 %>
<li>Nom : <a href="ublog_test/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>
<%



mot_recherche="old"
'mot_recherche3="tristan"
mot_recherche2="ancien"
'mot_recherche4="tristan"


leresultat7 =InStr(f.name, mot_recherche3)
leresultat8 =InStr(f.name, mot_recherche4)


%>

<%
if leresultat7<>0 or  leresultat8<>0 then
%>
<li><font color=violet>Fichier à effacer</font>
<%
end if
%>
<br><br>
<% next%>




Le nombre d'éléments de la collection
(fichiers ou dossiers) est <% = fc.count %>  et <% = fc1.count %>



<!-- fin autre methode-->
<%	
	' ajout tristan 
	
	
	 Set FSO = nothing 
	
	%>
	<center>
	
	<br>
	


					
					
									
				
	 
	 <table border=0>
	
	 
	
	 
	 
	 
	 
	 <tr><td align=right colspan=10>
					
					 <!--<INPUT type="reset" value="Reset" id=reset1 name=reset1>-----><INPUT type="submit" value="Valider" id=submit1 name=submit1>
	
					</td></tr>	
	 
		</table>
		
		
		
		
		<center></form>
	 
               
               
               
               
       
                         
                          <!------ fin corps de texte-------------------->
		
		
		
		<!-------------------------------------------FIN AJOUT DE TEXTE IMPORTE DE ORAS----------------------------------->
       
                        
                   
                         
                          
                        
                     
                      
                      </div>
                     
                        <DIV class=txt align=justify>&nbsp;</DIV>
						<!------ fin corps de texte-------------------->
					</td>
					</tr>
					</table>


 <!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>