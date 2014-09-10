/********************************************************************************
 * File        : SelectRadio.as
 * Description : SelectRadio.as
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 18, 2013 12:12:04 AM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vodfoream.settings {
	import skins.vodfoream.RadioCircle;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.MovieClip;

	public class SelectRadio extends MovieClip {
		
		public var labelName:TextField;
		public var radioCircle:RadioCircle;
		
		public var id:String;
		
		public function SelectRadio() {
			radioCircle.buttonMode = true;
			radioCircle.addEventListener(RadioCircle.SELECTED, selectHandler);
		}
		
		private function selectHandler(e:Event):void{
			dispatchEvent(new Event(e.type));
		}
		
		public function setName(n:String):void{
			labelName.text = n;
		}
		
	}
}
