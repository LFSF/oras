<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
	<!-- #include file="grand_meta.txt"-->
	<title>Rh�ne-solidarit�</title>
	<!-- #include file="connexion.asp"-->
	<!-- #include file="util.asp"-->
	<link href="styles.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /></head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">
<div id="bandeau_orange">RECHERCHE OFFRES</div>
<!-- #include file="fichier_menu.txt"-->
<a class="lien" href="p_annonces.asp"><font size="1"><b>&lt;&lt; Retour </b></font></a>
<%
Dim where,tab_name,tab_request,nb_ok,i,j,est_vide

Dim lesRegions()
taille=1

Set rs = Conn.Execute("SELECT * FROM REGIONS;")
'Construction de la liste des regions.
While not rs.EOF
    redim preserve lesRegions(taille)
    taille=taille+1
    lesRegions(taille-1)=rs("nomRegion")
                                              

Rs.MoveNext
Wend

rs.Close

tab_request=array(Request.Form("duree_esperee"),Request.Form("lieu_du_poste"),Request.Form("type_contrat"))
tab_name=array("DureeOff","LieuOff","ProfilOff")
where=""
est_vide=1
j=0

'On teste si on a entre au moins un critere
while (j<=UBound(tab_request) and est_vide=1)
    if(tab_request(j)<>"") then
        est_vide=0
    end if
    j=j+1
Wend

'Si on a rentre au moins un critere alors
if est_vide=0 then

     ' Response.Write "tab_request= ( "

     ' for j=0 to ubound(tab_request)
      '    Response.Write j&"=>"&tab_request(j)&" "
     ' next

      'Response.Write ") <br />"


      'Tableau d'accueil des parametres non vides
      Dim result()

      nb_ok=0

      ' Test de la prï¿½sence des variables pour la contruction de la requete
      ' Et on compte combien ne sont pas vide
      For i=0 to UBound(tab_request)
          if tab_request(i)<>"" then
              redim preserve result(nb_ok)

              nb_ok=nb_ok+1
              result(nb_ok-1)=i

          end if
      next

      'Response.Write "TResult= "&ubound(result)&"<br />"
      'Response.Write "Result= ( "

      'for j=0 to ubound(result)
      '    Response.Write j&"=>"&result(j)&" "
     ' next

      'Response.Write ") <br />"

      'On construit la chaine WHERE en fonction du nombre de parametre
      if nb_ok<>0 then

             for i=0 to UBound(result)
                      if result(i)=0 and tab_request(result(i))<>"" then
                            where=where&" AND "&tab_name(result(i))&"= '"&tab_request(result(i))&"' "
                      else
                            where=where&" AND "&tab_name(result(i))&"= "&tab_request(result(i))&" "
                      end if
             Next
      end if

      'Response.Write "Where= "&where&"<br />"
end if

sql="SELECT NumOff,IntituleOff FROM OFFRES WHERE Visible=1 "&where&" ORDER BY DateOff  DESC"
'Principe: On va recupï¿½rer tous les mots envoyï¿½s de longueur > ï¿½ 4.
' Puis on recupï¿½rer tous les tuples de la base de donnï¿½es et on stocke dans un tableau tout les mots en faisant correspondre son id
' Par exemple si le tuple d'id=6 et id=4 contiennent le mot "reseaux" alors on crï¿½e un tableau (4,6) afin de construire dynamique la close WHERE
' de la requï¿½te SQL par la suite.

if(Request.Form("poste")<>"") then

    Dim oDict,aKeys,rs

    Set oDict = Server.CreateObject("Scripting.Dictionary")
    oDict.CompareMode =   VBBinaryCompare
    Set rs = Conn.Execute(sql)

    where2=""

    'On ajoute dans un dictionnaire qui a pour clï¿½ l'id de l'offre et pour valeur une liste de mots de l'intitulï¿½
    While Not rs.EOF
        Dim tmp,wordArray

        wordArray=traitement(rs("IntituleOff")," ")

        'Affichage
        'Response.Write rs("NumOff")&" == >"
        'writeArray(wordArray)

        if oDict.Exists(rs("NumOff")) then
               oDict.Remove(rs("NumOff"))
        end if

        oDict.Add rs("NumOff")&"",wordArray
        rs.MoveNext
    wend

    'aItems = oDict.Items
    'Set oDict = Nothing

    'For i = 0 To Ubound(aItems)
    '   writeArray(aItems(i))
    'Next


    'On recupere la liste des id contenant le mot
    Dim listIndice
    listIndice= searchIntoDict(oDict,LCase(removeAccents(Request.Form("poste"))))


    'Puis on construit la requete dynamiquement si la liste d'indice est vide alors il n'y a pas de tuples sinon c'est bon.
    where2=""
    tList=UBound(listIndice)

    'Si la liste n'est pas vide alors on peut crï¿½er la requete des reponses sinon c'est qu'il n'y a pas de reponse
    if tList >0 then

        for i=1 to tList
            where2=where2&" AND NumOff="&listIndice(i)
        Next

        'Creation de la nouvelle requete
        sql="SELECT * FROM OFFRES WHERE Visible=1 "&where&where2&" ORDER BY DateOff  DESC"
    else
        sql=""
    end if
    
    Set oDict = Nothing
else

    sql="SELECT * FROM OFFRES WHERE Visible=1 "&where&" ORDER BY DateOff  DESC"

end if



if sql="" then
    Response.Write "Il n'y a pas d'offres correspondantes � votre recherche"
else
    Dim aPoste,aType,aLieu,aDuree
    aPoste=""
    aType=""
    aLieu=""
    aDuree=""
    if Request.Form("poste")<>"" then
        aPoste=""""&Request.Form("poste")&""" /"
    end if
    
    Select Case Request.Form("type_contrat")
   case "1"
      aType="Les offres d'emploi"
   case "2"
      aType="Les offres de stage"
   case "3"
      aType="Le B�n�volat"
   case "4"
      aType="Les autres offres"
   case else
      aType="Toutes les offres"
end Select
      aType=aType&" /"

    if Request.Form("lieu_du_poste")<>"" then
        aLieu= lesRegions(Request.Form("lieu_du_poste"))&" /"
    else
        aLieu="France enti�re /"
    end if

    if Request.Form("duree_esperee")<>"" then
        aDuree= Request.Form("duree_esperee")&" /"
    else
        aDuree="N'importe quelle dur�e /"
    end if

    Response.Write "<p><b>Vos crit�res:</b> "&aPoste&aType&aLieu&aDuree&"</p>"

    'Response.Write "Sql= "&sql&"<br />"
    Set rs = Conn.Execute(sql)

    if rs.EOF then
        Response.Write "Il n'y a pas d'offres correspondantes � votre recherche"
    else

        Response.Write "<table width=""100%"" height=""100%"" border=""0"" cellpadding=""12"" cellspacing=""0"">"
        Response.Write "<tr valign=""top"">"
            Response.Write "<th>Date</th><th>Raison sociale</th><th>Poste</th><th>Lieu du poste</th><th>Dur�e de la mission</th>"
        Response.Write "</tr>"
        Dim strBgcolor

        strBgcolor = "#F1F1F1"
        
        While Not rs.EOF
            Response.write "<a href=""pa_consulter_emploi_stagebis.asp?num="&rs("NumOff")&""">" & _
                                "<tr style=""background-color: "&strBgcolor&" ;"" alig=""center"">" & _
                                    "<td>"&rs("DateOff")&"</td><td>"&rs("RaisonSocEntOff")&"</td><td>"&rs("IntituleOff")&"</td><td>"&rs("DureeOff")&"</td><td><a href=""pa_consulter_emploi_stagebis.asp?num="&rs("NumOff")&"""><img src=""img/divers/feuille.jpg"" border=""0""></a></td>" & _
                                "</tr>" & _
                            "</a>"

            'Alternance de la couleur des lignes
            If strBgcolor = "#F1F1F1" Then
              strBgcolor = "#FFFFFF"
            Else
                strBgcolor = "#F1F1F1"
            End If

            rs.MoveNext

        wend

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


<!-- Ne pas toucher ï¿½ ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>
<!-- #include file="deconnexion.asp"-->
</body>
</html>