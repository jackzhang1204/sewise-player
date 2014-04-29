package skins.vspaas
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class LogoBox extends MovieClip
	{
		private var loader:Loader;
		
		public function LogoBox()
		{
			this.addEventListener(MouseEvent.CLICK, mouseClickHandler);
		}
		private function mouseClickHandler(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://www.sewise.com/"));
		}
		public function load(url:String):void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorHandler);
			loader.load(new URLRequest(url));
		}
		private function loaderCompleteHandler(e:Event):void
		{
			while(this.numChildren)this.removeChildAt(0);
			this.addChild(loader);
			
			resize(this.stage.stageWidth);
		}
		private function loaderErrorHandler(e:Event):void
		{
			//resize(this.stage.stageWidth);
		}
		public function resize(w:Number):void
		{
			this.x = w - this.width - 15;
			this.y = 25 + 10;
		}
		
	}
}