/********************************************************************************
 * File        : ProgressLine.as
 * Description : 直播播放进度条
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 14, 2013 10:57:11 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.flowplayer.controlbar {
	import skins.PlayerEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class LiveProgressLine extends MovieClip {
		
		public var playPoint:MovieClip;
		
		public var seekLine:MovieClip;
		
		public var playedLine:MovieClip;
		
		public var loadedLine:MovieClip;
		
		public var totalLine:MovieClip;
		
		
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


		public function get seekPt():Number{
			return _seekPt;
		}
		
		public function LiveProgressLine() {
			playPoint.x = 0;
			loadedLine.x = 0;
			playedLine.x = 0;
			playedLine.width = 1;
			seekLine.width = loadedLine.width = 1;
			
			seekLine.buttonMode = true;
			seekLine.addEventListener(MouseEvent.CLICK, seekLineHandler);
			seekLine.addEventListener(MouseEvent.MOUSE_OVER, tipHandler);
			seekLine.addEventListener(MouseEvent.MOUSE_MOVE, tipHandler);
			seekLine.addEventListener(MouseEvent.MOUSE_OUT, tipHandler);
			
			playPoint.addEventListener(MouseEvent.MOUSE_DOWN, ppDownHandler);
			_dragTimer = new Timer(100);
			_dragTimer.addEventListener(TimerEvent.TIMER, dragHandler);
		}
		
		public function seeking(b:Boolean):void{
			_seeking = b;
		}
		
		public function resize(w:Number):void{
			/*
			totalLine.width = w;
			//seekLine.width = w;
			_totalWidth = totalLine.width - playPoint.width;
			if(_loadPt == 1) seekLine.width = loadedLine.width = w;
			*/
			
			
			/**
			 * 修复全屏切换时加载进度条显示位置可能出错的问题.
			 * 2013.9.17 jackzhang
			 **/
			if(playPoint.x > w - playPoint.width)playPoint.x = w - playPoint.width;
			totalLine.width = w;
			seekLine.width = w;
			loadedLine.width = w * _loadPt;
			playedLine.width = playPoint.x + playPoint.width;
			_totalWidth = totalLine.width - playPoint.width;
			//end 2013.9.17 jackzhang////
		}
		
		/**
		 * 设置下载进度条长度
		 */
		public function setLoadProgress(p:Number):void{
			_loadPt = p;
			if(p>0) seekLine.width = loadedLine.width = _totalWidth * (1-_startPt) * p + _totalWidth * _startPt + playPoint.width;
		}
		
		/**
		 * 设置播放进度
		 */
		public function setPlayProgress(p:Number):void{
			if(_seeking || _dragging) return;
			playPoint.x = _totalWidth * p;
			playedLine.width = playPoint.x + playPoint.width;
		}
		
		/**
		 * 播放停止时调用
		 */
		public function stopped():void{
			_startPt = 0;
			playPoint.x = 0;
			playedLine.width = 1;
			seekLine.width = loadedLine.width = 1;
			_seeking = false;
		}
		
		private function seekLineHandler(e:MouseEvent):void{
			_seekPt = totalLine.mouseX * totalLine.scaleX / totalLine.width;
			
			playedLine.width = _seekPt * _totalWidth + playPoint.width;
			playPoint.x = _seekPt * _totalWidth;
			this.dispatchEvent(new Event(PlayerEvent.SEEK));
		}
		
		private function ppDownHandler(e:MouseEvent):void{
			_dragging = true;
			_beforeDownX = playPoint.x;
			this.stage.addEventListener(MouseEvent.MOUSE_UP, ppUpHandler);
			playPoint.startDrag(false,new Rectangle(0,0,loadedLine.width-playPoint.width,0));
			_dragTimer.start();
		}
		
		private function ppUpHandler(e:MouseEvent):void{
			playPoint.stopDrag();
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, ppUpHandler);
			_afterUpX = playPoint.x;
			if(_beforeDownX != _afterUpX){
				_seekPt = _afterUpX/_totalWidth;
				this.dispatchEvent(new Event(PlayerEvent.SEEK));
			}
			_dragTimer.reset();
			_dragging = false;
		}
		
		private function dragHandler(e:TimerEvent):void{
			playedLine.width = playPoint.x + playPoint.width;
		}
		
		private function tipHandler(e:MouseEvent):void{
			this.dispatchEvent(e);
		}
		
	}
}
