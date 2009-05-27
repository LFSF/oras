<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
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
  
set rsVerif = Conn.Execute("SELECT * FROM MEMBRE WHERE MailMembre = '" & Request.Querystring("login") & "' AND MdpMembre = '" & Request.Querystring("Mdp") & "'")
if rsVerif("NumMembre") = "" then
 test = 0
else
 test = 1 
end if

	
 
%>

<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Verif Login</div>

<!--
<div id="post-it"><b><i>Sommaire</i></b><br />
_________________________________________________________<br /><br />

   ><em onclick="return fonc1()" onMouseOver="this.style.cursor='hand'; "> Historique</em><br />
   > <em onclick="return fonc2()" onMouseOver="this.style.cursor='hand'; ">Définition et principe</em><br />
   > <em onclick="return fonc3()" onMouseOver="this.style.cursor='hand'; ">Cadre législatif et réglementaire</em><br />
   > <em onclick="return fonc4()" onMouseOver="this.style.cursor='hand'; ">Où trouver des financements ?</em><br /></div>
-->
	
<form action="verif_login.asp" method="post"id="login" name="login">
<% if test = 0 then %>
<div id="accueil_tableau1" style="border:1px Grey; background-color:Light Grey;">
<div class="text" style="float:left;">
Login : <br><br><br>
Mot de Passe :
</div>
<div class="box" style="margin-left:10px;">
<input name="Login" type="text" Maxlength="50" value=""><br/><br/>
<input name="Mot de Passe" type="Password" Maxlength="50" value="">
<br/>
<input type="submit" value="Valider" id="submit1" name="submit1" style="BACKGROUND-COLOR: #cacaff" />
</div>
<br>
MOT DE PASSE ET/OU LOGIN INCORRECTE
</div>
<%else

session("numMembre") = rsVerif("NumMembre")
session("Login") = rsVerif("MailMembre")
session("MdpMembre") = rsVerif("MdpMembre")
%>

Bienvenue <%response.write(rsVerif("CivMembre"))%> &nbsp
<%response.write(rsVerif("PrenomMembre"))%> &nbsp
<%response.write(rsVerif("NomMembre"))%>
<% path = session("iTurl")
response.write(path)
if path <> "" then
response.write("Redirection vers la page : " & path)
response.redirect(path)
else
response.write("NON")
end if
 %> &nbsp
<%end if%>
<div id="accueil_tableau2" align="center">

    </table>
</div>
</p>

<p>

<div id="accueil_tableau22" align="center">

    </table>
</div>
</p>
</div>
 


 



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->

</html>