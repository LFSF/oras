 <!-- #include file="connexion.asp"-->
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  <meta name="generator" content="PSPad editor, www.pspad.com">
  <title> Formulaire football-ajouter</title>
  <script type="text/javascript" src="js/fonctions.js"></script>
  <link rel="stylesheet" media="screen" type="text/css" title="Deco" href="decoration.css" />
  </head>
  <body id="bodyajouter" >
  
  <table width="1000px" border="0px" cellpadding="0px" cellspacing="0px" align="middle">
  <tr><td width="100%" id="menu"><table cellpadding="0" cellspacing="0" height="40px" width="100%"><tr><td><a href="index.asp"><img src="img/start.png"/></a></td>
  <td><a href="index.asp"><img src="img/ongletaccueil.png"/></a></td>
   <td><a href="ajouterJoueur.asp"><img src="img/ajouter.png"/></a></td>
  <td><a href="delete.asp"><img src="img/supprimer.png"/></a></td><td><a href="transfert.asp"><img src="img/transfert.png"/></a></td><td><a><img src="img/end.png"/></a></td>
  </td></tr>
  </table>
  
 <button onClick="javascript: location.href='ajouterJoueur.asp'">>Joueur<</button>   <button onClick="javascript: location.href='ajouterClub.asp'">>Club<</button>

  
  
 <!--Formulaire-->
      <h3>Ajouter un joueur</h3>
  <form method="post" action="InsertJoueur.asp" name="formulaire" onsubmit="return checkjoueur();">
  
  Nom:<input type="text" name="nomJsaisi" /><br><br>
  Prenom:<input type="text" name="prenomJsaisi" /><br><br>
  Age:<select name="ageJsaisi" id="ageJsaisi" >
                 <%

                numMin=16
				numMax=40
                while numMin<=numMax
              %>
                   <option value="<%=numMin%>"/> <%=numMin%> </option>
              <%
				   numMin=numMin+1
				   wend
              %>

              </select><br><br>
  
  Nom de son Club:<select name="nomclubJsaisi" id="nomClubJsaisi">
             <option value='-1'>Choisir club</option>
             <%

              'On selectionne toutes les marques
              SQL="SELECT Nom_club FROM Club ;"
              Set RS = server.createobject("ADODB.Recordset")
              RS.Open SQL,Connexion , 3, 3
              ' Si il n y a pas de tuples
              if RS.eof then
                 Response.Write "Erreur dans la base de données</option>"
              else
                ' tant qu'il y a des fiches
                while not RS.eof
              %>
                   <option value="<%=RS("Nom_club")%>"/> <%=(RS("Nom_club"))%> </option>
              <%
                   RS.MOVENEXT ' fiche suivante
                   wend
                   ' Fermeture du recordSet

              end if
                  RS.close
              %>
			       </select><br><br>
  
  Poste:<select name="posteJsaisi" >
       <option value="Attaquant">Attaquant</option>
	   <option value="Milieu">Milieu</option>
	   <option value="Defenseur">Defenseur</option>
	   <option value="Gardien">Gardien</option>
	   </select>
	   <br><br>
  Numero de maillot:<input type="text" name="numJsaisi"  size=2 MAXLENGTH=2/> 
			  <br>
  
  <br><br>
  date de naissance :<input type="text" name="dnjJsaisi"  size=10 MAXLENGTH=10/> ex:(JJ/MM/AAAA) entre 1950 et 2005<br><br>
  Adresse:                                                           rue:   <input type="text" name="adrJsaisi"/><br>
   &nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp     ville: <input type="text" name="advJsaisi"/><br>
   &nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp	 dep:   <input type="text" name="addJsaisi"  size=5 MAXLENGTH=5/> ex:69100 <br><br> 
   
  
   
   <br><input type="submit" name="Ajouter ce joueur" /><br>
  </form>
  
  </body>
</html>
