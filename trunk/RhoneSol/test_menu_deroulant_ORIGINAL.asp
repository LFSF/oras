
<ul id="menuDeroulant" >
 <%
'vÃ©rification particulier ou organisme
Set rsEDverifstat = Conn.Execute("SELECT * FROM Membre where NumMembre=" & session("admin_id"))
if rsEDverifstat("Entreprise")=1 then
%>
 <li>
 <a href="p_profil_org.asp">Mon profil</a>
 </li>
<% else %>
<li>
 <a href="p_profil_part.asp">Mon profil</a></li>
<% end if
   set rsEDverifstat=nothing 
%>  
 

 
 
 <% if (session("admin_acces_admin")= 1 or session("acces_itw")= 1) then %>
 <li>
 <a href="#">Interview</a>
    <ul class="sousMenu"> 
		<li><a href="p_admin_interview_insert.asp">Insertion</a></li>
		<li><a href="p_admin_interview_modif.asp">Modifier</a></li>
		<li><a href="p_admin_interview_visualisation.asp">Visualiser</a></li>
		<li><a href="p_admin_interview_modif_ajout_images.asp">Ajouter les images</a></li>
    </ul>
 </li>
 <%end if %>

 <% if (session("admin_acces_admin")= 1 or session("acces_actu")= 1) then %>
 <li>
 <a href="#"><% =HTMLDecode("Actualité") %></a>
  	<ul class="sousMenu">
   		<li><a href="p_admin_actu_insert.asp">Insertion nouvelle Actu</a></li>
   		<li><a href="p_admin_actu_modif.asp">Modifier une Actu</a></li>
   		<li><a href="p_admin_actu_visualisation.asp">Visualiser une Actu</a></li>
   </ul>
 </li>
 <%end if %>
 
<% if (session("admin_acces_admin") = 1 or session("acces_cv") = 1)then %> 
<li>
 <a href="#">Offre</a>
  	<ul class="sousMenu">
   		<li><a href="p_admin_cv_validation.asp">CV</a></li>
   		<li><a href="p_admin_offre_validation.asp"><% =HTMLDecode("Offres stage-emploi-bénévolat") %></a></li>
    </ul>
</li><%end if %>

<li>
 <a href="#">Gestion</a>
  	<ul class="sousMenu">
   		<li><a href="#">Voir login</a></li>
		<li><a href="p_admin_demande_site_validation.asp"><% =HTMLDecode(" Dernières demandes de créer web") %></a></li>
		<li><a href="p_admin_demande_site_visualisation.asp"><% =HTMLDecode(" Visualiser demandes de créer web") %></a></li>
   		<li><a href="p_admin_adhesion_validation.asp"><% =HTMLDecode("Adhésions") %></a></li>
   		<li><a href="p_admin_idees_validation.asp"><% =HTMLDecode("Valider idées suggestions") %></a></li>
		
		<% if (session("admin_acces_admin")= 1 or session("acces_id")= 1 ) then %>
		<li><a href="p_admin_idees_visualisation.asp"><% =HTMLDecode("Visualiser idées suggestions") %></a></li>
		<%end if %>

		
		<% if (session("admin_acces_admin")= 1 ) then %><li><a href="p_admin_adhesion_message_validation.asp"><% =HTMLDecode("Messages adhésions") %></a></li><%end if %> 
   </ul>
 </li>
 
 <% if (session("admin_acces_admin")= 1 ) then %><li>
 <a href="p_profil_org.asp">Suppressions</a>
 </li>
 <%end if %>
 
 <% if (session("admin_acces_admin")= 1 or session("acces_news")= 1)  then %>
 <li>
 <a href="p_profil_org.asp">News</a>
 </li>
 <%end if %>
 
</ul>
</div>