(function($){
	/**
	 * Constructor.
	 * @name ControlBar : 皮肤控制层对象.
	 * 
	 */
	var ControlBar = SewisePlayerSkin.ControlBar = function(elementObject, elementLayout, topBar){
		var $container = elementObject.$container;
		var $video = elementObject.$video;
		var $controlbar = elementObject.$controlbar;
		var $playBtn = elementObject.$playBtn;
		var $pauseBtn = elementObject.$pauseBtn;
		var $fullscreenBtn = elementObject.$fullscreenBtn;
		var $normalscreenBtn = elementObject.$normalscreenBtn;
		var $soundopenBtn = elementObject.$soundopenBtn;
		var $soundcloseBtn = elementObject.$soundcloseBtn;
		var $shareBtn = elementObject.$shareBtn;
		var $playtime = elementObject.$playtime;
		var $progressPlayedLine = elementObject.$progressPlayedLine;
		var $progressPlayedPoint = elementObject.$progressPlayedPoint;
		var $progressLoadedLine = elementObject.$progressLoadedLine;
		var $progressSeekLine = elementObject.$progressSeekLine;
		
		//////////////
		var $buffer = elementObject.$buffer;
		var $bufferTip = elementObject.$bufferTip;
		var $bigPlayBtn = elementObject.$bigPlayBtn;
		//////////////
		var that = this;
		var mainPlayer;
		var screenState = "normal";
		var duration = 1;

		var playTime = 0;
		var playTimeHMS = "00:00";
		var durationHMS = "00:00";
		var ppPointW = 0;
		var dragging = false;
		var beforeDownX = 0;
		var afterUpX = 0;
		var ppLineWidth = 0;
		var psLineWidth = 0;
		var seekPt = 0;
		var screenRotate = false;
		var pageX = "pageX";
		var displayBar = true;
		var isPlaying = false;
		var hideTimeout;
		var delayTime = 5000;

		init();
		/////////////////////////////////////////
		function init(){
			ppPointW = $progressPlayedPoint.width();
			psLineWidth = $progressSeekLine.width();

			/**
			 * 由于ios设备下不允许控制音量，所以
			 * 这里统一取消音量控制按钮。
			 */
			$soundopenBtn.hide();
			$soundcloseBtn.hide();
			
			///////////////////////////////
			$pauseBtn.hide();
			$normalscreenBtn.hide();
			$soundcloseBtn.hide();
			$buffer.hide();
			$playtime.text(playTimeHMS + "/" + durationHMS);

			hideTimeout = setTimeout(hideControlBar, delayTime);
		}
		$playBtn.click(function(e){
			mainPlayer.play();
		});
		$pauseBtn.click(function(e){
			mainPlayer.pause();
		});
		$bigPlayBtn.click(function(e){
			e.originalEvent.stopPropagation();
			mainPlayer.play();
		});
		$fullscreenBtn.click(function(){
			if(SewisePlayerSkin.mobileExtEvent.block) {return false};

			that.fullScreen();
		});
		$normalscreenBtn.click(function(){
			if(SewisePlayerSkin.mobileExtEvent.block) {return false};

			that.noramlScreen();
		});

		this.fullScreen = function(){
			fullScreen($container.get(0));
			elementLayout.fullScreen();
			screenRotate = elementLayout.screenRotate;
			pageX = "pageY";

			$fullscreenBtn.hide();
			$normalscreenBtn.show();
		}
		this.noramlScreen = function(){
			normalscreen();
			elementLayout.normalScreen();
			screenRotate = elementLayout.screenRotate;
			pageX = "pageX";
			
			$fullscreenBtn.show();
			$normalscreenBtn.hide();
		}

		SewisePlayerSkin.mobileExtEvent = {
			block: false,
			fullScreen: $fullscreenBtn,
			normalScreen: $normalscreenBtn,
			intoFullScreen: that.fullScreen,
			exitFullScreen: that.noramlScreen
		}
		SewisePlayerSkin.exitFullscreen = function(){
			that.noramlScreen();
		}
		
		$controlbar.on('tap', function(e){
			e.originalEvent.stopPropagation();
		});
		$controlbar.click(function(e){
			e.originalEvent.stopPropagation();
		});
		
		/**
		 * 这里设置video不接受鼠标事件，防止android
		 * 设备下点击video时切换播放状态，以避免和
		 * container的click动作发生冲突。
		 */
		$($video).css("pointer-events", "none");

		$container.bind({"mousemove": containerOnMoveHandler, "touchmove": containerOnMoveHandler});
		$controlbar.bind({"mouseover": controlbarOnOverHandler, "touchstart": controlbarOnOverHandler});
		$controlbar.bind({"mouseout": controlbarOnOutHandler, "touchend": controlbarOnOutHandler});
		function containerOnMoveHandler(e){
			if(displayBar == false){
				showControlBar();
				hideTimeout = setTimeout(hideControlBar, delayTime);
			}
		}
		function controlbarOnOverHandler(e){
			if(hideTimeout != 0){
				clearTimeout(hideTimeout);
				hideTimeout = 0;
			}
		}
		function controlbarOnOutHandler(e){
			if(hideTimeout == 0){
				hideTimeout = setTimeout(hideControlBar, delayTime);
			}
		}
		
		function hideControlBar(){
			hideBar();
			topBar.hide();
			displayBar = false;
		}
		function showControlBar(){
			showBar();
			topBar.show();
			displayBar = true;
		}

		/////////////////////////////////////////////////////
		$soundopenBtn.click(function(){
			mainPlayer.muted(true);
			$soundopenBtn.hide();
			$soundcloseBtn.show();
		});
		$soundcloseBtn.click(function(){
			mainPlayer.muted(false);
			$soundopenBtn.show();
			$soundcloseBtn.hide();
		});
		$shareBtn.click(function(){
			if(window.shareVideo && typeof(window.shareVideo) == "function"){
				window.shareVideo();
			}else{
				console.log("Not found the shareVideo function of window");
			}
		});
		
		$progressSeekLine.mousedown(function(e){
			if(!screenRotate){
				ppLineWidth = (e[pageX] - e.target.getBoundingClientRect().left);
			}else{
				ppLineWidth = (e[pageX] - e.target.getBoundingClientRect().top);
			}
			psLineWidth = $progressSeekLine.width();
			$progressPlayedLine.css("width", ppLineWidth);
			$progressPlayedPoint.css("left", ppLineWidth - ppPointW / 2);
			seekPt = ppLineWidth / psLineWidth;
			mainPlayer.seek(seekPt * duration);

			//console.log(seekPt * duration);
		});
		$progressPlayedPoint.mousedown(function(e){
			this.blur();
			dragging = true;
			//beforeDownX = e.pageX;
			beforeDownX = e[pageX];
			ppLineWidth = $progressPlayedLine.width();
			psLineWidth = $progressSeekLine.width();

			$container.bind("mousemove", containerMouseMoveHandler);

			$(document).bind("mouseup", ppPointMouseUpHandler);
		});
		function containerMouseMoveHandler(e){
			//var currentWidth = ppLineWidth + (e.pageX - beforeDownX);
			var currentWidth = ppLineWidth + (e[pageX] - beforeDownX);

			if(currentWidth > 0 && currentWidth < psLineWidth){
				//console.log(currentWidth);
				
				$progressPlayedLine.css("width", currentWidth);
				$progressPlayedPoint.css("left", currentWidth - ppPointW / 2);
			}
		}
		function ppPointMouseUpHandler(e){
			$container.unbind("mousemove", containerMouseMoveHandler);
			$(document).unbind("mouseup", ppPointMouseUpHandler);
			//afterUpX = e.pageX;
			afterUpX = e[pageX];

			if(beforeDownX != afterUpX){
				ppLineWidth = $progressPlayedLine.width();
				seekPt = ppLineWidth / psLineWidth;
				mainPlayer.seek(seekPt * duration);
			}
			dragging = false;
		}

		//touch事件处理///////////////////////
		$progressPlayedPoint.bind("touchstart", touchstartHandler);
		function touchstartHandler(event){
			e = event.originalEvent;
			$progressPlayedPoint.blur();
			var touchTarget = e.targetTouches[0];
			dragging = true;
			//beforeDownX = touchTarget.pageX;
			beforeDownX = touchTarget[pageX];
			ppLineWidth = $progressPlayedLine.width();
			psLineWidth = $progressSeekLine.width();
			$progressPlayedPoint.bind("touchmove", ppPointTouchMoveHandler);
			$progressPlayedPoint.bind("touchend", ppPointTouchEndHandler);
		}
		function ppPointTouchMoveHandler(event){
			e = event.originalEvent;
			if (e.targetTouches.length == 1){
				e.preventDefault();
				var touchTarget = e.targetTouches[0];
				//console.log("touchmove pageX:" + touchTarget.pageX);
				var currentWidth = ppLineWidth + (touchTarget[pageX] - beforeDownX);
				if(currentWidth > 0 && currentWidth < psLineWidth){
					$progressPlayedLine.css("width", currentWidth);
					$progressPlayedPoint.css("left", currentWidth - ppPointW / 2);
				}
			}
		}
		function ppPointTouchEndHandler(event){
			e = event.originalEvent;
			$progressPlayedPoint.unbind("touchmove", ppPointTouchMoveHandler);
			$progressPlayedPoint.unbind("touchend", ppPointTouchEndHandler);
			if (e.changedTouches.length == 1){
				var touchTarget = e.changedTouches[0];
				//afterUpX = touchTarget.pageX;
				afterUpX = touchTarget[pageX];

				if(beforeDownX != afterUpX){
					ppLineWidth = $progressPlayedLine.width();
					seekPt = ppLineWidth / psLineWidth;
					//console.log("time:" + seekPt * duration);
					mainPlayer.seek(seekPt * duration);
				}
			}
			dragging = false;
		}
		function hideBar(){
			$controlbar.css("visibility", "hidden");
		}
		function showBar(){
			$controlbar.css("visibility", "visible");
		}
		
		//////////////////////////////////////////
		function fullScreen(obj){
			if (obj.requestFullscreen){
				obj.requestFullscreen();
			} else if (obj.msRequestFullscreen){
				obj.msRequestFullscreen();
			} else if (obj.mozRequestFullScreen){
				obj.mozRequestFullScreen();
			} else if (obj.webkitRequestFullscreen){
				obj.webkitRequestFullscreen();
			}
			screenState = "full";
			return;
		}
		function normalscreen(){
			if (document.exitFullscreen){
				document.exitFullscreen();
			} else if (document.msExitFullscreen){
				document.msExitFullscreen();
			} else if (document.mozCancelFullScreen){
				document.mozCancelFullScreen();
			} else if (document.webkitCancelFullScreen){
				document.webkitCancelFullScreen();
			}
			screenState = "normal";
			return;
		}
		///////////////////////////////////////////
		this.setPlayer = function(mPlayer){
			mainPlayer = mPlayer;
		}
		this.started = function(){
			$playBtn.hide();
			$pauseBtn.show();
			$bigPlayBtn.hide();
			isPlaying = true;
		}
		this.paused = function(){
			$playBtn.show();
			$pauseBtn.hide();
			$bigPlayBtn.show();
			isPlaying = false;
		}
		this.stopped = function(){
			$playBtn.show();
			$pauseBtn.hide();
			$bigPlayBtn.show();
			isPlaying = false;
		}
		this.setDuration = function(totalTimes){
			//alert("totalTimes: " + totalTimes);
			//console.log("totalTimes: " + totalTimes);
			//duration = totalTimes;
			//当时间为无限大时设置为3600秒，用于解决直播时间显示的问题。
			duration = (totalTimes != Infinity) ? totalTimes : 3600;
			
			if(totalTimes > 1){
				durationHMS = SewisePlayerSkin.Utils.stringer.secondsToMS(duration);
			}
			SewisePlayerSkin.duration = duration;
		}
		if(SewisePlayerSkin.duration){
			this.setDuration(SewisePlayerSkin.duration);
		}
		this.timeUpdate = function(currentTime){
			//console.log("currentTime: " + currentTime);
			//当直播使用点播皮肤时，由于直播没有返回currentTime时间所以直接取video的当前播放时间。
			if(currentTime == undefined || currentTime == Infinity){
				//currentTime = SewisePlayer.video.currentTime;
				currentTime = (SewisePlayer.video.currentTime != Infinity) ? SewisePlayer.video.currentTime : 0;
			}
			playTime = currentTime;

			//playTimeHMS = SewisePlayerSkin.Utils.stringer.secondsToHMS(playTime);
			playTimeHMS = SewisePlayerSkin.Utils.stringer.secondsToMS(playTime);

			$playtime.text(playTimeHMS + "/" + durationHMS);
			
			if(dragging) return;
			var playPt = playTime / duration;

			//ppLineWidth = playPt * 100 + "%";
			ppLineWidth = playPt * ($progressSeekLine.width() - ppPointW);

			$progressPlayedLine.css("width", ppLineWidth);
			
			//var ppPointLeft = $progressPlayedLine.width() - ppPointW / 2;
			var ppPointLeft = $progressPlayedLine.width();
			
			$progressPlayedPoint.css("left", ppPointLeft);
		}
		this.loadProgress = function(loadedPt){
			//console.log(loadedPt);
			
			var plLineWidth = loadedPt * 100 + "%";
			$progressLoadedLine.css("width", plLineWidth);
		}
		this.hide2 = function(){
			$controlbar.hide();
		}
		this.showBuffer = function(){
			$buffer.show();
		}
		this.hideBuffer = function(){
			$buffer.hide();
		}
		this.initLanguage = function(){
			var bufferTipStr = SewisePlayerSkin.Utils.language.getString("loading");
			$bufferTip.text(bufferTipStr);
		}
		
		
	};
	
})(window.jQuery)