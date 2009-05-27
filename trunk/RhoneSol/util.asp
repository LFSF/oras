<%
Dim lefiltre
lefiltre="jpg|png|gif|jpeg"


'Retournle l'extension du fichier et vide si erreur
function GetExtension(filename)

   if InStrRev(filename,".") > 0 then
              GetExtension= Mid(filename,InStrRev(filename,".")+1,len(filename))
      else
              GetExtension=""
      end if
end function

'Regarde si l'extension du fichier corresponds au filtre retourne vrai si c'est le cas faux sinon
function AvecUnSeulFiltre(filename,filtre)
    if LCase(GetExtension(filename))=filtre then
        AvecUnSeulFiltre=1
    else
        AvecUnSeulFiltre=0
    end if
end function





'Retourne vrai si le nom de fichier a une nom de fichier valide par les filtres
function Filtrer(filename,lesfiltres)
    tableau = Split(lesfiltres,"|", -1)
    i=0
    continue=1
    res=0
    While (i<UBound(tableau) and continue=1)
        if AvecUnSeulFiltre(filename,tableau(i))=1 then
            continue=0
            res=1
        end if
        i=i+1
    Wend
    Filtrer=res
end function

'Affiche à l'ecran un tableau
sub writeArray(arr)
    Dim i
    for i=0 to UBound(arr)
            Response.write arr(i)&" -"
    next
    Response.Write "<br/>"
end sub

'Affiche à l'ecran un dictionnaire
sub writeDict(dict)
    Dim i,aItems,aKeys
    if dict.Count > 0 then
        for i=0 to dict.Count-1
             aKeys=dict.Keys
             Response.Write aKeys(i)
             aItems= dict.Items
             Response.Write "Value: "
             writeArray(aItems(i))

         Next
    else
        Response.Write "Le dictionnaire est vide"
    end if
    
end sub

' Concatene deux tableaux et en retourne un seul
function array_merge(byVal firstArray, byVal secondArray)
      dim totalSize
      dim i
      dim combinedArray

      ' Ensure that we're dealing with arrays.

      if not isArray(firstArray) then
          firstArray = Array(firstArray)
      end if

      if not isArray(secondArray) then
          secondArray = Array(secondArray)
      end if

      ' Set up the new array.
      totalSize = uBound(firstArray) + uBound(secondArray) + 1
      combinedArray = firstArray
      redim preserve combinedArray(totalSize)
      for i = 0 to uBound(secondArray)

          combinedArray(uBound(firstArray) + 1 + i) = secondArray(i)

      next
      array_merge = combinedArray
end function

' Renvoie True si val est deja dans la liste list et False sinon
function appartient(list,val)
    Dim res,i
    res= false
    i=0
    'Tant que val n'est pas présent dans list alors res vaut false et continue à
    ' parcourir la liste.
    while (i<Ubound(list) and not res)
        if(list(i)=res) then
            res= true
        else
            i=i+1
        end if
    Wend
    appartient=res
end function

'Retourne la position du mot dans la liste s'il existe sinon -1
function searchIntoList(list,word)
    Dim res,i,contient
    'Valeur de retour
    res=-1
    i=0
    contient=0
    while (i<= Ubound(list) and contient=0)
        if word=list(i) then
            contient=1
            res=i
        end if
        i=i+1
    Wend
    searchIntoList=res

end function

'Retourne une liste des keys contenant toutes les occurences du mots word
'Par ex: pour le dico (1 -> "moteur","roue");(3 -> "roue")
'searchIntoDict(dico,"roue") retourne (1,3)
function searchIntoDict(dict,phrase)
    Dim res(),wordArray
    redim preserve res(0)
    wordArray= Split(phrase," ")

    if dict.Count > 0 then
        Dim tmp,taille,i,aItems,aKeys,j

        ' Taille initiale du tableau res
        taille=1

        for i=0 to dict.Count-1
            aItems=dict.Items
            ' On va regarder pour chaque mots de la phrase
            for j=0 to UBound(wordArray)
                tmp= searchIntoList(aItems(i),wordArray(j))
                if(tmp<>-1) then

                    aKeys= dict.Keys
                    'On regarde si l'indice n'est pas deja présente dans la liste
                    if not appartient(res,aKeys(i)) then
                        'On augmente la taille de la liste de retour et on insére la clé corespondante
                        redim preserve res(taille)
                        taille=taille+1
                        res(taille-1)= aKeys(i)
                    end if
                end if
            Next
        Next
    end if
    searchIntoDict=res    
end function


'enlever les accents
 
function strtr(chaine, strFrom, strTo)
  Dim c0, c1, i
  for i = 1 to len(strFrom)
    
    'récupération d'un caractère
    'de la chaîne strFrom à la
    'position i
    c0 = mid(strFrom, i, 1)
    
    'Si la longueur de la chaîne
    'strTo dépasse celle de strFrom
    'alors on remplace par rien
    if i > len(strTo) Then
      c1 = ""
    else
      c1 = mid(strTo, i, 1)
    end if
    
    'Remplacement des caractères
    'dans la chaîne de départ
    chaine = Replace(chaine, c0, c1)
    
  next
  
  'On renvoie la chaîne sans accents
  strtr = chaine
  
end function
'@param1 => chaîne : chaîne à transformer
'@return => chaîne : retourne la chaîne traduite
function removeAccents(chaine)
  Dim accent, noaccent
  accent   = "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûýýþÿ"
  noaccent = "AAAAAAACEEEEIIIIDNOOOOOOUUUUYbsaaaaaaaceeeeiiiidnoooooouuuyyby"
  removeAccents = strtr(chaine, accent, noaccent)
end function

'Retourne la liste des mots de longueur > 3 sans accents et en minuscule de str
function traitement(str,delimit)
    Dim res(),word,wordArray,tRes,i
    tRes=0
    redim preserve res(tRes)

    wordArray=Split(Trim(str),delimit)
    for i=0 to Ubound(wordArray)
        word=wordArray(i)
        if(Len(word)> 2) then
            tRes=tRes+1
            redim preserve res(tRes)
            res(i)= LCase(removeAccents(Trim(word)))
        end if
    Next
    traitement=res

end function
%>