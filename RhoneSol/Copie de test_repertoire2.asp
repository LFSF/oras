<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>Rhône-solidarit&eacute;</title>

<script language='JavaScript' type="text/javascript">
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

<style type="text/css">
div.color {
  border-bottom-width:2px;
  border-bottom-style:solid;
  border-bottom-color:gray;
  }
  
  table.color {
  border-bottom-width:2px;
  border-bottom-style:solid;
  border-bottom-color:gray;
  }
  
    tr.color {
  border-bottom-width:2px;
  border-bottom-style:solid;
  border-bottom-color:gray;
  }
  
    td.color {
  border-bottom-width:2px;
  border-bottom-style:solid;
  border-bottom-color:gray;
  }
  
    td.color1 {
  border-bottom-width:2px;
  border-bottom-style:solid;
  border-bottom-color:black;
  }
  
     p.color {
  border-bottom-width:1px;
  border-bottom-style:solid;
  border-bottom-color:gray;
  }

  </style
</head>

<body>





<table border="0" bgcolor="white" align="top"   >
<tr  >
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

<tr align="center" bgcolor="dodgerblue"  >

<td></td>
<td><br/><br/>
DENOMINATION
<br/><br/></td>
<td><br/><br/>LOCALISATION<br/><br/></td>
<td><br/><br/>
IDENTIFICATION<br/><br/></td>
<td><br/><br/>
REFERENCES DE GESTION<br/><br/></td>
<td ><br/><br/>
ACTIVITES<br/><br/></td>

</tr>



<%
a1=""
a11=""
a2=""
a22=""
a3=""
a33=""
a4=""
a44=""
zepage=0
session("zepage")=zepage

%>

				  
              <%
		  Dim Place
		  Place = 0
		  Dim rsED1
		  
		  dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")



Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
	

		  
		'*******************fonctionne      ******************************  
	 'Set rsED1 = Conn.Execute("SELECT * FROM repertoire_congo where visible_sur_site='oui' and profil='emploi'  ORDER BY  date_inscription  DESC")
		 
	 'Set rsED1 = Conn.Execute("SELECT a.numero , a.denomination , a.date_creation , a.denomination2 , b.organisme , b.siege_social , b.bp , c.fax , c.tel1 , c.tel2 , c.mail , d.implantation , d.bp_implantation , d.tel_implantation , d.fax_implantation , d.ville_implantation , e.cnss , e.rccm , e.niu , f.banque , f.commissaire , f.contact , g.activite_principale FROM rc1 a ,rc2 b , rc3 c , rc4 d , rc5 e , rc6 f , rc7 g where a.numero=b.numero and a.numero=c.numero and a.numero=d.numero and a.numero=e.numero  and a.numero=f.numero and a.numero=g.numero ")
	
		
	 Set rsED1 = Conn.Execute("SELECT a.numero , a.denomination , a.date_creation , a.denomination2 , b.organisme , b.siege_social , b.bp , c.fax , c.tel1 , c.tel2 , c.mail , d.implantation , d.bp_implantation , d.tel_implantation , d.fax_implantation , d.ville_implantation ,  e.cnss , e.rccm , e.niu ,  f.banque , f.commissaire , f.contact , g.activite_principale , g.sous_activite1 , g.sous_activite2 , g.sous_activite3 , g.sous_activite4  FROM (((((( rc1 a  inner join rc2 b  on a.numero=b.numero ) inner join rc3 c on c.numero=a.numero)  inner join rc4 d on d.numero=a.numero)  inner join rc5 e on e.numero=a.numero)   inner join rc6 f on f.numero=a.numero) inner join rc7 g on g.numero=a.numero) ") 
	

		
		
					
		
	

		 
		  While Not rsED1.EOF
		  
		  If strBgcolor = "#F1F1F1" Then
		  strBgcolor = "#FFFFFF"
		  Else
		  strBgcolor = "#F1F1F1"
		  End If
					
    
	  compteur = compteur + 1
		






		
	%>
	
	
	<% 



'num= rsED1("num")
numero= rsED1("numero")

denomination= rsED1("denomination")
date_creation= rsED1("date_creation")
denomination2= rsED1("denomination2")
organisme =rsED1("organisme")
siege_social = rsED1("siege_social")
bp = rsED1("bp")
fax = rsED1("fax")
tel1= rsED1("tel1")
tel2= rsED1("tel2")
mail= rsED1("mail")
implantation= rsED1("implantation")
bp_implantation= rsED1("bp_implantation")
tel_implantation= rsED1("tel_implantation")
fax_implantation= rsED1("fax_implantation")
ville_implantation= rsED1("ville_implantation")
cnss= rsED1("cnss")
mail= rsED1("mail")
rccm= rsED1("rccm")
niu= rsED1("niu")
banque= rsED1("banque")
commissaire= rsED1("commissaire")
contact= rsED1("contact")
activite_principale= rsED1("activite_principale")
sous_activite1= rsED1("sous_activite1")
sous_activite2= rsED1("sous_activite2")
sous_activite3= rsED1("sous_activite3")
sous_activite4= rsED1("sous_activite4")

a1 = sous_activite1 
a2 = sous_activite2 
a3 = sous_activite3 
a4 = sous_activite4 

%>
	
	
<%
if a11 <> a1 then
a11= a1
a1bis = a1bis &  a11  & "  -  "  
end if

if a22 <> a2 then
a22= a2
a2bis = a2bis &  a22  & "  -  "  
end if

if a33 <> a3 then
a33= a3
a3bis = a3bis &  a33  & "  -  "  
end if

if a44 <> a4 then
a44= a4
a4bis = a4bis &  a44  & "  -  "  
end if

%>	
	
	
<%	
if (session("zepage")==5 or session("zepage")==20 or session("zepage")==22) then
zecompteur=3
else
zecompteur=5
end if




if compteur >zecompteur then 



%>
<tr><td colspan="6">&nbsp;</td></tr>

<tr><td colspan="6">&nbsp;</td></tr>

<tr >
<td colspan="6" ><b><font size="3">

<p style="background-color:none; border-bottom-color: gray; border-style:solid; border-width:2px; margin-bottom:0px; "> 

<%=a1bis%>



</p> 

</font>


<b/>&nbsp;&nbsp;</td>


</tr>

<tr >
<td colspan="6" class="color"><b><font size="2">


 <%=a2bis%>

 
 
 </font> <b/>&nbsp;&nbsp;</td>

</tr>

<tr>
<td colspan="6" bgcolor="#66CCFF"> <%=a3bis%>&nbsp;&nbsp;</td>

</tr>

<tr>
<td colspan="6" class="color1"><%=a4bis%>&nbsp;&nbsp;</td>

</tr>



<tr  align="center" bgcolor="dodgerblue"   style="color:white ; font-size:12px " >

<td class="color">&nbsp;</td>

<td class="color">
<br/><br/><b>
DENOMINATION
</b><br/><br/>
</td>

<td class="color"><br/><br/>
<b>
LOCALISATION
</b>
<br/><br/></td>
<td class="color">
<br/><br/><b>
IDENTIFICATION
</b>
<br/><br/></td>
<td class="color"><br/><br/>
<b>
REFERENCES DE GESTION
</b>
<br/><br/></td>
<td class="color"><br/><br/>
<b>
ACTIVITES
</b>
<br/><br/></td>

</tr>


<%

compteur =1
zepage = zepage + 1
a11=""
a1bis=""
a22=""
a2bis=""
a33=""
a3bis=""
a44=""
a4bis=""

end if 

%>






<tr  valign="top" >
<td class="color">
<table ><tr bgcolor="darkturquoise"><td>
&nbsp;&nbsp;&nbsp;&nbsp;<%=numero%>&nbsp;&nbsp;
<br/>
<b>cpteur :</b>&nbsp;
<%=compteur%>
<br/>


<b>page :</b> &nbsp;
<%=zepage%>
</td></tr>


</table>

</td >
<td  class="color"> 
<b> 
<%=denomination%> 
&nbsp;
</br>
</br>
<%=denomination2
%>&nbsp;
</br>
</br>
<b><font size=1px>Forme juridique :</font></b>
&nbsp;
<%=organisme 
%>&nbsp;
</br>
</br>
<b><font size=1px>Date création :</font></b>&nbsp;


<%=date_creation%>&nbsp;
</td>
<td class="color">


<b>Siège social :</b>&nbsp;


<%=siege_social
%>&nbsp;
</br>
</br>

<%=bp 
%>&nbsp;
<b>Tél1 :</b>
<%=tel1
%>&nbsp;
<b>Tél2 :</b>
<%=tel2
%>&nbsp;
</br>
</br>
<b>Fax :</b>
<%=fax 
%>&nbsp;
<b>Mail :</b>
<%=mail
%>&nbsp;	 	 
</br></br>
<b>Implantation :</b>&nbsp;

<%=implantation
%>&nbsp;
<%=ville_implantation
%>&nbsp;
</br></br>
<%=bp_implantation
%>&nbsp;
<b>Tél :</b>
<%=tel_implantation
%>&nbsp;
<b>Fax :</b>
<%=fax_implantation
%>&nbsp;


</td>
<td class="color">

<b>N°RCCM :</b> 
<%=rccm
%>&nbsp;
</br>
</br>
<b>NIU :</b> 
<%=niu
%>&nbsp;
</br>
</br>
<b>CNSS :</b>
&nbsp;
<%=cnss
%>&nbsp;

</td>
<td class="color">
<b>Responsable :</b>
</br>
<%=contact
%>&nbsp;
</br>
</br>
<b>Banque :</b>
</br>
<%=banque
%>&nbsp;
</br>
</br>
<b>Commissaire aux comptes :</b>
</br>
<%=commissaire
%>&nbsp;


</td>

<td class="color">

<%=activite_principale
%>&nbsp;

</td>

</tr>

			





	 
	
	 
			  
			  
              <%
			  
			  			  

 
			  
			rsED1.MoveNext
				
			Wend
			rsED1.Close 
			
			Set rsED1 = Nothing
			%>
			

			
         
	
  </table>
  
	
	



		
		


 




</body>
</html>