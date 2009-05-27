<!-- #include file="connexion.asp"-->
<%


Set rsED = Conn.Execute("SELECT * FROM ACTUALITE where Visible=1 ORDER BY DateActu DESC")


%>
<script language="Javascript">
ejs_scroll_largeur = 170;
ejs_scroll_hauteur = 50;
/* Temps en secondes */
ejs_scroll_pause_seconde = 5;

ejs_scroll_message = new Array;

<%if not rsED.EOF Then%>
    ejs_scroll_message[0]='<a class="ejs_scroll" href="p_actualitesbis.asp?num=<%=rsED("NumActu")%>"><span class="date_boite"><%=mid(rsED("DateActu"),4,8)%></span> - <%=Server.HTMLEncode(rsED("TitreActu"))%></a>';
    <%rsED.MoveNext
    if not rsED.EOF Then%>
        ejs_scroll_message[1]='<a class="ejs_scroll" href="p_actualitesbis.asp?num=<%=rsED("NumActu")%>"><span class="date_boite"><%=mid(rsED("DateActu"),4,8)%></span> - <%=Server.HTMLEncode(rsED("TitreActu"))%></a>';
        <%rsED.MoveNext
        if not rsED.EOF Then%>
            ejs_scroll_message[2]='<a class="ejs_scroll" href="p_actualitesbis.asp?num=<%=rsED("NumActu")%>"><span class="date_boite"><%=mid(rsED("DateActu"),4,8)%></span> - <%=Server.HTMLEncode(rsED("TitreActu"))%></a>';
            <%rsED.MoveNext
            if not rsED.EOF Then%>
                ejs_scroll_message[3]='<a class="ejs_scroll" href="p_actualitesbis.asp?num=<%=rsED("NumActu")%>"><span class="date_boite"><%=mid(rsED("DateActu"),4,8)%></span> - <%=Server.HTMLEncode(rsED("TitreActu"))%></a>';
            <%End if
        End if
    End if
Else%>
    ejs_scroll_message[0]="Il n'y a aucune actu pour le moment"
<%
End if
%>


function d(texte)
    {
    document.write(texte);
    }

d('<div id="ejs_scroll_relativ"  style="position:relative;width:'+(ejs_scroll_largeur)+'px;vertical-align:middle;height:'+(ejs_scroll_hauteur)+'px"><font size="1">');
d('<div id="ejs_scroll_cadre"  style="overflow:hidden;position:absolute;width:'+(ejs_scroll_largeur)+'px;vertical-align:middle;height:'+(ejs_scroll_hauteur)+'px;top:0;left:0;clip:rect(0 '+(ejs_scroll_largeur)+' '+(ejs_scroll_hauteur)+' 0)">');
d('<div id="ejs_scroller_1"  style="position:absolute;width:'+(ejs_scroll_largeur)+'px;vertical-align:middle;left:0; top:10px;" class="ejs_scroll">'+ejs_scroll_message[0]+'</div>');
d('<div id="ejs_scroller_2" style="position:absolute;width:'+(ejs_scroll_largeur)+'px;vertical-align:middle;left:0; top:'+(ejs_scroll_hauteur)+'px;" class="ejs_scroll">'+ejs_scroll_message[1]+'</div>');
d('</div></font></div>');

ejs_scroll_mode =1;
ejs_scroll_actuel = 0;

function ejs_scroll_start()
    {
    //alert("pwet");
    if(ejs_scroll_mode == 1)
        {
        ejs_scroller_haut = "ejs_scroller_1";
        ejs_scroller_bas = "ejs_scroller_2";
        ejs_scroll_mode = 0;
        }
    else
        {
        ejs_scroller_bas = "ejs_scroller_1";
        ejs_scroller_haut = "ejs_scroller_2";
        ejs_scroll_mode = 1;
        }
    ejs_scroll_nb_message = ejs_scroll_message.length-1;
    if(ejs_scroll_actuel == ejs_scroll_nb_message)
        ejs_scroll_suivant = 0;
    else
        ejs_scroll_suivant = ejs_scroll_actuel+1;
    if(document.getElementById)
        document.getElementById(ejs_scroller_bas).innerHTML = ejs_scroll_message[ejs_scroll_suivant];
    ejs_scroll_top = 10;
    if(document.getElementById)
        setTimeout("ejs_scroll_action()",ejs_scroll_pause_seconde*1000)
    }

function ejs_scroll_action()
    {
    ejs_scroll_top -= 1;
    document.getElementById(ejs_scroller_haut).style.top = ejs_scroll_top+'px';
    document.getElementById(ejs_scroller_bas).style.top = ejs_scroll_top+ejs_scroll_hauteur+'px';
    if((ejs_scroll_top+ejs_scroll_hauteur) > 10)
        setTimeout("ejs_scroll_action()",10)
    else
        ejs_scroll_stop()
    }

function ejs_scroll_stop()
    {
    ejs_scroll_actuel = ejs_scroll_suivant;
    ejs_scroll_start()
    }

window.onload = ejs_scroll_start;

</script>

