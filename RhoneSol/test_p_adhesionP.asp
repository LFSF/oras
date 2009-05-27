


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

<div align="justify">
<!-- Formulaire d'adhésion -->
<form action="test_verif_p_adhesionP.asp" method="post" id="contact" name="contact" onsubmit="return verifformP()">

    <p><strong>Pour&nbsp; devenir ADHERENT ,&nbsp; Merci de renseigner le formulaire&nbsp; suivant :</strong><br /></p>

<table border="0" width="100%" cellpadding="2" cellspacing="2" class="txt">

    <tr>
        <td><% =Server.HtmlEncode("Civilité")%></td>
        <td>

            <table border="0" cellspacing="0" cellpadding="0" class="txt">
                <tr>
                    <td><input name="CivMembre" type="radio" value="madame" checked="checked" /></td>
                    <td>Mme&nbsp;</td>

                    <td><input type="radio" name="CivMembre" value="mademoiselle" /></td>
                    <td>Mlle&nbsp;</td>

                    <td><input type="radio" name="CivMembre" value="monsieur" /></td>
                    <td>M&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>


    <tr>
        <td width="30%" class="textes">Nom *</td>
        <td><input name="NomMembre" id="NomMembre" class="txt" size="30" maxlength="40" /></td>
    </tr>


    <tr>
        <td width="30%" class="textes"><% =Server.HtmlEncode("Prénom *")%></td>
        <td><input name="PreNomMembre" class="txt" size="30" maxlength="40" /></td>
    </tr>

    <!--vérifie si les donnée inscrite sont bien des chiffres, keycode pour IE et which pour firefox-->
    <tr>
        <td class="textes">Age *</td>
        <td><input name="AgeMembre" class="txt" id="AgeMembre" size="30" maxlength="2" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;" /></td>
    </tr>


    <!--vérifie si les donnée inscrite sont bien des chiffres, keycode pour IE et which pour firefox-->
    <tr>
        <td class="textes"><% =Server.HtmlEncode("Téléphone *")%></td>
        <td><input name="TelMembre" class="txt" id="TelMembre" size="30" maxlength="14" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/></td>
    </tr>



    <tr>
        <td class="textes">Mail *</td>
        <td><input name="MailMembre" class="txt" id="MailMembre" size="30" maxlength="50" /></td>
    </tr>   

    <tr>
        <td class="textes">Confirmation Mail *</td>
        <td><input name="MailMembre2" class="txt" id="MailMembre2" size="30" maxlength="50" /></td>
    </tr>

    <tr>
        <td class="textes">Mot de passe *</td>
        <td><input type="password" name="MdpMembre" id="MdpMembre" class="txt" size="30" maxlength="50"/></td>
    </tr>


    <tr>
        <td class="textes">Confirmation Mdp *</td>
        <td><input type="password" name="MdpMembre2" class="txt" size="30" maxlength="50" /></td>
    </tr>



    <tr>
        <td class="textes">Adresse *</td>
        <td><input name="AdrMembre" class="txt" size="30" maxlength="50" /></td>
    </tr>


    <!--vérifie si les donnée inscrite sont bien des chiffres, keycode pour IE et which pour firefox-->
    <tr>
        <td class="textes">Code Postal / BP*</td>
        <td><input name="CPMembre" class="txt" size="30" maxlength="10" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"></td>
    </tr>

    <tr>
        <td class="textes">Ville *</td>
        <td><input name="VilleMembre" class="txt" size="30" maxlength="50" /></td>
    </tr>




    <tr>
        <td class="textes">Pays *</td>
        <td><input name="PaysMembre" class="txt" value="France" size="30" maxlength="40" /></td>
    </tr>



    <tr>
        <td width="30%" class="textes">Fonction </td>
        <td><input name="FonctionMembre" class="txt" size="30" maxlength="40" /></td>
    </tr>


    <tr>
        <td class="textes">Association / Organisme</td>
        <td><input name="OrganismeMembre" class="txt" size="30" maxlength="40" /></td>
    </tr>


    <tr>
        <td width="25%">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>


    <tr>
        <td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>
    </tr>       


    <tr>
        <td colspan="2">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="txt">
                <tr>
                    <td colspan="2">Je souhaite devenir : Partenaire  &nbsp; <input  name="PartenaireMembre" type="checkbox" id="PartenaireMembre" /></td>
                </tr>
                <tr>
                    <td colspan="2" width="670" align="center" valign="center">&nbsp;&nbsp;</td>
                </tr>               
                <tr>
                    <td colspan="2">Dans les domaines suivants:</td>
                </tr>


                <tr>
                    <td colspan="2"><% =Server.HtmlEncode("La Cooperation décentralisée.")%></td>
                    <td><input name="CooperationMembre" type="checkbox" id="CooperationMembre" /></td>
                </tr>


                <tr>
                    <td colspan="2">Le Commerce solidaire.</td>
                    <td><input name="SolidaireMembre" type="checkbox" id="SolidaireMembre" /></td>
                </tr>


                <tr>
                    <td colspan="2">La Formation.</td>
                    <td><input name="FormationMembre" type="checkbox" id="FormationMembre" /></td>
                </tr>


                <tr>
                    <td colspan="2">Dans un Autre Domaine.</td>
                    <td><input name="AutreMembre" type="checkbox" id="AutreMembre" /></td>
                </tr>

            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>
    </tr>
    <tr>
        <td width="5%" align="middle">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>


    <tr>
        <td width="25%">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>


    <tr>
        <td colspan="2">
            <br />
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="txt">
                <tr>
                    <td colspan="2">Je souhaite m'inscrire a la Newsletter</td>
                    <td><input name="News" type="checkbox" id="checkbox" /></td>

                </tr>

                <% if Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_actualites.asp" then
                %>
                <tr>

                    <td colspan="2"><% =Server.HtmlEncode("Je souhaite écrire des articles dans votre pages actualités.")%></td>

                    <td><input name="RedacteurMembre" type="checkbox" checked=true id="RedacteurMembre" /></td>

                </tr>
                <%else%>
                <tr>

                    <td colspan="2"><% =Server.HtmlEncode("Je souhaite écrire des articles dans votre pages actualités.")%></td>

                    <td><input name="RedacteurMembre" type="checkbox"  id="RedacteurMembre" /></td>

                </tr>
                <%end if%>
                <tr>
                    <td colspan="2"><% =Server.HtmlEncode("Je souhaite faire connaître mon organisme via une Interview.")%></td>
                    <td><input name="InterviewMembre" type="checkbox" id="InterviewMembre" /></td>
                </tr>


                <tr>
                    <td colspan="2"><% =Server.HtmlEncode("Je souhaite créer un site Internet.")%></td>
                    <td><input name="CreationsiteMembre" type="checkbox" id="CreationsiteMembre" /></td>
                </tr>


                <tr>    
                    <td colspan="2">Autre&nbsp;</td>
                    <td><input name="AutresMembre" type="checkbox" id="AutresMembre" /></td>
                </tr>


                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>

    <tr>
        <td colspan="2">Message :</td>
    </tr>

    <tr>
        <td colspan="2">
            <textarea class="txt" id="MessageMembre" name="MessageMembre" rows="8" cols="60"></textarea>
        </td>
    </tr>

    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>

    <tr>
        <td>
            
            <%=recaptcha_challenge_writer("6LcESgUAAAAAAKdBFJM7JQQpKKpp6OnyJVHt9vyb")%>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>

                    <td width="50%" align="middle">
                        <input name="reset1" type="reset" value="Effacer" id="reset2" width="109" height="16" border="0">
                    <td width="50%" align="middle">
                        <input name="submit1" type="submit" value="Valider" id="submit1" width="109" height="16" border="0" onclick="<%Session>
                    </td>
                    </td>
            </tr>
            </table>

            <p>&nbsp;</p>
            <p>* (Obligatoire)</p>
        </td>
    </tr>
    </table>
</form>
</div>


