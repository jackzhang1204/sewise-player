(function($){
	/**
	 * Constructor.
	 * @name AdsContainer : 广告盒子.
	 * 
	 */
	
	var AdsContainer = SewisePlayerSkin.AdsContainer = function(elementObject, data){
		var $container = elementObject.$container;
		var $sewisePlayerUi = elementObject.$sewisePlayerUi;
		//banner ads init////////////
		var bannersData = data["banners"];
		if(bannersData){
			var adsBanner = $("<div class='sewise-player-ads-banner'></div>");
			adsBanner.css({
				"position": "absolute",
				"width": "100%",
				"height": "100%",
				"left": "0px",
				"top": "0px",
				"overflow": "hidden",
				"pointer-events": "none"
			});
			adsBanner.appendTo($container);
			$sewisePlayerUi.css("z-index", 1);
			SewisePlayerSkin.BannersAds(adsBanner, bannersData);
		}
		//other ads init/////////////
		
		
	};
	
})(window.jQuery)