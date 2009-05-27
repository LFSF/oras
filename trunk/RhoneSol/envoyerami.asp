<html>
<head>
<title>Envoyer</title>
<script language="JavaScript1.2">
	<!--
      function mverif(mail) {
         var arobase = mail.indexOf("@")
         var point = mail.lastIndexOf(".")
         if((arobase < 1)||(point + 1 == mail.length)
            ||(point < arobase+2)) return false
         return true
         }
      function test(Fsendername,Fsender,Ffriend) {
         if(Fsendername.value=="") { alert('Nom requis !')
            Fsendername.focus();return false }
		 if(!mverif(Fsender.value)) { alert('Votre Email est invalide !')
            Femail.focus();return false }
		 if(!mverif(Ffriend.value)) { alert('Email ami invalide !')
            Ffriend.focus();return false }
         return true
         }
//-->
</script>
</head>

<body background="img/fond.jpg">
<table   style="WIDTH: 350px; HEIGHT: 260px">
  <tr>
   
    <td  > 
      <div align="center"><font size="3" face="Verdana, Arial, Helvetica, sans-serif"><STRONG>Envoyer cette page à un 
      ami</STRONG> 
            </font></div>
   
      <form method="post" action="envoyerami2.asp" name="frmcomment" onSubmit="return test(this.Fsendername,this.Fsender,this.Ffriend)">
        
             
            
              <div align="center"><font ><font size="2"> <font face="Verdana, Arial, Helvetica, sans-serif"> 
                Votre nom :</font></font> </font></div>
            
              <div align="center"> 
                <input name="Fsendername" size="15" maxlength="35" >
              </div>
            
              <div align="center"><font ><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif">Votre 
                adresse E-MAIL :</font></font> </font></div>
            
              <div align="center"> 
                <input name="Fsender" maxlength="50" 
           >
              </div>
            
              <div align="center"><font ><font size="2"><font face="Verdana, Arial, Helvetica, sans-serif">Email 
                de votre ami(e)</font></font></font><font > </font></div>
            
              <div align="center">
                <input name="Ffriend" maxlength="50" 
           >
              </div>
            
              <div align="center"> 
                <input type="submit" name="Submit" value="Envoyer">
              </div>

      </form>
    </td>
      </tr>
</table>
</body>
</html>
