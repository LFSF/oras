<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->
<script language="javascript">
function removeMsg(){
	var Node= document.getElementById("msg");
	if(Node.hasChildNodes()){
		var message = Node.getElementsByTagName("td").item(0);
		Node.removeChild(message);
	}
}

</script>
<div align="justify">
        
<%
               
                                  
Dim nbParPage,limit,sql,numPage,nbLigne,x,y
limit=""
nbParPage=10
numPage=1


 if Request.QueryString("page")<>"" then
      numPage=Request.QueryString("page")
 end if

 sql="SELECT COUNT(*) AS nb FROM MEMBRE WHERE AdminMembre = 1"
 rs = Conn.Execute(sql)
 nbLigne= rs("nb")

 'Si il n'y a pas de tuples alors on affiche un message sinon on fait le traitement nécéssaire
 if nbLigne=0 then
      Response.Write "<p>Il n'y a pas de membres enregistrés</p>"
 else
 %>
 <form action="test_gesadmin.asp" enctype="application/x-www-form-urlencoded" method="post">
 <%
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
    <table class="txt" cellspacing="0" width="100%" cellpadding="1" cellspacing="0" id="tableau">
        <tbody>
		<%
		
		'Affichage du message de confirmation
		Response.Write "<tr id=""msg"">"
		
		if Request.QueryString("msg")=1 then
				Response.Write "<td style=""border:1px solid #336600;background-color: #66FF66;color: #336600"" colspan=""7"">"& _
							   "Les changements ont bien été pris en compte</td>"
		end if
		
		Response.Write "</tr>"
		
		%>
            <th  bgcolor="#EFEFEF" width="5%" style="color:#808080;">N°</th>
            <th bgcolor="#EFEFEF" width="35%" style="color:#808080;">Nom Prénom</th>
			<th bgcolor="#EFEFEF" width="35%" style="color:#808080;">Email</th>
            <th bgcolor="#EFEFEF" width="5%" style="color:#808080;">Accés actualités</th>
			<th bgcolor="#EFEFEF" width="5%" style="color:#808080;">Accés interview</th>
			<th bgcolor="#EFEFEF" width="5%" style="color:#808080;">Accés offres</th>
			<th bgcolor="#EFEFEF" width="5%" style="color:#808080;">Accés CV</th>
			<th bgcolor="#EFEFEF" width="5%" style="color:#808080;">Accés idées</th>
          

        <%
            sql="SELECT * FROM (SELECT TOP "&y-x&" * FROM (SELECT TOP "&y&" * FROM ADMIN,MEMBRE WHERE ADMIN.NumMembre=MEMBRE.NumMembre"& _
			    " ORDER BY ADMIN.NumMembre)AS t1 ORDER BY ADMIN.NumMembre DESC)AS t2;"
            'Response.Write sql&"<br />"

            Set rs = Conn.Execute(sql)
            if rs.EOF then
                Response.Write "<tr bgcolor=""#ffffff""><td colspan=""7"" >Il n'y a pas de membre enregistré</td></tr>"
            end if
            i=0
			
			

            while not rs.EOF

                if i mod 2 = 0 then
                    bgcolor="#dbfff8"
                else
                    bgcolor="#ffffff"
                end if

                Response.Write "<tr bgcolor="""&bgcolor&"""><td>"&rs("NumMembre")&"</td><td>"&rs("NomMembre")&" "&rs("PrenomMembre")&"</td><td>"&rs("MailMembre")&"</td>"
				
				checked="checked=""checked"""
		

				if rs("ActuVisu")= 1 then
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""ActuVisu"&i&""" "&checked&" onclick=""removeMsg();""></td>")				
				else
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""ActuVisu"&i&""" onclick=""removeMsg();""></td>")
				end if
				
				if rs("ItwVisu")= 1 then
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""ItwVisu"&i&""" "&checked&" onclick=""removeMsg();""></td>")
				else
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""ItwVisu"&i&""" onclick=""removeMsg();""></td>")
				end if
				
				if rs("OffVisu")= 1 then
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""OffVisu"&i&""" "&checked&" onclick=""removeMsg();""></td>")
				else
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""OffVisu"&i&""" onclick=""removeMsg();""></td>")
				end if
				
				if rs("CvVisu")= 1 then
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""CvVisu"&i&""" "&checked&" onclick=""removeMsg();""></td>")
				else
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""CvVisu"&i&""" onclick=""removeMsg();""></td>")
				end if
				if rs("IdVisu")= 1 then
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""IdVisu"&i&""" "&checked&" onclick=""removeMsg();""/>")
				else
					Response.Write("<td><input type=""checkbox""  align=""center"" name=""IdVisu"&i&"""  onclick=""removeMsg();""/>")
				end if
				
				' On rajoute en plus en hidden l'id du membre, pour pouvoir le recuperer lors du traitement
				Response.Write("<input type=""hidden""  align=""center"" name=""NumMembre"&i&""" value="""&rs("NumMembre")&""" ></td>")                              
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

            Response.Write "<tr bgcolor="""&bgcolor&"""><td colspan=""3"" align=""center"">"
            if numPage > 1 then
                Response.Write "<a href=""gesadmin.asp?page="&prec&""" title=""Page précédente"" onclick=""removeMsg();""> <<--</a>"
            end if
			Response.Write(" ")
            if numPage*nbParPage<nbLigne then
                Response.Write "<a href=""gesadmin.asp?page="&suiv&""" title=""Page précédente"" onclick=""removeMsg();""> -->></a>"
            end if
            Response.Write "</td></tr>"
			
			' Les boutons reset et submit
			Response.Write "<tr bgcolor=""#EFEFEF""><td align=""center"" colspan=""7""><input type=""hidden""  align=""center"" name=""NbMembre"" value="""&i&""" >"& _
						   "<input type=""reset"" value=""Reset"" onclick=""removeMsg();"" ><input type=""submit"" value=""Mettre a jour"" />"& _
						   "</td></tr>" 

        %>
        </tbody>
    </table>
  </form>
<%
end if
%>
<!-- #include file="deconnexion.asp"-->