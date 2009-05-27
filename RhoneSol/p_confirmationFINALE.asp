<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<SCRIPT LANGUAGE="JavaScript">
function fonc1()
{
window.location.href='p_infos_historique.asp'
}
function fonc2()
{
window.location.href='p_infos_definition.asp'
}
function fonc3()
{
window.location.href='p_infos_cadre.asp'
}
function fonc4()
{
window.location.href='p_infos_financements.asp'
}
</SCRIPT>


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

     
     
        <div>
    
        <% 
        ' On extrait les variables dans la barre d'adresse
        MonLogin = Request.QueryString("confirmation")
        MonMdp = Request.QueryString("mdp") 
        
        
        
        ' Connexion à la BDD & Modification
        dbPath = Server.MapPath("Upload_AdhesionG.mdb")

        Set Conn = Server.CreateObject("ADODB.Connection")

        Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
          & " DBQ=" & dbPath
          
        'Modification dans la base de donnée :  le membre devient valide
        'rsPost ="UPDATE MEMBRE SET AdhesionMembre='oui' WHERE MailMembre='" & Request.QueryString("confirmation") & "'"
        rsPost ="UPDATE MEMBRE SET AdhesionMembre='oui' WHERE MailMembre='" & Request.QueryString("confirmation")& "'" & " AND Motdepasse='" & Request.QueryString("mdp") &  "'"
        
        Conn.Execute(rsPost)
        majDate()
        %>
        <!-- #include file="deconnexion.asp"-->

        
        Votre inscription est activée. Vous pouvez vous connecter au site à partir des données suivantes : <br/><br/>
        Login: 
        <%=MonLogin%>
        <br/>
        Mot de passe : 
        <%=MonMdp%>
        
        
    </div>
     
     


      <!-- #include file="grand_footer.txt"-->  
    </div>

</body>
</html>