<%
dbPath = Server.MapPath("bd/Upload.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath

'Met � jour la date de mise � jour en l'inscrivant dans un fichier config.txt
sub majDate()
        Set FSO = _
   Server.CreateObject("Scripting.FileSystemObject")  

  'R�cup�rer le path long du dossier
  'qui contient le fichier
    dir = Server.MapPath("./")

  'Composer le chemin complet du fichier
    Fnm = dir & "\config.txt"

  'l'ouvrir en mode �criture
    set inF = FSO.OpenTextFile(Fnm,2,false)  

    inF.writeLine now

    inF.close
end sub

'Detruit une session ouverte en rendant vide toutes les variables de la session
sub session_destroy()
        'session("admin_securite")=""
        'Session("logadh")=""
        'session("page precedente")=""
        'session("lenumeroadh")=""
        'session("lenomadh")=""
        'session("leprenomadh")=""
        'session("lestatusadh")=""
        'session("leloginadh")=""
        'session("lemailadh")=""
        'session("leloginlogin")=""
        'session("leadresse")=""
        'session("leville")=""
        'session("lecp")=""
        'session("letelephone")=""
        'session("leportable")=""
        'session("lecommentaire")=""
        'session("lenaissance")=""
        'session("lemoisdenaissance")=""
        'session("lejourdenaissance")=""
        'session("leanneedenaissance")=""
        'session("ledateadhesion")=""
        'session("timeout")=""
        session.Abandon()
end sub

' Vire les balises pour ne recup�rer que le texte.
Function notag(txt)
   dim regEx
   Set regEx = New RegExp
   regEx.Global = True
   ' ^ signifie "tout sauf"
   ' + signifie 1 car au moins
   regEx.Pattern = "<[^>]+>"
   ' remplace par vide
   notag = regEx.replace(txt,"")
end function

Function HTMLDecode(sText)
    Dim aRemplacer,remplacerPar,i

    aRemplacer=array("°","¨","£","µ","§","é","è","ç","�","ù","ê","î","ô","û")
    remplacerPar= Array("�","�","�","�","�","�","�","�","�","�","�","�","�","�")

    for i=0 to UBound(aRemplacer)
        sText = Replace(sText, aRemplacer(i), remplacerPar(i))
    Next

    For I = 1 to 255
        sText = Replace(sText, "&#" & I & ";", Chr(I))
    Next
    HTMLDecode = sText
End Function

%>
 