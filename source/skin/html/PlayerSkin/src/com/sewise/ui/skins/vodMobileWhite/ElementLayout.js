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
		//var btnsWidth = 38 * 4 + 118 + 3 * 6;
		var btnsWidth = 38 * 3 + 90 + 3 * 6;
		var defProgressWidth = parseInt(defStageWidth) - btnsWidth;
		this.screenRotate = false;
		//console.log("defProgressWidth: " + defStageWidth);
		
		init();
		////////////////////////////////////////////////////////////////////////////////////////////
		/*document.addEventListener("fullscreenchange", fullscreenChangeHandler);
		document.addEventListener("MSFullscreenChange", fullscreenChangeHandler);
		document.addEventListener("mozfullscreenchange", fullscreenChangeHandler);
		document.addEventListener("webkitfullscreenchange", fullscreenChangeHandler);
		function fullscreenChangeHandler(){
			if(document.fullscreenElement != null || document.msFullscreenElement != null || document.mozFullScreenElement != null || document.webkitFullscreenElement != null){
            	console.info("full screen");
            	that.fullScreen();
          	}else{
            	console.info("normal screen");
            	that.normalScreen();
          	}
      	}*/

		function init(){
			if(defProgressWidth < 0){
				defProgressWidth = defProgressWidth + $playtime.width();
				$playtime.hide();
			}
			$controlBarProgress.css("width", defProgressWidth);
		}
		this.fullScreen = function(){
			if(window.toFullScreen && typeof(window.toFullScreen) == "function"){
				window.toFullScreen();
				
				$container.get(0).style.transform = "rotateZ(90deg)";
				$container.get(0).style.MsTransform = "rotateZ(90deg)";
				$container.get(0).style.MozTransform = "rotateZ(90deg)";
				$container.get(0).style.WebkitTransform = "rotateZ(90deg)";
				$container.get(0).style.OTransform = "rotateZ(90deg)";

				var clientW = document.getElementsByTagName("html")[0].clientWidth;
				var clientH = document.getElementsByTagName("html")[0].clientHeight;
				//console.log(clientW);
				//console.log(clientH);
				var offset = (clientW - clientH) / 2;
				$container.css({"width":clientH, "height":clientW, "left":offset, "bottom": offset});
				
				that.screenRotate = true;
			}else{
				//$container.css("width", "100%");
				//$container.css("height", "100%");
				
				$container.css("width", window.screen.width);
				$container.css("height", window.screen.height);
				//console.log($container.width());
			}

			//var fullProgressWidth = parseInt($container.width()) - btnsWidth;
			//兼容火狐bootstrap框架下，弹窗全屏时进度条显示的问题。
			var fullProgressWidth = parseInt($(window).width()) - btnsWidth;
			
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
			if(window.toNormalScreen && typeof(window.toNormalScreen) == "function"){
				window.toNormalScreen();
				
				$container.get(0).style.transform = "rotateZ(0deg)";
				$container.get(0).style.MsTransform = "rotateZ(0deg)";
				$container.get(0).style.MozTransform = "rotateZ(0deg)";
				$container.get(0).style.WebkitTransform = "rotateZ(0deg)";
				$container.get(0).style.OTransform = "rotateZ(0deg)";
				
				that.screenRotate = false;
			}

			//$container.css("width", defStageWidth);
			//$container.css("height", defStageHeight);
			$container.css({"width":defStageWidth, "height":defStageHeight, "left":0, "bottom": 0});
			
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
	
})(window.jQuery);