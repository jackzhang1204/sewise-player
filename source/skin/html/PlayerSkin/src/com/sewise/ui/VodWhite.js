/*
 * Name: VodWhite SewisePlayerSkin framework V1.0.0
 * Author: Jack Zhang
 * Website: http://www.sewise.com/
 * Date: 24th March 2014
 * Copyright: 2014, Sewise
 * 
 */

(function(win, $){
	$(document).ready(function(){
		var mainPlayer = SewisePlayer.IVodPlayer;
		var elementObject = new SewisePlayerSkin.ElementObject();
		var elementLayout = new SewisePlayerSkin.ElementLayout(elementObject);
		var logoBox = new SewisePlayerSkin.LogoBox(elementObject);
		var topBar = new SewisePlayerSkin.TopBar(elementObject);
		var controlBar = new SewisePlayerSkin.ControlBar(elementObject, elementLayout, topBar);
		
		
		//实现IVodSkin接口//////////////////////////////////////
		SewisePlayerSkin.IVodSkin.player = function(mPlayer){
			mainPlayer = mPlayer;
			controlBar.setPlayer(mainPlayer);
			
		}
		SewisePlayerSkin.IVodSkin.started = function(){
			controlBar.started();
		}
		SewisePlayerSkin.IVodSkin.paused = function(){
			controlBar.paused();
		}
		SewisePlayerSkin.IVodSkin.stopped = function(){
			controlBar.stopped();
		}
		SewisePlayerSkin.IVodSkin.duration = function(totalTimes){
			controlBar.setDuration(totalTimes);
		}
		SewisePlayerSkin.IVodSkin.timeUpdate = function(currentTime){
			controlBar.timeUpdate(currentTime);
		}
		SewisePlayerSkin.IVodSkin.loadedProgress = function(loadedPt){
			controlBar.loadProgress(loadedPt);
		}
		SewisePlayerSkin.IVodSkin.programTitle = function(title){
			topBar.setTitle(title);
			
			//console.log("Title: " + title);
		}
		SewisePlayerSkin.IVodSkin.logo = function(url){
			logoBox.setLogo(url);
			
			//console.log("logo: " + url);
		}


		//通知主播放器皮肤已经初始化完成.
		try{
			SewisePlayer.CommandDispatcher.dispatchEvent({type: SewisePlayer.Events.PLAYER_SKIN_LOADED, playerSkin: SewisePlayerSkin.IVodSkin});
		}catch(e){
			console.log("No Main Palyer");

			//alert("No Main Palyer");
		}
		
		//$(".sewise-player-ui").css("visibility", "hidden");
		
	})

})(window, window.jQuery);