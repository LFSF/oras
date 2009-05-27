<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Oras - Organisation des Réseaux Solidaires</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_nbGroup(event, grpName) { //v6.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) {
      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}
//-->
</script>
</head>

<body onload="MM_preloadImages('img/img_r2_c4bis.jpg','img/img_r2_c6bis.jpg','img/img_r2_c7bis.jpg','img/img_r2_c8bis.jpg','img/img_r2_c3bis.jpg')">

<div id="conteneur">





	<div id="header">
    
    	<div id="haut_logo">
        </div>
        
        <div id="haut_menu">
        </div>
        
        <div id="menu">
       	  <table border="0" cellpadding="0" cellspacing="0">
        	  <tr>
        	    <td><a href="index.php" target="_top" onclick="MM_nbGroup('down','group1','accueil','',1)" onmouseover="MM_nbGroup('over','accueil','img/img_r2_c3bis.jpg','',1)" onmouseout="MM_nbGroup('out')"><img src="img/img_r2_c3.jpg" alt="image" name="accueil" border="0" id="accueil" /></a></td>
        	    <td><a href="objectifs.php" target="_top" onclick="MM_nbGroup('down','group1','objectifs','',1)" onmouseover="MM_nbGroup('over','objectifs','img/img_r2_c4bis.jpg','',1)" onmouseout="MM_nbGroup('out')"><img src="img/img_r2_c4.jpg" alt="image" name="objectifs" width="110" height="38" border="0" id="objectifs" /></a></td>
        	    <td><a href="javascript:;" target="_top" onclick="MM_nbGroup('down','group1','missions','',1)" onmouseover="MM_nbGroup('over','missions','','',1)" onmouseout="MM_nbGroup('out')"><img src="img/img_r2_c5bis.jpg" alt="image" name="missions" border="0" id="missions" /></a></td>
        	    <td><a href="actus.php" target="_top" onclick="MM_nbGroup('down','group1','actus','',1)" onmouseover="MM_nbGroup('over','actus','img/img_r2_c6bis.jpg','',1)" onmouseout="MM_nbGroup('out')"><img src="img/img_r2_c6.jpg" alt="image" name="actus" width="120" height="38" border="0" id="actus" /></a></td>
        	    <td><a href="partenariat.php" target="_top" onclick="MM_nbGroup('down','group1','partenariat','',1)" onmouseover="MM_nbGroup('over','partenariat','img/img_r2_c7bis.jpg','',1)" onmouseout="MM_nbGroup('out')"><img src="img/img_r2_c7.jpg" alt="image" name="partenariat" width="100" height="38" border="0" id="partenariat" /></a></td>
        	    <td><a href="contact.php" target="_top" onclick="MM_nbGroup('down','group1','contact','',1)" onmouseover="MM_nbGroup('over','contact','img/img_r2_c8bis.jpg','',1)" onmouseout="MM_nbGroup('out')"><img src="img/img_r2_c8.jpg" alt="image" name="contact" width="100" height="38" border="0" id="contact" /></a></td>
                <td><img src="img/img_r2_c9.jpg" alt="image" /></td>
      	    </tr>
      	  </table>
        </div>
        
	</div>














    
	<div id="intro">
    
    	<div id="intro_contenu" align="justify">
        	<table border="0" cellspacing="5px">
            	<tr>
                	<td><img src="img/intro/solidarite.jpg" alt="image" /></td>
                    <td><img src="img/intro/oras.jpg" alt="image" /><br />La solidarité  inspire les échanges culturels et économiques entre les peuples. Elle est une composante du développement durable et le fondement de nos structures.</td>
				</tr>
			</table>
        </div>
        
  </div>














    
	<div id="bloc_gauche">
    
        	<? include ("bloc_gauche.html"); ?>
    
    </div>














    
	<div id="etiquettes">
    
        	<img src="img/etiquettes/missions.gif" alt="image" />
    
    </div>
    
    <div id="contenu_global">
    
    	<div id="contenu" align="justify">
        
        	<h1>Formation bureautique - Février 2008</h1>
    
    		<p><img src="img/news/exemple_1.jpg" alt="image" class="news_image_gauche" />Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>

<p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>

			<p>&nbsp;</p>

			<h1>Formation bureautique - Février 2008</h1>
    
    		<p><img src="img/news/exemple_1.jpg" alt="image" class="news_image_droite" />Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>

<p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>
    	</div>
    
    </div>















       
    <div id="footer" align="center">
    	<? include ("footer.html"); ?>
    </div>

</div>
</body>
</html>