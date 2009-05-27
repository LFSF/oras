<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

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
    	<td colspan="2"><font color="#6faa06">Vérification avant Validation_______________________________________________________________</font></td>
    </tr>
</table>

                <table width="400" border="0" cellpadding="0" cellspacing="0" class="txt" align="center">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
				  <tr> 
                    <td class="txt1">Titre de l'interview :</td>
                    <td><% =session("titre_interview")%></td>
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
                  </tr>	 <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Introduction de l'interview :&nbsp;</font><% =  request.form("intro_interview")%><%session("intro_interview")=  request.form("intro_interview")%>&nbsp;<br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				   <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	 <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 1 :&nbsp;<% =  request.form("objet1")%><%session("question1")=  request.form("objet1")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse1")%><%session("Reponse1")=  request.form("Reponse1")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 2 :&nbsp;<% =  request.form("objet2")%><%session("question2")=request.form("objet2")%>&nbsp; </font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse2")%><%session("Reponse2")=  request.form("Reponse2")%></td>
                  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				 
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 3 : &nbsp;<% =  request.form("objet3")%><%session("question3")=  request.form("objet3")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse3")%><%session("Reponse3")=  request.form("Reponse3")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 4 : &nbsp;<% =  request.form("objet4")%><%session("question4")=  request.form("objet4")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse4")%><%session("Reponse4")=  request.form("Reponse4")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 5 : &nbsp;<% =  request.form("objet5")%><%session("question5")=  request.form("objet5")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse5")%><%session("Reponse5")=  request.form("Reponse5")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 6 : &nbsp;<% =  request.form("objet6")%><%session("question6")=  request.form("objet6")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse6")%><%session("Reponse6")=  request.form("Reponse6")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 7 : &nbsp;<% =  request.form("objet7")%><%session("question7")=  request.form("objet7")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse7")%><%session("Reponse7")=  request.form("Reponse7")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 8 : &nbsp;<% =  request.form("objet8")%><%session("question8")=  request.form("objet8")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse8")%><%session("Reponse8")=  request.form("Reponse8")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 9 : &nbsp;<% =  request.form("objet9")%><%session("question9")=  request.form("objet9")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse9")%><%session("Reponse9")=  request.form("Reponse9")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 10 : &nbsp;<% =  request.form("objet10")%><%session("question10")=  request.form("objet10")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse10")%><%session("Reponse10")=  request.form("Reponse10")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 11 : &nbsp;<% =  request.form("objet11")%><%session("question11")=  request.form("objet11")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse11")%><%session("Reponse11")=  request.form("Reponse11")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 12 : &nbsp;<% =  request.form("objet12")%><%session("question12")=  request.form("objet12")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse12")%><%session("Reponse12")=  request.form("Reponse12")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 13 : &nbsp;<% =  request.form("objet13")%><%session("question13")=  request.form("objet13")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse13")%><%session("Reponse13")=  request.form("Reponse13")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 14 : &nbsp;<% =  request.form("objet14")%><%session("question14")=  request.form("objet14")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse14")%><%session("Reponse14")=  request.form("Reponse14")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 15 : &nbsp;<% =  request.form("objet15")%><%session("question15")=  request.form("objet15")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse15")%><%session("Reponse15")=  request.form("Reponse15")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 16 : &nbsp;<% =  request.form("objet16")%><%session("question16")=  request.form("objet16")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse16")%><%session("Reponse16")=  request.form("Reponse16")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 17 : &nbsp;<% =  request.form("objet17")%><%session("question17")=  request.form("objet17")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse17")%><%session("Reponse17")=  request.form("Reponse17")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 18 : &nbsp;<% =  request.form("objet18")%><%session("question18")=  request.form("objet18")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse18")%><%session("Reponse18")=  request.form("Reponse18")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 19 : &nbsp;<% =  request.form("objet19")%><%session("question19")=  request.form("objet19")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse19")%><%session("Reponse19")=  request.form("Reponse19")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Question 20 : &nbsp;<% =  request.form("objet20")%><%session("question20")=  request.form("objet20")%>&nbsp;</font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =  request.form("Reponse20")%><%session("Reponse20")=  request.form("Reponse20")%></td>
                  </tr>
				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
				  
				  
				  
				  <tr>
					<td colspan="2" width="670" valign="center">


					  <INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier" onClick="history.back()" > -->
					
					   <input name="valider" style="width:75" type="button" OnClick="window.location.href='valider_p_admin_interview_insert.asp'" value="Valider">	
			  
					     <!--  <input name="creer" style="width:75" type=submit value="Creer" >  -->
					
 
	 <!--<input style="margin-top:4" type=submit value="Upload">		-->

	</form>
	

					
				  
				  
					</td>
                  </tr>
				  
                </table>
	

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