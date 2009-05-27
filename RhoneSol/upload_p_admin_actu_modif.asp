<%@ Language=VBScript %>
<% 
option explicit 
Response.Expires = -1
Server.ScriptTimeout = 600
%>

<!-- #include file="admin_securite.asp"-->
<!-- #include file="freeaspupload.asp" -->



<%


' ****************************************************
' Change the value of the variable below to the pathname
' of a directory with write permissions, for example "C:\Inetpub\wwwroot"
  Dim uploadsDirVar
  uploadsDirVar="C:/inetpub/vhosts/rhone-solidarite.com/httpdocs/fichiers_upload/upload_actualites" 
' ****************************************************

' Note: this file uploadTester.asp is just an example to demonstrate
' the capabilities of the freeASPUpload.asp class. There are no plans
' to add any new features to uploadTester.asp itself. Feel free to add
' your own code. If you are building a content management system, you
' may also want to consider this script: http://www.webfilebrowser.com/



function TestEnvironment()
    Dim fso, fileName, testFile, streamTest
    TestEnvironment = ""
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    if not fso.FolderExists(uploadsDirVar) then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not exist.</B><br>The value of your uploadsDirVar is incorrect. Open uploadTester.asp in an editor and change the value of uploadsDirVar to the pathname of a directory with write permissions."
        exit function
    end if
    fileName = uploadsDirVar & "\test.txt"
 
    on error resume next
    Set testFile = fso.CreateTextFile(fileName, true)
	
    If Err.Number<>0 then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have write permissions.</B><br>The value of your uploadsDirVar is incorrect. Open uploadTester.asp in an editor and change the value of uploadsDirVar to the pathname of a directory with write permissions."
        exit function
    end if
    Err.Clear
    testFile.Close
    fso.DeleteFile(fileName)
    If Err.Number<>0 then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have delete permissions</B>, although it does have write permissions.<br>Change the permissions for IUSR_<I>computername</I> on this folder."
        exit function
    end if
    Err.Clear
    Set streamTest = Server.CreateObject("ADODB.Stream")
    If Err.Number<>0 then
        TestEnvironment = "<B>The ADODB object <I>Stream</I> is not available in your server.</B><br>Check the Requirements page for information about upgrading your ADODB libraries."
        exit function
    end if
    Set streamTest = Nothing
end function

function SaveFiles
    Dim Creer, fileName, fileSize, ks, i, fileKey

    Set Creer = New FreeASPUpload
    Creer.Save(uploadsDirVar)

	'If something fails inside the script, but the exception is handled
	'If Err.Number<>0 then Exit function

    'SaveFiles = ""
    'ks = Creer.UploadedFiles.keys
    'if (UBound(ks) <> -1) then
        'SaveFiles = "<B>Files uploaded:</B> "
        'for each fileKey in Valider.UploadedFiles.keys
            'SaveFiles = SaveFiles & Valider.UploadedFiles(fileKey).FileName & " (" & Valider.UploadedFiles(fileKey).Length & "B) "
        'next
    'else
        'SaveFiles = "The file name specified in the upload form does not correspond to a valid file in the system."
    'end if
	'SaveFiles = SaveFiles & "<br>Enter a number = " & Valider.Form("enter_a_number") & "<br>"
	'veFiles = SaveFiles & "Checkbox values = " & Valider.Form("checkbox_values") & "<br>"
end function


 
 SaveFiles()

%>


<%
response.redirect("valider_p_admin_actu_modif.asp")
%>


<HTML>
<HEAD>
<TITLE>Test Free ASP Upload</TITLE>
<style>
BODY {background-color: white;font-family:arial; font-size:12}
</style>

</HEAD>

<BODY>

<br><br>
<div style="border-bottom: #A91905 2px solid;font-size:16">Upload files to your server</div>

<%


  


%>
<!-- Please support this free script by having a link to freeaspupload.net either in this page or somewhere else in your site. -->
<div style="border-bottom: #A91905 2px solid;font-size:10">Powered by <A HREF="http://www.freeaspupload.net/" style="color:black">Free ASP Upload</A></div>

<br><br>



</BODY>
</HTML>
