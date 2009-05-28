<%
' On Error Resume Next

' Classsic ASP pages created by Andre F Bruton
' E-mail: andre@bruton.co.za
' Date: 2008/01/19


recaptcha_challenge_field  = Request("recaptcha_challenge_field")
recaptcha_response_field   = Request("recaptcha_response_field")
recaptcha_private_key      = "6LcESgUAAAAAACbPJgiRDJsbhOAhyX_a0xclrHEu "
recaptcha_public_key       = "6LcESgUAAAAAAKdBFJM7JQQpKKpp6OnyJVHt9vyb "
browser                    = Request.ServerVariables("HTTP_USER_AGENT")
ip                         = Request.ServerVariables("REMOTE_HOST")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!-- #include file="grand_meta.txt"-->
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<!-- #include file="connexion.asp"-->
<title>Rhône-solidarité </title>

<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%

 
' returns string the can be written where you would like the reCAPTCHA
'challenged placed on your page
function recaptcha_challenge_writer(publickey)
recaptcha_challenge_writer = "<script type=""text/javascript"">" & _
"var RecaptchaOptions = {" & _
"   theme : 'white'," & _
"   tabindex : 0" & _
"};" & _
"</script>" & _
"<script type=""text/javascript"" src=""http://api.recaptcha.net/challenge?k=" & publickey & """></script>" & _
"<noscript>" & _
  "<iframe src=""http://api.recaptcha.net/noscript?k=" & publickey &""" frameborder=""1""></iframe><br>" & _
    "<textarea name=""recaptcha_challenge_field"" rows=""3""cols=""40""></textarea>" & _
    "<input type=""hidden"" name=""recaptcha_response_field""value=""manual_challenge"">" & _
"</noscript>" 

end function

function recaptcha_confirm(privkey,rechallenge,reresponse)
' Test the captcha field

Dim VarString
VarString = _
        "privatekey=" & privkey & _
        "&remoteip=" & Request.ServerVariables("REMOTE_ADDR") & _
        "&challenge=" & rechallenge & _
        "&response=" & reresponse

Dim objXmlHttp
Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
objXmlHttp.open "POST", "http://api-verify.recaptcha.net/verify",False
objXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
objXmlHttp.send VarString

Dim ResponseString
ResponseString = split(objXmlHttp.responseText, vblf)
Set objXmlHttp = Nothing

if ResponseString(0) = "true" then
  'They answered correctly
   recaptcha_confirm = ""
else
  'They answered incorrectly
   recaptcha_confirm = ResponseString(1)
end if

end function

%> 

<!-- #include file="grand_header.txt"-->

<% 
cTemp = recaptcha_confirm(recaptcha_private_key, recaptcha_challenge_field, recaptcha_response_field)

If cTemp <> "" Then 
%>

<div id="contenu">
<center><h3><b>Les 2 Mots saisis ne sont pas corrects</b></h3><br/>
<a href="javascript:history.back()">Retour</a></center>

<%
else
%>

<% 
        ' On extrait les variables dans la barre d'adresse
        zemail = Request.form("MailMembre")
        
          Dim rsED1
      
        
    compteur=0
        Set rsED1 = Conn.Execute("SELECT * FROM Membre  where MailMembre='"  & zemail  & "'")
   
          While Not rsED1.EOF
        compteur = compteur + 1
          
            rsED1.MoveNext
                
            Wend
            rsED1.Close 
            
            Set rsED1 = Nothing

        %>

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Vérification Adhesion avant enregistrement</div>

<table border="0px" width="100%" cellpadding="10px">
    
    <tr>
        <td colspan="2"><font color="#6faa06">Vérification avant validation _____________________________________________________</font></td>
    </tr>


</table>



<%

 if (request.form("News")="on")then
session("News")="1"
else
session("News")="0"
end if

 if (request.form("PartenaireMembre")="on")then
session("PartenaireMembre")="oui"
else
session("PartenaireMembre")="non"
end if

if (request.form("CooperationMembre")="on") then
session("CooperationMembre")="oui"
else
session("CooperationMembre")="non"
end if

if (request.form("SolidaireMembre")="on") then
session("SolidaireMembre")="oui"
else
session("SolidaireMembre")="non"
end if

if (request.form("FormationMembre")="on") then
session("FormationMembre")="oui"
else
session("FormationMembre")="non"
end if
                  
if (request.form("AutreMembre")="on") then
session("AutreMembre")="oui"
else
session("AutreMembre")="non"
end if  
                
if (request.form("RedacteurMembre")="on") then
session("RedacteurMembre")="oui"
else
session("RedacteurMembre")="non"
end if  
                
if (request.form("InterviewMembre")="on") then
session("InterviewMembre")="oui"
else
session("InterviewMembre")="non"
end if          

if (request.form("CreationsiteMembre")="on") then
session("CreationsiteMembre")="oui"
else
session("CreationsiteMembre")="non"
end if      

if (request.form("News")="on") then
session("News")="oui"
else
session("News")="non"
end if  

if (request.form("AutresMembre")="on") then
session("AutresMembre")="oui"
else
session("AutresMembre")="non"
end if  


                  
%>

<table style="background-repeat:no-repeat;" width="650" border="0" cellspacing="0" cellpadding="0" align="center" valign="center" class="txt2">

    <tr >
        <td colspan="2" class="style"> <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>

    <tr>
        <td><br />
           
    			<table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  
                 
<!--  
 RS("DateMembre")=replace(REPLACE(date,"""",espace),"'",simplecot) 
 RS("AdhesionMembre")="non"-->      
           
<!-- Nom -->                    
                  <tr> 
                    <td class="txt1"><font color="#969696">Nom :</font></td>
                    <td><% =request.form("NomMembre")%><%session("NomMembre")=request.form("NomMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Prenom :</font></td>
                    <td><% =request.form("PrenomMembre")%><%session("PrenomMembre")=request.form("PrenomMembre")%></td>
                  </tr>

                  <tr> 
                    <td class="txt1"><font color="#969696">Téléphone :</font></td>
                    <td><% =request.form("TelMembre")%><%session("TelMembre")=request.form("TelMembre")%></td>
                  </tr>
                  
                  <tr> 
                  
                  <% if compteur>0 then%>
                  <font color="#FF0000">
                    <td><font color="#FF0000">ATTENTION Email DEJA EXISTANT :</font> </td>
                    <td><font color="#FF0000"><% =request.form("MailMembre")%></font><%session("MailMembre")=request.form("MailMembre")%></td>
                </font>
                    
                    <% end if %>    

                     <% if compteur=0 then%>        
                  
                  <td class="txt1"><font color="#969696">Email :</font></td>
                    <td><% =request.form("MailMembre")%><%session("MailMembre")=request.form("MailMembre")%></td>
                  
                  <% end if %>
                  </tr>

                  <tr> 
                    <td class="txt1"><font color="#969696">Adresse :</font></td>
                    <td><% =request.form("AdrMembre")%><%session("AdrMembre")=request.form("AdrMembre")%></td>
                  </tr>
                  
                  <tr>
                    <td class="txt1"><font color="#969696">Mot de passe : </font></td>
                    <td><% =request.form("MdpMembre")%><%session("MdpMembre")=request.form("MdpMembre")%></td>
                  </tr>
                
                  <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite recevoir la Newsletter :</font></td>
                
                    <td><% =session("News")%></td>
                    
                    
                  </tr>               
                  
                  <tr>
                    <td class="txt1"><font color="#969696">Veuillez indiquer votre age :</font></td>
                    <td><% =request.form("AgeMembre")%><%session("AgeMembre")=request.form("AgeMembre")%></td>
                  </tr> 
                  
                  <tr> 
                    <td><font color="#969696">Civilité :</font></td>
                    <td><% =request.form("CivMembre")%> <%session("CivMembre")=request.form("CivMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Ville :</font></td>
                    <td><% =request.form("VilleMembre")%><%session("VilleMembre")=request.form("VilleMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Code Postal / Boîte Postal:</font></td>
                    <td><% =request.form("CPMembre")%><%session("CPMembre")=request.form("CPMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Fonction :</font></td>
                    <td><% =request.form("FonctionMembre")%><%session("FonctionMembre")=request.form("FonctionMembre")%></td>
                  </tr>
                    
                  <tr> 
                    <td class="txt1"><font color="#969696">Organisme :</font></td>
                    <td><% =request.form("OrganismeMembre")%><%session("OrganismeMembre")=request.form("OrganismeMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Pays :</font></td>
                    <td><% =request.form("PaysMembre")%><%session("PaysMembre")=request.form("PaysMembre")%></td>
                  </tr>

                  <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite devenir partenaire :</font></td>
                    <td><%=session("PartenaireMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Dans le domaine de la Coopération Décentralisée :</font></td>
                    <td><%=session("CooperationMembre")%></td>
                  </tr>
                  
                  <!--solidaire, formation, autre -->
                  <tr> 
                    <td class="txt1"><font color="#969696">Dans le domaine du commerce solidaire :</font></td>
                    <td><% =session("SolidaireMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Dans le domaine de la formation :</font></td>
                    <td><% =session("FormationMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Autre domaine :</font></td>
                    <td><% =session("AutreMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite écrire des articles dans la rubriques actualités :</font></td>
                    <td><% =session("RedacteurMembre")%></td>
                  </tr>
                  
                  <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite faire connaître mes actions :</font></td>
                    <td><% =session("InterviewMembre")%></td>
                  </tr>
                  

    
                  <tr>
                    <td class="txt1"><font color="#969696">Je souhaite créer un site Internet :</font></td>
                    <td><% =session("AutresMembre")%></td>
                  </tr>

                                  
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
    
                  
                  
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Message : </font><br><br><br>&nbsp;
                  </td>
                  </tr>
                  
                  <tr>
                    <td colspan="2"><% =request.form("MessageMembre")%><%session("MessageMembre")=request.form("MessageMembre")%></td>
                  </tr>
                  
                  <tr>
                    <td colspan="2" width="670" valign="center">__________________________________________________</td>
                  </tr>
    
              
                  <tr>
                  <td>
                  
                  <br>
                    <br>    
                      <INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier" onClick="history.back()" >
                    
                <% if compteur=0 then   %>
                    <input name="valider" style="width:75" type="button" OnClick="window.location.href='valider_p_adhesionP.asp'" value="Valider">  
            
              

                  <% end if %>
                  
                  
                  
                
                  </td></tr>
                  
                </table>
    </td></tr><tr><td colspan="2"></td></tr>

</table>
<%end if%>
<!-- Ne pas toucher à ce qui suit : placement du footer -->

 <!-- #include file="grand_footer.txt"-->  



 
</div>

</body>
 <!-- #include file="deconnexion.asp"--> 
</html>