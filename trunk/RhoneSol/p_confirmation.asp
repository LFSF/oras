<%@ LANGUAGE="VBSCRIPT" %>
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

    <div id="contenu">

    <!-- #include file="fichier_menu.txt"-->

    <div id="bandeau_orange">Partenaires</div>

    <table border="0px" width="100%" cellpadding="10px">
        
        <tr>
            <td colspan="2"><font color="#6faa06">Partenaires____________________________________________________________________</font></td>
        </tr>
        <tr>
                

    </table>

        <% 
        ' On extrait les variables dans la barre d'adresse
        MonLogin = Request.QueryString("confirmation")
        MonMdp = Request.QueryString("mdp") 
        
        ' Connexion à la BDD & Modification
          
        'Modification dans la base de donnée :  le membre devient valide
        'rsPost ="UPDATE MEMBRE SET AdhesionMembre='oui' WHERE MailMembre='" & Request.QueryString("confirmation") & "'"
        rsPost ="UPDATE MEMBRE SET AdhesionMembre='oui' WHERE MailMembre='" & Request.QueryString("confirmation")& "'" & " AND MdpMembre='" & Request.QueryString("mdp") &  "'"
        
        Conn.Execute(rsPost)
        majDate()

        %>
        
        <!-- #include file="deconnexion.asp"-->

        <br/><br/><br/><br/><br/>
        Votre inscription est activée. Vous pouvez vous connecter au site à partir des données suivantes : <br/><br/>
        Login: 
        <%=MonLogin%>
        <br/>
        Mot de passe : 
        <%=MonMdp%>
        
        
    
     <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>


      <!-- #include file="grand_footer.txt"-->  
    </div>

</body>
</html>