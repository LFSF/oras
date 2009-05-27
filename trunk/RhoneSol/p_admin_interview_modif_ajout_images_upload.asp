<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<% if not(Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_interview_modif_ajout_images.asp") then
	response.redirect("http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp")
	else
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> 
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>


<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
				<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin_interview.asp"><font size=1><b>
                         << Retour Menu Interview &nbsp;</b></font>
                          </a></td></tr></table> 

	<%
espace="&#034;"
simplecot="&#039;"
'******************Pour l'interview********************
'Recuperation de l'indice de l'interview pour l'appliquer à l'image
'fonctionnement du script :
'toute les requêtes doivent se faire avec une restriction sur le numéro d'interview
'par exemple à la ligne 32 : <citation> Set rsED = Conn.Execute("SELECT NomImg FROM ListFiles") </citation> 
'devient Set rsED = Conn.Execute("SELECT NomImg FROM ListFiles where NumItw =idInterview")
'cela permet d'afficher et d'effectuer les actions que sur les images concernant l'interview sélectionné
idInterview=request.querystring("idint")



'idInterview = request.querystring("idint")



'Etant donnée que la partie interview n'est achevée, aucun idinterview n'est envoyée
'par défaut on l'initialise à 1 pour tester le formulaire
	'if idInterview = "" then
		'idInterview = 1
	'end if

'****************** Fin Pour l'interview********************






'if (session("visualisation_img_1")<>"" or (request.querystring("idint")=1)) then
'session("visualisation_img_1")=""
if (request.querystring("idint")<>"" ) then
'***********************************************
if(idInterview <>0) then
Session("idint") = idInterview
end if

		  
		  Set rsED = Conn.Execute("SELECT NomImg FROM ListFiles WHERE NumItw="&request.querystring("idint"))
		   IF rsED.EOF Then
		  Response.Write("Il n'y a aucun fichier ")
		  Else
		  While Not rsED.EOF

			nom_fichier=rsED("NomImg")
		
		compteur_img = compteur_img + 1
		%>
		<img src="UploadFolder/<%=nom_fichier%>" width='170px' height='130px'>
		
		
		<input name='delete' type='image' img src='img/postdelete.gif' id='delete' 
			onclick="window.location='ImgDelete.asp?UrlImg=<%=nom_fichier%>&idint=<%=idInterview%>'"> &nbsp;&nbsp;
		<% if (compteur_img=5) then%>
		<br/><br/>_______________________________<br/><br/>
		<%
		compteur_img=0
		
		%>
		
        <%
		end if
		 
			rsED.MoveNext
			Wend
			rsED.Close 
			Set rsED = Nothing
			End If
			


'*******FIN SCRIPT AFFICHER LES IMG***************************************


end if



if (session("redirection_db-multiple-file-to-disk.asp")<>"") then
'on vide la session par securite
session("redirection_db-multiple-file-to-disk.asp")=""
session("variable_id_img")=""






'************SCRIPT FSO*********************************************




'*********************FIN SCRIPT FSO*********************************

end if

'Sample file Field-SaveAs.asp 
'Store extra upload info to a database
' and file contents to the disk
Server.ScriptTimeout = 5000

'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 1000


'Form.SizeLimit = 10240*1024'10MB
Form.SizeLimit = 1024*10240'

'{b}Set the upload ID for this form.
'Progress bar window will receive the same ID.
if len(Request.QueryString("UploadID"))>0 then
  Form.UploadID = Request.QueryString("UploadID")'{/b}
end if
'was the Form successfully received?
Const fsCompletted  = 0

If Form.State = fsCompletted Then 'Completted
  Const VirtualFolder = "UploadFolder"

  'Create destination path+filename for the source file.
  'Create an URL for image.
  Dim DestinationPath, virtDestinationPath
  DestinationPath = Server.mapPath(VirtualFolder) & "\"
  virtDestinationPath = "http://" + Request.ServerVariables("SERVER_NAME") _
  
   + GetPath(Request.ServerVariables("SCRIPT_NAME") ) _
   + VirtualFolder + "/"

  'Open recordset to store uploaded data
  Dim RS: Set RS = OpenUploadRS


  Dim FileField
  For Each FileField in Form.Files.Items
  
    'Fo each file sent
    if len(FileField.FileName)> 0 then 'File is specified.
	if FileField.Length<1024*1024 then 
      Dim DestinationFileName
	  compteur = compteur +1

	  FileField.FileName= "toto" &compteur &hour(now()) &minute(now()) &second(now()) &FileField.FileName
	  FileField.FileName=Replace(FileField.FileName,"'","_")
      DestinationFileName = DestinationPath & FileField.FileName

      'Save file to physical location
      FileField.SaveAs DestinationFileName
      
      'Store extra info about upload to database
      RS.AddNew
	  '*****Ancienne Base******
		   'RS("UploadDT") = Now()
		   'RS("Description") = Form("Desc-" & FileField.Name)
		   'RS("NomImg")= FileField.FileName
		   'RS("SourceFileName") = virtDestinationPath & FileField.FileName
		   'RS("DestFileName") = DestinationFileName
		   'RS("DataSize") = FileField.Length
       '*******Fin Ancienne Base ******
	   RS("NomImg") = FileField.FileName
       RS("DescriptionImg") = Form("Desc-" & FileField.Name)
       RS("UrlImg") = DestinationFileName
       RS("NumItw") = Session("idint")
      RS.Update
	 
else
response.write("Fichier superieur a 1meg")   
end if
   end if

  Next 

  'What to do with Form("Description")?
  Response.write "<br/>Nom de(s) image(s)  rajoutée(s) à l'interview :"
  Dim Field: For Each Field in Form.Files.Items
  if Field.FileName<>"" then
  
  ' Ajout compteur pour aligner les images
  compteur_img3 = compteur_img3 + 1
	Response.write "<br/>&nbsp;" & Field.FileName
	%>
	<!--visualisation de l'image-->
	<img src="UploadFolder/<%=Field.FileName%>" width='170px' height='130px'>

	

	
	<input name='delete' type='image' img src='img/postdelete.gif' id='delete' 
	onclick="window.location='ImgDelete.asp?UrlImg=<%=Field.FileName%>&idint=<%=idInterview%>'">
	 
	 	<% if (compteur_img3=5) then%>
		<br/><br/>_______________________________<br/><br/>
		<%
		compteur_img3=0
		end if
		%>
	 
	 
	<%
end if
  Next
  '{b}Save file to the destination
  '{/b}

'  response.write "<Font color=green><br/>SourceFile was saved as " & DestinationFileName
'  response.write "<br/>See ListFiles table in " & Server.MapPath("upload.mdb") & " database.</Font>"

ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
    case fsSizeLimit: response.write  "<br/><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br/>"
    case else response.write "<br/><Font Color=red>Some form error.</Font><br/>"
  end Select
End If'Form.State = 0 then



Function OpenUploadRS()
  Dim RS  : Set RS = CreateObject("ADODB.Recordset")

  'Open dynamic recordset, table Upload
  RS.Open "ListFiles", GetConnection, 2, 2
  
  Set OpenUploadRS = RS
end Function 

Function GetConnection()
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "Microsoft.Jet.OLEDB.4.0"
  Conn.open "Data Source=" & Server.MapPath("bd/Upload.mdb") 
  set GetConnection = Conn
end function

Function SplitFileName(FullPath)
  Dim Pos, PosF
  PosF = 0
  For Pos = Len(FullPath) To 1 Step -1
    Select Case Mid(FullPath, Pos, 1)
      Case ":", "/", "\": PosF = Pos + 1: Pos = 0
    End Select
  Next
  If PosF = 0 Then PosF = 1
 SplitFileName = PosF
End Function

Function GetPath(FullPath)
  GetPath = left(FullPath, SplitFileName(FullPath)-1)
End Function




'{b}get an unique upload ID for this upload script and progress bar.
Dim UploadID, PostURL
UploadID = Form.NewUploadID

'Send this ID as a UploadID QueryString parameter to this script.
PostURL = Request.ServerVariables("SCRIPT_NAME") & "?UploadID=" & UploadID'{/b}

%>

<h1 align="center">Modification de l'interview n°<%=Session("idint")%></h1>

<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La limite est de  <%=Form.SizeLimit%>B (Soit <%=Form.SizeLimit \ 1024 %>kB ) .
  </TD></TR>
  </TABLE>
  




<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" OnSubmit="return ProgressBar();" Action="<%=PostURL%>">

<Div ID=files>
   File 1 : <input type="file" name="File1"> Description 1 : <Input Name="Desc-File1" Size=25><br/>
   File 2 : <input type="file" name="File2"> Description 2 : <Input Name="Desc-File2" Size=25><br/>
   File 3 : <input type="file" name="File3"> Description 3 : <Input Name="Desc-File3" Size=25><br/>
   File 4 : <input type="file" name="File4"> Description 4 : <Input Name="Desc-File4" Size=25><br/>
   File 5 : <input type="file" name="File5"> Description 5 : <Input Name="Desc-File5" Size=25><br/>
   File 6 : <input type="file" name="File6"> Description 6 : <Input Name="Desc-File6" Size=25><br/>
   File 7 : <input type="file" name="File7"> Description 7 : <Input Name="Desc-File7" Size=25><br/>
   File 8 : <input type="file" name="File8"> Description 8 : <Input Name="Desc-File8" Size=25><br/>
   File 9 : <input type="file" name="File9"> Description 9 : <Input Name="Desc-File9" Size=25><br/>
   File 10 : <input type="file" name="File10"> Description 10 : <Input Name="Desc-File10" Size=25>
</Div>

<Input Type=Button Value="Add a file" OnClick=return(Expand()) 
 Style="border=0;background=yellow;cursor:hand"><br/>
 
<Input Type=Button Value="Visualiser les images de l'interview" OnClick="window.location='p_admin_interview_modif_ajout_images_upload.asp?idint=<%=Session("idint")%>'"><br/>


<input Name=SubmitButton Value="Upload" Type=Submit><br/>
</Form>

<SCRIPT>
//Open window with progress bar.
function ProgressBar(){
  var ProgressURL
  ProgressURL = 'progress.asp?UploadID=<%=UploadID%>'

  var v = window.open(ProgressURL,'_blank','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=350,height=200')
  
  return true;
}
</SCRIPT> 


<Script>
//Expand form with a new File fields if needed.
var nfiles = 10;
function Expand(){
  nfiles++
  var adh = '<br/> File '+nfiles+' : <input type="file" name="File'+nfiles+'"> Description '+nfiles+' : <Input Name="Desc-File'+nfiles+'" Size=50>';
  files.insertAdjacentHTML('BeforeEnd',adh);
  return false;
}
</Script>


<HR COLOR=silver Size=1>


  <!--fin corps de texte-->
		
		
		
		<!--           fin insertion  -->
		


 
<br />
<br />
<br />
<br />
<br />
<br />
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>
<% end if %>
<% end if %>