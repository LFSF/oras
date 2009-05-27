<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->
<!-- #include file="util.asp"-->
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">
<div id="bandeau_orange">RECHERCHE OFFRES</div>
<!-- #include file="fichier_menu.txt"-->
<a class="lien" href="p_annonces.asp"><font size="1"><b>&lt;&lt; Retour </b></font></a><br />
<%
Dim where,where2,tab_name,tab_request,nb_ok,i,j,est_vide

Dim lesRegions()
taille=1

Set rs = Conn.Execute("SELECT * FROM REGIONS;")

While not rs.EOF
    redim preserve lesRegions(taille)
    taille=taille+1
    lesRegions(taille-1)=rs("nomRegion")
                                              

Rs.MoveNext
Wend

rs.Close
' A finir pour les CV !!!!!!!!!!!!!!!!!!!!!
tab_request=array(Request.Form("profil"),Request.Form("lieu_du_poste"),Request.Form("duree_esperee"))
tab_name=array("ProfilAnn","LieuAnn","DureeEspereeAnn")
where=""
where2=""
est_vide=1
j=0

while (j<=UBound(tab_request) and est_vide=1)
    if(tab_request(j)<>"") then
        est_vide=0
    end if
    j=j+1
Wend

if est_vide=0 then

      'Response.Write "tab_request= ( "

     ' for j=0 to ubound(tab_request)
     '     Response.Write j&"=>"&tab_request(j)&" "
      'next

     ' Response.Write ") <br />"


      'Tableau d'accueil des parametres non vides
      Dim result()

      nb_ok=0

      ' Test de la présence des variables pour la contruction de la requete
      ' Et on compte combien ne sont pas vide
      For i=0 to UBound(tab_request)
          if tab_request(i)<>"" then
              redim preserve result(nb_ok)

              nb_ok=nb_ok+1
              result(nb_ok-1)=i

          end if
      next

      'Response.Write "TResult= "&ubound(result)&"<br />"
     ' Response.Write "Result= ( "

      'for j=0 to ubound(result)
      '    Response.Write j&"=>"&result(j)&" "
     ' next

      'Response.Write ") <br />"

      'On construit la chaine WHERE en fonction du nombre de parametre
      if nb_ok<>0 then

             for i=0 to UBound(result)

                      where=where&" AND "&tab_name(result(i))&"= "&tab_request(result(i))&" "
             Next
      end if

      'Response.Write "Where= "&where&"<br />"
end if

sql="SELECT * FROM ANNONCES WHERE Visible=1 "&where&" ORDER BY DateAnn  DESC"
'Response.Write sql&"<br />"

'Principe: On va recupérer tous les mots envoyés de longueur > à 4.
' Puis on recupérer tous les tuples de la base de données et on stocke dans un tableau tout les mots en faisant correspondre son id
' Par exemple si le tuple d'id=6 et id=4 contiennent le mot "reseaux" alors on crée un tableau (4,6) afin de construire dynamique la close WHERE
' de la requéte SQL par la suite.

if(Request.Form("nomCV")<>"") then

    Dim oDict,aKeys,rs

    Set oDict = Server.CreateObject("Scripting.Dictionary")
    oDict.CompareMode =   VBBinaryCompare
    Set rs = Conn.Execute(sql)

    where2=""

    'On ajoute dans un dictionnaire qui a pour clé l'id de l'offre et pour valeur une liste de mots de l'intitulé
    While Not rs.EOF
        Dim tmp,wordArray

        wordArray=traitement(rs("IntituleAnn")," ")

        'Affichage
        'Response.Write rs("NumOff")&" == >"
        'writeArray(wordArray)

        if oDict.Exists(rs("NumAnn")) then
               oDict.Remove(rs("NumAnn"))
        end if

        oDict.Add rs("NumAnn")&"",wordArray
        rs.MoveNext
    wend

    rs.Close

    'aItems = oDict.Items
    'Set oDict = Nothing

    'For i = 0 To Ubound(aItems)
    '   writeArray(aItems(i))
    'Next


    'On recupere la liste des id contenant le mot
    Dim listIndice
    listIndice= searchIntoDict(oDict,LCase(removeAccents(Request.Form("nomCV"))))


    'Puis on construit la requete dynamiquement si la liste d'indice est vide alors il n'y a pas de tuples sinon c'est bon.

    tList=UBound(listIndice)

    'Si la liste n'est pas vide alors on peut créer la requete des reponses sinon c'est qu'il n'y a pas de reponse
    if tList >0 then

        for i=1 to tList
            where2=where2&" AND NumAnn="&listIndice(i)
        Next

    else
        where2="null"
    end if
    
    Set oDict = Nothing

end if






    Dim aPoste,aType,aLieu,aDuree
    aPoste=""
    aType=""
    aLieu=""
    aDuree=""

    if Request.Form("nomCV")<>"" then
        aPoste=""""&Request.Form("nomCV")&""" /"
    end if
    
    Select Case Request.Form("profil")
   case "1"
      aType="Emploi"
   case "2"
      aType="Stage"
   case "3"
      aType="Autres"

   case else
      aType="Toutes les offres"
end Select

      aType=aType&" /"

    if Request.Form("lieu_du_poste")<>"" then
        aLieu= lesRegions(Request.Form("lieu_du_poste"))&" /"
    else
        aLieu="France entière /"
    end if


Select Case Request.Form("duree_esperee")
   case "1000"
      aDuree="C.D.I"
   case "15"
      aDuree="15 jours"
   case "30"
      aDuree="1 mois"
   case "90"
      aDuree="3 mois"
   case "120"
      aDuree="4 mois"
   case "150"
      aDuree="5 mois"
   case "180"
      aDuree="6 mois"
   case "270"
      aDuree="9 mois"
   case "360"
      aDuree="1 an et +"

   case else
      aDuree="Toutes les durées"
end Select

Response.Write "<p><b>Vos critères:</b> "&aPoste&aType&aLieu&aDuree&"/ </p>"

' SQL contient la requete pour avoir la liste d'annonces correspondante aux critéres , à partir de maintenant
' On va recupérer la liste des CVs valides en fonction des autres critéres.



if Request.Form("niveau_formation")<>"" then
    where=where&"AND FormationAnn='"&Request.Form("niveau_formation")&"' "
end if
'Response.Write "Sql= "&sql&"<br />"


' Si where2=null alors cela veut dire que l'on a rentré quelque chose dans l'input de recherche
' et que la recherche ne donne rien et donc dans ce cas pas la peine d'aller plus loin.
' Sinon on continue avec la restriction where2 en plus.

if where2="null" then
    Response.Write "Il n'y a pas d'offres correspondantes à votre recherche"
else


    Set rs = Conn.Execute(sql)

    if rs.EOF then
        Response.Write "Il n'y a pas d'offres correspondantes à votre recherche"
    else

        While not rs.EOF
            where=where&" AND ANNONCES.NumCV="&rs("NumCV")
            rs.MoveNext
        Wend

     end if
     rs.Close

     sql="SELECT *  FROM CV,ANNONCES WHERE ANNONCES.Visible=1 "&where&where2&" AND ANNONCES.NumCV=CV.NumCV ORDER BY DateAnn DESC"
     'Response.Write "Sql2= "&sql&"<br />"
     Set rs = Conn.Execute(sql)

     if rs.EOF then
          Response.Write "Il n'y a pas d'offres correspondantes à votre recherche"
     else
          While not rs.EOF
                                                                                                                                                                                                                                                                                                                                                                                                                  
                Response.Write "<table width=""100%"" height=""100%"" border=""0"" cellpadding=""12"" cellspacing=""0"">"
                Response.Write "<tr valign=""top"">"                                                                                                                                                                                                                                                                                                                                                                          
                Response.Write "<th>Date</th><th>Intitulé</th><th>Lieu du poste</th><th>Durée espérée</th><th>Disponible à partir du</th>"                                                                                                                                                                                                                                                                                    
                Response.Write "</tr>"                                                                                                                                                                                                                                                                                                                                                                                        
                Dim strBgcolor                                                                                                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                                                                                                                  
                strBgcolor = "#F1F1F1"                                                                                                                                                                                                                                                                                                                                                                                        
                Response.write "<a href=""pa_consulter_emploi_stagebis.asp?num="&rs("NumCV")&""">"
                Response.write "<tr style=""background-color: "&strBgcolor&" ;"" alig=""center"">" & _                                                                                                   
                    "<td>"&rs("DateAnn")&"</td><td>"&rs("DiplomeActuCV")&"</td><td>"&rs("IntituleAnn")&"</td><td>"&lesRegions(rs("LieuAnn"))&"</td>" & _                                 
                    "<td>"&aDuree&"</td><td>"&rs("DispoJourAnn")&" "&rs("DispoMoisAnn")&" "&rs("DispoAnneeAnn")&"</td>" & _                                                              
                    "<td><a href=""pa_consulter_cvbis.asp?num="&rs("NumCV")&""" title="&rs("Nom")&" "&rs("Prenom")&"><img src=""img/divers/feuille.jpg"" border=""0""></a></td>" & _
                                                                                                                                                                                         
                "</tr>" & _                                                                                                                                                              
                                "</a>"
                rs.MoveNext


                'Alternance de la couleur des lignes                                                                                                                                                                                                                                                                                                                                                                          
                If strBgcolor = "#F1F1F1" Then                                                                                                                                                                                                                                                                                                                                                                                
                    strBgcolor = "#FFFFFF"                                                                                                                                                                                                                                                                                                                                                                                    
                Else
                    strBgcolor = "#F1F1F1"                                                                                                                                                                                                                                                                                                                                                                                    
                End If                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                  

          Wend                      
          Response.Write "</table>"
          rs.Close
     end if




end if
                                                                  
%>                                                                
                                                                  
      <!--           fin insertion  -->                           
                                                                  
                                                                  
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
<br />                                                            
                                                                  
                                                                  
<!-- Ne pas toucher à ce qui suit : placement du footer -->       
                                                                  
                                                                  
<!-- #include file="grand_footer.txt"-->                          
</div>                                                            
<!-- #include file="deconnexion.asp"-->                           
</body>                                                           
</html>                                                           