/**
 *
 * @access public
 * @return void
 **/
function createButton(id){
	var button = document.createElement('BUTTON');
	var buttext2 = document.createTextNode('Ajouter');
	button.appendChild(buttext2);
	//button.onclick= uploadImage;
	document.getElementById(id).innerHTML="<a href='javascript:;' onclick='uploadImage()'>Ajouter</a>";

}