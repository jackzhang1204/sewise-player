(function(){
	/**
	 * Constructor.
	 * @name ControlBar : 皮肤控制层对象.
	 * 
	 */
	var ControlBar = SewisePlayerSkin.ControlBar = function(elementObject, elementLayout){
		var $container = elementObject.$container;
		var $controlbar = elementObject.$controlbar;
		var $playBtn = elementObject.$playBtn;
		var $pauseBtn = elementObject.$pauseBtn;
		var $stopBtn = elementObject.$stopBtn;
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
		var $topbar = elementObject.$topbar;
		
		//////////////
		var $buffer = elementObject.$buffer;
		var $bigPlayBtn = elementObject.$bigPlayBtn;
		//////////////
		var mainPlayer;
		var screenState = "normal";
		var duration = 1;

		var playTime = 0;
		var playTimeHMS = "000:00";
		var durationHMS = "000:00";
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
			
			$stopBtn.hide();
			///////////////////////////////
			$pauseBtn.hide();
			$normalscreenBtn.hide();
			$soundcloseBtn.hide();
			$buffer.hide();
		}
		$playBtn.click(function(e){
			mainPlayer.play();
		});
		$pauseBtn.click(function(e){
			mainPlayer.pause();
		});
		$stopBtn.click(function(){
			mainPlayer.stop();
		});
		$bigPlayBtn.click(function(){
			mainPlayer.play();
		});
		$fullscreenBtn.click(function(){
			fullScreen($container.get(0));
			elementLayout.fullScreen();
			screenRotate = elementLayout.screenRotate;
			pageX = "pageY";

			$fullscreenBtn.hide();
			$normalscreenBtn.show();
		});
		$normalscreenBtn.click(function(){
			normalscreen();
			elementLayout.normalScreen();
			screenRotate = elementLayout.screenRotate;
			pageX = "pageX";
			
			$fullscreenBtn.show();
			$normalscreenBtn.hide();
		});
		
		SewisePlayerSkin.exitFullscreen = function(){
			normalscreen();
			elementLayout.normalScreen();
			screenRotate = elementLayout.screenRotate;
			$fullscreenBtn.show();
			$normalscreenBtn.hide();
		}
		
		$controlbar.click(function(e){
			e.originalEvent.stopPropagation();
		});
		//$container.on("click", function(e){
		$container.click(function(e){
			if(displayBar){
				$controlbar.css("visibility", "hidden");
				$topbar.css("visibility", "hidden");
				
				displayBar = false;
			}else{
				$controlbar.css("visibility", "visible");
				$topbar.css("visibility", "visible");
				
				displayBar = true;
			}
		});
		

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
			//console.log("share video");
			
			if(window.shareVideo && typeof(window.shareVideo) == "function"){
				window.shareVideo();
			}else{
				console.log("Not found the shareVideo function of window");
			}
		});
		
		
		$progressSeekLine.mousedown(function(e){
			//console.log(e.pageX);
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
			//console.log("mousedown");

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
			//console.log("mouseup");
			
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
			//console.log("touchstart");
			e = event.originalEvent;
			//console.log(e);
			$progressPlayedPoint.blur();
			var touchTarget = e.targetTouches[0];
			dragging = true;
			//beforeDownX = touchTarget.pageX;
			beforeDownX = touchTarget[pageX];

			//console.log("beforeDownX:" + beforeDownX);
			ppLineWidth = $progressPlayedLine.width();
			psLineWidth = $progressSeekLine.width();
			$progressPlayedPoint.bind("touchmove", ppPointTouchMoveHandler);
			$progressPlayedPoint.bind("touchend", ppPointTouchEndHandler);
		}
		function ppPointTouchMoveHandler(event){
			//console.log("touchmove");
			e = event.originalEvent;
			//console.log(e);
			if (e.targetTouches.length == 1){
				e.preventDefault();
				var touchTarget = e.targetTouches[0];
				//console.log("touchmove pageX:" + touchTarget.pageX);
				//var currentWidth = ppLineWidth + (touchTarget.pageX - beforeDownX);
				var currentWidth = ppLineWidth + (touchTarget[pageX] - beforeDownX);

				if(currentWidth > 0 && currentWidth < psLineWidth){
					$progressPlayedLine.css("width", currentWidth);
					$progressPlayedPoint.css("left", currentWidth - ppPointW / 2);
				}
			}
		}
		function ppPointTouchEndHandler(event){
			//console.log("touchend");
			e = event.originalEvent;
			//console.log(e);
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
		}
		this.paused = function(){
			$playBtn.show();
			$pauseBtn.hide();
			$bigPlayBtn.show();
		}
		this.setDuration = function(totalTimes){
			duration = totalTimes;
			//durationHMS = SewisePlayerSkin.Utils.stringer.secondsToHMS(duration);
			if(totalTimes >= 1){
				durationHMS = SewisePlayerSkin.Utils.stringer.secondsToMS(duration);
			}
			SewisePlayerSkin.duration = duration;
			//console.log(duration);
		}
		if(SewisePlayerSkin.duration){
			this.setDuration(SewisePlayerSkin.duration);
		}
		this.timeUpdate = function(currentTime){
			playTime = currentTime;
			//playTimeHMS = SewisePlayerSkin.Utils.stringer.secondsToHMS(playTime);
			playTimeHMS = SewisePlayerSkin.Utils.stringer.secondsToMS(playTime);

			$playtime.text(playTimeHMS + "/" + durationHMS);
			
			if(dragging) return;
			var playPt = playTime / duration;
			ppLineWidth = playPt * 100 + "%";
			$progressPlayedLine.css("width", ppLineWidth);
			
			var ppPointLeft = $progressPlayedLine.width() - ppPointW / 2;
			$progressPlayedPoint.css("left", ppPointLeft);
		}
		this.loadProgress = function(loadedPt){
			//console.log(loadedPt);
			
			var plLineWidth = loadedPt * 100 + "%";
			$progressLoadedLine.css("width", plLineWidth);
		}

		
	};
	
})()