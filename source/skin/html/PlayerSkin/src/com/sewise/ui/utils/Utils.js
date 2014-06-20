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
			}
			
			
		}
		
		
	};
	
})()