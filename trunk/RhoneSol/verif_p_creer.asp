<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

	
	<!-- #include file="connexion.asp"-->
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<% 
		Set rsED1 = Conn.Execute("SELECT * FROM CREATION")
%>

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Vérification de la demande avant enregistrement</div>

<table border="0px" width="100%" cellpadding="10px">
	
	<tr>
		<td colspan="2"><font color="#6faa06">
        	Vérification avant validation _____________________________________________________</font>
		</td>
    </tr>

</table>


<table style="background-repeat:no-repeat;" width="650" border="0" cellspacing="0" cellpadding="0" align="center valign="center" class="txt2">

	<tr>
		<td colspan="2" class="style"> <br />
        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>

	<tr>
		<td> <br />
           
<table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
	<tr> 
		<td>
        	<img src="../imgs/1x1.gif" width="165" height="1">
		</td>
	
    	
        <td>&nbsp;
        	
        </td>
        
	</tr>


	<tr> 
    	<td>
        	<font color="#969696">
            	Civilité :
            </font>
        </td>
        
        <td>
			<% =request.form("CivCrea")%> <%session("CivCrea")=request.form("CivCrea")%>
        </td>
	</tr>    
         
                  
    <tr> 
    	<td class="txt1">
        	<font color="#969696">
            	Nom :
            </font>
        </td>
        
        <td>
			<% =request.form("NomCrea")%><%session("NomCrea")=request.form("NomCrea")%>
        </td>
    </tr>
    
    			  
	<tr> 
    	<td class="txt1">
        	<font color="#969696">
            	Prenom :
            </font>
        </td>
       
    	<td>
			<% =request.form("PrenomCrea")%><%session("PrenomCrea")=request.form("PrenomCrea")%>
        </td>
	</tr>


	<tr> 
    	<td class="txt1">
        	<font color="#969696">
            	Fonction :
            </font>
        </td>
        
        <td>
			<% =request.form("FonctionCrea")%><%session("FonctionCrea")=request.form("FonctionCrea")%>
        </td>
	</tr>
    
    			    
	<tr> 
    	<td class="txt1">
        	<font color="#969696">
            	Société :
            </font>
        </td>
        
        <td>
			<% =request.form("SocieteCrea")%><%session("SocieteCrea")=request.form("SocieteCrea")%>
        </td>
	</tr>
    

	<tr> 
		<td class="txt1">
        	<font color="#969696">
            	Adresse :
            </font>
        </td>
        
        <td>
			<% =request.form("AdrCrea")%><%session("AdrCrea")=request.form("AdrCrea")%>
        </td>
	</tr>
    
    
    <tr> 
    	<td class="txt1">
        	<font color="#969696">
            	Code Postal / Boîte Postal:
            </font>
        </td>
		
        <td>
			<% =request.form("CpCrea")%><%session("CpCrea")=request.form("CpCrea")%>
        </td>
	</tr>
    

	<tr> 
    	<td class="txt1">
        	<font color="#969696">
            	Ville :
            </font>
        </td>
        
        <td>
			<% =request.form("VilleCrea")%><%session("VilleCrea")=request.form("VilleCrea")%>
        </td>
	</tr>

	<tr> 
    	<td class="txt1">
        	<font color="#969696">
            	Mail :
            </font>
        </td>
        
        <td>
			<% =request.form("MailCrea")%><%session("MailCrea")=request.form("MailCrea")%>
        </td>
	</tr>

    
    <tr> 
		<td class="txt1">
        	<font color="#969696">
            	Téléphone Fixe :
            </font>
		</td>
        
         <td>
			<% =request.form("FixeCrea")%><%session("FixeCrea")=request.form("FixeCrea")%>
        </td>
	</tr>
        
    
    <tr> 
		<td class="txt1">
        	<font color="#969696">
            	Téléphone Portable :
            </font>
		</td>
        
         <td>
			<% =request.form("PortableCrea")%><%session("PortableCrea")=request.form("PortableCrea")%>
        </td>
	</tr>


    <tr> 
		<td class="txt1">
        	<font color="#969696">
            	Votre projet :
            </font>
		</td>
        
         <td>
			<% =request.form("ProjetCrea")%><%session("ProjetCrea")=request.form("ProjetCrea")%>
        </td>
	</tr>


    <tr> 
		<td class="txt1">
        	<font color="#969696">
            	Votre demande :
            </font>
		</td>

    
         <td>
			<% =request.form("DemandeCrea")%><%session("DemandeCrea")=request.form("DemandeCrea")%>
        </td>
	</tr>


    <tr> 
		<td class="txt1">
        	<font color="#969696">
            	Votre budget :
            </font>
		</td>
        
         <td>
			<% =request.form("BudgetCrea")%><%session("BudgetCrea")=request.form("BudgetCrea")%>
        </td>
	</tr>


    <tr> 
		<td class="txt1">
        	<font color="#969696">
            	Délai :
            </font>
		</td>
        
         <td>
			<% =request.form("DelaiCrea")%><%session("DelaiCrea")=request.form("DelaiCrea")%>
        </td>
	</tr>


    <tr> 
		<td class="txt1">
        	<font color="#969696">
            	Commentaire :
            </font>
		</td>
        
         <td>
			<% =request.form("CommentCrea")%><%session("CommentCrea")=request.form("CommentCrea")%>
        </td>
	</tr>
	<tr>
		<td colspan="2" width="670" valign="center">&nbsp;</td>
	</tr>

	<tr>
		<td> 				<br /><br /><br /><br /><br /><br /><br /><br /> 	
        

            
					  
                      
				<INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier" onClick="history.back()" >
					
				<input name="valider" style="width:75" type="button" OnClick="window.location.href='valid_p_creer_fin.asp'" value="Valider">	
			
			  	
			  
		  </td></tr>
				  
                </table>
	</td></tr><tr><td colspan="2"></td></tr></table>
  <!-- #include file="grand_footer.txt"-->  
  
<!-- #include file="deconnexion.asp"-->
</div>

</body>
</html>