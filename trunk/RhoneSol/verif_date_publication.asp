<!-- #include file="connexion.asp"-->
<%
'**************Test************
'response.write("date du formulaire : ")
'response.write(request.form("dispo_jour"))
'response.write("/")
'response.write(request.form("dispo_mois"))
'response.write("/")
'response.write(request.form("dispo_annee"))
'response.write("<br>")
'response.write(request.form("ID_ITW"))
'la date JJ/MM/AAAA
'**************Fin Test************
'initialisation de la date de publication
DatePublication=(request.form("dispo_jour")&"/"&request.form("dispo_mois")&"/"&request.form("dispo_annee"))
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Rhône-solidarité</title>
</head>

<body>
Vous avez choisi pour l'interview n° <%=request.form("ID_ITW")%>
la date de publication le <%=DatePublication%>
<%
'L'interview doit être validé
set rsValidITW = Conn.Execute("SELECT CodeValidItw FROM Interview where NumItw="&request.form("ID_ITW"))
if(rsValidITW("CodeValidItw")<>0)then

	'on récupère toutes les dates de publication afin de les comparer avec la nouvelle date qu'on souhaite enregistrer
	Set rsDatePub = Conn.Execute("SELECT DatePublicationItw FROM Interview")
	IF rsDatePub.EOF Then
			  Response.write("Il n'y a aucune date")
			 Else
			  While Not rsDatePub.EOF
				  'cette date doit être différente des autres dates
				  if ("'"&rsDatePub("DatePublicationItw")&"'" = "'"&DatePublication&"'")then
					' quand ExistDate=1 cela veut dire que la date existe 
					ExistDate = 1
					Message="La date est déjà prise! Veuillez en sélectionner une autre."
				  end if

				rsDatePub.MoveNext
			  Wend
			  rsDatePub.Close 
			  Set rsED = Nothing
	End If
	'la date choisie ne peut être antérieure à la date du moment
	if(Cdate(DatePublication) < date) then 
		ExistDate = 1
		Message="La date choisie est passée, veuillez choisir une autre date."
	end if
	if (ExistDate<>1) then
			sqlITWPublication="Update INTERVIEW set DatePublicationItw='"&DatePublication&"'  where NumItw =" & request.form("ID_ITW")
			Conn.Execute(sqlITWPublication)
			Message =("Votre Interview sera bien publiée")
			response.write ("<h3 style='font-size:25px;font-weight:bold;font-style:italic;color:#006699;'>"&Message&"</h3>")
			else
			'page erreur
			response.write ("<h3 style='font-size:25px;font-weight:bold;font-style:italic;color:#CC0033;'>"&Message&"</h3>")
	end if
else
	Message="L'interview doit être valider avant d'être publiée."
	response.write ("<h3 style='font-size:25px;font-weight:bold;font-style:italic;color:#CC0033;'>"&Message&"</h3>")
end if
%>
<center><Input type="button" Value="Fermer" onclick="window.close();opener.location.reload(true);"><center>
<!-- #include file="deconnexion.asp"-->
</body>
</html>