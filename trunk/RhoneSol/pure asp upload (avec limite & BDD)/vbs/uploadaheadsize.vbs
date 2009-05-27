  Dim WebServer, UploadReadAheadSize
'  Set WebServer = GetObject("IIS://localhost/W3SVC[/sitenum[/folder[/uploadscript.asp]]]")
  Set WebServer = GetObject("IIS://localhost/W3SVC/1/upload")
  
  'Get UploadReadAheadSize property
  UploadReadAheadSize = WebServer.UploadReadAheadSize
  wscript.echo UploadReadAheadSize
  
  'Set another size
  WebServer.UploadReadAheadSize = 0
  wscript.echo WebServer.UploadReadAheadSize

  WebServer.SetInfo 
