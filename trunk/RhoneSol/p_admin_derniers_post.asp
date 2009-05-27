<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>




<link href="styles.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
<!--
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>

<SCRIPT language=JavaScript> 
function fonctest()
{
window.location.href="espaceadh.asp"
}
function fonc100()
{
window.location.href='testd.asp'
}
function fonc1()
{
window.location.href='ndambog.asp'
}
<!--Hide JavaScript from Java-Impaired Browsers 
//--> 


</SCRIPT>
<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>






<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>

<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Validation des CVs _______________________________________________________________</font></td>
    </tr>
				<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin.asp"><font size=1><b>
                         << Retour Page Administration &nbsp;</b></font>
                          </a></td></tr></table>                
                         
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


               %>  
               
               
               
               
               <%
               
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
  
Verif = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= " & Server.MapPath("bd/bd_rs.mdb")

 Set connv = Server.CreateObject("ADODB.Connection")
 connv.Open Verif
 Set rsv = Server.CreateObject("ADODB.RecordSet")
       

 'SQL1 = "Select * from contact_organisme where journee12mai='non'"
 
 SQL1 = "Select * from t_depotcv where visible_sur_site='non'"
 
 
  rsv.PageSize=100
  rsv.open SQL1,connv,1,3 
  rsv.AbsolutePage =session("numeropage")


 '=================*******************************************************
 
  

%>
<center><FONT size=1><STRONG>Numero de la page :<%
Response.Write(session("numeropage"))%><br></STRONG></font></center><br>

<form name=lesadh action="valid_p_admin_derniers_post.asp" method="post"   id="p_admin_derniers_post">
    

	<%	
	for i=1 to rsv.PageSize
					
					'id_login = rsv.fields("login").value
					'id_password =rsv.fields("passe").value
					lenum =rsv.fields("numcv").value
					date_inscription = rsv.fields("date_inscription").value
					civilite = rsv.fields("civilite").value
					age = rsv.fields("age").value
					nom = rsv.fields("nom").value
					prenom = rsv.fields("prenom").value
					adresse = rsv.fields("adresse").value
					ville = rsv.fields("ville").value
					cp= rsv.fields("cp").value
					email = rsv.fields("email")
					tel = rsv.fields("tel")
					
					
					
					
					niveau_formation = rsv.fields("niveau_formation")
					diplome_en_cour = rsv.fields("diplome_en_cour")
					diplome_obtenu = rsv.fields("diplome_obtenu")
					autre_diplome = rsv.fields("autre_diplome")
					profil = rsv.fields("profil")
					intitule = rsv.fields("intitule")
					experience_pro = rsv.fields("experience_pro")
				    commentaire = rsv.fields("commentaire")
					lien_http = rsv.fields("lien_http")
					visible_sur_site= rsv.fields("visible_sur_site")
					
					
					
					
							
					compteur =compteur + 1
				
					
						
	%>
	
	<center>
	<table  borderColor=green border="1" ><tr><td>
	<table class="txt" border=0>
	<tr bgcolor=#cccccc>
	<!--
	<th>N°</th><th>Civilité</th><th>Nom</th><th>Prenom</th>
	-->
	<td>num</td><td>numcv</td>
	<td>civilite&nbsp;<br>
	
	nom&nbsp;
	
	prenom</td>
	
	<td>date_inscription</td>
	<td>adresse<br>
	
	cp&nbsp;
	
	ville
	</td>
	
	<td>email<br>
	
	tel
	</td>
	<td>
	niveau_formation<br>
	
	
	diplome_en_cour<br>
	
	
	diplome_obtenu<br>
	
	
	autre_diplome
	</td>
	
	
	<td>profil
	<br>-------<br>
	
	
	
	intitule</td>
	
	
	<td>Validation</td>

	
	
	</tr>		
										
		<tr bgcolor="#dbfff8">
		
		<td>
		
		
		<%= compteur%></td>
		
		
		
		
		<td>
		<INPUT type="hidden"  value="<%=lenum%>" name="lenum<%=compteur%>"><%=lenum %>
		</td>
		
		<td><INPUT type="hidden"  value="<%=civilite%>" name="civilite<%=compteur%>"><%=civilite %>
		<br>
		<!--
		</td>
		<td>
		-->
		
		
		<em class=lien title="détail">
					
		<INPUT type="hidden"  value="<%=nom%>" name="nom<%=compteur%>"><%=nom %>
		</em>
		<br>
		<!--
		</td>
		<td>
		-->
		<INPUT type="hidden"  value="<%=prenom%>" name="prenom<%=compteur%>"><%=prenom %>
		<br>
		<%=age%>&nbsp;ans
		</td>
		
		
		
		<td><INPUT type="hidden"  value="<%=date_inscription%>" name="date_inscription<%=compteur%>"><%=date_inscription%></td>
		
		
		
		<td>
		<INPUT type="hidden"  value="<%=adresse%>" name="adresse<%=compteur%>"><%=adresse%><br>
		<!--
		</td>
		
		<td>
		-->
		<INPUT type="hidden"  value="<%=cp%>" name="cp<%=compteur%>"><%=cp%>
		<!--
		</td>
		
		<td>
		-->
		<INPUT type="hidden"  value="<%=ville%>" name="ville<%=compteur%>"><%=ville%>
		
		</td>
		
		<td>
		
		<INPUT type="hidden"  value="<%=email%>" name="email<%=compteur%>"><%=email%>
		<br>
		
		<!--
		</td>
		
		<td>
		-->
		<INPUT type="hidden"  value="<%=tel%>" name="tel<%=compteur%>"><%=tel%>
		
		</td>
		
		<td>
		<INPUT type="hidden"  value="<%=niveau_formation%>" name="niveau_formation<%=compteur%>"><%=niveau_formation %>
		
		<br>
		-----------------
		<br>
		<!--
		</td>
		
		<td>
		-->
		<INPUT type="hidden"  value="<%=diplome_en_cour%>" name="diplome_en_cour<%=compteur%>"><%=diplome_en_cour%>
		<br>
		-----------------
		<br>
		<!--
		</td>
		
		<td>
		-->
		<INPUT type="hidden"  value="<%=diplome_obtenu%>" name="diplome_obtenu<%=compteur%>"><%=diplome_obtenu%>
		<br>
		-----------------
		<br>
		<!--
		</td>
		
		<td>
		-->
		
		<INPUT type="hidden"  value="<%=autre_diplome%>" name="autre_diplome<%=compteur%>"><%=autre_diplome%>
		
		</td>
		<td>
		
		<INPUT type="hidden"  value="<%=profil%>" name="profil<%=compteur%>"><%=profil%>
		<br>
		-----------------
		<br>
		<!--
		</td>
		
		<td>
		-->
		
		<INPUT type="hidden"  value="<%=intitule%>" name="intitule<%=compteur%>"><%=intitule%>
		
		
		
		
		
		</td>
		
		
	<td><INPUT type="checkbox" id=checkbox<%=compteur%> name="checkbox<%=compteur%>"></td>
		
	
	
		
		</tr>
		</table>
		
		<table>
		<tr bgcolor=#cccccc>
	<td>experience_pro</td>
	</tr>
	<tr>
		
				
		<td><INPUT type="hidden"  value="<%=experience_pro%>" name="experience<%=compteur%>"><%=experience_pro%></td>
		
		</tr>
	
	<tr bgcolor=#cccccc>
	
	<td>commentaire</td>
	</tr>
	
	<tr>
	
		
		<td><INPUT type="hidden"  value="<%=commentaire%>" name="commentaire<%=compteur%>"><%=commentaire%></td>
		</tr>
	
	<tr bgcolor=#cccccc>
	<td>lien_http</td>
	
	</tr>
	
	<tr>
				
		<td><INPUT type="hidden"  value="<%=lien_http%>" name="lien_http<%=compteur%>"><%=lien_http%></td>
		
		
		
		</tr>
	</table>
	
	</td></tr></table>
	<br>
	
		
		
					
					
									
					<%
					
					session("lecompteur")=compteur	
						'Response.Write(session("lecompteur"))
					
					rsv.MoveNext 
					
		if rsv.EOF  then exit for
	next
	 set connv=nothing%>
	 
	 <table border=0>
	
	 
	
	 
	 
	 
	 
	 <tr><td align=right colspan=10>
					
					 <INPUT type="reset" value="Reset" id=reset1 name=reset1><INPUT type="submit" value="Submit" id=submit1 name=submit1>
	
					</td></tr>	
	 
		</table>
		
		
		
		
		<center></form>
	    <%
		if clng(session("numeropage"))<rsv.PageCount then
		Response.Write( "<a href=p_admin_derniers_post.asp?sens=suivant>Les suivants</a>")
		end if
		%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%
		if clng(session("numeropage"))>1 then
		Response.Write("<a href=p_admin_derniers_post.asp?sens=precedent>Les précedents</a>")
		end if
		%>
               
               
               
               
       
                         
                          <!------ fin corps de texte-------------------->
		
		
		
		<!-------------------------------------------FIN AJOUT DE TEXTE IMPORTE DE ORAS----------------------------------->
       
                        
                   
                         
                          
                        
                     
                      
                      </DIV>	<!------ fin corps de texte-------------------->
					</td>
					</tr>
					</table>



    
	



 



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>