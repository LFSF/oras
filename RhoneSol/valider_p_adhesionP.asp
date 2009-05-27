<!-- #include file="connexion.asp"-->
<%
  'Initialisation des variables
  Dim espace,simplecot,nameTab,valTab,sqlInsert

  espace="&#034;"
  simplecot="&#039;"

  'Enregistrement des valeurs dans un tableau pour la creation de la base de donnee
  nameTab=Array("NomMembre","PrenomMembre","TelMembre","MailMembre","AdrMembre","MdpMembre","News","CivMembre","VilleMembre","CPMembre","FonctionMembre","OrganismeMembre","PaysMembre","PartenaireMembre","CooperationMembre","SolidaireMembre","FormationMembre","AutreMembre","RedacteurMembre","InterviewMembre","EcrireItwMembre","CreationsiteMembre","AutresMembre","MessageMembre")
  
  sqlInsert="INSERT INTO MEMBRE ("
  for i=0 to Ubound(nameTab)-1
        sqlInsert=sqlInsert&nameTab(i)&", "
  Next
  sqlInsert=sqlInsert&nameTab(Ubound(nameTab))&", DateMembre, AgeMembre,AdhesionMembre,Entreprise,AdminMembre) VALUES ("

  for i=0 to Ubound(nameTab)-1
        sqlInsert=sqlInsert&"'"&replace(Trim(session(nameTab(i))),"'",simplecot)&"', "
  Next
  sqlInsert=sqlInsert&"'"&replace(Trim(session(nameTab(Ubound(nameTab)))),"'",simplecot)&"',"&date&","&session("AgeMembre")&",'non',0,0) ;"
  'Ajout dans la table membre
  'Response.Write sqlInsert
  Conn.execute(sqlInsert)

  'On recupere l'id du dernier enregitrement
  Set RS = server.createobject("ADODB.Recordset")
  RS.Open "SELECT @@IDENTITY AS lastId",Conn , 3, 3


  nameTab=Array("CvVisu","CvValid","ActuAdd","ActuVisu","ActuValid","ActuModif","ItwAdd","ItwVisu","ItwValid","ItwModif","IdVisu","SuperAdmin","OffVisu","OffValid")

  sqlInsert="INSERT INTO ADMIN ("
  for i=0 to Ubound(nameTab)-1
        sqlInsert=sqlInsert&nameTab(i)&", "
  Next
  sqlInsert=sqlInsert&nameTab(Ubound(nameTab))&",NumMembre) VALUES ("

  for i=0 to Ubound(nameTab)-1
        sqlInsert=sqlInsert&"0, "
  Next
  sqlInsert=sqlInsert&"0,"&RS("lastId")&") ;"

  'Ajout du membre dans la table ADMIN
  'Response.Write sqlInsert
  Conn.execute(sqlInsert)
  RS.Close

  'Création du dossier pour l'upload des images
  Dim dir
  dir=Server.MapPath("fichiers_upload/img_article/")

  Set FSO = server.createObject("Scripting.FileSystemObject")

  Folder = dir&"/"&session("MailMembre")&"_"&session("NomMembre")&"/"

  If Not FSO.FolderExists(Folder) Then
      FSO.CreateFolder(Folder)
  End If

  response.redirect("valid_p_adhesionP.asp")


%>


                
<!-- #include file="deconnexion.asp"-->

