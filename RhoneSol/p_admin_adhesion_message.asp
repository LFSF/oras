<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript> 
function fonc1()
{
window.location.href ='p_admin_adhesion_message_validation.asp'
}

</script>
<style type="text/css">
div.alien{cursor:hand}

</style>
</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Menu message adhésion _______________________________________________________________</font></td>
    </tr>
	

				<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin.asp"><font size=1><b>
                         << Retour Page Administration &nbsp;</b></font>
                          </a></td></tr></table>   



	<%response.write ( "<br><br><b>Date du jour</b>" & " " & date & "<br><br>")%>
			
<table bgcolor="#6faa06"  cellspacing="1" cellpadding="5" border="0" align="center" style="WIDTH: 409px; HEIGHT: 102px">
	<tr>
	<td align="middle">
  
	</td>
	</tr>
	<tr>
	<td align="middle">
  <font color="#6faa06">Tableau </font>
	</td>
	</tr>
	<tr>
	<td align="middle">
  
	</td>
	</tr>
	<tr>
	<td align="middle">
  
	</td>
	</tr>
  <TR>
		<td align="middle" bgcolor="white">
			<table width="192" border="0" 
				 style  ="WIDTH: 192px; HEIGHT: 15px">
			<tr>
				<div align='center' onclick="return fonc1()">
				Validation des messages adhésions</div>
			</tr>		
			</table>
		</td><!--</tr>
	<TR>-->
	</TR>
	
		
			
	
<br><br><br><br><br><br><br><br><br><br><br><br><br></table>
<P align=center>
<br><br>
<br><br><BR><BR>
<%if session("administrateur")="admin" then%>
<a href=p_admin.asp class=lien>RETOUR</a>
<% else %>
<a href=p_membres.asp class=lien>RETOUR</a>
<% end if%>

</P>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

  <!------ fin corps de texte-------------------->
		
		
		
		<!-------------------------------------------FIN AJOUT DE TEXTE IMPORTE DE ORAS----------------------------------->
       
                        
                   
                         
                          
                        
                     
                      
                   <DIV class=txt align="justify">&nbsp;</DIV>
                       
                    
						<!------ fin corps de texte-------------------->
					</td>
					</tr>
					</table>


  </center>
    
	</td></tr>

</table>

 



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>