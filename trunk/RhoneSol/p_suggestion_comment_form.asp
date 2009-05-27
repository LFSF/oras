<script>
function go()
{
if (document.form.name.value == '')
{
alert('Please, Fill in you name');
return false;
}
else
return true;
}

</script>

<form name="form" id="form" method="post" action="p_suggestion_addComment.asp">
  <table width="100%" border="0" cellspacing="0" cellpadding="5">
    <tr valign="top"> 
      <td>Nom:</td>
      <td> 
        <input type="text" name="name"></td>
  </tr>
    <tr valign="top"> 
      <td>E-mail:</td>
      <td> 
        <input type="text" name="mail"></td>
  </tr>
    <tr valign="top"> 
      <td>E-mail:</td>
      <td> 
        <input type="text" name="url" value="http://"></td>
  </tr>
    <tr valign="top"> 
      <td>Votre commentaire:</td>
      <td> 
        <textarea name="comment" cols="40" rows="6"></textarea></td>
  </tr>
    <tr valign="top"> 
      <td>&nbsp;</td>
      <td>
	  	<input name="date" type="hidden" value="<% Response.write date & " " & hour(time) & ":" & minute(time) & ":" & second(time) %>">
	  	<input name="blogID" type="hidden" value="<% Response.Write "" & Cint(Request.QueryString("id")) %>">
		<!-- <input name="catID" type="hidden" value="<'%=rsCat("cat_id")%>">-->
        <input type="submit" name="Submit" value="Valider" class="searchSubmit" onclick="return go();"></td>
  </tr>
</table>
</form>