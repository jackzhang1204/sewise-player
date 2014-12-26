(function($){
	/**
	 * Constructor.
	 * @name ControlBar : 皮肤控制层对象.
	 * 
	 */
	var ControlBar = SewisePlayerSkin.ControlBar = function(elementObject, elementLayout, topBar, clarityWindow){
		var $container = elementObject.$container;
		var $video = elementObject.$video;
		var $controlbar = elementObject.$controlbar;
		var $playBtn = elementObject.$playBtn;
		var $pauseBtn = elementObject.$pauseBtn;
		var $stopBtn = elementObject.$stopBtn;
		var $fullscreenBtn = elementObject.$fullscreenBtn;
		var $normalscreenBtn = elementObject.$normalscreenBtn;
		var $soundopenBtn = elementObject.$soundopenBtn;
		var $soundcloseBtn = elementObject.$soundcloseBtn;
		var $volumelineVolume = elementObject.$volumelineVolume;
		var $volumelineDragger = elementObject.$volumelineDragger;
		var $volumelinePoint = elementObject.$volumelinePoint;
		//var $shareBtn = elementObject.$shareBtn;
		
		var $playtime = elementObject.$playtime;
		var $totaltime = elementObject.$totaltime;
		var $progressPlayedLine = elementObject.$progressPlayedLine;
		var $progressPlayedPoint = elementObject.$progressPlayedPoint;
		var $progressLoadedLine = elementObject.$progressLoadedLine;
		var $progressSeekLine = elementObject.$progressSeekLine;

		//////////////
		var $buffer = elementObject.$buffer;
		var $bufferTip = elementObject.$bufferTip;
		var $bigPlayBtn = elementObject.$bigPlayBtn;
		//////////////
		var $claritySwitchBtn = elementObject.$claritySwitchBtn;
		var $clarityBtnText = elementObject.$clarityBtnText;
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

		var vlPointW = 0;
		var vdLineWidth = 0;
		var vvLineWidth = 0;
		var volumePt = 0;
		var vDragging = false;
		var vBeforeDownX = 0;
		var vAfterUpX = 0;
		var isPlaying = false;
		var hideTimeout;
		var delayTime = 5000;
		
		init();
		/////////////////////////////////////////
		function init(){
			ppPointW = $progressPlayedPoint.width();
			psLineWidth = $progressSeekLine.width();

			vlPointW = $volumelinePoint.width();
			vdLineWidth = $volumelineDragger.width();

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

			hideTimeout = setTimeout(hideControlBar, delayTime);
		}
		
		/**
		 * 这里设置video不接受鼠标事件，防止android
		 * 设备下点击video时切换播放状态，以避免和
		 * container的click动作发生冲突。
		 */
		$($video).css("pointer-events", "none");
		
		$container.click(function(e){
			$container.mousemove();
			if(isPlaying){
				mainPlayer.pause();
			}else{
				mainPlayer.play();
			}
		});	
		$container.dblclick(function(e){
			if(screenState == "normal"){
				that.fullScreen();
			}else{
				that.noramlScreen();
			}
		});
		
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
			$claritySwitchBtn.hide();
			hideBar();
			topBar.hide();
			displayBar = false;
		}
		function showControlBar(){
			$claritySwitchBtn.show();
			showBar();
			topBar.show();
			displayBar = true;
		}

		$controlbar.click(function(e){
			e.originalEvent.stopPropagation();
		});
		$playBtn.click(function(){
			mainPlayer.play();
		});
		$pauseBtn.click(function(){
			mainPlayer.pause();
		});
		$stopBtn.click(function(){
			mainPlayer.stop();
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

			///////////
			$volumelineVolume.css("width", 0);
			$volumelinePoint.css("left", - vlPointW / 2);
		});
		$soundcloseBtn.click(function(){
			mainPlayer.muted(false);
			$soundopenBtn.show();
			$soundcloseBtn.hide();

			///////////
			$volumelineVolume.css("width", vvLineWidth);
			$volumelinePoint.css("left", vvLineWidth - vlPointW / 2);
		});
		$claritySwitchBtn.click(function(e){
			e.originalEvent.stopPropagation();
			clarityWindow.toggle();
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
			mainPlayer.seek(seekPt * duration);

			//console.log(seekPt * duration);
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
					//console.log("time:" + seekPt * duration);
					mainPlayer.seek(seekPt * duration);
				}
			}
			dragging = false;
		}
		////////////////////////////////////////////////////
		$volumelineDragger.mousedown(function(e){
			//console.log(e.pageX);
			vvLineWidth = (e.pageX - e.target.getBoundingClientRect().left);
			vdLineWidth = $volumelineDragger.width();
			$volumelineVolume.css("width", vvLineWidth);
			$volumelinePoint.css("left", vvLineWidth - vlPointW / 2);
			volumePt = vvLineWidth / vdLineWidth;
			mainPlayer.setVolume(volumePt);

			mutedCheck();
			//console.log(vvLineWidth);
		});
		$volumelinePoint.mousedown(function(e){
			//console.log("mousedown");
			this.blur();
			vDragging = true;
			vBeforeDownX = e.pageX;
			vvLineWidth = $volumelineVolume.width();
			vdLineWidth = $volumelineDragger.width();

			$container.bind("mousemove", vContainerMouseMoveHandler);
			$(document).bind("mouseup", vPointMouseUpHandler);
		});
		function vContainerMouseMoveHandler(e){
			var vCurrentWidth = vvLineWidth + (e.pageX - vBeforeDownX);
			if(vCurrentWidth > 0 && vCurrentWidth < vdLineWidth){
				//console.log(vCurrentWidth);
				
				$volumelineVolume.css("width", vCurrentWidth);
				$volumelinePoint.css("left", vCurrentWidth - vlPointW / 2);
			}
		}
		function vPointMouseUpHandler(e){
			//console.log("mouseup");
			
			$container.unbind("mousemove", vContainerMouseMoveHandler);
			$(document).unbind("mouseup", vPointMouseUpHandler);
			vAfterUpX = e.pageX;
			if(vBeforeDownX != vAfterUpX){
				vvLineWidth = $volumelineVolume.width();
				volumePt = vvLineWidth / vdLineWidth;
				mainPlayer.setVolume(volumePt);

				mutedCheck();
			}
			vDragging = false;
		}
		//touch事件处理///////////////////////
		$volumelinePoint.bind("touchstart", vTouchstartHandler);
		function vTouchstartHandler(event){
			//console.log("touchstart");
			e = event.originalEvent;
			//console.log(e);
			$volumelinePoint.blur();
			var touchTarget = e.targetTouches[0];
			vDragging = true;
			vBeforeDownX = touchTarget.pageX;
			//console.log("vBeforeDownX:" + vBeforeDownX);
			vvLineWidth = $volumelineVolume.width();
			vdLineWidth = $volumelineDragger.width();
			$volumelinePoint.bind("touchmove", vPointTouchMoveHandler);
			$volumelinePoint.bind("touchend", vPointTouchEndHandler);
		}
		function vPointTouchMoveHandler(event){
			//console.log("touchmove");
			e = event.originalEvent;
			//console.log(e);
			if (e.targetTouches.length == 1){
				e.preventDefault();
				var touchTarget = e.targetTouches[0];
				//console.log("touchmove pageX:" + touchTarget.pageX);
				var vCurrentWidth = vvLineWidth + (touchTarget.pageX - vBeforeDownX);
				if(vCurrentWidth > 0 && vCurrentWidth < vdLineWidth){
					$volumelineVolume.css("width", vCurrentWidth);
					$volumelinePoint.css("left", vCurrentWidth - vlPointW / 2);
				}
			}
		}
		function vPointTouchEndHandler(event){
			//console.log("touchend");
			e = event.originalEvent;
			//console.log(e);
			$volumelinePoint.unbind("touchmove", vPointTouchMoveHandler);
			$volumelinePoint.unbind("touchend", vPointTouchEndHandler);
			if (e.changedTouches.length == 1){
				var touchTarget = e.changedTouches[0];
				vAfterUpX = touchTarget.pageX;
				if(vBeforeDownX != vAfterUpX){
					vvLineWidth = $volumelineVolume.width();
					volumePt = vvLineWidth / vdLineWidth;
					//console.log("volume:" + volumePt);
					mainPlayer.setVolume(volumePt);

					mutedCheck();
				}
			}
			vDragging = false;
		}
		////////////////////////////////
		function hideBar(){
			$controlbar.css("visibility", "hidden");
		}
		function showBar(){
			$controlbar.css("visibility", "visible");
		}

		//////////////////////////////////////////
		document.addEventListener("fullscreenchange", fullscreenChangeHandler);
		document.addEventListener("MSFullscreenChange", fullscreenChangeHandler);
		document.addEventListener("mozfullscreenchange", fullscreenChangeHandler);
		document.addEventListener("webkitfullscreenchange", fullscreenChangeHandler);
		function fullscreenChangeHandler(){
			if(document.fullscreenElement != null || document.msFullscreenElement != null
				|| document.mozFullScreenElement != null || document.webkitFullscreenElement != null){
				console.log("document to fullscreen");
            	elementLayout.fullScreen();
          	}else{
          		//console.log("document to normalscreen");
            	elementLayout.normalScreen();
          	}
          	that.timeUpdate(playTime);
      	}
		$(window).bind("resize", nsResizeHandler);
		function nsResizeHandler(e){
			elementLayout.resize();
			that.timeUpdate(playTime);
		}
		function fsResizeHandler(e){
			elementLayout.fullScreen("not-support");
			that.timeUpdate(playTime);
		}

		function fullScreen(obj){
			$(window).unbind("resize", nsResizeHandler);
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
				$video.play();
				$video.webkitEnterFullscreen();
				$fullscreenBtn.show();
				$normalscreenBtn.hide();
			}else{
				//console.log("not-support");
				elementLayout.fullScreen("not-support");

				that.timeUpdate(playTime);
				$(window).bind("resize", fsResizeHandler);
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

				that.timeUpdate(playTime);
				$(window).unbind("resize", fsResizeHandler);
			}
			screenState = "normal";
			
			$(window).bind("resize", nsResizeHandler);
			return;
		}
		function mutedCheck(){
			if(volumePt > 0){
				mainPlayer.muted(false);
				$soundopenBtn.show();
				$soundcloseBtn.hide();
			}else{
				mainPlayer.muted(true);
				$soundopenBtn.hide();
				$soundcloseBtn.show();
			}
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
			//duration = totalTimes;
			
			duration = (totalTimes != Infinity) ? totalTimes : 3600;
			if(totalTimes > 1){
				durationHMS = SewisePlayerSkin.Utils.stringer.secondsToMS(duration);
			}
			
			$totaltime.text(durationHMS);

			//console.log(duration);
		}
		this.timeUpdate = function(currentTime){
			if(currentTime == undefined || currentTime == Infinity){
				currentTime = 0;
			}

			playTime = currentTime;
			playTimeHMS = SewisePlayerSkin.Utils.stringer.secondsToMS(playTime);
			$playtime.text(playTimeHMS);
			
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
		this.initVolume = function(value){
			volumePt = value;
			vvLineWidth = vdLineWidth * volumePt;
			$volumelineVolume.css("width", vvLineWidth);
			$volumelinePoint.css("left", vvLineWidth - vlPointW / 2);

			mutedCheck();
		}
		this.hide2 = function(){
			$controlbar.hide();
		}
		this.hideClarityBtn = function(){
			$claritySwitchBtn.hide();
		}
		this.updateClarityBtnPosition = function(){
			$claritySwitchBtn.css("top", "0%");
			$claritySwitchBtn.css("margin-top", "-5px");
		}
		this.updateClarityBtnText = function(value){
			$clarityBtnText.text(value);
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