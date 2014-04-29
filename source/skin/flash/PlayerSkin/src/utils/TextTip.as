/********************************************************************************
 * File        : TextTip.as
 * Description : 播放器信息提示
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 1, 2013 5:23:40 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package utils {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.text.TextFormatAlign;

	public class TextTip extends MovieClip {
		
		private var _info:TextField;
		private var _container:Sprite;
		private var _showTimer:Timer;
		
		/**
		 * 文字提示
		 * @param info 提示信息
		 * @param color 文本颜色
		 * @param size 文本大小
		 */
		public function TextTip(container:Sprite) {
			_container = container;
			_container.addChild(this);
			_showTimer = new Timer(3000,1);
			_showTimer.addEventListener(TimerEvent.TIMER_COMPLETE, tipHideHandler);
		}
		
		/**
		 * 显示提示字符
		 * @param txt 所显示的字符
		 * @param time 显示多长时间，单位：秒，0表示一直显示
		 */
		public function show(txt:String,time:Number=0):void{
			if(_info) this.hide();
			_info = new TextField();
			_info.background = true;
			_info.backgroundColor = 0x000000;
			_info.alpha = 0.7;
			_info.wordWrap = false;
			_info.autoSize = "left";
			_info.text = txt;
			var tf:TextFormat = new TextFormat("Microsoft YaHei",15,0xFFFFFF);
			tf.align = TextFormatAlign.CENTER;
			tf.leftMargin = 5;
			tf.rightMargin = 5;
			tf.leading = 2;
			_info.setTextFormat(tf);
			_info.x=0;
			this.addChild(_info);
			this.center();
			
			if(time){
				_showTimer.delay = time * 1000;
				_showTimer.start();
			}
		}
		
		/**
		 * 设置tip要显示的文字内容
		 */
		public function hide():void{
			if(!_info) return;
			this.removeChild(_info);
			_info = null;
		}
		
		/**
		 * 居中
		 */
		private function center():void{
			this.x = (_container.stage.stageWidth - this.width) / 2;
			this.y = (_container.stage.stageHeight - this.height) / 2;
		}
		
		private function tipHideHandler(e:TimerEvent):void{
			_showTimer.reset();
			this.hide();
		}
		
		
	}
}
