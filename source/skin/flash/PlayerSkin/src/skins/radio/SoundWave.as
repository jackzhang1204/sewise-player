package skins.radio {
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	public class SoundWave extends MovieClip{
		private var waveTimer:Timer;
		private var waveSprite:Sprite;
		
		private var delayTimer:uint = 500;
		private var waveHeight:int = 120;
		private var channelLength:int = 256;
		
		//private var channel1Color:uint = 0xFF0000;
		private var channel1Color:uint = 0xD69A0E;
		//private var channel2Color:uint = 0xFF0000;
		private var channel2Color:uint = 0xFCE7A8;
		
		public function SoundWave() {
			waveSprite = new Sprite;
			this.addChild(waveSprite);
			//////////////
			this.width = this.stage.stageWidth;
			this.height = 120;
			this.x = 0;
			this.y = -this.height / 2;
			
			waveTimer = new Timer(delayTimer);
			waveTimer.addEventListener(TimerEvent.TIMER, waveTimerHandler);
			waveTimer.start();
		}
		public function resize(bgW:Number, bgH:Number, controlBarBgH:Number):void
		{
			this.width = this.stage.stageWidth;
			this.height = bgH - controlBarBgH;
			this.x = 0;
			this.y = -this.height / 2 + (this.stage.stageWidth - controlBarBgH) / 2;
		}
		private function waveTimerHandler(e:TimerEvent):void
		{
			var bytes:ByteArray = new ByteArray();
			try{
				SoundMixer.computeSpectrum(bytes, false, 0);
			}catch(e:Error){
				this.visible = false;
				waveTimer.stop();
				waveTimer.removeEventListener(TimerEvent.TIMER, waveTimerHandler);
			}
			var g:Graphics = waveSprite.graphics;
			g.clear();
			g.lineStyle(1, channel1Color, 0.5, true);
			//g.beginFill(channel1Color, 0.5);
			g.moveTo(0, waveHeight);
			var n:Number = 0;
			for (var i:int = 0; i < channelLength; i++)
			{
				n = (bytes.readFloat() * waveHeight);
				g.lineTo(i * 2, waveHeight - n);
			}
			g.lineTo(channelLength * 2, waveHeight);
			//g.endFill();
			g.lineStyle(1, channel2Color, 0.5, true);
			//g.beginFill(channel2Color, 0.5);
			g.moveTo(channelLength * 2, waveHeight);
			for (i = channelLength; i > 0; i--)
			{
				n = (bytes.readFloat() * waveHeight);
				g.lineTo(i * 2, waveHeight - n);
			}
			g.lineTo(0, waveHeight);
			//g.endFill();
		}
		
		
	}
	
}
