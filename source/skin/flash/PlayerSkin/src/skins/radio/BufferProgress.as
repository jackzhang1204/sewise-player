/********************************************************************************
 * File        : BufferProgress.as
 * Description : BufferProgress.as
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 17, 2013 9:32:08 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.radio {
	import flash.text.TextField;
	import flash.display.MovieClip;
	
	import utils.LanguageManager;

	public class BufferProgress extends MovieClip {
		
		public var bufferPt:TextField;
		
		public var tip:TextField;
		
		//jack fix/////
		public function initLanguage():void
		{
			tip.text = LanguageManager.getInstance().getString("loading");
		}
		//jack fix/////
		
		public function BufferProgress() {
			this.visible = false;
		}
		
		public function resize(w:Number,h:Number, controlBarBgH:Number):void{
			this.x = 15;
			this.y = (h - controlBarBgH - this.height) / 2 + 15;
		}
		
		public function setProgress(p:Number):void{
			bufferPt.text = Math.ceil(p*100) + "%";
		}
		
		
	}
}
