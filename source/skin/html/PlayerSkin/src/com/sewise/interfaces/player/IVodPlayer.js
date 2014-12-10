(function(win){
	/**
	 * Constructor.
	 * @name IVodPlayer : html5点播主播器接口对象.
	 * 
	 */
	var IVodPlayer = win.SewisePlayer.IVodPlayer = win.SewisePlayer.IVodPlayer ||
	{
		play: function(){},
		pause: function(){},
		stop: function(){},
		seek: function(time){},
		changeClarity: function(level){},
		setVolume: function(volume){},
		toPlay: function(videoUrl, title, startTime, autostart){},
		duration: function(){},
		playTime: function(){},
		type: function(){},
		showTextTip: function(){},
		hideTextTip: function(){},

		muted: function(){},
		bufferProgress: function(p){}
		
	};
	
})(window);