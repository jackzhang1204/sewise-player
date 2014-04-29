/********************************************************************************
 * File        : BigIconContainer.as
 * Description : 大控制按钮类
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 18, 2013 10:05:12 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vspaas {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	
	import utils.Colorer;
	import skins.PlayerEvent;

	public class BigIconContainer extends MovieClip {
		public var bg:MovieClip;
		
		public function BigIconContainer() {
			this.addEventListener(MouseEvent.CLICK, bigPlayHandler);
		}
		public function playing():void{
			this.visible = false;
		}
		public function stopped():void{
			this.visible = true;
		}
		public function paused():void{
			this.visible = false;
		}
		private function bigPlayHandler(e:MouseEvent):void{
			this.dispatchEvent(new Event(PlayerEvent.PLAY));
		}
		
		public function setUiColor(color:uint):void
		{
			Colorer.SetRGB(bg, color);
		}
		
	}
}


