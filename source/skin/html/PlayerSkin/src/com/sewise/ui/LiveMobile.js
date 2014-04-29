/*
 * Name: LiveWhite SewisePlayerSkin framework V1.0.0
 * Author: Jack Zhang
 * Website: http://www.sewise.com/
 * Date: 24th March 2014
 * Copyright: 2014, Sewise
 * 
 */

(function(win){
	$(document).ready(function(){
		var mainPlayer = SewisePlayer.ILivePlayer;
		var elementObject = new SewisePlayerSkin.ElementObject();
		var elementLayout = new SewisePlayerSkin.ElementLayout(elementObject);
		var logoBox = new SewisePlayerSkin.LogoBox(elementObject);
		var topBar = new SewisePlayerSkin.TopBar(elementObject);
		var controlBar = new SewisePlayerSkin.ControlBar(elementObject, elementLayout);
		
		
		//实现ILiveSkin接口//////////////////////////////////////
		SewisePlayerSkin.ILiveSkin.player = function(mPlayer){
			mainPlayer = mPlayer;
			controlBar.setPlayer(mainPlayer);
			
		}
		SewisePlayerSkin.ILiveSkin.started = function(){
			controlBar.started();
		}
		SewisePlayerSkin.ILiveSkin.paused = function(){
			controlBar.paused();
		}
		SewisePlayerSkin.ILiveSkin.stopped = function(){
			controlBar.stopped();
		}
		SewisePlayerSkin.ILiveSkin.duration = function(totalTimes){
			controlBar.setDuration(totalTimes);
		}
		SewisePlayerSkin.ILiveSkin.timeUpdate = function(currentTime){
			controlBar.timeUpdate(currentTime);
		}
		SewisePlayerSkin.ILiveSkin.loadedProgress = function(loadedPt){
			controlBar.loadProgress(loadedPt);
		}
		SewisePlayerSkin.ILiveSkin.programTitle = function(title){
			topBar.setTitle(title);
			
			//console.log("Title: " + title);
		}
		SewisePlayerSkin.ILiveSkin.logo = function(url){
			logoBox.setLogo(url);
			
			//console.log("logo: " + url);
		}
		
		
		//通知主播放器皮肤已经初始化完成.
		try{
			SewisePlayer.CommandDispatcher.dispatchEvent({type: SewisePlayer.Events.PLAYER_SKIN_LOADED, playerSkin: SewisePlayerSkin.ILiveSkin});
		}catch(e){
			console.log("No Main Palyer");
			
			//alert("No Main Palyer");
		}
		
		//$(".sewise-player-ui").css("visibility", "hidden");
		
	})

})(window);