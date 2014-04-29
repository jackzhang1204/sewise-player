package utils
{
	public class LanguageManager
	{
		public static var language:String = "zh_CN";
		private static var instance:LanguageManager = null;
		private var langObj:Object = new Object();
		
		public function LanguageManager():void
		{
			switch (language)
			{
				case "en_US":
					en_us();
					
					break;
				case "zh_CN":
					zh_cn();
					
					break;
				default:
					zh_cn();
					
			}
		}
		
		public static function getInstance():LanguageManager
		{
			if(instance == null)
			{
				instance = new LanguageManager();
			}
			return instance;
		}
		public function getString(str:String):String
		{
			return langObj[str];
		}
		
		private function zh_cn():void
		{
			langObj.stop = "停止播放";
			langObj.pause = "暂停";
			langObj.play = "播放";
			langObj.fullScreen = "全屏";
			langObj.normalScreen = "恢复";
			langObj.soundOn = "打开声音";
			langObj.soundOff = "关闭声音";
			langObj.clarity = "清晰度";
			
			langObj.titleTip = "正在播放：";
			
			langObj.claritySetting = "清晰度设置";
			langObj.clarityOk = "确定";
			langObj.clarityCancel = "取消";
			langObj.backToLive = "回到直播";
			langObj.loading = "缓冲节目";
			
			langObj.subtitles = "字幕";
			
		}
		private function en_us():void
		{
			langObj.stop = "Stop";
			langObj.pause = "Pause";
			langObj.play = "Play";
			langObj.fullScreen = "Full Screen";
			langObj.normalScreen = "Normal Screen";
			langObj.soundOn = "Sound On";
			langObj.soundOff = "Sound Off";
			langObj.clarity = "Clarity";
			
			langObj.titleTip = "Playing:";
			
			langObj.claritySetting = "Definition Setting";
			langObj.clarityOk = "OK";
			langObj.clarityCancel = "Cancel";
			langObj.backToLive = "Back To Live";
			langObj.loading = "Loading";
			
			langObj.subtitles = "Subtitles";
		}
		
		
	}
	
}