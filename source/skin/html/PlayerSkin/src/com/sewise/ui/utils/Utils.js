(function(){
	/**
	 * Constructor.
	 * @name Utils : 皮肤层工具对象.
	 * 
	 */
	var Utils = SewisePlayerSkin.Utils = {
		stringer: {
			time2FigFill: function(num){
	        	var time;
	        	num = Math.floor(num);
				num < 10 ? time = "0" + num : time = String(num);
				return time;
			},
			secondsToHMS: function(seconds){
				if(seconds < 0) return;
				var hour = this.time2FigFill(Math.floor(seconds / 3600));
				var min = this.time2FigFill((seconds / 60) % 60);
				var sec = this.time2FigFill(seconds % 60);
				return hour + ":" + min + ":" + sec;
			},
			secondsToMS: function(seconds){
				if(seconds < 0) return;
				var min = this.time2FigFill(seconds / 60);
				var sec = this.time2FigFill(seconds % 60);
				return min + ":" + sec;
			},
			dateToTimeString: function(newDate){
				var date;
				if(newDate){
					date = newDate;
				}else{
					date = new Date();
				}
				var ye = date.getFullYear();
				var mo = date.getMonth() + 1;
				var da = date.getDate();
				var ho = this.time2FigFill(date.getHours());
				var mi = this.time2FigFill(date.getMinutes());
				var se = this.time2FigFill(date.getSeconds());
				return ye + "-" + mo + "-" + da + " " + ho + ":" + mi + ":" + se;
			},
			dateToTimeStr14: function(date){
				var ye = date.getFullYear();
				var mo = this.time2FigFill(date.getMonth() + 1);
				var da = this.time2FigFill(date.getDate());
				var ho = this.time2FigFill(date.getHours());
				var mi = this.time2FigFill(date.getMinutes());
				var se = this.time2FigFill(date.getSeconds());
				return ye + mo + da + ho + mi + se;
			},
			dateToStrHMS: function(date){
				var ho = this.time2FigFill(date.getHours());
				var mi = this.time2FigFill(date.getMinutes());
				var se = this.time2FigFill(date.getSeconds());
				return ho + ":" + mi + ":" + se;
			},
			dateToYMD: function(date){
				var ye = date.getFullYear();
				var mo = this.time2FigFill(date.getMonth() + 1);
				var da = this.time2FigFill(date.getUTCDate());
				return ye + "-" + mo + "-" + da;
			},
			hmsToDate: function(hms){
				var hmsArray = hms.split(":");
				var ho = hmsArray[0] ? hmsArray[0] : 0;
				var mi = hmsArray[1] ? hmsArray[1] : 0;
				var se = hmsArray[2] ? hmsArray[2] : 0;
				var date = new Date();
				date.setHours(ho, mi, se);
				return date;
			},
			hmsToSeconds: function(hms){
				var hmsArray = hms.split(":");
				var ho = hmsArray[0] ? parseInt(hmsArray[0]) : 0;
				var mi = hmsArray[1] ? parseInt(hmsArray[1]) : 0;
				var se = hmsArray[2] ? parseInt(hmsArray[2]) : 0;
				var seconds = ho * 3600 + mi *60 + se;
				return seconds;
			}
			
		},
		language: {
			zh_cn: {
				"stop": "停止播放",
				"pause": "暂停",
				"play": "播放",
				"fullScreen": "全屏",
				"normalScreen": "恢复",
				"soundOn": "打开声音",
				"soundOff": "关闭声音",
				"clarity": "清晰度",
				"titleTip": "正在播放：",
				"claritySetting": "清晰度设置",
				"clarityOk": "确定",
				"clarityCancel": "取消",
				"backToLive": "回到直播",
				"loading": "缓冲",
				"subtitles": "字幕",
				"default": "默认"
			},
			en_us: {
				"stop": "Stop",
				"pause": "Pause",
				"play": "Play",
				"fullScreen": "Full Screen",
				"normalScreen": "Normal Screen",
				"soundOn": "Sound On",
				"soundOff": "Sound Off",
				"clarity": "Clarity",
				"titleTip": "Playing: ",
				"claritySetting": "Definition Setting",
				"clarityOk": "OK",
				"clarityCancel": "Cancel",
				"backToLive": "Back To Live",
				"loading": "Loading",
				"subtitles": "Subtitles",
				"default": "Default"
			},
			lang:{},
			init: function(lan){
				switch(lan){
					case "en_US":
						this.lang = this.en_us;
						break;
					case "zh_CN":
						this.lang = this.zh_cn;
						break;
					default:
						this.lang = this.zh_cn;
				}
			},
			getString: function(str){
				return this.lang[str];
			}
			
		}
		
		
	};
	
})()