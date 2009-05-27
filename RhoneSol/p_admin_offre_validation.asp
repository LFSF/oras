<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_off")= 1) then
	response.redirect("p_admin.asp")
	else
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!--#include file ="menu_deroulant.txt" --></div>
<table border="0px" width="100%" cellpadding="10px">
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
				<tr>
				<td width=82%>
					 
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin.asp"><font size=1><b>
                         << Retour Page Administration &nbsp;</b></font>
                          </a></td></tr></table> 
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <%
		  Dim Place
		  Place = 0
		  Dim rsED
		  
	  
		  
		  Set rsED = Conn.Execute("SELECT * FROM OFFRES where Visible=0 ORDER BY ProfilOff DESC, DateOff ASC")
		  %>
              <%
		  While Not rsED.EOF
		  %>
              <%
					If strBgcolor = "#F1F1F1" Then
						strBgcolor = "#FFFFFF"
					Else
						strBgcolor = "#F1F1F1"
					End If
					%>
           <a href="p_admin_offre_display.asp?num=<%=rsED("NumOff")%>"><tr bgcolor="<%=strBgcolor%>"onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place = Place+1 %>
                  <b><%=Place%></b>&nbsp;&nbsp;</td>
                <td width="150"><%=rsED("DateOff")%>&nbsp;</td>
                <td><%=rsED("IntituleOff")%>&nbsp;&nbsp;</td>
				<%if rsED("ProfilOff") = 1 then %>
				<td><%response.write("Emploi")%>&nbsp;&nbsp;</td>
				<% else %>
				<%if rsED("ProfilOff") = 2 then %>
				<td><%response.write("Stage")%>&nbsp;&nbsp;</td>
				<% else %>
				<%if rsED("ProfilOff") = 3 then %>
				<td><%response.write("Autre")%>&nbsp;&nbsp;</td>
				<% else %>
				<%if rsED("ProfilOff") = 4 then %>
				<td><%response.write("Benevole")%>&nbsp;&nbsp;</td>
				<% end if
end if
end if
end if				%>
				 <td><%=rsED("DureeOff")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td width="20"><a href="p_admin_offre_display.asp?num=<%=rsED("NumOff")%>"><img src="img/postdisplay.gif" border="0"></a></td>
                <td width="20"><a href="p_admin_offre_valid.asp?num=<%=rsED("NumOff")%>"><img src="img/postvalid.gif" border="0"></a></td>
				
				<td width="20"><a href="p_admin_offre_delete.asp?num=<%=rsED("NumOff")%>"><img src="img/postdelete.gif" border="0"></a></td>
                
              </tr></a>
			  
			  <!-----------------Initialisation de la session-------------->
			  
		
			  <!-----------------Fin initialisation de la session----------------------->
			  
			  
              <%
			rsED.MoveNext
			Wend
			rsED.Close 
			Set rsED = Nothing
			%>
            </table></td>
        </tr>
      </table>
		
		
		<!--           fin insertion  -->
		


 
<br />
<br />
<br />
<br />
<br />
<br />
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>


</body>
<!-- #include file="deconnexion.asp"-->
</html>
<%end if%>