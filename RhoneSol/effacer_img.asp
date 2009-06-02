<%
Function File_Exist(PathName)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   If (fso.FileExists(PathName)) Then
      File_Exist = true
   Else
      File_Exist = false
   End If
   Set fso = Nothing
End Function

Function File_Delete(PathName)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   If (fso.FileExists(PathName)) Then
      Set MyFile = fso.GetFile(PathName)
      If (MyFile.attributes and (1 or 16 or 1024 or 2048)) Then
         File_Delete = 0
      Else
         MyFile.Delete
         File_Delete = 2
      End If
      Set MyFile = Nothing
   Else
      File_Delete=0
   End If
   Set fso = nothing   
End Function

Function URLDecode(sConvert)
    Dim aSplit
    Dim sOutput
    Dim I
    If IsNull(sConvert) Then
       URLDecode = ""
       Exit Function
    End If
	
    ' convert all pluses to spaces
    sOutput = REPLACE(sConvert, "+", " ")
	
    ' next convert %hexdigits to the character
    aSplit = Split(sOutput, "%")
	
    If IsArray(aSplit) Then
      sOutput = aSplit(0)
      For I = 0 to UBound(aSplit) - 1
        sOutput = sOutput & _
          Chr("&H" & Left(aSplit(i + 1), 2)) &_
          Right(aSplit(i + 1), Len(aSplit(i + 1)) - 2)
      Next
    End If
	
    URLDecode = sOutput
End Function	

Dim msg,path
retour=0
path=Request.QueryString("path")

if(path<>"") then
	
	retour=File_Delete(path)
	Response.Write path&" "&retour
else
	Response.Redirect("p_list_image.asp?retour="&retour)
end if 

Response.Redirect("p_list_image.asp?retour="&retour)


%>