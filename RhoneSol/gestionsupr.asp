<!-- #include file="admin_securite.asp"-->

<!-- #include file="connexion.asp"-->
      <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
        
<%
               
                                    
  '********** enregistrement des donnees dans la bd
 
'  valid_enregistrement="non"
' dbPath = Server.MapPath("bd/oras.mdb")
'Set Conn = Server.CreateObject("ADODB.Connection")
'Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
'  & " DBQ=" & dbPath


'SQL="SELECT * FROM [contact_organisme]"
'Set RS = server.createobject("ADODB.Recordset")
'RS.Open SQL,Conn , 3, 3

'RS.addnew
'***********
' RS("status")=Request.form("status")
' RS("nom")=Request.form("nom")
' RS("prenom")=Request.form("prenom") 
' RS("fonction")=Request.form("fonction") 
' RS("type_organisme")=Request.form("typeorganisme") 
' RS("nom_organisme")=Request.form("nom_organisme")
' RS("email")=Request.form("email") 
' RS("tel")=Request.form("telephone")
' RS("tel2")=Request.form("telephone2") 
' RS("fax")=Request.form("fax")
' RS("adresse")=Request.form("adresse")
' RS("cp")=Request.form("cp")
' RS("ville")=Request.form("ville")
' RS("pays")=Request.form("pays")
' RS("commentaire")=Request.form("commentaire")
' RS("date_inscription")=Date
' valid_enregistrement="oui"
 
'***********
'RS.update
'rs.Close
'set rs = Nothing
'conn.Close
'set conn= Nothing  
                            
  '***** fin enregistrement*****************

       select case Request.QueryString("sens")
        case""
            if session("numeropage")<>1 then
                if session("numeropage")="" then
                            session("numeropage")=1
                end if
            end if
            case"suivant"
        session("numeropage")=session("numeropage")+1
            case"precedent"
        session("numeropage")=session("numeropage")-1
        end select




 
 '=================*******************************************************
  
'  Set rs2 = Server.CreateObject("ADODB.RecordSet")

 
 
 'SQL1 = "Select * from t_depotcv where visible_sur_site='non'"
 
 ' SQL2 = "Select * from ADMIN WHERE SuperAdmin =" & 1 & ""
 
 
 
 
 ' rs2.open SQL2,conn,3,3 

  
 Set rsv = Server.CreateObject("ADODB.RecordSet")
       
    'SQL1 = "select * from MEMBRE INNER JOIN ADMIN ON  MEMBRE.NumMembre  = ADMIN.NumMembre and ADMIN.SuperAdmin=" & 1
 
        SQL1 = "select * from MEMBRE INNER JOIN ADMIN ON  MEMBRE.NumMembre  = ADMIN.NumMembre where ADMIN.SuperAdmin=" & 1 &  " OR(ActuVisu=1 and ItwVisu=1 and CVVisu=1 and OffVisu=1 and IdVisu=1)"
 
 
'response.write(SQL1 & "</br>")
 
 ' SQL1 = "Select * from MEMBRE WHERE NumMembre = " & rs2("NumMembre") & ""
 
 
  rsv.PageSize=100
  rsv.open SQL1,conn,1,3 
  rsv.AbsolutePage =session("numeropage")
  



 '=================*******************************************************
 
  

%>
<center><FONT size=1><STRONG>Numero de la page :<%
Response.Write(session("numeropage"))%><br></STRONG></font></center><br>

<form name=lesadh action="validgestionsupr.asp" method="post"   id="p_admin_gestion_login">
    <table class="txt" cellpadding="1" cellspacing="0" width="100%">
        <th  bgcolor="#EFEFEF" width="10%" style="color:#808080;">N°</th>
        <th bgcolor="#EFEFEF" width="60%" style="color:#808080;">Nom Prénom</th>
        <th bgcolor="#EFEFEF" width="30%" style="color:#808080;">Super Admin</th>


    <%  
    for i=1 to rsv.PageSize
                    if i mod 2 = 0 then
                        bgcolor="#dbfff8"
                    else
                        bgcolor="#ffffff"
                    end if
                
                    lenum =rsv.fields("NumMembre").value
                    'date_inscription = rsv.fields("date_inscription").value
                    'civilite = rsv.fields("civilite").value
                    'age = rsv.fields("age").value
                    nom = rsv.fields("NomMembre").value
                    prenom = rsv.fields("PrenomMembre").value
                    organisme = rsv.fields("OrganismeMembre").value
                    adresse = rsv.fields("AdrMembre").value
                    ville = rsv.fields("VilleMembre").value
                    cp= rsv.fields("CPMembre").value
                    email = rsv.fields("MailMembre")
                    tel = rsv.fields("TelMembre")
                    
                    'acces_admin= rs2.fields("SuperAdmin")
                    
                    acces_admin= rsv.fields("SuperAdmin")
                    
                    
                    
                    
                    
                            
                    compteur =compteur + 1
                    Response.Write "<tr bgcolor="""&bgcolor&""">"
                    
                        
    %>
    

        <td>
        
        
        <%= compteur%>
        </td>
        
        
        
        
        <!--<td>
        <INPUT type="hidden"  value="<'%=lenum%>" name="lenum<'%=compteur%>"> <'%=lenum %>
        </td>-->
        
        <td>
        <INPUT type="hidden"  value="<%=civilite%>" name="civilite<%=compteur%>"><%=civilite %>
        &nbsp;
        <INPUT type="hidden"  value="<%=nom%>" name="nom<%=compteur%>"><%=nom %>
        &nbsp;
        <INPUT type="hidden"  value="<%=prenom%>" name="prenom<%=compteur%>"><%=prenom %>

        </td>
        
        
        
        
        
        <!--<td>
        <INPUT type="hidden"  value="<'%=adresse%>" name="adresse<'%=compteur%>"><'%=adresse%>
        <br>
        <INPUT type="hidden"  value="<'%=cp%>" name="cp<'%=compteur%>"><'%=cp%>
        <INPUT type="hidden"  value="<'%=ville%>" name="ville<'%=compteur%>"><'%=ville%>
        </td>
        
        
        
        <td>
        <INPUT type="hidden"  value="<'%=email%>" name="email<'%=compteur%>"><'%=email%>
        <br>
        <INPUT type="hidden"  value="<'%=tel%>" name="tel<'%=compteur%>"><'%=tel%>
        </td>-->
        
        
    
        
        
        <%if (acces_admin= 1)then %>
        <td><INPUT type="checkbox" id=checkbox<%=compteur%> name="checkbox<%=compteur%>" checked></td>
        
        <%else%>
        <td><INPUT type="checkbox" id=checkbox<%=compteur%> name="checkbox<%=compteur%>" ></td>
        <%end if
                    
                    session("lecompteur")=compteur  
                        'Response.Write(session("lecompteur"))
                    
                    rsv.MoveNext 
        Response.Write "</tr>"
                    
        if rsv.EOF  then exit for

    next
     set connv=nothing
     %>
     
     

        </table>
        
    
     <table border=0>
    
     
    
     
     
     
     
     <tr><td align=right >
                    
                     <INPUT type="reset" value="Reset" id=reset1 name=reset1><INPUT type="submit" value="Submit" id=submit1 name=submit1>
    
                    </td></tr>  
     
        </table>
        
        
        
        
        </center>
        </form>
        
        
        <%
        if clng(session("numeropage"))<rsv.PageCount then
        Response.Write( "<a href=p_admin_gestion_login.asp?sens=suivant>Les suivants</a>")
        end if
        %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%
        if clng(session("numeropage"))>1 then
        Response.Write("<a href=p_admin_gestion_login.asp?sens=precedent>Les précedents</a>")
        end if
        %>
               
               
<!-- #include file="deconnexion.asp"-->

