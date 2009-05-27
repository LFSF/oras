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
dbPath = Server.MapPath("upload.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
  
  
'set rsVerif = Conn.Execute("SELECT * FROM MEMBRE WHERE MailMembre = " & Request.Querystring("login") & "AND MdpMembre = " & Request.Querystring("Mdp") & "")
 
%>

<!-- #include file="grand_header2.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Login</div>

<!--
<div id="post-it"><b><i>Sommaire</i></b><br />
_________________________________________________________<br /><br />

   ><em onclick="return fonc1()" onMouseOver="this.style.cursor='hand'; "> Historique</em><br />
   > <em onclick="return fonc2()" onMouseOver="this.style.cursor='hand'; ">Définition et principe</em><br />
   > <em onclick="return fonc3()" onMouseOver="this.style.cursor='hand'; ">Cadre législatif et réglementaire</em><br />
   > <em onclick="return fonc4()" onMouseOver="this.style.cursor='hand'; ">Où trouver des financements ?</em><br /></div>
-->
	

<div id="accueil_tableau1" style="border:1px Grey; background-color:Light Grey;">
<div class="text" style="float:left;">
Login : <br><br><br>
Mot de Passe :
</div>
<form action="verif_login.asp" method="get" id="login" name="login">
<div class="box" style="margin-left:10px;">
<input name="Login" id="Login" type="text" Maxlength="50" value=""><br/><br/>
<input name="Mdp" id="Mdp" type="Password" Maxlength="50" value="">
</div>
<input type="submit" value="Valider" id="submit1" name="submit1" style="BACKGROUND-COLOR: #cacaff" />

</form>
<a href="p_partenaire.asp"><img src="img/infolog.png" border=0></a>
<br>
<br>
<br>
<br>


</div>

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
</html>