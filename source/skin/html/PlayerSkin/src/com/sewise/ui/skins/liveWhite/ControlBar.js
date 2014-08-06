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
		var $liveBtn = elementObject.$liveBtn;
		var $fullscreenBtn = elementObject.$fullscreenBtn;
		var $normalscreenBtn = elementObject.$normalscreenBtn;
		var $soundopenBtn = elementObject.$soundopenBtn;
		var $soundcloseBtn = elementObject.$soundcloseBtn;
		//var $shareBtn = elementObject.$shareBtn;
		
		var $playtime = elementObject.$playtime;
		var $progressPlayedLine = elementObject.$progressPlayedLine;
		var $progressPlayedPoint = elementObject.$progressPlayedPoint;
		var $progressLoadedLine = elementObject.$progressLoadedLine;
		var $progressSeekLine = elementObject.$progressSeekLine;

		
		//////////////
		var $buffer = elementObject.$buffer;
		var $bigPlayBtn = elementObject.$bigPlayBtn;
		//////////////
		var that = this;
		var mainPlayer;
		var screenState = "normal";
		var duration = 0.1;
		var playTime = 0;
		var playTimeHMS = "00:00:00";
		var durationHMS = "00:00:00";
		var ppPointW = 0;
		var dragging = false;
		var beforeDownX = 0;
		var afterUpX = 0;
		var ppLineWidth = 0;
		var psLineWidth = 0;
		var seekPt = 0;
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
			//$soundopenBtn.hide();
			//$soundcloseBtn.hide();
			///////////////////////////////

			$pauseBtn.hide();
			$normalscreenBtn.hide();
			$soundcloseBtn.hide();
			$buffer.hide();
		}
		$controlbar.click(function(e){
			e.originalEvent.stopPropagation();
		});
		$container.click(function(e){
			if(displayBar){
				hideBar();
				topBar.hide();
				displayBar = false;
			}else{
				showBar();
				topBar.show();
				displayBar = true;
			}
		});
		$playBtn.click(function(){
			mainPlayer.play();
		});
		$pauseBtn.click(function(){
			mainPlayer.pause();
		});
		$liveBtn.click(function(){
			mainPlayer.live();
		});
		$bigPlayBtn.click(function(e){
			e.originalEvent.stopPropagation();
			mainPlayer.play();
		});
		$fullscreenBtn.click(function(){
			that.fullScreen();
		});
		$normalscreenBtn.click(function(){
			that.noramlScreen();
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

		/*
		$shareBtn.click(function(){
			if(window.shareVideo && typeof(window.shareVideo) == "function"){
				window.shareVideo();	
			}else{
				console.log("Not found the shareVideo function of window");
			}
		});
		*/
		
		$progressSeekLine.mousedown(function(e){
			//console.log(e.pageX);
			
			ppLineWidth = (e.pageX - e.target.getBoundingClientRect().left);
			psLineWidth = $progressSeekLine.width();
			$progressPlayedLine.css("width", ppLineWidth);
			$progressPlayedPoint.css("left", ppLineWidth - ppPointW / 2);
			seekPt = ppLineWidth / psLineWidth;
			seekPlay(seekPt);
		});
		$progressPlayedPoint.mousedown(function(e){
			//console.log("mousedown");

			this.blur();
			dragging = true;
			beforeDownX = e.pageX;
			ppLineWidth = $progressPlayedLine.width();
			psLineWidth = $progressSeekLine.width();

			$container.bind("mousemove", containerMouseMoveHandler);
			$(document).bind("mouseup", ppPointMouseUpHandler);
		});
		function containerMouseMoveHandler(e){
			var currentWidth = ppLineWidth + (e.pageX - beforeDownX);
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
			afterUpX = e.pageX;
			if(beforeDownX != afterUpX){
				ppLineWidth = $progressPlayedLine.width();
				seekPt = ppLineWidth / psLineWidth;
				seekPlay(seekPt);
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
			beforeDownX = touchTarget.pageX;
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
				var currentWidth = ppLineWidth + (touchTarget.pageX - beforeDownX);
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
				afterUpX = touchTarget.pageX;
				if(beforeDownX != afterUpX){
					ppLineWidth = $progressPlayedLine.width();
					seekPt = ppLineWidth / psLineWidth;
					seekPlay(seekPt);
				}
			}
			dragging = false;
		}
		function seekPlay($seekPt){
			var shiftDate = new Date(Math.floor(mainPlayer.playTime().getTime() / 1000 / 3600) * 3600 * 1000 + $seekPt * duration * 1000);
			var shiftTime = SewisePlayerSkin.Utils.stringer.dateToTimeStr14(shiftDate);
			mainPlayer.seek(shiftTime);
			//console.log(shiftDate);
			//console.log(shiftTime);
		}
		function hideBar(){
			$controlbar.css("visibility", "hidden");
		}
		function showBar(){
			$controlbar.css("visibility", "visible");
		}
		//////////////////////////////////////////
		
		function fullScreen(obj){
			//console.log("to fullScreen");
			if (obj.requestFullscreen){
				obj.requestFullscreen();
			} else if (obj.msRequestFullscreen){
				obj.msRequestFullscreen();
			} else if (obj.mozRequestFullScreen){
				obj.mozRequestFullScreen();
			} else if (obj.webkitRequestFullscreen){
				obj.webkitRequestFullscreen();
			}else if($video.webkitEnterFullscreen){
				//console.log("native fullscreen");
				/*$video.play();
				$video.webkitEnterFullscreen();
				$fullscreenBtn.show();
				$normalscreenBtn.hide();*/

				//为保留直播UI控制时移，取消原生UI全屏功能
				elementLayout.fullScreen("not-support");
			}else{
				//console.log("not-support");
				elementLayout.fullScreen("not-support");
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
			}else{
				elementLayout.normalScreen();
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
		this.stopped = function(){
			$playBtn.show();
			$pauseBtn.hide();
			$bigPlayBtn.show();
		}
		this.setDuration = function(totalTimes){
			duration = totalTimes;

			//console.log("duration:" + duration);
		}
		this.timeUpdate = function(){
			if(!mainPlayer.playTime()) return;
			
			durationHMS = SewisePlayerSkin.Utils.stringer.dateToStrHMS(new Date(Math.ceil(mainPlayer.playTime().getTime() / 1000 / duration) * duration * 1000));
			playTimeHMS = SewisePlayerSkin.Utils.stringer.dateToStrHMS(new Date(Math.floor(mainPlayer.playTime().getTime() / 1000 / duration) * duration * 1000));
			$playtime.text(playTimeHMS + "/" + durationHMS);

			if(dragging) return;
			var playPt = (Math.floor(mainPlayer.playTime().getTime() / 1000) % duration) / duration;
			ppLineWidth = playPt * 100 + "%";
			$progressPlayedLine.css("width", ppLineWidth);
			var ppPointLeft = $progressPlayedLine.width() - ppPointW / 2;
			$progressPlayedPoint.css("left", ppPointLeft);

			//////////////////////
			var loadedPt;
			var playTimeRightHour = Math.ceil(mainPlayer.playTime().getTime() / 1000 / 3600);
			var liveTimeLeftHour = Math.floor(mainPlayer.liveTime().getTime() / 1000 / 3600);
			if(liveTimeLeftHour >= playTimeRightHour){
				loadedPt = 1;
			}else{
				loadedPt = (Math.floor(mainPlayer.liveTime().getTime() / 1000) % duration) / duration;
			}
			//console.log("loadedPt: " + loadedPt);
			var plLineWidth = loadedPt * 100 + "%";
			$progressLoadedLine.css("width", plLineWidth);
		}
		this.hide2 = function(){
			$controlbar.hide();
		}
		this.fullScreen = function(){
			$fullscreenBtn.hide();
			$normalscreenBtn.show();
			fullScreen($container.get(0));
		}
		this.noramlScreen = function(){
			$fullscreenBtn.show();
			$normalscreenBtn.hide();
			normalscreen();
		}

		
	};
	
})(window.jQuery)