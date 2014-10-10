(function($){
	/**
	 * Constructor.
	 * @name ElementObject : 布肤元素对象.
	 * 
	 */
	var ElementObject = SewisePlayerSkin.ElementObject = function(){
		this.$sewisePlayerUi = $(".sewise-player-ui");
		//this.$container = this.$sewisePlayerUi.parent().parent();
		this.$container = this.$sewisePlayerUi.parent();
		////////////////
		this.$video = this.$container.find("video").get(0);
		////////////////
		this.$controlbar =  this.$sewisePlayerUi.find(".controlbar");
		this.$playBtn = this.$sewisePlayerUi.find(".controlbar-btns-play");
		this.$pauseBtn = this.$sewisePlayerUi.find(".controlbar-btns-pause");
		this.$fullscreenBtn = this.$sewisePlayerUi.find(".controlbar-btns-fullscreen");
		this.$normalscreenBtn = this.$sewisePlayerUi.find(".controlbar-btns-normalscreen");
		this.$soundopenBtn = this.$sewisePlayerUi.find(".controlbar-btns-soundopen");
		this.$soundcloseBtn = this.$sewisePlayerUi.find(".controlbar-btns-soundclose");
		this.$shareBtn = this.$sewisePlayerUi.find(".controlbar-btns-share");
		this.$playtime = this.$sewisePlayerUi.find(".controlbar-playtime");
		
		this.$controlBarProgress = this.$sewisePlayerUi.find(".controlbar-progress");
		this.$progressPlayedLine = this.$sewisePlayerUi.find(".controlbar-progress-playedline");
		this.$progressPlayedPoint = this.$sewisePlayerUi.find(".controlbar-progress-playpoint");
		this.$progressLoadedLine = this.$sewisePlayerUi.find(".controlbar-progress-loadedline");
		this.$progressSeekLine = this.$sewisePlayerUi.find(".controlbar-progress-seekline");

		////////////////
		this.$logo = this.$sewisePlayerUi.find(".logo");
		this.$logoIcon = this.$sewisePlayerUi.find(".logo-icon");
		
		////////////////
		this.$topbar = this.$sewisePlayerUi.find(".topbar");
		this.$programTip= this.$sewisePlayerUi.find(".topbar-program-tip");
		this.$programTitle= this.$sewisePlayerUi.find(".topbar-program-title");
		this.$topbarClock = this.$sewisePlayerUi.find(".topbar-clock");
		
		////////////////
		this.$buffer = this.$sewisePlayerUi.find(".buffer");
		this.$bufferTip = this.$sewisePlayerUi.find(".buffer-text-tip");
		
		////////////////
		this.$bigPlayBtn = this.$sewisePlayerUi.find(".big-play-btn");
		
		
		//////////////////////////////////////////////////////////////
		//this.defStageWidth = this.$container.css("width");
		//this.defStageHeight = this.$container.css("height");
		//改为.width()只取元素的尺寸值（不带单位），这样可以防止zepto.js库取到百分比值。
		//if(!this.defStageWidth)this.defStageWidth = this.$container.width();
		//if(!this.defStageHeight)this.defStageHeight = this.$container.height();
		if(!SewisePlayerSkin.defStageWidth){
			SewisePlayerSkin.defStageWidth = this.defStageWidth = this.$container.width();
			SewisePlayerSkin.defStageHeight = this.defStageHeight = this.$container.height();
		}
		
	};
	
})(window.jQuery)