<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-1.3.2.js"></script>
<script type="text/javascript">
function verif(){
   var msg="";
   var len=document.getElementById("poste").value.length;
   var len2=document.getElementById("nomCV").value.length;

   if ((len<3 && len>0) || (len2<3 && len2>0)){
        msg+="Veuillez entrer un mot de longueur superieur a 3.";
   }

   if (msg!=""){
          alert(msg);
          return(false);
   }else{
          return(true);
   }


}
</script>
<style type="text/css">
@import 'test.css';
</style>
<script type="text/javascript" src="js/jquery-1.2.1.pack.js"></script>
<script type="text/javascript" src="js/jquery.pager_home.js"></script>

<script type="text/javascript" src="js/jquery.accordion.pack.js"></script>
<script type="text/javascript" src="js/jquery.bgiframe.pack.js"></script>
<script type="text/javascript" src="js/jquery.tabs.pack.js"></script>
<script type="text/javascript">

//<![CDATA[
var init = {
  menu: function(){
    if( (!$.browser.version <= 6 && !$.browser.msie) || ($.browser.version > 6 && $.browser.msie) ){ // not IE6
      $("#dropMenu li.sub ul").each(function(){
      $(this).css('width', $(this).parents("ul").width()-90 + 'px');
    });
  }
},
pager: function(){
  $("#pager").pager("div");
  $("#pager").css("visibility","visible");
},  
carousel: function(){
  $("#carousel").pagedCarousel("#carouselPaging", '4', 'http://www.letudiant.fr/file/resources/etu/front/img/', { scroll: 1, animation: 'slow'});
  $("#carousel").css("visibility","visible");
},
height: function(){
  compareheight('.newsBlock');
  compareheight('.greyTable .Block');
},
newsticker: function(){
  $('#newsticker a').Tooltip({
    delay: 0,
    showURL: false,
    track: true
});
$("#newsticker").newsticker();
},
accordion: function(){
  $(".accordion").each(function(){
    $(this).Accordion({selectedClass:'AccActive'});
    //$("div:first", this).show();
});
},
others: function(){
$("#footerMain .links li").eq(0).css('background', 'none');  
// Closing block, using AJAX to get response from script which will rememeber the block closed
$("#closeElementsContainer").bind("click", function(){ 
$(".ElementsContainer").hide(460);
setTimeout(function(){
$("#closeElementsContainer").parent().hide(300);
}, 100);
var html = $.ajax({url: 'somewhere/user.php?SESSID=', async: false}).responseText;
return false;
});
// Hides elements of map
$("#Map .Background .ter").animate({ opacity: 'hide' }, 50);
// Defining the teritory of map to show as first
initMap();
}
};
jQuery(function($) {
init.menu();
init.pager();
init.accordion();
init.others();
$(".image-gallery a").click(function() {
var newsource = $(this).attr('href');
var newComment = $(this).attr('comment');
if($("#imageShowcast .Image").attr('src') != 'img/icon_dot.gif') {
$("#imageShowcast").animate({ opacity: 'hide' }, 350);  
setTimeout(function(){
$("#imageShowcast .Image").attr('src', newsource);
$("#imageShowcast .ImgSalonComment").html(newComment);
$("#imageShowcast").animate({ opacity: 'show' }, 410);  
}, 410);
} else {
$("#imageShowcast .Image").attr('src', $(this).attr('href'));
$("#imageShowcast").animate({ opacity: 'show' }, 410);  
}  
return false;
});
$("#imageShowcast a").click(function() {
$("#imageShowcast").animate({ opacity: 'hide' }, 460);  
return false;
});
});
$(document).ready(function(){
SmartMoveEndPageDivs();
init.newsticker();
$('.articleBottom .nav a, ul.toolsWithTips li a, .image-gallery a').Tooltip({
delay: 0,
showURL: false,
track: true
});
if ($("#pub_ist_layer:visible")) {
$('#pub_ist_layer').bgiframe();
}
$("acronym").each(function(i){
$(this).css("text-decoration","underline");
$(this).css("color","#CC0000");
$(this).css("cursor","help");
});
});
//]]> 
</script>
</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_orange">Annonces</div>

<!--
<div id="post-it"><b><i>Sommaire</i></b><br />
_________________________________________________________<br /><br />

   ><em onclick="return fonc1()" onMouseOver="this.style.cursor='hand'; "> Historique</em><br />
   > <em onclick="return fonc2()" onMouseOver="this.style.cursor='hand'; ">Définition et principe</em><br />
   > <em onclick="return fonc3()" onMouseOver="this.style.cursor='hand'; ">Cadre législatif et réglementaire</em><br />
   > <em onclick="return fonc4()" onMouseOver="this.style.cursor='hand'; ">OÃ¹ trouver des financements ?</em><br /></div>
-->
<table border="0px" width="100%" cellpadding="10px">
    
    
    
    <tr>
        <td colspan="2"><font color="#6faa06">Annonces____________________________________________________________________</font></td>
    </tr>
    
    </table>
    
    
    <table>
    <tr>
        <td width="50%">

        
        
       <!-- <img src="img/img_a_exploiter/img_www.jpg">  -->

          <div style="position: static;" class="accordion">
              <h4 class="any"></h4>
              <div style="display: none;" id="contentJob"></div>
              <h4 class="any"><img src="img/menu/bouton_orange.gif" />  Consulter emplois/stages</h4>
              <div style="display: none;" id="contentJob">
                <form action="pa_rech_emploi_stage.asp" method="post" enctype="application/x-www-form-urlencoded" onsubmit="return verif();">
                      <fieldset>
                            <a  style="font-weight:bold;color:orange;text-decoration:underline;font-size:15px" href="pa_consulter_emploi_stage.asp" title="Consulter" style="color:black;">+ Consulter toutes les offres</a><br />
                            <br />
                            <table>
                                <tr>
                                    <td  colspan="2" align="left">Chercher un emploi ou un stage:</td>
                                </tr>
                                <tr>
                                     <td><% =Server.HtmlEncode("Mots clés: ")%></td><td><input type="text" name="poste" id="poste"/></td>
                                </tr>
                                <tr>
                                     <td>Type:</td>
                                    <td>
                                        <select id="type_contrat" name="type_contrat">
                                            <option value="">Consulter toutes les types d'offres</option>
                                            <option value="1">Seulement les offres d'emplois</option>
                                            <option value="2">Seulement les offres de stages</option>
                                            <option value="3"><% =Server.HtmlEncode("Seulement le bénévolat")%></option>
                                            <option value="4">Seulement les autres offres</option>

                                        </select>
                                    </td> 
                                 </tr>
                                 <tr>
                                       <td>Lieu: </td>
                                      <td>
                                      <select id="lieu_du_poste" name="lieu_du_poste">
                                      <%
                                                 Dim lesRegions()
                                                 taille=1

                                                 Set rs = Conn.Execute("SELECT * FROM REGIONS;")

                                                 While not rs.EOF
                                                        redim preserve lesRegions(taille)
                                                        taille=taille+1
                                                        lesRegions(taille-1)=rs("nomRegion")
                                                        

                                                 Rs.MoveNext
                                                 Wend

                                                 rs.Close

                                                 Response.Write "<option value="""" selected>"&Server.HtmlEncode("France entière")&"</option>"
                                                 
                                                 for i=1 to UBound(lesRegions)
                                                        Response.Write "<option value="""&i&""">"&Server.HtmlEncode(lesRegions(i))&"</option>"
                                                 Next

                                      %>
                                      </select>
                                      </td> 
                                 </tr>
                                 <tr>
                                     <td align="left"><% =Server.HtmlEncode("Durées: ")%></td>
                                     <td>
                                      <select id="duree_esperee" name="duree_esperee">
                                          <option value="" selected ><%=Server.HtmlEncode("Toutes les durées")%></option>
                                          <option value="C.D.I" >C.D.I</option>
                                          <option value="15 jours" >15 jours</option>
                                          <option value="1 mois">1 mois</option>
                                          <option value="2 mois">2 mois</option>
                                          <option value="3 mois">3 mois</option>
                                          <option value="4 mois">4 mois</option>
                                          <option value="5 mois">5 mois</option>
                                          <option value="6 mois">6 mois</option>
                                          <option value="9 mois">9 mois</option>
                                          <option value="1 an et +">1 an et +</option>
                                      </select>
                                      </td>
                                 </tr>

                                 <tr ><td colspan="2"><input type="reset" value="Effacer" /><input type="submit" value="Chercher" /></td></tr>
                               </table>
                          </fieldset>
                      </form>
                </div>
               <h4 class="any"><img src="img/menu/bouton_orange.gif" />  <a href="p_proposer.asp" title="Proposer un emploi">  Proposer un emploi/stage</a></h4>
               <h4 class="any"><img src="img/menu/bouton_orange.gif" />  Consulter les CVs</h4>
               <div style="display: none;" id="contentJob"> <!-- pa_consulter_cv.asp -->
                 <form enctype="application/x-www-form-urlencoded" action="pa_rech_cv.asp" method="post" onsubmit="return verif();">
                        <fieldset>
                                  <a style="font-weight:bold;color:orange;text-decoration:underline;font-size:15px" href="pa_consulter_cv.asp" title="Deposer un CV" style="color:black;">+ Consulter tous les Cvs</a><br />
                                  <br />
                                  <table>
                                     <tr>
                                      <td colspan="2" align="left">Chercher un cv: </td>
                                    </tr>
                                    <tr> 
                                        <td colspan="2">
                                             <input name="profil" type="radio" value="1" checked>Emploi&nbsp;
                                             <input type="radio" name="profil" value="2">Stage&nbsp;
                                             <input type="radio" name="profil" value="3">Autre&nbsp;
                                        </td>
                                    </tr> 
                                    <tr>
                                       <td><% =Server.HtmlEncode("Mots clés: ")%> </td><td><input type="text" name="nomCV" id="nomCV" /></td>
                                    </tr>
                                    <tr>
                                         <td>Niveau de formation: </td>
                                        <td>
                                            <select name="niveau_formation">
                            
                                                <option value="bac+1">Bac+1</option>
                                                <option value="bac+2" selected>Bac+2</option>
                                                <option value="bac+3">Bac+3</option>
                                                <option value="bac+4">Bac+4</option>
                                                <option value="bac+5_sup">Bac+5 ou sup</option>
                                                <option value="autres">Autres</option>
                                            </select>
                                        </td> 
                                    </tr>
                                    <tr>
                                       <td align="left"><% =Server.HtmlEncode("Durées: ")%></td>
                                       <td>
                                        <select id="duree_esperee" name="duree_esperee">
                                            <option value="" selected ><%=Server.HtmlEncode("Toutes les durées")%></option>
                                            <option value="1000" >C.D.I</option>
                                            <option value="15" >15 jours</option>
                                            <option value="30">1 mois</option>
                                            <option value="60">2 mois</option>
                                            <option value="90">3 mois</option>
                                            <option value="120">4 mois</option>
                                            <option value="150">5 mois</option>
                                            <option value="180">6 mois</option>
                                            <option value="270">9 mois</option>
                                            <option value="360">1 an et +</option>
                                        </select>
                                        </td>

                                    </tr>
                                    <tr>
                                       <td>Lieu: </td>
                                      <td>
                                      <select id="lieu_du_poste" name="lieu_du_poste">
                                      <%

                                                 Response.Write "<option value="""" selected>"&Server.HtmlEncode("France entière")&"</option>"
                                                 
                                                 for i=1 to UBound(lesRegions)
                                                        Response.Write "<option value="""&i&""">"&Server.HtmlEncode(lesRegions(i))&"</option>"
                                                 Next

                                      %>
                                      </select>
                                      </td>
                                    </tr>
                                    <tr>
                                      <td colspan="2"><input type="reset" value="Effacer"/>  <input type="submit" value="Chercher" /></td>
                                    </tr>
                                  </table>
                        </fieldset>
                    </form>
                    </div>
                    <h4 class="any"><img src="img/menu/bouton_orange.gif" /><a href="p_deposer.asp" title="Deposer un CV">  <%= Server.HtmlEncode("Déposer un CV")%></a></h4>

                </div>


               <!-- <table valign="top" align="center" width="300" border="0" cellpadding="3" cellspacing="0" class="txt">
                         
                         <tr class="styl">
                          <td><input name="profil" type="radio" value="6" checked></td>
                          <td>Consulter lespetites annonces&nbsp; </td><br/>
                         </tr>
                         
                         <tr class="styl">
                          <td><input name="profil" type="radio" value="5"></td>
                          <td>Déposer une petite annonce&nbsp; </td><br/>
                         </tr>

                         <tr class="styl"> 
                          <td> <input name="profil" type="radio" value="1" checked="checked"></td>
                          <td>Consulter les emplois/stages </td><br/>
                         </tr>
                                                 <tr class="styl">
                          <td><input name="profil" type="radio" value="2"></td>
                          <td>Proposer un emploi/stage&nbsp; </td><br/>
                         </tr>
                        
                        <tr class="styl">
                          <td><input type="radio" name="profil" value="4"></td>
                          <td>Consulter les CV&nbsp; </td>
                          </tr>
                        
                         <tr class="styl">
                          <td> <input name="profil" type="radio" value="3"></td>
                          <td>Déposer un CV&nbsp; </td><br/>
                          </tr>
                          
                          
                           
                          
                          
                          <br/>
                          <tr>
                    <td align="center" colspan="2" class="styl">
                      <input name="valider" type="submit" value="Valider" id="valider" width="109" height="16" border="0">
                    </td>
                  </tr>
               </table>
             </form></p>
        </td>       
        
    </tr>
    
  <br/>  <br/>  <br/>  <br/>  <br/>  <br/>  <br/>  <br/>  <br/>  <br/>
</table>
-->
 
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>


<!-- Ne pas toucher Ã  ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->
</html>