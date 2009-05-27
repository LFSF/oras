<!-- #include file="connexion.asp"-->
<script type="text/javascript" language="javascript" src="js/ajaxGesMembre.js"></script>

<div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->

<%
               
                                  
Dim nbParPage,limit,sql,numPage,nbLigne,x,y
limit=""
nbParPage=10
numPage=1


 if Request.QueryString("page")<>"" then
      numPage=Request.QueryString("page")
 end if

 sql="SELECT COUNT(*) AS nb FROM MEMBRE WHERE AdminMembre = 0"
 rs = Conn.Execute(sql)
 nbLigne= rs("nb")

 'Si il n'y a pas de tuples alors on affiche un message sinon on fait le traitement nécéssaire
 if nbLigne=0 then
      Response.Write "<p>Il n'y a pas de membres enregistrés</p>"
 else
     y= numPage*nbParPage

     if y=> nbLigne then
          y=nbLigne
     end if

     x= numPage*nbParPage-nbParPage
     'Response.Write "x= "&x&" y="&y

     ' Si on rentre à la main un nombre supérieur au nombre de pages.
     if x>nbLigne then
          Response.AddHeader "Refresh", "0;URL="&Request.ServerVariables("URL")&"?page=1"
     end if

    %>
    <center><FONT size=1><STRONG><%Response.Write "N° de la page : "&numPage %><br></STRONG></font></center><br>
    <table class="txt" cellspacing="0" width="100%" cellpadding="1" cellspacing="0">
        <tbody>
            <th  bgcolor="#EFEFEF" width="10%" style="color:#808080;">N°</th>
            <th bgcolor="#EFEFEF" width="50%" style="color:#808080;">Nom Prénom</th>
            <th bgcolor="#EFEFEF" width="30%" style="color:#808080;">Mail</th>
            <th bgcolor="#EFEFEF" width="10%" style="color:#808080;">Accés au panel d'administration</th>
          

        <%

            sql="SELECT * FROM (SELECT TOP "&y-x&" * FROM (SELECT TOP "&y&" * FROM MEMBRE WHERE AdminMembre = 0 ORDER BY NumMembre)AS t1   WHERE AdminMembre = 0 ORDER BY NumMembre DESC)AS t2 WHERE AdminMembre = 0 ORDER BY NumMembre;"
            'Response.Write sql&"<br />"

            Set rs = Conn.Execute(sql)
            if rs.EOF then
                Response.Write "<tr bgcolor=""#ffffff""><td colspan=""3"" >Il n'y a pas de membre enregistré</td></tr>"
            end if
            i=0

            while not rs.EOF

                if i mod 2 = 0 then
                    bgcolor="#dbfff8"
                else
                    bgcolor="#ffffff"
                end if

                Response.Write "<tr bgcolor="""&bgcolor&"""><td>"&rs("NumMembre")&"</td><td>"&rs("NomMembre")&" "&rs("PrenomMembre")&"</td>" & _
                               "<td>"&rs("MailMembre")&"</td><td><input type=""checkbox""  align=""center"" onclick=""ajaxAccesAdmin("&rs("NumMembre")&");""></td></tr>"

                i=i+1
                rs.MoveNext
            Wend
            rs.Close

            prec=numPage-1
            suiv=numPage+1

            if (prec <= 0) then
                prec=1
            end if

            ' On teste le nombre de membres de la table et ou l'on est dans le tableau pour afficher ou non
            ' le boutons précédents-suivant.

            Response.Write "<tr><td colspan=""3"" align=""center"">"
            if numPage > 1 then
                Response.Write "<a href=""gesmembre.asp?page="&prec&""" title=""Page précédente""> <<--</a>"
            end if
			Response.Write(" ")
            if numPage*nbParPage<nbLigne then
                Response.Write "<a href=""gesmembre.asp?page="&suiv&""" title=""Page précédente""> -->></a>"
            end if
            Response.Write "</td></tr>"
			

        %>
        </tbody>
    </table>
<%
end if
%>
<!-- #include file="deconnexion.asp"-->