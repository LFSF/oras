<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<!-- #include file="connexion.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>

<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<div align="justify">

<table border="0px" width="100%" cellpadding="10px">
    <tr>
        <td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
    <tr>
        <td width=82%>
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->
            <A class=lien href="p_admin_actu.asp"><font size="1"><b>
                    << Retour Menu Article &nbsp;</b></font>
            </a>
        </td>
    </tr>
</table>
</div>

<% if (session("admin_acces_admin")=1 ) then %> 



<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<%
	session("actu_del") = "m"
	Dim Place
	Place = 0

	'Set rsED = Conn.Execute("SELECT * FROM ACTUALITE where Visible=0 ORDER BY DateActu DESC")

	Set rsED = Conn.Execute("SELECT * FROM ACTUALITE  ORDER BY DateActu DESC")

	While Not rsED.EOF

	If strBgcolor = "#F1F1F1" Then
    strBgcolor = "#FFFFFF"
	Else
    strBgcolor = "#F1F1F1"
	End If


	if(rsED("Visible")=1 ) then
	actu_valide ="<font color='blue'>oui</font>"
	else
	actu_valide ="<font color='red'>non</font>"
	end if

%>

	<%
		session("NumActu") = rsED("NumActu")
	%>
	<tr bgcolor="<%=strBgcolor%>"> 
    	<td width="5%"><% Place = Place+1 %><b><%=Place%></b>&nbsp;&nbsp;</td>
        <td width="10%"><%=rsED("DateActu")%>&nbsp;</td>
        <td width="55%"><%=rsED("TitreActu")%></a>&nbsp;&nbsp;</td>
        <td width="5%"><%=actu_valide%></a>&nbsp;&nbsp;</td>
        <td width="10%"><%=rsED("PieceJointesActu")%> <%session("recup_pieces_jointes")= rsED("PieceJointesActu")%></a></td>
        <td ><a href="p_admin_actu_modif_display.asp?num=<%=rsED("NumActu")%>"><img src="img/postdisplay.gif" border="0"></a></td>
		
      <% if (session("admin_acces_admin")=1 or session("admin_validation_actualites")=1) then %>
        <td ><a href="p_admin_actu_modif_valid.asp?num=<%=rsED("NumActu")%>"><img src="img/postvalid.gif" border="0"></a></td>
      <%end if%>
	  
        <td ><a href="p_admin_actu_modif_edit.asp?num=<%=rsED("NumActu")%>"><img src="img/postedit.gif" border="0"></a></td>
      
	  <% if (session("admin_acces_admin")=1 or session("admin_validation_actualites")=1) then %>
         <td ><a href="p_admin_actu_modif_delete.asp?num=<%=rsED("NumActu")%>"><img src="img/postdelete.gif" border="0"></a></td>
      <%end if%>
   </tr>
              
        <!--Initialisation de la session-->
            
        
              <!--Fin initialisation de la session-->
              
              
<%
rsED.MoveNext
Wend
rsED.Close
%>

</table>

<%else%>





<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<%
	Dim Place1
	Place1 = 0

	Set rsED1 = Conn.Execute("SELECT ACTUALITE.* FROM ACTUALITE INNER JOIN MEMBRE ON ACTUALITE.NumMembre = MEMBRE.NumMembre WHERE ((MEMBRE.NumMembre)=" & session("admin_id") & " AND ((ACTUALITE.Visible)=1));")

	While Not rsED1.EOF

	If strBgcolor = "#F1F1F1" Then
    strBgcolor = "#FFFFFF"
	Else
    strBgcolor = "#F1F1F1"
	End If
	%>
	
	<%
		session("NumActu") = rsED1("NumActu")
	%>
	<tr bgcolor="<%=strBgcolor%>"> 
		<td width="5%"><% Place1 = Place1+1 %><b><%=Place1%></b>&nbsp;&nbsp;</td>
    	<td width="10%"><%=rsED1("DateActu")%>&nbsp;</td>
    	<td width="55%"><%=rsED1("TitreActu")%></a>&nbsp;&nbsp;</td>
    	<td width="10%"><%=rsED1("PieceJointesActu")%> <%session("recup_pieces_jointes")= rsED1("PieceJointesActu")%></a></td>
    	<td ><a href="p_admin_actu_modif_display.asp?num=<%=rsED1("NumActu")%>"><img src="img/postdisplay.gif" border="0"></a></td>
		
	  <% if (session("admin_acces_admin")=1 or session("admin_validation_actualites")=1) then %>
   		<td ><a href="p_admin_actu_modif_valid.asp?num=<%=rsED1("NumActu")%>"><img src="img/postvalid.gif" border="0"></a></td>
      <%end if%>
	  
    	<td ><a href="p_admin_actu_modif_edit.asp?num=<%=rsED1("NumActu")%>%>"><img src="img/postedit.gif" border="0"></a></td>

      <% if (session("admin_acces_admin")=1 or session("admin_validation_actualites")=1) then %>
    	<td ><a href="p_admin_actu_modif_delete.asp?num=<%=rsED1("NumActu")%>"><img src="img/postdelete.gif" border="0"></a></td>
      <%end if%>
    </tr>

    <!--Initialisation de la session-->


    <!--Fin initialisation de la session-->


<%
rsED1.MoveNext
Wend
rsED1.Close
%>
</table>

<%end if%>
 <!--fin corps de texte-->
        
        
        
        <!--fin insertion  -->
        


 
<br />
<br />
<br />
<br />
<br />
<br />
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->
</div>
</body>
<!-- #include file="deconnexion.asp"-->
</html>


