/*
 *  Auteur : Daynos <devjs@daynos.net> 
 *  
 *  Class Onglet - version 0.1.20070703
 *  
 *  /!\/!\/!\/!\/!\/!\/!\/!\/!\
 *  REQUIERT LE FRAMEWORK JAVASCRIPT "PROTOTYPE"
 *  Prototype JavaScript framework, version 1.5.1.1
 *  (c) 2005-2007 Sam Stephenson
 *  http://www.prototypejs.org/
 *  /!\/!\/!\/!\/!\/!\/!\/!\/!\
*/


Onglet = Class.create ();
Onglet.prototype = {
	Version				: '0.2.20070723',
	element				: null,				/* calque attribué au gestionnaire d'onglet */
	
	initialize: function (element, cssId){
		this.element = $(element);
		Object.extend (this.element, __OngletElement);
		this.element.initialize (cssId);
	},
	
	// Ajouter un onglet de type TEXTE : charge du texte dans le div
	addOngletTexte: function (titre, contenu) {
		return this.element.addOnglet (0, titre, contenu);
	},

	// Ajouter un onglet de type HTML : charge du code html dans le div
	addOngletHtml: function (titre, contenu) {
		return this.element.addOnglet (1, titre, contenu);
	},

	// Ajouter un onglet de type URL : charge une page html dans une iframe
	addOngletUrl: function (titre, contenu) {
		return this.element.addOnglet (2, titre, contenu);
	},
	
	// Ajouter un onglet de type AJAX : charge une contenu dynamique dans le div
	addOngletAjax: function (titre, contenu) {
		return this.element.addOnglet (3, titre, contenu);
	},
	
	// Ajouter un onglet de type CALQUE : récupère le contenu d'un div existant et le place dans un onglet
	addOngletCalque: function (titre, contenu) {
		return this.element.addOnglet (4, titre, contenu);
	},
	
	// Affiche l'onglet n°...
	setFocus: function (n) {
		this.element.setFocus (n);
	}
}

__OngletElement = {
	oMenu				: null,				/* calque contenant les boutons du menu */
	oConteneur			: null,				/* calque contenant les contenus des onglets */
	nOnglets			: 0,				/* nombre d'onglets liés */
	cssId				: null,				/* préfixe des css à utiliser */

	initialize: function (cssId) {
		this.cssId 		= cssId;
		
		// Ajouter le CSS
		this.addClassName (this.cssId);
		
		// Créer le calque qui contiendra les boutons du menu
		var menuDiv = document.createElement('div');
		menuDiv.id = this.id + "_m";
		this.appendChild (menuDiv);
		this.oMenu = $(menuDiv.id);
		Object.extend (this.oMenu, __MenuOnglet);
		this.oMenu.initialize (cssId);
		
		// Créer le calque qui contiendra l'ensemble des onglets
		var conteneurDiv = document.createElement('div');
		conteneurDiv.id = this.id + "_c";
		this.appendChild (conteneurDiv);
		this.oConteneur = $(conteneurDiv.id);
		Object.extend (this.oConteneur, __ConteneurOnglet);
		this.oConteneur.initialize (cssId);
	},
	
	// Ajouter un onglet, retourne l'id du calque "contenu"
	addOnglet: function (type, titre, contenu) {
		this.nOnglets++;
		// créer un bouton pour l'onglet
		this.oMenu.addBouton (this.nOnglets, titre, this.cssId);
		// créer un calque pour accueillir le contenu de l'onglet
		return this.oConteneur.addContenu (this.nOnglets, type, contenu, this.cssId);
	},
	
	setFocus: function (newFocusId) {
		var contenu = this.oConteneur.getElementId (newFocusId);
		var bouton = this.oMenu.getElementId (newFocusId);
		// Cacher tous les contenus
		this.oConteneur.immediateDescendants().each(Element.hide);
		// Griser tous les onglets
		this.oMenu.immediateDescendants().each(__BoutonOnglet.setInactive);
		// Afficher le contenu de l'onglet désiré
		$(contenu).show ();
		// Afficher le bouton de l'onglet désiré
		$(bouton).setActive (bouton);
	}
}

__MenuOnglet = {
	initialize: function () {
		this.addClassName (this.up(0).cssId + "_menu");
	},
	
	addBouton: function (ongletId, texte) {
		// Créer le calque du bouton
		var nouveauDiv = document.createElement('div');
		nouveauDiv.id = this.getElementId (ongletId);
		nouveauDiv.ongletId = ongletId;
		this.appendChild (nouveauDiv);
		Object.extend ($(nouveauDiv.id), __BoutonOnglet);
		$(nouveauDiv.id).initialize (texte);
	},
	
	getElementId: function (n) {
		return this.id + "_b" + n;
	}
	
}

__ConteneurOnglet = {
	initialize: function (cssId) {
		this.addClassName (cssId + "_conteneur");
	},
	
	addContenu: function (ongletId, type, contenu, cssId) {
		// Créer le calque du contenu
		var nouveauDiv = document.createElement('div');
		nouveauDiv.id = this.getElementId (ongletId);
		this.appendChild (nouveauDiv);
		Object.extend ($(nouveauDiv.id), __ContenuOnglet);
		$(nouveauDiv.id).initialize (type, contenu, cssId);
		return nouveauDiv.id;
	},
	
	getElementId: function (n){
		return this.id + "_c" + n;
	}
}

__BoutonOnglet = {
	initialize: function (texte) {
		this.appendChild (document.createTextNode(texte));
		this.setInactive ();
		// Surveiller les click sur le bouton
		this.observe ('click', function(event){
			var elm = Event.element(event);
			$(elm).up(1).setFocus ($(elm).ongletId);
		});
	},
	
	setActive: function (element) {
		if (!element) {element = this;}
		var cssId = $(element).up(1).cssId;
		if ($(element).hasClassName (cssId + "_bouton_off")) {
			$(element).removeClassName (cssId + "_bouton_off");
		}
		$(element).addClassName (cssId + "_bouton");
	},
	
	setInactive: function (element) {
		if (!element) {element = this;}
		var cssId = $(element).up(1).cssId;
		if ($(element).hasClassName (cssId + "_bouton")) {
			$(element).removeClassName (cssId + "_bouton");
		}
		$(element).addClassName (cssId + "_bouton_off");
	}
}

__ContenuOnglet = {
	initialize: function (type, valeur, cssId) {
		// gérer le contenu du div selon son type
		switch (type) {
			case 0:
				// mode texte
				this.appendChild (document.createTextNode(valeur));
				break;
			case 1:
				// mode html
				this.update(valeur);
				break;
			case 2:
				// mode url
				if (Prototype.Browser.IE)
				{
					// IE n'aime pas les iframe créé via createElement. Alors il faut lui dédier un bout de code...
					var html = "<iframe id='" + this.id + "_i'"
							+ " src='" + valeur + "'"
							+ " scrolling='1'"
							+ " frameborder='0'"
							+ "></iframe>";
					this.update (html);
				} else {
					var iframe = document.createElement ('iframe');
					iframe.id			= this.id+"_i";
					iframe.src			= valeur;
					iframe.scrolling	= true;
					iframe.frameborder	= "0";
					this.appendChild (iframe);
				}
				// Appliquer le style css des iframes
				$(this.id+"_i").addClassName (this.up(1).cssId + "_iframe");
				break;
			case 3 :
				// mode ajax
				var element = this;
				new Ajax.Request (valeur, {
					method: 'get',
					onSuccess: function (transport) {
						element.update(transport.responseText);
					}
				});
				break;
			case 4 :
				// mode calque
				this.update ($(valeur).remove ().innerHTML);
				break;
			default:
				this.appendChild (document.createTextNode(valeur));
				break;
		}
		// par défaut, tous les onglets sont invisibles. Utiliser setFocus pour déterminer l'onglet à afficher par défaut.
		this.hide ();
		// appliquer le style css au calque
		this.addClassName (cssId + "_contenu");
		
	}
}
