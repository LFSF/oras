$.fn.pager = function(clas, options) {
	
	var settings = {		
		navId: 'nav',
		navClass: 'nav',
		navAttach: 'append',
		highlightClass: 'highlight',
		prevText: '',
		nextText: '',
		linkText: null,
		linkWrap: null,
		height: null
	}
	if(options) $.extend(settings, options);
	
		
	return this.each( function () {
		
		var me = $(this);
		var size;
	  	var i = 0;		
		var navid = '#'+settings.navId;
		
		function init () {
			size = $(clas, me).not(navid+', .nosize').size();
			if(settings.height == null) {			
				settings.height = getHighest();
			}
			if(size > 1) {
				makeNav();
				show();
				highlight();
			}			
			sizePanel();
			if(settings.linkWrap != null) {
				linkWrap();
			}
		   
			timer = setTimeout(function(){ showItem() },3500);
		   
			function showItem(){
				if(size == eval(i) + 1)
					i = 0;
				else
					i = eval(i) + 1;
				
				show();
				highlight();
				
				timer = setTimeout(function(){ showItem() },3500);
			}
		}
		function makeNav () {		
			var str = '<div id="'+settings.navId+'" class="'+settings.navClass+'">';
			if (settings.prevText != "") {
				str += '<a href="#" class="prev">'+settings.prevText+'</a>';
			}
			for(var i = 0; i < size; i++) {
				var j = i;
				str += '<a href="#" rel="'+j+'">';
				str += (settings.linkText == null) ? j : settings.linkText[j];				
				str += '</a>';
			}
			if (settings.nextText != "") {
				str += '<a href="#" class="next">'+settings.nextText+'</a>';
			}
			str += '</div>';
			switch (settings.navAttach) {		
				case 'before':
					$(me).before(str);
					break;
				case 'after':		
					$(me).after(str);
					break;
				case 'prepend':
					$(me).prepend(str);
					break;
				default:
					$(me).append(str);
					break;
			}
		}
		function show () {
			$(me).find(clas).not(navid+', .nosize').css("display","none");
			
			var show = $(me).find(clas).not(navid+', .nosize').get(i);
			$(show).css("display","block");
			
			/*$(show).fadeIn(1000,function(){
				$(me).find(clas).not(navid).hide();
				$(this).show();
			});*/
			
			//$(me).find(clas).not(navid).hide();
			//$(show).show();
		}		
		function highlight () {
			$(me).find(navid).find('a').removeClass(settings.highlightClass);
			var show = $(me).find(navid).find('a').get(i);			
			$(show).addClass(settings.highlightClass);
		}

		function sizePanel () {
			if($.browser.msie) {
				$(me).find(clas).not(navid+', .nosize').css( {
					height: settings.height
				});	
			} else {
				$(me).find(clas).not(navid+', .nosize').css( {
					minHeight: settings.height
				});
			}
		}
		function getHighest () {
			var highest = 0;
			$(me).find(clas).not(navid).each(function () {
				
				if(this.offsetHeight > highest) {
					highest = this.offsetHeight;
				}
			});
			highest = highest + "px";
			return highest;
		}
		function getNavHeight () {
			var nav = $(navid).get(0);
			return nav.offsetHeight;
		}
		function linkWrap () {
			$(me).find(navid).find("a").wrap(settings.linkWrap);
		}
		init();
		$(this).find(navid).find("a").click(function () {
			clearTimeout(timer);

			if($(this).attr('rel') == 'next') {
				if(i + 1 < size) {
					i = i+1;
				}
			} else if($(this).attr('rel') == 'prev') { 
				if(i > 0) {	
					i = i-1;
				}
			} else {		
				var j = $(this).attr('rel');	
				i = j;		
			}
			show();
			highlight();
			return false;
		});
	});	
}