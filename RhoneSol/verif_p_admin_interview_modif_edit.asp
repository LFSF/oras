<%@ Language=VBScript %>
<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->

<%
Dim rsE

Set rsE = Conn.Execute("SELECT * FROM QUESTION WHERE  NumItw = " & session("num") & "")
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
function verifform()
{
 if(document.deposer.intitule.value == "")
  {
   alert("Merci d'indiquer l'intitulé de l'offre.");
   document.deposer.intitule.focus();
   return false;
  }
 if(document.deposer.nom.value == "")
  {
   alert("Merci d'indiquer votre nom.");
   document.deposer.nom.focus();
   return false;
  }
 if(document.deposer.prenom.value == "")
  {
   alert("Merci d'indiquer votre prenom.");
   document.deposer.prenom.focus();
   return false;
  }
 if(document.deposer.adresse.value == "")
  {
   alert("Merci d'indiquer votre adresse.");
   document.deposer.adresse.focus();
   return false;
  }
   if(document.deposer.cp.value == "")
  {
   alert("Merci d'indiquer votre code postal (99 si hors de france).");
   document.deposer.cp.focus();
   return false;
  }
   if(document.deposer.ville.value == "")
  {
   alert("Merci d'indiquer votre ville.");
   document.deposer.ville.focus();
   return false;
  }
   if(document.deposer.pays.value == "")
  {
   alert("Merci d'indiquer votre pays.");
   document.deposer.pays.focus();
   return false;
  }
   if(document.deposer.email.value == "")
  {
   alert("Merci d'indiquer votre adresse email.");
   document.deposer.email.focus();
   return false;
  }
 adresse_email = document.deposer.email.value;
arobase = adresse_email.indexOf("@");
point = adresse_email.indexOf(".",arobase);
mauvais_endroit_point = arobase+1;
double_point = adresse_email.indexOf("..",arobase);
nbre_carac = adresse_email.length - point;
double_arobase = adresse_email.indexOf("@",arobase+1);
    
// dans l'ordre:            
// si l'arobase est absente ou en 1ere position
// ou si le . suivant l'arobase est juste derriere ou absent
// si la longueur de l'adresse est inferieure a 5 (grand minimum -> x@x.x)
// si il ya pas 2 . qui se suive deriere l'arobase
// si il y a bien 2 caractere minimum apres le . situe derriere l'arobase
// si il y a pas une arobase deriere la premiere arobase
if ( (arobase < 1) ||  
     (point <= mauvais_endroit_point) || 
     (adresse_email.length < 5) || 
     (double_point >= 0) ||
     (nbre_carac < 3) ||
     (double_arobase >= 0) )
    {
    alert ("l'adresse email est invalide.");
    document.deposer.email.focus();
    return false;
    }
   if(document.deposer.tel.value == "")
  {
   alert("Merci d'indiquer votre numéro de telephone.");
   document.deposer.tel.focus();
   return false;
  }
   if(document.deposer.diplome_en_cour.value == "")
  {
   alert("Merci d'indiquer votre diplôme en cour.");
   document.deposer.diplome_en_cour.focus();
   return false;
  }
   if(document.deposer.diplome_obtenu.value == "")
  {
   alert("Merci d'indiquer vos diplômes obtenus.");
   document.deposer.diplome_obtenu.focus();
   return false;
  }
   if(document.deposer.poste.value == "")
  {
   alert("Merci d'indiquer le poste recherché.");
   document.deposer.poste.focus();
   return false;
  }
   if(document.deposer.experience_pro.value == "")
  {
   alert("Merci d'indiquer votre expérience professionnelle.");
   document.deposer.experience_pro.focus();
   return false;
  }
 }
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

<SCRIPT language="JavaScript"> 
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
<script type="text/javascript" src="infobulle.js"></script>
</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>

<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<table border="0px" width="100%" cellpadding="10px">

    
    
    <tr>
        <td colspan="2"><font color="#6faa06">Modification Interview ______________________________________________________</font></td>
    </tr><td>
<table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
   <tr> 
   	 <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
     <td>&nbsp;</td>
   </tr>
   <tr> 
      <td class="txt1">Date de l'interview :</td>
      <td><% =session("date_interview")%></td>
   </tr>
   <tr> 
      <td class="txt1">statut :</td>
      <td><% =session("statut")%></td>
   </tr>
   <tr> 
      <td class="txt1">Raison social :</td>
      <td><% =session("rs")%></td>
   </tr>
   <tr> 
      <td class="txt1">Adresse :</td>
      <td><% =session("adresse")%></td>
   </tr>
   <tr> 
      <td class="txt1">Code Postal :</td>
      <td><% =session("cp")%></td>
   </tr>
   <tr> 
       <td class="txt1">Ville :</td>
       <td><% =session("ville")%></td>
   </tr>
   <tr> 
        <td class="txt1">Pays :</td>
        <td><% =session("pays")%></td>
    </tr>
    <tr> 
         <td class="txt1">Civilite :</td>
         <td><% =session("civilite")%></td>
    </tr>
    <tr> 
         <td class="txt1">Nom du responsable :</td>
         <td><% =session("nom_responsable")%></td>
    </tr>
    <tr> 
         <td class="txt1">Prenom du responsable :</td>
         <td><% =session("prenom_responsable")%></td>
    </tr>
    <tr> 
         <td class="txt1">Email :</td>
         <td><% =session("email")%></td>
    </tr>
    <tr> 
          <td class="txt1">Téléphone :</td>
          <td><% =session("tel")%></td>
    </tr>
    <tr>
           <td colspan="2" width="670" valign="center">__________________________________________________</td>
    </tr>
    <tr> 
           <td colspan="2">&nbsp;</td>
    </tr>
	<tr> 
           <td colspan="2">&nbsp;</td>
    </tr> 
	<tr> 
           <td valign="top" colspan="2"><font color="#969696">Titre de l'interview :&nbsp;</font><% =session("titre_interview")%>&nbsp; <br><br>&nbsp;</td>
	</tr>
    <tr> 
           <td valign="top" colspan="2"><font color="#969696">Introduction de l'interview :&nbsp;</font><% =request.form("intro_interview")%><%session("intro_interview")=request.form("intro_interview")%>&nbsp; <br><br>&nbsp;
           </td>
	</tr>
    <tr>
          <td colspan="2" width="670" valign="center">__________________________________________________</td>
    </tr>
	
    <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 1 :&nbsp;<% =request.form("objet1")%><%session("question1")=request.form("objet1")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse1")%><%session("Reponse1")=request.form("Reponse1")%>
		   </td>
     </tr>
	 
     <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 2 :&nbsp;<% =request.form("objet2")%><%session("question2")=request.form("objet2")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse2")%><%session("Reponse2")=request.form("Reponse2")%>
		   </td>
     </tr>
	 
	 <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 3 :&nbsp;<% =request.form("objet3")%><%session("question3")=request.form("objet3")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse3")%><%session("Reponse3")=request.form("Reponse3")%>
		   </td>
     </tr>
      
	           <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 4 :&nbsp;<% =request.form("objet4")%><%session("question4")=request.form("objet4")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse4")%><%session("Reponse4")=request.form("Reponse4")%>
		   </td>
     </tr>
     
	  <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 5 :&nbsp;<% =request.form("objet5")%><%session("question5")=request.form("objet5")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse5")%><%session("Reponse5")=request.form("Reponse5")%>
		   </td>
     </tr>
            
	 <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 6 :&nbsp;<% =request.form("objet6")%><%session("question6")=request.form("objet6")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse6")%><%session("Reponse6")=request.form("Reponse6")%>
		   </td>
     </tr>
      
	  <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 7 :&nbsp;<% =request.form("objet7")%><%session("question7")=request.form("objet7")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse7")%><%session("Reponse7")=request.form("Reponse7")%>
		   </td>
     </tr>
                  
      <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 8 :&nbsp;<% =request.form("objet8")%><%session("question8")=request.form("objet8")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse8")%><%session("Reponse8")=request.form("Reponse8")%>
		   </td>
     </tr>
     
	 <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 9 :&nbsp;<% =request.form("objet9")%><%session("question9")=request.form("objet9")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse9")%><%session("Reponse9")=request.form("Reponse9")%>
		   </td>
     </tr> 
	 
	  
            <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 10 :&nbsp;<% =request.form("objet10")%><%session("question10")=request.form("objet10")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse10")%><%session("Reponse10")=request.form("Reponse10")%>
		   </td>
     </tr>
                  
    <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 11 :&nbsp;<% =request.form("objet11")%><%session("question11")= request.form("objet11")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse11")%><%session("Reponse11")= request.form("Reponse11")%>
		   </td>
     </tr>
                  
      <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 12 :&nbsp;<% =request.form("objet12")%><%session("question12")=server.HTMLEncode(request.form("objet12"))%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse12")%><%session("Reponse12")=request.form("Reponse12")%>
		   </td>
     </tr> 
      
	  <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 13:&nbsp;<% =request.form("objet13")%><%session("question13")= request.form("objet13")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse13")%><%session("Reponse13")= request.form("Reponse13")%>
		   </td>
     </tr>
                  
     <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 14 :&nbsp;<% =request.form("objet14")%><%session("question14")=request.form("objet14")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse14")%><%session("Reponse14")= request.form("Reponse14")%>
		   </td>
     </tr>
     
	  <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 15 :&nbsp;<% =request.form("objet15")%><%session("question15")=request.form("objet15")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse15")%><%session("Reponse15")= request.form("Reponse15")%>
		   </td>
     </tr>
     
	              
     <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 16 :&nbsp;<% =request.form("objet16")%><%session("question16")=request.form("objet16")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse16")%><%session("Reponse16")= request.form("Reponse16")%>
		   </td>
     </tr>
     
	       <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 17 :&nbsp;<% =request.form("objet17")%><%session("question17")=request.form("objet17")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse17")%><%session("Reponse17")= request.form("Reponse17")%>
		   </td>
     </tr>
	 
	 
     <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 18 :&nbsp;<% =request.form("objet18")%><%session("question18")=request.form("objet18")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse18")%><%session("Reponse18")= request.form("Reponse18")%>
		   </td>
     </tr>
	 
	 <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 19 :&nbsp;<% =request.form("objet19")%><%session("question19")=request.form("objet19")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse19")%><%session("Reponse19")= request.form("Reponse19")%>
		   </td>
     </tr>
     
	    <tr> 
           <td colspan="2">&nbsp;</td>
     </tr> 
	 <tr> 
          <td valign="top" colspan="2"><font color="#969696">Question 20 :&nbsp;<% =request.form("objet20")%><%session("question20")=request.form("objet20")%>&nbsp;</font><br><br>&nbsp;
           </td>
     </tr>
     <tr> 
           <td colspan="2"><% =request.form("Reponse20")%><%session("Reponse20")= request.form("Reponse20")%>
		   </td>
     </tr>
                  
      <tr> 
           <td colspan="2">&nbsp;</td>
      </tr> 
      <tr>
           <td colspan="2" width="670" valign="center">

    
    <!-- <form name="frmSend" method="POST" enctype="multipart/form-data" action="upload_p_admin_interview_insert.asp">
    

                      <INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier" onClick="history.back()" > -->
                    
                       <input name="valider" style="width:75" type="button" OnClick="window.location.href='valider_p_admin_interview_modif_edit.asp'" value="Valider">  
              
      	  
	  
	                     <!--  <input name="creer" style="width:75" type=submit value="Creer" >  -->
                    
 
     <!--<input style="margin-top:4" type=submit value="Upload">        -->

    </form>
    

                    
                  
                  
                    </td>
                  </tr>
                  
      </table>
	</center>
    </td></tr><tr><td colspan="2"></td></tr></table>

 <!-- fin corps de texte -->
        
        
        
        <!--           fin insertion  -->
    <%rsE.close%>
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  


</body>
<!-- #include file="connexion.asp"-->
</html>