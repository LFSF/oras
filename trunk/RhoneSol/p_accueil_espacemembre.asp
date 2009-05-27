<%
    if session("admin_nom")<>"" then
        Response.Write "<b>Bonjour "&session("admin_nom")&"</b><br/>"
        Response.Write "<a href='deconnect.asp' title='Se deconnecter' >"&Server.HtmlEncode("Se déconnecter")&"</a>"
    else
%>
        <form action="p_membres.asp" method="post">
          Login:<br/>
          <input type="text" name="loga" class="txt" id="loga"  maxlength="100" /><br/>
          Mot de passe: <br/>
          <input type="password" name="password" class="txt" id="password" maxlength="30"  />
          <input type="hidden" name="test" value="oui" /><br/> <a align="center"><a href="p_adhesion.asp"> S'inscrire </a><br/>
          <div class="buttons">
                <button type="reset" class="negative"><img src="./img/menu/bouton_rouge.gif" alt="Effacer" />Effacer</button>
                <button type="submit" class="positive"><img src="./img/menu/bouton_vert.gif" alt="Valider" />Ok</button>       
          </div>
        </form>
<%
    end if
%>