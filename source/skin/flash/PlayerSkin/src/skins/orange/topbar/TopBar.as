/********************************************************************************
 * File        : TopBar.as
 * Description : TopBar.as
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 14, 2013 11:04:04 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.orange.topbar {
	import fl.transitions.easing.Regular;
	import fl.transitions.Tween;
	import flash.text.TextField;
	import flash.display.MovieClip;
	
	import utils.LanguageManager;

	public class TopBar extends MovieClip {
		
		public var topBarBg:MovieClip;
		
		public var programTitle:MovieClip;
		
		public var playerClock:MovieClip;
		
		public function TopBar() {
			
		}
		
		//jack fix/////
		public function initLanguage():void
		{
			(programTitle["tip"] as TextField).text = LanguageManager.getInstance().getString("titleTip");
		}
		//jack fix/////
		
		public function resize(w:Number):void{
			topBarBg.width = w;
			playerClock.x = w - playerClock.width;
			show();
		}
		
		public function setTitle(t:String):void{
			(programTitle["title"] as TextField).text = t;
		}
		
		public function setClock(t:String):void{
			(playerClock["clockTime"] as TextField).text = t;
		}
		
		
		public function show():void{
			var _showTween:Tween = new Tween(this, "y", Regular.easeOut, this.y, 0, 0.5, true);
			_showTween.start();
		}
		
		public function hide():void{
			var _hideTween:Tween = new Tween(this, "y", Regular.easeOut, this.y, -this.height, 1, true);
			_hideTween.start();
		}

		
		
	}
}
