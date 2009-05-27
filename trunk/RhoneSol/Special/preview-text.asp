<%
..... ASP handling code
%>
<form name="file_upload" method="POST" ENCTYPE="multipart/form-data">
<br><input Name=SourceFile1 Type=File onchange=preview(this)>
<br><input Name=SourceFile2 Type=File onchange=preview(this)>

</Form>
Text preview:<br>
<IFrame ID=ipreview width=600 height=400></IFrame>

<Script>
//Huge-asp upload preview sample
//http://www.motobit.com

function preview(i) {
	//get current input preview
	var file = i.value

	//or get get preview for one of form field
  //var file = file_upload.SourceFile1.value

	//Get a file extension
	var ext = file.substr(file.lastIndexOf('.')).toLowerCase()

	//Check extension to text/html
	var isImage = '.htm,.html,.txt,.ini,.xml,.....'.indexOf(ext+',') >= 0

	if (isImage) {
		//Show preview for the image.
		ipreview.src = 'file://' + file
	} else {
		//some default image for preview
		ipreview.src = 'res://shdoclc.dll/warning.gif'
	};
}

//window.onerror = donotmsgboxes;
function donotmsgboxes(msg,url,line)
{	// we do not need error messages
	return true
}

</Script>
