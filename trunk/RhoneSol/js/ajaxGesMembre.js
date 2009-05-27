/**
 * Fonction qui retourne l'object XMLHttpRequest ou ActiveX selon le navigateur
 * @access public
 * @return XMLHttpRequest ou ActiveX
 **/
function getXhr(){
        var xhr = null;
        if(window.XMLHttpRequest){ // Firefox et autres
            xhr = new XMLHttpRequest();
        }else if(window.ActiveXObject){ // Internet Explorer
            try {
                xhr = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                xhr = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }else { // XMLHttpRequest non supporté par le navigateur
            alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest...");
            xhr = false;
        }
        return xhr;

		var xhr_object = null;

}

/**
 * fonction qui permet de modifier l'accés au panel d'administration d'un membre
 * @access public
 * @return void
 **/
function ajaxAccesAdmin(idMembre){
 var msg="Voulez-vous vraiment autoriser ce membre à avoir accés au panel d'administration? ";
 if (confirm(msg)) {
  var xhr = getXhr();
	// On défini ce qu'on va faire quand on aura la réponse
    xhr.onreadystatechange = function(){
	    // On ne fait quelque chose que si on a tout reçu et que le
	    //serveur est ok
	    if(xhr.readyState == 4 && xhr.status == 200){

			location.href="gesmembre.asp";
	    }
    }

    // On envoie l'id du membre en POST car il s'agit d'une donnée sensible
    xhr.open("POST","ajaxModifieAccesAdmin.asp",true);
    xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');


    xhr.send("idMembre="+idMembre);

 }

}