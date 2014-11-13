(function(win){
	/**
	 * Constructor.
	 * @name IVodSkin : html5点播皮肤接口对象.
	 * 
	 */
	var IVodSkin = win.SewisePlayerSkin.IVodSkin = win.SewisePlayerSkin.IVodSkin || 
	{
		player: function(){},
		started: function(){},
		paused: function(){},
		stopped: function(){},
		seeking: function(b){},
		buffering: function(b){},
		bufferProgress: function(p){},
		loadedProgress: function(p){},
		loadedOpen: function(){},
		loadedComplete: function(){},
		
		programTitle: function(title){},
		duration: function(time){},
		playTime: function(time){},
		startTime: function(time){},
		loadSpeed: function(time){},
		initialClarity: function(levels){},
		
		lang: function(lang){},
		logo: function(url){},
		
		timeUpdate: function(time){},
		volume: function(value){},
		
		clarityButton: function(state){},
		timeDisplay: function(state){},
		controlBarDisplay: function(state){},
		topBarDisplay: function(state){},
		customStrings: function(strings){},
		customDatas: function(data){},
		
		fullScreen: function(){},
		noramlScreen: function(){},
		
		initialAds: function(data){},
		initialStatistics: function(data){}
		
	};
	
})(window);