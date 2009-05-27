<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

<script language="JavaScript">

function fonc2()
{
if((event.keyCode<48)||(event.keyCode>57))

    {
    // alert(window.event.keyCode);
    alert("Attention uniquement des chiffres !");
    event.returnValue=false;
    }
}
</script>
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

<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if 
(win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} 
else 
{ document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

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
        <td colspan="2"><font color="#6faa06">Vérification avant validation_______________________________________________________________</font></td>
    </tr>
<tr>
<td><br/><center>
                <table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  
                 
                  <tr> 
                    <td><font color="#969696">Auteur :</font></td>
                    <td><%= session("admin_nom") %>&nbsp;<%= session("admin_prenom")%></td>
                        </tr>
                  </tr>
                  
                  
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Date :</font></td>
                    <td><% =request.form("date")%><%session("date")=request.form("date")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Titre :</font></td>
                    <td><% =request.form("titre")%><%session("titre")=request.form("titre")%></td>
                  </tr>
                 
                    
                    <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                  
               
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Message : </font><br/><br/><br/>&nbsp;
                  </td>
                  </tr>
                  
                  <tr>
                    <td colspan="2"><%
                                        Response.Write request.form("message")

                                        session("MessageActu")=request.form("message")

                                    %>
                    </td>
                  </tr>
                  
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
                   <br/>
 <br/>  <br/>
 <br/> 

    
                  
                  <tr>
                    <td colspan="2" width="670" valign="center">

    <form name="frmSend" method="POST" enctype="multipart/form-data" OnSubmit="return ProgressBar();" action="valider_p_admin_actu_insert.asp">
    
    <B>Joindre un fichier <font color=red>( < 2Mo)</font></B><br/><br/>
     <input name="attach1" type="file" size=35><br/>

    <br/>
 <br/>  
                    <INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier" onClick="location.href='p_admin_actu_insert.asp'" >

                    <input name="creer" style="width:75" type=submit value="Créer" >
</form>

                    </td>
                  </tr>
                </table></center>
    </td></tr><tr><td colspan="2"></td></tr></table>

<!--fin corps de texte-->
 
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>