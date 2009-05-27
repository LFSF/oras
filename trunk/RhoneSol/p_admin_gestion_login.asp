<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" type="text/javascript" src="prototype.js"></script>
<script language="javascript" type="text/javascript" src="onglet.js"></script>
<link href="style.css" rel="stylesheet" type="text/css" />
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

<SCRIPT language="JavaScript"> 
function fonctest()
{
window.location.href="espaceadh.asp";
}
function fonc100()
{
window.location.href="testd.asp";
}
function fonc1()
{
window.location.href="ndambog.asp";
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
<div id="bandeau_menu"><!--#include file="menu_deroulant.txt"--></div>

<table border="0px" width="100%" cellpadding="10px">
    
    
    <tr>
        <td colspan="2"> <a class="lien" href="p_admin.asp"><font size="1"><b>&lt;&lt; Retour Page Administration &nbsp;</b></font></a></td>
    </tr>
    <tr>
        <td colspan="2"><font color="#6faa06">Gestion de membres_______________________________________________________________</font></td>
    </tr>
    
    
    <tr>
        <td width=82%>
                     
      
<div id="calqueracine"></div>
<script language="javascript" type="text/javascript">
<!--
var oOnglet = new Onglet ("calqueracine", "cssonglet");
oOnglet.addOngletUrl ("Membres", "gesmembre.asp");
oOnglet.addOngletUrl ("Admin", "gesadmin.asp");
oOnglet.addOngletUrl ("Super Admin", "gestionsupr.asp");

oOnglet.setFocus (1);
-->
</script>
<br /><br />
 <!-- Ne pas toucher à ce qui suit : placement du footer -->


    

</td></tr></table>
<!-- #include file="grand_footer.txt"-->
</div>
</body>
<!-- #include file="deconnexion.asp"-->

</html>