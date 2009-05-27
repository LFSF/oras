<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">CONSULTATION OFFRES</div>
<a class=lien href="p_annonces.asp">
               <font size=1><b><< Retour </b></font>
</a>
<br/>  <br/>
<tr>
        <td colspan="2"><font color="#6faa06">Offres Emplois____________________________________________________________________</font></td>
    </tr>
    
    </table>
    
  
    
    <!--       INSERTION -->
    
                              
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
                    <td>
          
    
                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                  
                  <tr>
        <th>N°</th>
   
        <th>Date</th>
        <th>Raison sociale</th>
        <th>Poste</th>
        
        <th>Lieu du poste</th>
   
        <th>Durée de la mission</th>
    </tr>
                  
                  
              <%
          Dim Place
          Place = 0
          Dim rsED1
          
          
          Set rsED1 = Conn.Execute("SELECT * FROM OFFRES where Visible=1 and ProfilOff=1")
         'where NumMembre=" & rsED2("NumMembre") & "")

  
          While Not rsED1.EOF
          If strBgcolor = "#F1F1F1" Then
          strBgcolor = "#FFFFFF"
        Else
        strBgcolor = "#F1F1F1"
        End If
                    %>
                    
              <a href="pa_consulter_emploi_stagebis.asp?num=<%=rsED1("NumOff")%>"><tr bgcolor="<%=strBgcolor%>" onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place1 = Place1+1 %>
                  <b><%=Place1%></b> 
                  </td>
                  
                            <%
Session.LCID = 1036
%>  
    
                  
                <td width="110"><%=mid(rsED1("DateOff"),1,10)%>
                </td>
                <td><%=rsED1("RaisonSocEntOff")%>
                </td>
                <td><%=rsED1("IntituleOff")%>
                </td>
                 <td><%=rsED1("LieuOff")%>
                 </td>
              <td><%      if rsED1("DureeOff")="def" then
       response.write("C.D.I")
       else
       response.write(rsED1("DureeOff"))
end if
    %>
                </td>
                
              <td width="20"></td>
               
               <td width="20"><a href="pa_consulter_emploi_stagebis.asp?num=<%=rsED1("NumOff")%>">
               <img src="img/divers/feuille.jpg" border="0"></a></td>
              </tr></a>
            
             

              
              <%
              
        
              
            rsED1.MoveNext
            Wend
            rsED1.Close 
            
            Set rsED1 = Nothing
            %>
            

            
            </table>
            <tr>
        <td colspan="2"><font color="#6faa06">Offres Stage____________________________________________________________________</font></td>
    </tr>
    
    </table>
    
  
    
    <!--INSERTION -->
    
                              
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
                    <td>
          
    
                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                  
                  <tr>
        <th>N°</th>
   
        <th>Date</th>
        <th>Raison sociale</th>
        <th>Poste</th>
        
        <th>Lieu du poste</th>
   
        <th>Durée de la mission</th>
    </tr>
                  
                  
              <%
          Dim Place1
          Place1 = 0
          Dim rsED2
          
          
          Set rsED2 = Conn.Execute("SELECT * FROM OFFRES where Visible=1 and ProfilOff=2 ORDER BY DateOff  DESC")
         'where NumMembre=" & rsED2("NumMembre") & "")

  
          While Not rsED2.EOF
          If strBgcolor = "#F1F1F1" Then
          strBgcolor = "#FFFFFF"
        Else
        strBgcolor = "#F1F1F1"
        End If
                    %>
                    
              <a href="pa_consulter_emploi_stagebis.asp?num=<%=rsED2("NumOff")%>"><tr bgcolor="<%=strBgcolor%>" onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place1 = Place1+1 %>
                  <b><%=Place1%></b> 
                  </td>
                  
                            <%
Session.LCID = 1036
%>  
    
                  
                <td width="110"><%=rsED2("DateOff")%>
                </td>
                <td><%=rsED2("RaisonSocEntOff")%>
                </td>
                <td><%=rsED2("IntituleOff")%>
                </td>
                 <td><%=rsED2("LieuOff")%>
                 </td>
              <td><%=rsED2("DureeOff")%>
                </td>
                
              <td width="20"></td>
               
               <td width="20"><a href="pa_consulter_emploi_stagebis.asp?num=<%=rsED2("NumOff")%>">
               <img src="img/divers/feuille.jpg" border="0"></a></td>
              </tr></a>
            
             

              
              <%
              
        
              
            rsED2.MoveNext
            Wend
            rsED2.Close 
            
            Set rsED2 = Nothing
            %>
            

        
            </table>
            <tr>
        <td colspan="2"><font color="#6faa06">Recherche de Bénévoles____________________________________________________________________</font></td>
    </tr>
    
    </table>
    
  
    
    <!--       INSERTION -->
    
                              
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
                    <td>
          
    
                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                  
                  <tr>
        <th>N°</th>
   
        <th>Date</th>
        <th>Raison sociale</th>
        <th>Poste</th>
        
        <th>Lieu du poste</th>
   
        <th>Durée de la mission</th>
    </tr>
                  
                  
              <%
         
          
          Set rsED4 = Conn.Execute("SELECT * FROM OFFRES where Visible=1 and ProfilOff=3 ORDER BY DateOff  DESC")
'        where NumMembre=" & rsED4("NumMembre") & "")

  
          While Not rsED4.EOF
          If strBgcolor = "#F1F1F1" Then
          strBgcolor = "#FFFFFF"
        Else
        strBgcolor = "#F1F1F1"
        End If
                    %>
                    
              <a href="pa_consulter_emploi_stagebis.asp?num=<%=rsED4("NumOff")%>"><tr bgcolor="<%=strBgcolor%>" onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place4 = Place4+1 %>
                  <b><%=Place4%></b> 
                  </td>
                  
                            <%
Session.LCID = 1036
%>  
    
                  
                <td width="110"><%=rsED4("DateOff")%>
                </td>
                <td><%=rsED4("RaisonSocEntOff")%>
                </td>
                <td><%=rsED4("IntituleOff")%>
                </td>
                 <td><%=rsED4("LieuOff")%>
                 </td>
              <td><%      if rsED4("DureeOff")="def" then
       response.write("C.D.I")
       else
       response.write(rsED4("DureeOff"))
end if  %>
                </td>
                
              <td width="20"></td>
               
               <td width="20"><a href="pa_consulter_emploi_stagebis.asp?num=<%=rsED4("NumOff")%>">
               <img src="img/divers/feuille.jpg" border="0"></a></td>
              </tr></a>
            
             

              
            
        <%
            rsED4.MoveNext
            Wend
            rsED4.Close 
            
            Set rsED4 = Nothing
        %>
            

        
            </table>
        
<!-- 444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444 -->
        <tr>
        <td colspan="2"><font color="#6faa06">Autres Offres____________________________________________________________________</font></td>
    </tr>
    
    </table>
    
  
    
    <!--       INSERTION -->
    
                              
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
                    <td>
          
    
                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                  
                  <tr>
        <th>N°</th>
   
        <th>Date</th>
        <th>Raison sociale</th>
        <th>Poste</th>
        
        <th>Lieu du poste</th>
   
        <th>Durée de la mission</th>
    </tr>
              
              <%
          Dim Place2
          Place2 = 0
          Dim rsED3
          

          Set rsED3 = Conn.Execute("SELECT * FROM OFFRES where Visible=1 and ProfilOff=4 ORDER BY DateOff  DESC")
'   where NumMembre=" & rsED3("NumMembre") & "")
          While Not rsED3.EOF
          If strBgcolor = "#F1F1F1" Then
          strBgcolor = "#FFFFFF"
        Else
        strBgcolor = "#F1F1F1"
        End If
                    %>
                    
              <a href="pa_consulter_emploi_stagebis.asp?num=<%=rsED3("NumOff")%>"><tr bgcolor="<%=strBgcolor%>" onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place2 = Place2+1 %>
                  <b><%=Place2%></b>
  
                  </td>
                <td width="110"><%=rsED3("DateOff")%>
                </td>
                <td><%=rsED3("RaisonSocEntOff")%>
                </td>
                <td><%=rsED3("IntituleOff")%>
                </td>
                 <td><%=rsED3("LieuOff")%>
                 </td>
                 <td><%if rsED3("DureeOff")="def" then
   response.write("C.D.I")
   else
   response.write(rsED3("DureeOff"))
end if
    %>
                </td>
                
                
              
              <td width="20"></td>
               
               <td width="20"><a href="pa_consulter_emploi_stagebis.asp?num=<%=rsED3("NumOff")%>">
               <img src="img/divers/feuille.jpg" border="0"></a></td>
              </tr></a>
            
            
              
              
              <%
              
          
              
            rsED3.MoveNext
            Wend
            rsED3.Close 
            
            Set rsED3 = Nothing
            %>
            
            
        </table>
                     
                       
                    
                    </td>
            </tr>
    </table>
        
        
        
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