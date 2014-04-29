(function(){
	/**
	 * Constructor.
	 * @name LogoBox: logo层对象.
	 * 
	 */
	var LogoBox = SewisePlayerSkin.LogoBox = function(elementObject){
		var $logoIcon = elementObject.$logoIcon;

		/////////////////////////////
		this.setLogo = function(url){
			$logoIcon.css("background", "url(" + url + ") 0px 0px no-repeat");
			$logoIcon.attr("href", "http://www.sewise.com/");
		}
		
	};
	
})()