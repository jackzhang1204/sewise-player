/********************************************************************************
 * File        : ProgressLine.as
 * Description : 播放进度条
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 14, 2013 10:57:11 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vspaas.controlbar {
	//import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import utils.Stringer;
	import utils.Colorer;
	import skins.PlayerEvent;

	public class ProgressLine extends MovieClip {
		public var playPoint:MovieClip;
		public var seekLine:MovieClip;
		public var playedLine:MovieClip;
		public var loadedLine:MovieClip;
		public var totalLine:MovieClip;
		public var lineMask:MovieClip;
		
		//播放区总长度
		private var _totalWidth:Number;
		//起始位置百分比
		private var _startPt:Number = 0;
		//本次跳转操作百分比
		private var _seekPt:Number;
		//下载进度
		private var _loadPt:Number = 0;
		//是否正在seek操作
		private var _seeking:Boolean;
		//是否正在拖动
		private var _dragging:Boolean = false;
		
		
		//拖动前播放点位置
		private var _beforeDownX:Number;
		//拖动后播放点位置
		private var _afterUpX:Number;
		//拖动timer
		private var _dragTimer:Timer;
		
		private var veinsBmpData:BitmapData;
		private var veinsLine:Sprite;
		private var playPointTime:TextField;
		private var _duration:Number = 0;
		
		public function get seekPt():Number{
			return _seekPt;
		}
		
		public function setPlayTime(time:String):void
		{
			if(!_dragging)
			{
				playPointTime.text = time;
			}
		}
		public function set duration(t:Number):void{
			_duration = t;
		}
		public function setUiColor(color:uint):void
		{
			Colorer.SetRGB(totalLine, color);
		}
		
		
		public function ProgressLine() {
			playPoint.x = 0;
			loadedLine.x = 4;
			playedLine.x = 0;
			playedLine.width = 1;
			loadedLine.width = 1;
			
			seekLine.buttonMode = true;
			//seekLine.addEventListener(MouseEvent.CLICK, seekLineHandler);
			/*seekLine.addEventListener(MouseEvent.MOUSE_OVER, tipHandler);
			seekLine.addEventListener(MouseEvent.MOUSE_MOVE, tipHandler);
			seekLine.addEventListener(MouseEvent.MOUSE_OUT, tipHandler);*/
			
			//playPoint.addEventListener(MouseEvent.MOUSE_DOWN, ppDownHandler);
			seekLine.addEventListener(MouseEvent.MOUSE_DOWN, ppDownHandler);
			
			_dragTimer = new Timer(100);
			_dragTimer.addEventListener(TimerEvent.TIMER, dragHandler);
			
			playPointTime = playPoint.time as TextField;
			playPoint.mouseChildren = false;
			playPoint.mouseEnabled = false;
			var grid:Rectangle = new Rectangle(4, 4, (totalLine.width - 8), (totalLine.height - 8));
			totalLine.scale9Grid = grid;
			
			veinsLine = new Sprite;
			veinsBmpData = new VeinsBitmapData(50, 32);
			veinsBitmapFill(veinsLine, veinsBmpData, totalLine.width, totalLine.height);
			veinsLine.mouseEnabled = false;
			this.addChildAt(veinsLine, 0);
			veinsLine.mask = playedLine;
		}
		
		public function seeking(b:Boolean):void{
			_seeking = b;
		}
		
		public function resize(w:Number):void{
			/*
			totalLine.width = w;
			seekLine.width = w;
			_totalWidth = totalLine.width - playPoint.width;
			if(_loadPt == 1) loadedLine.width = w;
			*/
			
			
			/**
			 * 修复全屏切换时加载进度条显示位置可能出错的问题.
			 * 2013.9.17 jackzhang
			 **/
			if(playPoint.x > w - playPoint.btn.width)playPoint.x = w - playPoint.btn.width;
			totalLine.width = w;
			seekLine.width = w;
			loadedLine.width = (w - 8) * _loadPt;
			playedLine.width = playPoint.x;
			_totalWidth = totalLine.width - playPoint.btn.width;
			//end 2013.9.17 jackzhang////
			
			lineMask.width = totalLine.width;
			veinsBitmapFill(veinsLine, veinsBmpData, totalLine.width, totalLine.height);
		}
		
		/**
		 * 设置播放的起始位置
		 * @param p 起始位置比例值
		 */
		public function setStartPosition(p:Number):void{
			_startPt = p;
			playPoint.x = _totalWidth * p;
			playedLine.width = _totalWidth * p;
			loadedLine.width = (_totalWidth - 8) * p;
		}
		
		/**
		 * 设置下载进度条长度
		 */
		public function setLoadProgress(p:Number):void{
			_loadPt = p;
			if(p>0) loadedLine.width = (_totalWidth - 8) * (1-_startPt) * p + (_totalWidth - 8) * _startPt + playPoint.btn.width;
		}
		
		/**
		 * 设置播放进度
		 */
		public function setPlayProgress(p:Number):void{
			//MonsterDebugger.trace(this, "_seeking:" + _seeking);
			
			if(_seeking || _dragging) return;
			playPoint.x = _totalWidth * p;
			playedLine.width = playPoint.x;
		}
		
		/**
		 * 播放停止时调用
		 */
		public function stopped():void{
			_startPt = 0;
			playPoint.x = 0;
			playedLine.width = 1;
			loadedLine.width = 1;
			_seeking = false;
		}
		
		private function seekLineHandler(e:MouseEvent):void{
			_seekPt = seekLine.mouseX * seekLine.scaleX / seekLine.width;
			playedLine.width = _seekPt * _totalWidth;
			playPoint.x = _seekPt * _totalWidth;
			//_player.seek(_seekPt);
			this.dispatchEvent(new Event(PlayerEvent.SEEK));
		}
		
		private function ppDownHandler(e:MouseEvent):void{
			_dragging = true;
			_beforeDownX = playPoint.x;
			playPoint.x = this.mouseX;
			this.stage.addEventListener(MouseEvent.MOUSE_UP, ppUpHandler);
			playPoint.startDrag(false,new Rectangle(0,0,totalLine.width-playPoint.btn.width,0));
			_dragTimer.start();
			
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, ppMoveHandler);
		}
		private function ppMoveHandler(e:MouseEvent):void{
			var timeStr:String = Stringer.secToStrMS(_duration * (playPoint.x / totalLine.width));
			playPointTime.text = timeStr;
		}
		private function ppUpHandler(e:MouseEvent):void{
			playPoint.stopDrag();
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, ppUpHandler);
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, ppMoveHandler);
			_afterUpX = playPoint.x;
			if(_beforeDownX != _afterUpX){
				_seekPt = _afterUpX/_totalWidth;
				this.dispatchEvent(new Event(PlayerEvent.SEEK));
			}
			_dragTimer.reset();
			_dragging = false;
		}
		
		private function dragHandler(e:TimerEvent):void{
			playedLine.width = playPoint.x;
		}
		
		private function tipHandler(e:MouseEvent):void{
			this.dispatchEvent(e);
		}
		
		private function veinsBitmapFill(sprite:Sprite, bmpData:BitmapData, width:Number, height:Number):void
		{
			sprite.graphics.clear()
			sprite.graphics.beginBitmapFill(bmpData, null, true);
			sprite.graphics.drawRect(0, 0, width, height);
			sprite.graphics.endFill();
		}
		
	}
}
