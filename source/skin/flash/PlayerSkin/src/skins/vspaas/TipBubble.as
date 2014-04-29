/********************************************************************************
 * File        : TipBubble.as
 * Description : 提示小泡
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 19, 2013 9:46:52 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vspaas {
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import flash.text.TextField;

	public class TipBubble extends MovieClip {
		
		//泡的底部小三角
		public var triangle:MovieClip;
		//泡的长方形区
		public var rectangle:MovieClip;
		//显示的信息
		private var _info:TextField;
		
		public function TipBubble() {
			this.visible = false;
			_info = rectangle["info"] as TextField;
			
		}
		
		/**
		 * 显示信息方法
		 * @param txt 信息文本
		 * @param mx 鼠标相对播放容器所在x坐标位置
		 * @param y 本提示框所在y坐位置
		 * @param l 左边边缘坐标位置
		 * @param r 右边边缘坐标位置
		 */
		public function showInfo(txt:String,mx:Number,y:Number,l:Number,r:Number):void{
			//设置显示的文本信息
			_info.text = txt;
			this.visible = true;
			
			//jack fix 2013.7.1/////////
			if(_info.length > 10)
			{
				rectangle.width = 100;
				this.width = rectangle.width;
			}else{
				rectangle.width = 70;
				this.width = rectangle.width;
			}
			//jack fix 2013.7.1/////////
			
			//设置提示泡的位置
			this.y = y;
			var x1:Number = mx - this.width/2;
			this.x = x1;

			//设置小三角形的x位置
			triangle.x = (rectangle.width - triangle.width)/2;
			if(x1<l){
				this.x = l;
				triangle.x = mx - triangle.width/2;
				return;
			}
			if(x1>r-this.width){
				this.x = r-this.width;
				triangle.x = mx + this.width - r - triangle.width/2;
			}
		}
		
	}
}
