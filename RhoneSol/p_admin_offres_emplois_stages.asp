<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_off")= 1) then
	response.redirect("p_admin.asp")
	else
%>
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
    	<td colspan="2"><font color="#6faa06">Validation des Offres Emplois / Stage _______________________________________________________________</font></td>
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
 
 SQL1 = "Select * from T_proposer where visibilite_sur_site='non'"
 
 
  rsv.PageSize=100
  rsv.open SQL1,connv,1,3 
  rsv.AbsolutePage =session("numeropage")


 '=================*******************************************************
 
  

%>
<center><FONT size=1><STRONG>Numero de la page :<%
Response.Write(session("numeropage"))%><br></STRONG></font></center><br>

<form name=lesadh action="valid_p_admin_offres_emplois_stages.asp" method="post"   id="valid_p_admin_offres_emplois_stages.asp">
    

	<%	
	for i=1 to rsv.PageSize
					
					'id_login = rsv.fields("login").value
					'id_password =rsv.fields("passe").value
					
					
					num =rsv.fields("num").value
					duree_offre = rsv.fields("duree_offre").value
					statut= rsv.fields("statut").value
					rs = rsv.fields("raison_sociale").value
					adresse = rsv.fields("adresse").value
					ville = rsv.fields("ville").value
					cp= rsv.fields("cp").value
					email = rsv.fields("email")
					civilite = rsv.fields("civilite").value
					nom_responsable=rsv.fields("nom_responsable").value
					prenom_responsable=rsv.fields("prenom_responsable").value
					tel = rsv.fields("tel")
					profil=	rsv.fields("profil").value	
					intitule=	rsv.fields("intitule").value
					lieu=	rsv.fields("lieu").value
					precision_lieu=	rsv.fields("precision_lieu").value						
					description=	rsv.fields("description").value	
					doc_a_fournir=	rsv.fields("doc_a_fournir").value	
					duree_contrat=	rsv.fields("duree_contrat").value	
					
					indemnite=	rsv.fields("indemnite").value	
					montant_indemnite=	rsv.fields("montant_indemnite").value	
					autres_indemnites=	rsv.fields("autres_indemnites").value	
					date_inscription = rsv.fields("date_inscription").value
					
									
					
					visible_sur_site= rsv.fields("visibilite_sur_site")
					
					
					
					
							
					compteur =compteur + 1
				
					
						
	%>
	
	<center>
	<table  borderColor=green border="1" ><tr><td>
	<table class="txt" border=0>
	<tr bgcolor=#cccccc>
	<!--
	<th>N°</th><th>Civilité</th><th>Nom</th><th>Prenom</th>
	-->
	<td>compteur</td><td>num dans BD</td>
	<td>RS -ADRESSE<br>
	
	</td>
	
	<td>responsable</td>
	<td>Profil recherche<br>
	
	
	</td>
	
	<td>Dates de contrat<br>
	
	
	</td>
	
	<!--
	<td>
	niveau_formation<br>
	
	
	
	</td>
	
	
	<td>profil
	<br>-------<br>
	
	
	
	intitule</td>
	--->
	
	<td>Validation</td>

	
	
	</tr>		
										
		<tr bgcolor="#dbfff8">
		
		<td>
		
		
		<%= compteur%></td>
		
		
		
		
		<td>
		<INPUT type="hidden"  value="<%=num%>" name="num<%=compteur%>"><%=num %>
		</td>
		
		<td><INPUT type="hidden"  value="<%=num%>  name="civilite<%=compteur%>">
		
					
				
				
		
		
		
		
		
		
		<br>
		<%=statut%>&nbsp;<br><%=rs%>&nbsp;<br><u>Adresse :</U><br><%=adresse%>&nbsp;<br>
		<%=cp%>&nbsp;<%=ville%>&nbsp;
		</td>
		
		
		
		<td><%=civilite%>&nbsp;<%=prenom_responsable%>&nbsp;<%=nom_responsable%><br>&nbsp<%=email%>&nbsp;<br><%=tel%></td>
		
		
		
		<td>
		<u>Poste :</u><%=intitule%><br><br><u>Lieu :</U><br><%=lieu%><br><br>
		<u>Précision lieu :</u><br>&nbsp;<%=precision_lieu%><br>
		<u>Indemnite :</u>&nbsp;<%=indemnite%><br>
		<u>montant :</u><%=montant_indemnite%><br>
		<u>Autres indemnites : </u><%=autres_indemnites%><br><br>
		<u>Doc. à fournir : </U><br><%=doc_a_fournir%>
		
		</td>
		
		<td>
		<u>Duree de l'offre :</u><br>
		<%=duree_offre%><br>
		<u>Duree du contrat : </u><br>
		<%=duree_contrat%><br>
		<u>Date inscription : </u><br>
		<%=date_inscription%>
		
		
		<br>
		
		
		
		</td>
		<!--
		<td>
		
		
		
		
		</td>
		<td>
		
		
		
		
		</td>
		-->
		
	<td>
	<INPUT type="checkbox" id=checkbox<%=compteur%> name="checkbox<%=compteur%>"></td>
		
	
	
		
		</tr>
		</table>
		
		<table>
		<tr bgcolor=#cccccc>
	<td>Profil</td>
	</tr>
	<tr>
		
		
							
				
				
		<td><%=profil%></td>
		
		</tr>
	
	<tr bgcolor=#cccccc>
	
	<td>description</td>
	</tr>
	
	<tr>
	
		
		<td><%=description%></td>
		</tr>
	
	<tr bgcolor=#cccccc>
	
	<td>lien_http</td>
	
	</tr>
	
	<tr>
				
		<td></td>
		
		
		
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
		Response.Write( "<a href=p_admin_offres_emplois_stages.asp?sens=suivant>Les suivants</a>")
		end if
		%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%
		if clng(session("numeropage"))>1 then
		Response.Write("<a href=p_admin_offres_emplois_stages.asp?sens=precedent>Les précedents</a>")
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
<% end if %>