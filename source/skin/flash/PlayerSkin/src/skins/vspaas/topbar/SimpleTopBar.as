/********************************************************************************
 * File        : TopBar.as
 * Description : TopBar.as
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 14, 2013 11:04:04 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vspaas.topbar {
	import fl.transitions.easing.Regular;
	import fl.transitions.Tween;
	import flash.text.TextField;
	import flash.display.MovieClip;

	public class SimpleTopBar extends MovieClip {
		
		public var topBarBg:MovieClip;
		
		//播放时间
		public var playTime:TextField;

		//总时间字符串
		public var totalTime:String = "00:00:00";
		
		public function SimpleTopBar() {
			
		}
		
		public function resize(w:Number):void{
			topBarBg.width = w;
			show();
		}
		
		//播放时间字符串
		public function set playedTime(t:String):void{
			playTime.text = t + "/" + totalTime;
		}

		/**
		 * 播放时间重置
		 */
		private function playTimeReset():void{
			playTime.text = "00:00:00/00:00:00";
		}
		
		public function stopped():void{
			playTimeReset();
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
