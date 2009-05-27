<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<script>
function montrer1(mondiv1)
{
	document.getElementById(mondiv1).style.visibility = 'visible';
}

function montrer2(mondiv2)
{
	document.getElementById(mondiv2).style.visibility = 'visible';
}

function cacher1(mondiv1)
{
	document.getElementById(mondiv1).style.visibility = 'hidden';
}

function cacher2(mondiv2)
{
	document.getElementById(mondiv2).style.visibility = 'hidden';
}

</script>


<link href="styles.css" rel="stylesheet" type="text/css" />

</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">REJOIGNEZ NOUS!</div>

<table border="0px" width="100%" cellpadding="10px">
	<tr>
		<td colspan="2">
			<font color="#6FAA06">
				Adhésion____________________________________________________________________
			</font>
		</td>
	</tr>
</table>
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

	<p id="mondiv1" style="visibility:hidden;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/particulier.png" style="position: absolute; top:34%;" ></img></p>


	<p id="mondiv2" style="visibility:hidden;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/Organisme.png" style="position: absolute; top:34%; " ></img></p>


<!--<div style="width:160px ;padding: 10px ;color: #000000; margin-left:auto; margin-right:auto; font-size:14px; border : 1px solid #6FAA06;">
	-->
	<div style="float:left; padding: 5px ; font-size:14px; border:1px solid #6FAA06; margin-left:38%; margin-right: -14%; width:12%; text-align: center;">

<a onMouseOver="montrer1('mondiv1')" onMouseOut="cacher1('mondiv1')" href="http://www.rhone-solidarite.com/p_adhesionP.asp">Particulier</a></div><div style="float:left; padding: 5px ;font-size:14px; border:1px solid #6FAA06; margin-left: 15%; margin-right: auto; width: 12%; text-align: center;">
<a onMouseOver="montrer2('mondiv2')" onMouseOut="cacher2('mondiv2')" href="http://www.rhone-solidarite.com/p_adhesionO.asp">Organisme</a></div>


<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br />

<!-- Ne pas toucher à ce qui suit : placement du footer -->
<!-- #include file="grand_footer.txt"-->  


</body>
</html>