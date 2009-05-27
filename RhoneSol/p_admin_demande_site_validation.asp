<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
<title>Rh&Atilde;&acute;ne-solidarit&Atilde;&copy;</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

</head>

<body>

<!-- #include file="admin_securite.asp"-->
<!-- #include file="grand_header.txt"-->
<!-- #include file="FCKeditor/fckeditor.asp" -->


<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!--#include file ="menu_deroulant.txt" --></div>

<div align="justify">
<table border="0px" width="100%" cellpadding="10px">
	<tr>
    	<td colspan="2"><font color="#6faa06">Menu des demandes de site _______________________________________________________________</font></td>
    </tr>
	<tr>
		<td width=82%>
					 
	 
        <!------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin_demandes_site.asp"><font size=1><b><< Retour Menu des demandes de site &nbsp;</b></font>
        </a>
		</td>
	</tr>
</table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<%
			  			
		  Dim Place
		  Place = 0
		  Dim rsED
		  Set rsED = Conn.Execute("SELECT * FROM CREATION WHERE validation=0")
	  %>
      <%
		  IF rsED.EOF Then
		  Response.Write("Il n'y a aucune demande pour le moment ")
		  Else
		  While Not rsED.EOF
	  %>
		  
      <%
		  If strBgcolor = "#F1F1F1" Then
		  strBgcolor = "#FFFFFF"
		Else
			strBgcolor = "#F1F1F1"
	    End If
	   %>
<a href="p_admin_demande_site_display.asp?NumCrea=<%=rsED("NumCrea")%>"><tr bgcolor="<%=strBgcolor%>"onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
<tr>
	<td width="15"> 
             <% Place = Place+1 %>
             <b><%=Place%></b>
	</td>
    <td width="150"></td>
    <td><%=rsED("NomCrea")%>&nbsp;&nbsp;<%=rsED("PrenomCrea")%></td>
	<td><%=rsED("ProjetCrea")%></td>
	<td width="20"><a href="p_admin_demande_site_display.asp?NumCrea=<%=rsED("NumCrea")%>"><img src="img/postdisplay.gif" border="0"></td></a>
    <td width="20"><a href="p_admin_demande_site_validation.asp?NumCrea=<%=rsED("NumCrea")%>"><img src="img/postvalid.gif" border="0"></a></td>
           <!---<td width="20"><a href="p_admin_idees_delete.asp?NumCrea=<'%=rsED("NumCrea")%>"><img src="postdelete.gif" border="0"></a></td>---> 
</tr>
</a>
<%
	rsED.MoveNext
	Wend
	rsED.Close 
	Set rsED = Nothing
	End If
%>
</table>
			
<% if (Request.Querystring("NumCrea")>0) then
					Dim rsED2
					Set rsED2 = Conn.Execute("SELECT * FROM Creation WHERE NumCrea = " & Request.Querystring("NumCrea") & "")
%>
<br><br><br>
				
<div>
				
	Répondre à <%=rsED2("NomCrea")%>&nbsp;<%=rsED2("PrenomCrea")%> &agrave; l'adresse <%=rsED2("MailCrea")%> : <br/>
	<form action="p_admin_demande_site_valid.asp?NumCrea=<%=rsED2("NumCrea")%>" method="post" id="contact" name="contact" onsubmit="return verifform()">
	<%
			Dim oFCKeditor
			Set oFCKeditor = New FCKeditor
			oFCKeditor.BasePath = "FCKeditor/"
			oFCKeditor.Create "FCKeditor1"
	%>
		<input type="submit" value="envoyer" id="envoyer" name="envoyer" width="109" height="16" border="0">
	</form>
</div>

<%
		'rsED2.Close 
		'Set rsED2 = Nothing	
 end if 
 %>
  
  
 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
  <!------ fin corps de texte-------------------->
		<!-------------------------------------------FIN AJOUT DE TEXTE IMPORTE DE ORAS----------------------------------->
                      
<DIV class=txt align="justify">&nbsp;</DIV>
                    
						<!------ fin corps de texte-------------------->
					
<!-- Ne pas toucher à ce qui suit : placement du footer -->

  <!-- #include file="grand_footer.txt"-->  
  <!-- #include file="deconnexion.asp"-->
</div>
</body>
</html>