/********************************************************************************
 * File        : RadioCircle.as
 * Description : SelectRadio中的选择小圆圈
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 17, 2013 10:47:35 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.orange {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;

	public class RadioCircle extends MovieClip {
		
		public static const SELECTED:String = "radio_selected";
		
		public var point:MovieClip;
		
		private var _selected:Boolean = false;
		
		public function RadioCircle(selected:Boolean = false) {
			_selected = selected;
			point.visible = _selected;
			this.addEventListener(MouseEvent.CLICK, selectHandler);
		}
		
		public function set selected(b:Boolean):void{
			_selected = b;
			point.visible = b;
		}

		public function get selected():Boolean{
			return _selected;
		}
		
		private function selectHandler(e:MouseEvent):void{
			if(_selected) return;
			selected = true;
			dispatchEvent(new Event(SELECTED));
		}
		
		
		
	}
}
