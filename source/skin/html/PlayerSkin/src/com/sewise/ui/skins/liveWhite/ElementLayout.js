(function($){
	/**
	 * Constructor.
	 * @name ElementLayout : 皮肤布局对象.
	 * 
	 */
	var ElementLayout = SewisePlayerSkin.ElementLayout = function(elementObject){
		var $container = elementObject.$container;
		var $controlBarProgress = elementObject.$controlBarProgress;
		var $playtime = elementObject.$playtime;

		var that = this;
		var defStageWidth = elementObject.defStageWidth;
		var defStageHeight = elementObject.defStageHeight;
		

		//var btnsWidth = 38 * 5 + 118 + 3 * 6;
		/**
		 * 由于ios设备下不允许控制音量，所以
		 * 这里统一取消音量控制按钮。
		 */
		var btnsWidth = 38 * 4 + 118 + 3 * 6;
		var defProgressWidth = parseInt(defStageWidth) - btnsWidth;
		
		init();
		////////////////////////////////////////////////////////////////////////////////////////////
		document.addEventListener("fullscreenchange", fullscreenChangeHandler);
		document.addEventListener("MSFullscreenChange", fullscreenChangeHandler);
		document.addEventListener("mozfullscreenchange", fullscreenChangeHandler);
		document.addEventListener("webkitfullscreenchange", fullscreenChangeHandler);
		function fullscreenChangeHandler(){
			if(document.fullscreenElement != null || document.msFullscreenElement != null
				|| document.mozFullScreenElement != null || document.webkitFullscreenElement != null){
				//console.log("document to fullscreen");
            	that.fullScreen();
          	}else{
          		//console.log("document to normalscreen");
            	that.normalScreen();
          	}
      	}
		function init(){
			if(defProgressWidth < 0){
				defProgressWidth = defProgressWidth + $playtime.width();
				$playtime.hide();
			}
			$controlBarProgress.css("width", defProgressWidth);
		}
		this.fullScreen = function(state){
			if(state == "not-support"){
				var clientW = $(window).width() - 15;
				var clientH = $(window).height() - 15;
				//console.log("clientW: " + clientW + "\nclientH: " + clientH);
				$container.css("width", clientW);
				$container.css("height", clientH);
				
				/*$container.css("width", window.screen.width);
				$container.css("height", window.screen.height);*/
				//console.log($container.width());
			}else{
				$container.css("width", "100%");
				$container.css("height", "100%");
			}
			
			var fullProgressWidth = parseInt($container.width()) - btnsWidth;
			//console.log(fullProgressWidth);
			if(fullProgressWidth < 0){
				fullProgressWidth = fullProgressWidth + $playtime.width();
				$playtime.hide();
			}else{
				$playtime.show();
			}
			$controlBarProgress.css("width", fullProgressWidth);
		}
		this.normalScreen = function(){
			$container.css("width", defStageWidth);
			$container.css("height", defStageHeight);

			defProgressWidth = parseInt(defStageWidth) - btnsWidth;
			if(defProgressWidth < 0){
				defProgressWidth = defProgressWidth + $playtime.width();
				$playtime.hide();
			}else{
				$playtime.show();
			}
			$controlBarProgress.css("width", defProgressWidth);
		}
		
	};
	
})(window.jQuery)