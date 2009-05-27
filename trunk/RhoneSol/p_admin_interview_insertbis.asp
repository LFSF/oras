<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<!-- #include file="connexion.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
<%session("civilite")=server.HTMLEncode(request.form("civilite"))%>
<%session("nom_responsable")=server.HTMLEncode(request.form("responsable"))%>
<%session("prenom_responsable")=server.HTMLEncode(request.form("prenom_responsable"))%>
<%session("email")=server.HTMLEncode(request.form("email"))%>
<%session("tel")=request.form("tel")%>
<%session("titre_interview")=server.HTMLEncode(request.form("titre_interview"))%>

	
<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<table border="0px" width="100%" cellpadding="10px">
	<tr>
    	<td colspan="2"><font color="#6faa06">Nouvelle interview_______________________________________________________________</font></td>
    </tr>
</table> 
  	
<form action="verif_p_admin_interview_insert.asp" method="post"id="intwbis" name="intwbis" OnSubmit="return verifform()">
	<input type="hidden" name="test" value="oui">

<table  border="0" align="center">
	<tr valign="top"> 
    	<td width="100">Introduction:</td>		
	</tr >
	<tr>
        <td colspan="2" align="center">
		<!--<textarea type="text" style="width:100%" name="intro_interview" size="50" rows="10" maxlength ="500" ></textarea>-->
		<textarea class="txt" id="intro_interview"  name="intro_interview" rows="10" cols="60"></textarea>
		</td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>
		
	<tr valign="top">
		<td width="100"><STRONG>Questions/Réponses :</STRONG></td>		
	</tr >
		
</table>
    
<table>
 	<tr>
		<td  align="middle">Question 1:&nbsp;&nbsp;&nbsp;
			<INPUT id=text1 name=objet1 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp; 
			
		</td>
	</tr>
	<tr valign="top"> 
         <td width="100">Reponse 1:</td>		
	</tr >
	<tr>
          <td colspan="2" align="center"> 
			<!---->
		  <textarea class="txt" id="reponse1"  name="reponse1" rows="10" cols="60"></textarea>
		   </td>
  	</tr>
	<tr> 
          <td colspan="2">&nbsp;</td>
    </tr>			
 	<tr>
		<td  align="middle">Question 2:&nbsp;&nbsp;&nbsp;
			<INPUT id=text2 name=objet2 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 2:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center">
		<textarea class="txt" id="reponse2"  name="reponse2" rows="10" cols="60"></textarea>
	    </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>	
			
	<tr>
		<td  align="middle">Question 3:&nbsp; &nbsp;&nbsp;
			<INPUT id=text2 name=objet3 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 3:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center">
		<textarea class="txt" id="reponse3"  name="reponse3" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
         <td colspan="2">&nbsp;</td>
    </tr>			
<br><br>
	<tr>
		<td  align="middle">Question 4:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet4 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
         <td width="100">Reponse 4:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center">
		<textarea class="txt" id="reponse4"  name="reponse4" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 5:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet5 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp; 
		</td>
	</tr>
	<tr valign="top"> 
       	<td width="100">Reponse 5:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse5"  name="reponse5" rows="10" cols="60"></textarea>
    	</td>
	</tr>
	<tr> 
          <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		  <td  align="middle">Question 6:&nbsp;&nbsp;&nbsp;
			<INPUT id=text2 name=objet6 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
  		  </td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 6:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse6"  name="reponse6" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
<br><br>
	<tr>
		<td  align="middle">Question 7:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet7 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 7:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse7"  name="reponse7" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 8:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet8 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp; 
		</td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 8:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse8"  name="reponse3" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 9:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet9 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
       	<td width="100">Reponse:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse9"  name="reponse9" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 10:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet10 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 10:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse10"  name="reponse10" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 11:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet11 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 11:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse11"  name="reponse11" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 12:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet12 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
       	<td width="100">Reponse 12:</td>		
	</tr>
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse12"  name="reponse12" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 13:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet13 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 13:</td>		
	</tr>
	<tr>	
		<td colspan="2" align="center"><textarea class="txt" id="reponse13"  name="reponse13" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 14:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet14 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 14:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse14"  name="reponse14" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 15:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet15 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
		</tr>
	<tr valign="top"> 
	    <td width="100">Reponse 15:</td>		
	</tr>
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse15"  name="reponse15" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 16:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet16 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp; 
		</td>
	</tr>
	<tr valign="top"> 
       	<td width="100">Reponse 16:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse16"  name="reponse16" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
        <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 17:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet17 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
        <td width="100">Reponse 17:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse17"  name="reponse17" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
       <td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 18:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet18 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
		</tr>
	<tr valign="top"> 
       	<td width="100">Reponse 18:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse18"  name="reponse18" rows="10" cols="60"></textarea>
         </td>
	</tr>
	<tr> 
 		<td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 19:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet19 style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
       	<td width="100">Reponse 19:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse19"  name="reponse19" rows="10" cols="60"></textarea>
        </td>
	</tr>
	<tr> 
    	<td colspan="2">&nbsp;</td>
    </tr>			
	<tr>
		<td  align="middle">Question 20:&nbsp;&nbsp;&nbsp;
		<INPUT id=text2 name=objet20  style="WIDTH: 330px; HEIGHT: 25px" size=53 obligatoire>&nbsp;  
		</td>
	</tr>
	<tr valign="top"> 
       	<td width="100">Reponse 20:</td>		
	</tr >
	<tr>
		<td colspan="2" align="center"><textarea class="txt" id="reponse20"  name="reponse20" rows="10" cols="60"></textarea>
        </td>
	</tr>
				
			
</table>
<center>
        <INPUT style="WIDTH: 153px; HEIGHT: 24px;color:blue;" type=submit size=51 value=Suivant id=submit1 name=submit1>
</center>
                   
	
<br><br>
	
	
</form>
 

  <!--fin corps de texte-->
		
		
		
		<!--           fin insertion  -->
		


 
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
<% end if %>