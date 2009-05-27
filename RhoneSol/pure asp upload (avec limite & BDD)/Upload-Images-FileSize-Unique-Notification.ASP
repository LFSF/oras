<%
Option explicit
'Stores only files with size less than MaxFileSize


Const maxFileSize = 1500000 'limit of size per file
Const imageExts = ".gif,.jpg,.png,.jpeg,.bmp"

Dim DestinationPath
DestinationPath = Server.mapPath("UploadFolder")

'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 2000
Form.SizeLimit = 4*1000000 'limit of size per whole form

'{b}Set the upload ID for this form.
'Progress bar window will receive the same ID.
if len(Request.QueryString("UploadID"))>0 then
  Form.UploadID = Request.QueryString("UploadID")'{/b}
end if
'was the Form successfully received?
Const fsCompletted  = 0

If Form.State = fsCompletted Then 'Completted
  Dim CustomerID
  CustomerID = Form("CustomerID")

  'Do something with upload - save, enumerate, ...
  response.write "<br><b>Upload result: Form was accepted.</b>" 
  response.write "<br>Number of file fields:" & Form.Files.Count
  response.write "<br>Request total bytes:" & Request.TotalBytes

  'PRocess files and create HTML report
  Dim OutHTML:  OutHTML = do_Files (Form)

  'Send the report by email
  SendReport "to@yourdomain.com", OutHTML

  'Write the report to a client
  response.write OutHTML

ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
    case fsSizeLimit: response.write  "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
    case else response.write "<br><Font Color=red>Some form error.</Font><br>"
  end Select
End If'Form.State = 0 then




Function do_Files (Form)
  Dim HTML


  '1. Process main upload fields - CustomerID, Description
  Dim UploadID, Uploads, CustomerID
  CustomerID = Form("CustomerID")
  if len(CustomerID)=0 then CustomerID = -1

  'DB contains two tables:
  ' - Uploads with UploadID (primary key), Description, and CustomerID
  ' - UploadsFiles with UploadID (foreign key), Description, DestFileName, DataSize and SourceFileName
  'Open table with list of uploads
  
  Set Uploads = OpenUploadRS("Uploads")
  Uploads.AddNew
    Uploads("Description") = Form("Description")
    Uploads("CustomerID") = CustomerID
  Uploads.Update
  UploadID = Uploads("UploadID")

  HTML = HTML & "<br>UploadID:" & UploadID
  HTML = HTML & "<br>CustomerID:" & Form("CustomerID")

  '2. Process form files
  Dim File
  For Each File In Form.Files.Items
    If Len(File.FileName) > 0 Then
      
      'Open recordset to store uploaded files
      Dim UploadsFiles: Set UploadsFiles = OpenUploadRS("UploadsFiles")

      HTML = HTML &  "<br>File:" & File.FileName & ", size :" & (File.Length \ 1024 +1) & "kB"
      HTML = HTML &  ", Is image:" & IsImage(File)
      if File.Length > maxFileSize then
        HTML = HTML &  "<Font Color=red> exceeds the size limit  (" & maxFileSize & ").</font>" 
      elseif not IsImage(File) Then 
        HTML = HTML &  "<Font Color=red> is not an image type (" & imageExts & ").</font>" 
      else
        Dim DestFileName
        DestFileName = GetUniqueFileName(File.FileName, DestinationPath)
        File.SaveAs DestinationPath & "\" & DestFileName

        'Store extra info about upload to database
        UploadsFiles.AddNew
         UploadsFiles("UploadID") = UploadID
         UploadsFiles("SourceFileName") = left(File.FilePath,255)
         UploadsFiles("DestFileName") = left(DestFileName, 255)
         UploadsFiles("DataSize") = File.Length
         '...
        UploadsFiles.Update

        HTML = HTML &  "<Font Color=green> was stored to a disk as '" & DestFileName & "'.</font>"
      end if
    end if'if len(File.FileName)=0 then

  Next
'  Form.Files.Save DestinationPath 
  HTML = HTML &  "<br>Files was saved to " & DestinationPath & " folder."
  do_Files = HTML
End Function


'Send and upload report to administrator.
Sub SendReport(NotifyAddress, Message)
  
  Dim objNewMail: Set objNewMail = CreateObject("CDONTS.NewMail")
  Const CdoMailFormatMime = 0
  objNewMail.MailFormat = CdoMailFormatMime
  objNewMail.BodyFormat = 0 ' HTML

  Dim Subject
  Subject = "Upload of files - user '" & request.servervariables("REMOTE_USER") & "'"
  'Send the new email
  objNewMail.Send "from@yourdomain.com", NotifyAddress, Subject, Message
End Sub



Function OpenUploadRS(TableName)
  Dim RS  : Set RS = CreateObject("ADODB.Recordset")
  'Open dynamic recordset
  
  RS.Open TableName, GetConnection, 2, 2
  
  Set OpenUploadRS = RS
end Function 

Function GetConnection()
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "Microsoft.Jet.OLEDB.4.0"
  Conn.open "Data Source=" & Server.MapPath("upload.mdb") 
  set GetConnection = Conn
end function






'This function checks filename and CONTENTS of a field
'to recognize images
Function IsImage(Field)
  IsImage = True 'I'm sorry, PureASP upload does not have HexString property.
  Exit Function
  if instr(1, imageExts & ",", Field.FileExt & ",", 1)>0 _
    or Left(Field.ContentType, 5) = "image" Then 
    
    ' FFD8FF = JFIF
    ' 49492A00 = TIF
    if Field.HexString (0,3)="FFD8FF" or Field.HexString (0,4)="49492A00" _
    or Field.String(,6,4)="JFIF" or Field.String(,0,3)="GIF" _
    or Field.String(,1,3)="PNG"  or Field.String(,0,2)="BM" then
      IsImage = True
    end if
  end if
End Function





Dim gFS
'creates an unique filename
'in filename.ext, filename-1.ext, filename-2.ext, filename-3.ext, ... schema
Function GetUniqueFileName(FileName, DestPath)
  if isempty(gFS) then Set gFS = CreateObject("Scripting.FileSystemObject")
  Dim DotPos: DotPos = InStrRev(FileName,".")
  if DotPos = 0 then DotPos = len(FileName)+1
  Dim Counter, FullPath, NewFileName
  Counter = 1
  NewFileName = FileName
  if gFS.FileExists(DestPath & "\" & NewFileName) then
    Do
      Counter = Counter + 1
      NewFileName = Left(FileName, DotPos-1) & "-" & Counter _
        & Mid(FileName, DotPos)
    Loop while gFS.FileExists(DestPath & "\" & NewFileName)
  end if
  GetUniqueFileName = NewFileName
End Function


%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload - Image upload, combine several upload features.</TITLE>
 <STYLE TYPE="text/css"><!--TD  {font-family:Arial,Helvetica,sans-serif }TH  {font-family:Arial,Helvetica,sans-serif }TABLE  {font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>


<TABLE cellSpacing=1 cellPadding=3 bordercolor=silver bgcolor=GAINSBORO width="" border=1>
<form name="file_upload" method=post ENCTYPE="multipart/form-data" OnSubmit="return ProgressBar(this);">
<input type=hidden name=CustomerID Value="<%=CustomerID%>">
<TR>
 <TD>&nbsp;</TD>
 <TD Align=Right><input type="submit" Name="Action" value="Upload these images &gt;&gt;"></TD>
</TR>
<TR>
 <TD>Description</TD>
 <TD><input size=40 Name="Description" value=""></TD>
</TR>
<TR>
 <TD NoWrap>Images to upload<br><Input Type=Button Value="Add an image" OnClick=return(Expand()) 
 Style="border=0;background=yellow;cursor:hand"></TD>
 <TD>
<Div ID=files>
 <div id=dfile1>
   Image 1 : <input type="file" name="Image 1" id="Image 1" onchange="preview(1)" onfocus="preview(1)"><img id="himg1" style="display:none" onload="himgLoaded(1)"> Size:&nbsp;<span id="size1">-</span><br>
 </div>
   Image 2 : <input type="file" name="Image 2" id="Image 2" onchange="preview(2)" onfocus="preview(2)"><img id="himg2" style="display:none" onload="himgLoaded(2)"> Size:&nbsp;<span id="size2">-</span><br>
   Image 3 : <input type="file" name="Image 3" id="Image 3" onchange="preview(3)" onfocus="preview(3)"><img id="himg3" style="display:none" onload="himgLoaded(3)"> Size:&nbsp;<span id="size3">-</span><br>
</Div>
 Total size:&nbsp;<span id="totalSize">-</span>
</TD>
</TR>
<!--<TR>
 <TD>Description</TD>
 <TD><textarea cols="60" rows="3" name="Description">Type description of the image upload.</textarea></TD>
</TR>-->
<tr><td><Div ID=ImageName>Image preview :</Div></td><td>
<img border="0" width="0" ID="ipreview" src="">
</td></tr>
</form></Table>






<SCRIPT>
//Open window with progress bar.
//pair upload window and progress window (using UploadID).
function ProgressBar(form){
 //check file sizes.
 
 if (checkFileSize()) {
   alert('Upload size is over limit. Please check selected files.')
   return false;
 };

  
 //ASP script handling progress window
 var ProgressScript
 ProgressScript = 'progress.asp'
 

 //Progress window parameters
 var pp = 'toolbar=no,location=no,directories=no,status=no,menubar=no'
 pp+=',scrollbars=no,resizable=yes,width=350,height=200';
  
 //1. Get unique UploadID
 var UploadID
 UploadID = Math.round(Math.random() * 0x7FFFFFF0)
  
 //2. Add upload ID to form action URL
 var action = form.action;
 if ('' == action) action = ''+document.location;
 action = AddToQuery(action, 'UploadID', UploadID);
 form.action = action

 //3. Open progress window with the same UploadID
 var ProgressURL
 ProgressURL = ProgressScript + '?UploadID=' + UploadID 

 var v = window.open(ProgressURL,'_blank',pp)
 
 return true;
};

//Adds value and its name to querystring
function AddToQuery(q, valname, val){
 if (q.indexOf('?')<0) {
   q += '?'
 } else {
 var pv = q.indexOf(valname+'=');
 if (pv >= 0){
  var amp = q.indexOf('&', pv);
  if (amp<0) {
   q = q.substr(0, pv) 
  } else {
   q = q.substr(0, pv) + q.substr(amp+1) + '&'
  }
 } else {
  if (q.substr(q.length-1)!='?') q += '&'
 };
 };
 q += valname + '=' + val
 return q
};
</SCRIPT> 


<Script>
//Additional function - dynamic form to add new files at a client side.

var nfiles = 3;
//Add two files for upload
//Expand();
function Expand(){
  
  //get an HTML code of a first upload element
  var adh = dfile1.outerHTML;

  //replace '1' to nfiles (2, 3, ...)
  adh = adh.replace(/1/g,++nfiles)
  
  //insert the code of a new element before end of div files
  files.insertAdjacentHTML('BeforeEnd',adh);

  //clear mask and real value of the element nfiles
  //document.getElementById('maskfile'+nfiles).value=''
  return false;
};

</Script>


<Script>
//Huge-asp upload preview sample
//http://www.motobit.com

function isImage(file){
  //Get a file extension
  var ext = file.substr(file.lastIndexOf('.')).toLowerCase()

  //Check extension to image types.
  
  return '<%=imageExts%>,'.indexOf(ext+',') >= 0
};

var lastfieldname = ''
var filenamechecked = ''
function preview(n) {
  //get current input preview
  var htmlfile = document.getElementById('Image '+n);
  var file = htmlfile.value

  //set the size field.
  var himg = document.getElementById('himg'+n);
  if (file.length>0) himg.src = 'file://' + file;
  else { 
    himg.src = ''; 
    document.getElementById('size'+n).innerHTML='-'
  };
  
  if (file.length<=0) return;

  //or get get preview for one of form field
  //var file = file_upload.SourceFile1.value
  var ipreview = document.getElementById('ipreview');
  
  //do not check the file more than one.
  if (filenamechecked != htmlfile.value) {
    filenamechecked = htmlfile.value
  } else {
    return true;
  };

  if (isImage(file)) {

    //Show preview for the image.
    ipreview.src = 'file://' + file
    //alert(file);
    //alert(ipreview.src);
    ipreview.title = 'Image ' + file 
    if (ipreview.width != 300) ipreview.width = 300;

    ImageName.innerHTML = 'Image preview<br>(' + htmlfile.name + ')'
  } else {
    //some default image for preview
    ipreview.src = 'res://shdoclc.dll/warning.gif'

    alert('Please choose some image file (<%=imageExts%>)');
    
  };
  
  lastfieldname = htmlfile.name
}

function himgLoaded(n){
  checkFileSize();
};


//this function gets a sizes of images,
//write the sizes to HTML form
//counts total size and checks file sizes against a limit
var maxFileSize = <%=maxFileSize%>
var FormSizeLimit = <%=Form.SizeLimit%>
function checkFileSize() {
  var totalSize = 0;
  var htmlSize;
  var overLimit = false;
  for (j = 1; j <= nfiles; j++) {
    var himg = document.getElementById('himg'+j);
    var size = document.getElementById('size'+j);
    var fileSize = himg.fileSize ;

    fileSize = parseInt(fileSize);
    
    if (fileSize < 0) {
      size.innerHTML = '-';
    } else {
      htmlSize = formatSize(fileSize);
      if ( fileSize>maxFileSize ) {
        htmlSize += ' (over limit, ' + formatSize(maxFileSize) + ' max)'
        size.style.color = 'red';
        overLimit = true;
      } else {
        size.style.color = '';
      };
      size.innerHTML = htmlSize;
      totalSize += fileSize;
    };//if (fileSize < 0) {
  };//for (j = 1; j <= nfiles; j++)


  var htotalSize = document.getElementById('totalSize');
  
  if (totalSize > 0){
    htmlSize = formatSize(totalSize);
  } else {
    htmlSize = '-';
  };
  if (totalSize > FormSizeLimit) {
    htotalSize.style.color = 'red';
    htmlSize += ' (over limit, ' + formatSize(FormSizeLimit) + ' max)'
    overLimit = true;
  } else {
    htmlSize += ' (of ' + formatSize(FormSizeLimit) + ' max)'
  };
  htotalSize.innerHTML = htmlSize
  return overLimit;
};

function formatSize(size) {
  if (size < 0x100000) {// < 1 MB
    return Math.round(size / 0x400)+"&nbsp;kB"; 
  } else { // > 1 MB
    return (Math.round((size / 0x100000)*10)/10)+"&nbsp;MB";
  }
}


//window.onerror = donotmsgboxes;
function donotmsgboxes(msg,url,line)
{  // we do not need error messages
  return true
}

</Script>


<br><br>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Huge ASP 
      file upload</A> -  Image upload, combine several upload features.&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>


<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demonstrates several Huge-ASP file upload features.
      <li><b>Client-side preview of images</b> - client-side JavaScript shows preview of an image when user choose some image. 
      Client can see images before upload
      <li><b>Client-side check of file extensions</b> - File extensions are checked before upload. If the extension is not in '<%=imageExts%>' list, client get a warning message.
      <li><b>Client-side check of file and form size</b> - the source form size and size of each file field is checked BEFORE the form is sent. So the client do not need to send the form to see if the size of files/upload is correct.
       <br>&nbsp;&nbsp;&nbsp;- Limit for whole form is set to <%=Form.SizeLimit%> Bytes
       <br>&nbsp;&nbsp;&nbsp;- Limit per file is set to <%=maxFileSize%> Bytes
      <li><b>Upload with progress bar</b> - This script shows progress bar immediatelly after 'Upload' click. Client can immediatelly see that upload starts and then can see progress of the upload. 
      <li><b>Server side checking for form and file size</b>
       <br>&nbsp;&nbsp;&nbsp;- Limit for whole form is set to <%=Form.SizeLimit%> Bytes
       <br>&nbsp;&nbsp;&nbsp;- Limit per file is set to <%=maxFileSize%> Bytes
      <li><b>Server side checking for file extensions and content-type</b> File extensions are checked AFTER upload once again (to handle situation when client-side script is off). If the extension is not in '<%=imageExts%>' list or content-type is not 'image/...', file is not stored on server-side
      <li><b>Server side checking of a file CONTENTS</b> <%=imageExts%> files have a special contents characteristics. This script also checks the CONTENTS of a file to be sure that the file is not an .exe renamed to .gif or .jpg. The file is stored ONLY if it is REALLY an image. (see IsImage function inside this source)
      <li><b>Save files with unique file names</b> - each correct image file is stored. If same old-file exists on server-side, new file with the same name is stored with unique file name (GetUniqueFileName function inside this script)
      <li><b>Store upload info to a database</b> - This script also stores info about upload and each uploaded file to a database
      <li><b>Send administrator email notification</b> - This script creates an HTML report about upload and the report is sent to administrator email.
       
      <br><br>Destination folder is <%=DestinationPath%>

      <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; See also:
      <li><A Href="default.htm">List of samples</A>
      <li><A Href="Upload-Progress.ASP">Base upload with progress bar</A>
      <li><A Href="Progress-Galery\Upload-ProgressGal.ASP">Progress bar gallery</A>
      <li><A Href="Upload-Images-FileSize-Unique-Notification.ASP">Upload images with preview, progress and checking</A>
      <li><A Href="Upload-Email.ASP">Upload to email</A>

      </P>
  </TD></TR></TABLE>


<HR COLOR=silver Size=1>
<CENTER>
<FONT SIZE=1>&copy; 1996 – <%=year(date)%> Antonin Foller, <a href="http://www.motobit.com">Motobit Software</a>, e-mail <A href="mailto:help@pstruh.cz" >help@pstruh.cz</A>
<br>To monitor current running uploads/downloads, see <A Href="http://www.motobit.com/help/iistrace/iis-monitor.asp">IISTracer - IIS real-time monitor</A>.
</FONT>

</CENTER>
</Div>
</BODY></HTML>
