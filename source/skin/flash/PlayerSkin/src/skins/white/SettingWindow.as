/********************************************************************************
 * File        : SettingWindow.as
 * Description : SettingWindow.as
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 17, 2013 10:30:36 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.white {
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.display.MovieClip;

	public class SettingWindow extends MovieClip {
		
		public var closeBtn:SimpleButton;
		public var title:TextField;
		public var submitBtn:SimpleButton;
		public var cancelBtn:SimpleButton;
		
		public var okText:TextField;
		public var cancelText:TextField;
		
		//protected var _white:Orange;
		
		public function SettingWindow() {
			closeBtn.addEventListener(MouseEvent.CLICK, closeHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			
			cancelBtn.addEventListener(MouseEvent.CLICK, closeHandler);
			submitBtn.addEventListener(MouseEvent.CLICK, submitHandler);
		}
		
		//public function setOrange(o:Orange):void{
		//	_white = o;
		//}

		public function resize(w:Number,h:Number):void{
			this.x = (w - this.width) / 2;
			this.y = (h - this.height) / 2;
		}
		
		protected function submitHandler(e:MouseEvent):void{
			//TODO in subclass
		}
		
		protected function closeHandler(e:MouseEvent):void{
			this.visible = false;
			//TODO in subclass
		}
		
		private function downHandler(e:MouseEvent):void{
			//this.startDrag(false,new Rectangle(0,0,_white.bg.width - this.width,_white.bg.height-this.height));
			this.startDrag(false,new Rectangle(0,0,this.parent.width - this.width,this.parent.height-this.height));
		}
		
		private function upHandler(e:MouseEvent):void{
			this.stopDrag();
		}



	}
}
