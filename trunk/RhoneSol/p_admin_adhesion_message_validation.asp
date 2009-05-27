<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript">
		function verifform()
			{

					// Vérifie si le nom est bien indiqué
					 if(request.form("FCKeditor1") == "")
					 {
					  alert("Merci d'insérer un message");
					  //document.contact.NomMembre.focus();
					  return false;
					 }
			 }
		</script>
 
 
 
</head>

<body>
<!-- #include file="admin_securite.asp"-->
<!-- #include file="FCKeditor/fckeditor.asp" -->
<!-- #include file="grand_header.txt"-->
<!-- #include file="connexion.asp"-->

<div id="contenu">
		<!-- #include file="fichier_menu.txt"-->


		<div id="bandeau_vert">Espace Membres</div>
		<div id="bandeau_menu"><!--#include file ="menu_deroulant.txt" --></div>
		
<div align="justify">
<table border="0px" width="100%" cellpadding="10px">
			
	<tr>
		<td><font color="#6faa06">Menu Messages/adhésions _______________________________________________________________</font></td>
	</tr>
	<tr>
		<td width=82%>
		       <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
				
				<a href="p_admin_adhesion_message.asp"><font size="1"><b><< Retour Menu message adhésion &nbsp;</b></font></a>
		</td>
	</tr>
</table>
</div>


<%
				  
				  Dim Place
				  Place = 0
				  Dim rsED
				  'Set rsED = Conn.Execute("SELECT * FROM MEMBRE and AdhesionMembre='oui')
				  Set rsED = Conn.Execute("SELECT * FROM MEMBRE WHERE ((MESSAGEMEMBRE <>'' and AutreMembre='oui' and AdhesionMembre='oui')or (MESSAGEMEMBRE ='' and AutreMembre='oui' and AdhesionMembre='oui')) and NumMembre not in (select NumMembre from Membre where ReponseAdhMembre<>'')")
				  
%>
<%
IF rsED.EOF Then
Response.Write("Il n'y a aucun message adhésion pour le moment ")
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
		<% Place = Place+1 %>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
<tr>
	<td><b><%=Place%></b></td>
	<td width="100"><%=rsED("NomMembre")%></td>
	<td><%=rsED("PrenomMembre")%></td>
	<td width="20"><a href="p_admin_adhesion_display.asp?num=<%=rsED("NumMembre")%>"><img src="img/postdisplay.gif" border="0"></a></td>
	<td width="20"><a href="p_admin_adhesion_message_validation.asp?num=<%=rsED("NumMembre")%>"><img src="img/postvalid.gif" border="0"></a></td> 
		                 <!---<td width="20"><a href="p_admin_idees_delete.asp?num=<'%=rsED("num")%>"><img src="postdelete.gif" border="0"></a></td>---> 
		                
</tr>
<%
	rsED.MoveNext
	Wend
	'rsED.Close 
	'Set rsED = Nothing
	End If
%>
</table>
	 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<% if (Request.Querystring("num")>0) then

					Dim rsED2
					Set rsED2 = Conn.Execute("SELECT * FROM MEMBRE WHERE NumMembre = " & Request.Querystring("num") & "")
					'rsED = "SELECT * FROM IDEES WHERE NumIdee = " & Request.Querystring("num") & ""

					'rsED2 = "SELECT * FROM IDEES WHERE NumIdee=10"
					'Conn.Execute(rsED)
					
%>
<div>
		Répondre à <%=rsED2("NomMembre")%>&nbsp;<%=rsED2("PrenomMembre")%> à l'adresse <%=rsED2("MailMembre")%> : <br/>
		<form action="p_admin_adhesion_message_valid.asp?num=<%=rsED2("NumMembre")%>" method="post" id="contact" name="contact" onsubmit="return verifform()">
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
	 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		  <!------ fin corps de texte-------------------->
				<!-------------------------------------------FIN AJOUT DE TEXTE IMPORTE DE ORAS----------------------------------->
               

						<!------ fin corps de texte-------------------->
					
	
		<!-- Ne pas toucher à ce qui suit : placement du footer -->


<!-- #include file="grand_footer.txt"-->  
</div>
<!-- #include file="deconnexion.asp"-->
</body>
</html>