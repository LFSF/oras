<div class="datemaj" align="right">

<%
    Set FSO = Server.CreateObject("Scripting.FileSystemObject")
    'Récupérer le path long du dossier
    'qui contient le fichier
    dir = Server.MapPath("./")
    'Composer le chemin complet du fichier
    Fnm = dir & "\config.txt"

    'Dim mydatemaj

    'Vérifier que ce fichier existe bien
    if FSO.FileExists(Fnm) then

        'Ouvrir le fichier
        set inF = FSO.OpenTextFile(Fnm,1,false)
        'Lire une seule ligne
        mydatemaj = inF.readLine

        'Enfin fermer le fichier
        inF.close
    else
        mydatemaj=now

    end if



    Response.Write "<small>"&Server.HTMLEncode("Dernière mise à jour le "&mydatemaj)&"</small>"

%>
</div>
<hr noshade="noshade" size="1px"/>
<br />
<div align="center"><a href="p_membres.asp">ESPACES MEMBRES</a>  -  <a href="p_idees.asp">IDEES/SUGGESTIONS </a> -  <a href="p_contact.asp">CONTACT</a> 
<br /><a href="p_charte.asp">CHARTE</a><a href="p_mentionslegales.asp">- MENTIONS LEGALES</a> - <a href="p_plansite.asp">PLAN DU SITE</a> - <a href="http://www.exilens.com">created by exilens</a></div>
<br />








