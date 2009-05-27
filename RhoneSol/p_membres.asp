<!-- #include file="connexion.asp"-->

<%
if session("admin_nom")<>"" then
    Response.Redirect("p_admin.asp")
else
  if Request.Form("test")="oui" and session("vrf") = 0 then
  '===================================
        'session_destroy()

  '============== Verification des  identifiants ==================

      espace="&#034;"
      simplecot="&#039;"
  lelelog=Request.Form("loga")
  lelogin = replace(REPLACE( lelelog,"""",espace),"'",simplecot)
  lelepass=Request.Form("password")
  lepass = replace(REPLACE( lelepass,"""",espace),"'",simplecot)
  '===============redirection vers page administrateur

  '**************************************Login  t_login*********************************************'
          

          Dim rsED
              compteur=0
                 Set rsED = Conn.Execute("SELECT * FROM MEMBRE WHERE MailMembre = '" & lelogin & "' AND MdpMembre = '" & lepass & "' AND AdhesionMembre ='oui'")
                IF rsED.EOF Then

                  Set rsEDbis = Conn.Execute("SELECT * FROM MEMBRE WHERE MailMembre = '" & lelogin & "' AND MdpMembre = '" & lepass & "'")
                   IF rsEDbis.EOF Then
                   Response.Redirect("p_membres.asp?var=3333")
                   else
                    Response.Redirect("p_membres.asp?var=2222")
                   end if
                session("rep")="LE MAIL N existe pas"
                Response.Redirect("p_membres.asp?var=1111")
                else
                While Not rsED.EOF
                
                nummembre = rsED("NumMembre")
                
                  session("rep")="OK LE MAIL  existe bien"
                
               Set rsED1 = Conn.Execute("SELECT * FROM ADMIN where NumMembre=" & nummembre )
                       
                  
                       IF rsED1("SuperAdmin")=0 Then
                       session("rep")=nummembre & "<br/>OK LE MAIL  existe bien Mais il n'est pas superadmin"
                       
                       Session("logadh")="oui"
      
                      session("admin_securite")="ok"
                      session("admin_nom")= rsED("NomMembre") 
                      session("admin_prenom")=rsED("PrenomMembre") 
                      session("admin_adresse")=rsED("AdrMembre") 
                      session("admin_cp")=rsED("CPMembre") 
                      session("admin_ville")=rsED("VilleMembre") 
                      session("admin_tel")=rsED("TelMembre") 
                      session("admin_email")=rsED("MailMembre") 
                      session("admin_password")=rsED("MdpMembre") 
                      session("admin_acces_admin")=rsED1("SuperAdmin") 
                      session("acces_actu")=rsED1("ActuVisu") 
                      session("acces_itw")=rsED1("ItwVisu") 
                      session("acces_cv")=rsED1("CVVisu") 
                      session("acces_id")=rsED1("IDVisu") 
                      session("acces_off")=rsED1("OffVisu")
                      session("admin_id")=rsED1("NumMembre")
                      session.Timeout = 30
                      'session("admin_id")=rsED1("NumAdmin")
                      Response.Redirect("p_admin.asp")
                       
                       
                       else
                       session("rep")=nummembre & "<br/>OK LE MAIL  existe bien et EN PLUS il est superadmin"
                       
                       
                        Session("logadh")="oui"
      
                      session("admin_securite")="ok"
                      session("admin_nom")= rsED("NomMembre") 
                      session("admin_prenom")=rsED("PrenomMembre") 
                      session("admin_adresse")=rsED("AdrMembre") 
                      session("admin_cp")=rsED("CPMembre") 
                      session("admin_ville")=rsED("VilleMembre") 
                      session("admin_tel")=rsED("TelMembre") 
                      session("admin_email")=rsED("MailMembre") 
                      session("admin_password")=rsED("MdpMembre") 
                      session("admin_acces_admin")=rsED1("SuperAdmin") 
                      session("acces_actu")=rsED1("ActuVisu") 
                      session("acces_itw")=rsED1("ItwVisu") 
                      session("acces_cv")=rsED1("CVVisu") 
                      session("acces_id")=rsED1("IDVisu") 
                      session("acces_off")=rsED1("OffVisu")
                      session("admin_id")=rsED1("NumMembre")
                      session.Timeout = 30
                      'session("admin_id")=rsED1("NumAdmin")
                      Response.Redirect("p_admin.asp")
                      end if
                      
                rsED.MoveNext
              Response.Redirect("p_membres.asp?var=1111")
              Wend
              rsED.Close 
              Set rsED = Nothing
              End If
      
   end if 
      
      %>
   


  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <!-- #include file="grand_meta.txt"-->
  




  <link href="styles.css" rel="stylesheet" type="text/css" />
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <title>Rhône-solidarité</title>
  </head>

  <body>





  <!-- #include file="grand_header.txt"-->

  <div id="contenu">

  <!-- #include file="fichier_menu.txt"-->

  <div id="bandeau_orange">Espace Membres</div>

  <table border="0px" width="100%" cellpadding="10px">
      
      <tr>
          <td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
      </tr>
      <tr><td>
               
  <center>
    <TABLE bordercolor=green align=center style="WIDTH: 100%; HEIGHT: 100%" border="1" cellSpacing=1  cellPadding=1 border=0>
     <!-- <TR bordercolor="#0033ff"> -->
      <TR bordercolor=green> 
       <TD valign="top"  width="8%" height="17">







  <script language="JavaScript" type="text/javascript">

  function verifform()
  {

  // Vérifie si le nom est bien indiqué
   if(document.f.loga.value == "")
   {
    alert("\nMerci d'indiquer votre login.");
    document.f.loga.focus();
    return false;
   }

  // Vérifie si le mot de passe est bien indiqué
   if(document.f.password.value == "")
   {
    alert("\nMerci d'indiquer votre mot de passe.");
    document.f.password.focus();
    return false;
   } 
   
  }
   </script>
       
  <form action="p_membres.asp" method="post" id="f" name="f" onsubmit="return verifform()">
            <center>


<table align=center >

            
              <input type="hidden" name="test" value="oui">

                  <tr> 
             <td> <font color="green">Login </font> <br />
              <input name="loga" class="txt" id="loga" size="30" maxlength="100" /></td><td></td></tr>
            <tr> <td>
       <font color="green">Mot de passe </font> <br /> <input type="password" name="password" class="txt" id="password" size="30"/></td>
       <td><input width="120" height="20" style="BACKGROUND-IMAGE: url(img\postit_gris_petit_penche2.gif); WIDTH: 120px; CURSOR: hand; COLOR: green; HEIGHT: 24px" type="submit" value="Valider" id=submit1 name=submit1 size=36>
           </td></tr>               
    <tr> <td><a href="p_adhesion.asp"> S'inscrire </a></td></tr> 
      </table> 
     
   </center>

  </form>
  <% 
              If Request.QueryString("var")=1 then
  %>
                  
                  <table align=center >
                  <tr><td colspan="2" align="middle">
                          <P><font color="red"><b>ERREUR <br />insérer votre mail pour recevoir vos identifiants</b>
         </font> &nbsp;&nbsp;
         <%
         'response.write("message  : " & session("rep"))
         %></P>
              <P><FONT  color=#ff0000></FONT>&nbsp;</P> </td><tr><td colspan="2" align="middle">
              

   <form name="fff" action="p_envoi_identifiants.asp" method="post">
    Votre mail : <INPUT id="mail" name="mail" ><br>&nbsp;
        <INPUT type="submit"   style="BACKGROUND-IMAGE: url(bouton\boutonvide.gif); WIDTH: 120px; CURSOR: hand; COLOR: green; HEIGHT:   
         24px" value="Envoi identifiants" id=submit2 name=submit2 >
         </form>

  </td>
  </tr>
  </table>
  <%
          end if
  %>
      


  <% 
              If (Request.QueryString("var")=1111) then
  %>
                  
                  <table align=center >
                  <tr><td colspan="2" align="middle">
                          <P><font color="red"><b>ERREUR <br>veuillez insérer votre mail pour recevoir vos identifiants!</b>
         </font></p>
         <p>&nbsp;&nbsp;<%
         'response.write("message  : " & session("rep"))
         %></P>
              <P><FONT  color=#ff0000></FONT>&nbsp;</P> </td><tr><td colspan="2" align="middle">
              

   <form name="fff" action="p_envoi_identifiants.asp" method="post">
    Votre mail : <INPUT id="mail" name="mail" ><br>&nbsp;
        <INPUT type="submit"   style="BACKGROUND-IMAGE: url(bouton\boutonvide.gif); WIDTH: 120px; CURSOR: hand; COLOR: green; HEIGHT:   
         24px" value="Envoi identifiants" id=submit2 name=submit2 >
         </form>

  </td>
  </tr>
  </table>
  <%
          end if
  %>  
          
     

  <% 
              If (Request.QueryString("var")=2222) then
  %>
                  
                  <table align=center >
                  <tr><td colspan="2" align="middle">
                          <P><font color="red"><b>ERREUR <br/>Vous êtes bien enregistré, Mais vous n'avez pas encore validé votre inscription.<br/>Veuillez insérer votre mail pour recevoir vos identifiants!</b>
         </font></p>
         <p>&nbsp;&nbsp;<%
         'response.write("message  : " & session("rep"))
         %></P>
              <P><FONT  color=#ff0000></FONT>&nbsp;</P> </td><tr><td colspan="2" align="middle">
              

   <form name="fff" action="p_envoi_identifiants.asp" method="post">
    Votre mail : <INPUT id="mail" name="mail" ><br>&nbsp;
        <INPUT type="submit"   style="BACKGROUND-IMAGE: url(bouton\boutonvide.gif); WIDTH: 120px; CURSOR: hand; COLOR: green; HEIGHT:   
         24px" value="Envoi identifiants" id=submit2 name=submit2 >
         </form>

  </td>
  </tr>
  </table>
  <%
          end if
  %>  

  <% 
              If (Request.QueryString("var")=3333) then
  %>
                  
                  <table align=center >
                  <tr><td colspan="2" align="middle">
                          <P><font color="red"><b>ERREUR <br>veuillez insérer votre mail pour recevoir vos identifiants!</b>
         </font></p>
         <p>&nbsp;&nbsp;<%
         'response.write("message  : " & session("rep"))
         %></P>
              <P><FONT  color=#ff0000></FONT>&nbsp;</P> </td><tr><td colspan="2" align="middle">
              

   <form name="fff" action="p_envoi_identifiants.asp" method="post">
    Votre mail : <INPUT id="mail" name="mail" ><br>&nbsp;
        <INPUT type="submit"   style="BACKGROUND-IMAGE: url(bouton\boutonvide.gif); WIDTH: 120px; CURSOR: hand; COLOR: green; HEIGHT:   
         24px" value="Envoi identifiants" id=submit2 name=submit2 >
         </form>

  </td>
  </tr>
  </table>
  <%
          end if
  %>  
     
      <script>
  document.f.loga.focus();
  </script>    
      </td></tr>

  </table>

   <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>



  <!-- Ne pas toucher Ã  ce qui suit : placement du footer -->


    <!-- #include file="grand_footer.txt"-->  
  </div>

  </body>
  <!-- #include file="deconnexion.asp"-->
  </html>
<%
end if
%>