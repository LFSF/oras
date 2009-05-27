<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<!-- #include file="connexion.asp"-->

<% 

'Dim rsCat
'Set rsCat = Conn.Execute("SELECT * FROM t_actualites WHERE auteur = " & Request.Querystring("auteur") & "")



Dim rsE

'edP = "SELECT * FROM t_actualites WHERE N° = " & Request.Querystring("N°") & ""

Set rsE = Conn.Execute("SELECT * FROM QUESTION WHERE  NumItw = " & session("num") & "")
Set rs1 = Conn.Execute("SELECT * FROM INTERVIEW WHERE  NumItw = " & session("num") & "")
' la requete pour compter combien de question on en a
set RS_count= Conn.Execute("Select count(*) as Nb_question from INTERVIEW where NumItw = " & session("num") & "")

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/wysiwyg.js"></script>
<script type="text/javascript">
WYSIWYG.attach('all')
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

<script language="Javascript1.2">
<!-- // load htmlarea
_editor_url = "";                     
// URL to htmlarea files
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
// -->
</script>

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


<script type="text/javascript" language="javascript" src="infobulle.js"></script>
<style type="text/css">
div.alien{cursor:hand}

</style>
</head>

<body>      
<%session("date_interview")=request.form("date_interview")%>
<%session("statut")=server.HTMLEncode(request.form("statut"))%>
<%session("rs")=request.form("rs")%>
<%session("adresse")=server.HTMLEncode(request.form("adresse"))%>
<%session("cp")=request.form("cp")%>
<%session("ville")=server.HTMLEncode(request.form("ville"))%>
<%session("pays")=server.HTMLEncode(request.form("pays"))%>
<%session("civilite")=request.form("civilite")%>
<%session("nom_responsable")=server.HTMLEncode(request.form("responsable"))%>
<%session("prenom_responsable")=server.HTMLEncode(request.form("prenom_responsable"))%>
<%session("email")=request.form("email")%>
<%session("tel")=request.form("tel")%>
<%session("titre_interview")=server.HTMLEncode(request.form("titre_interview"))%>

    





<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>

<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<table border="0px" width="100%" cellpadding="10px">
    
    
    
    <tr>
        <td colspan="2"><font color="#6faa06">Modification Interview ______________________________________________________</font></td>
    </tr>
</table> 
    <form action="verif_p_admin_interview_modif_edit.asp" method="post"id="intwbis" name="intwbis" OnSubmit="return verifform()">
<input type="hidden" name="test" value="oui">
<table  border="0" align="center">
    
    <tr>
    <td>
  
    
    
    
            <table  border="0" align="center">
            
            <tr valign="top"> 
                  <td width="100">Introduction:</td>        
                <tr >
                    <tr>
                    <td colspan="2" align="center"><textarea class="txt" id="intro_interview"  name="intro_interview" rows="10" cols="60"><%=rs1("IntroItw")%></textarea>
                    
    </td>
                </tr>
            <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr> 
            
        <tr valign="top">
            
                  <td width="100"><STRONG>Questions/Réponses :</STRONG></td>        
    </tr >
                  
                  </td>
    </tr>           
</table>
    
 <table>
<%  Dim Question,Reponse
 
	for i=0 to 19
		if (i>=RS_count("Nb_question")) then
			Question=""
			Reponse="" 
		else 
              Question=rsE("Question")
              Reponse=rsE("Reponse")
			  rsE.Movenext
		end if
		x=i+1
		%>
		<tr><td  align=middle>Question <%=x %>:&nbsp; 
                      &nbsp;&nbsp;
            <INPUT id=text<%=x %> name=objet<%=x %> style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire  value="<%=Question%>">&nbsp; 
            </td>
		</tr>
        <tr valign="top"> 
            <td width="100">Reponse <%=x %>:</td>
        </tr>
        <tr>
             <td colspan="2" align="center"><textarea class="txt" id="reponse<%=x %>"  name="reponse<%=x %>" rows="10" cols="60"><%=Reponse%></textarea>
              </td>
		</tr>
		<tr> 
        	<td colspan="2">&nbsp;</td>
        </tr>
	<% next %> 
</table>
                
               <center>
                   <INPUT style="WIDTH: 153px; HEIGHT: 24px;color:blue;" type=submit size=51 value=Suivant id=submit1 name=submit1></center>
                   
    
    <br>
 <br>
    
 </table>   
</form>
 

  <!-- fin corps de texte-->
        
        
        
        <!--           fin insertion  -->
        

<!-- #include file="deconnexion.asp"-->
 
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  


</body>
</html>
<% end if %>