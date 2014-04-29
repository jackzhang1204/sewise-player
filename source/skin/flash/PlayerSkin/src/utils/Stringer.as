/********************************************************************************
 * File        : Stringer.as
 * Description : 字符串转换工具
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Jan 18, 2013 12:20:06 AM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package utils {
	
	public class Stringer {



		/**
		 * 时间字符串转成日期
		 * @param timeStr xxxx-xx-xx xx:xx:xx 或 xxxx-xx-xx
		 */
		public static function timeStrToDate(timeStr:String):Date {
			var tempArr:Array = timeStr.split(" ", 2);
			var dateArr:Array = (tempArr[0] as String).split("-", 3);
			var timeArr:Array;
			if(tempArr.length>1){
				timeArr = (tempArr[1] as String).split(":", 3);
				return new Date(Number(dateArr[0]), Number(dateArr[1])-1, Number(dateArr[2]), Number(timeArr[0]), Number(timeArr[1]), Number(timeArr[2]));
			}
			else return new Date(Number(dateArr[0]), Number(dateArr[1])-1, Number(dateArr[2]));
		}

		/**
		 * Date对象  返回 18:05:15
		 * @param date
		 */		
		public static function dateToStrHMS(date:Date):String{
			
			/**时*/
			var hours:int = date.getHours();
			
			/**分*/
			var minutes:int = date.getMinutes();
			
			/**秒*/
			var sec:int = date.getSeconds();
			
			return pack(hours) +":"+pack(minutes) +":"+pack(sec);
		}

		/**
		 *  秒数 转换  01:15:18
		 * @param sec 
		 */		
		public static function secToString(s:Number):String{
			/**小时值*/
			var hour:String = pack(Math.floor(s/3600));
			/**分钟值*/
			var min:String  = pack((s/60)%60);
			/**秒钟值*/
			var sec:String   = pack(s%60);
			
			return hour+":"+min+":"+sec;
		}
		
		public static function secToStrMS(s:Number):String{
			var min:String  = String(Math.floor(s / 60));
			var sec:String   = pack(s%60);
			return min + ":" + sec;
		}
		
		/**
		 * 将时间转换成
		 * xxxx-xx-xx xx:xx:xx字符串
		 */
		public static function dateToTimeStr(d:Date):String{
			var y:int = d.getFullYear();
			var m:int = d.getMonth()+1;
			var dd:int = d.getDate();
			var h:String = pack(d.getHours());
			var minu:String = pack(d.getMinutes());
			var s:String = pack(d.getSeconds());
			return y+'-'+m+'-'+dd+' '+h+':'+minu+':'+s;
		}
		/*public static function timeStrToDate(dateStr:String = "2013-6-25 14:20:30"):Date
		{
			var dateArray:Array = dateStr.split(" ");
			var date1:Array = dateArray[0].split("-");
			var date2:Array = dateArray[1].split(":");
			var year:Object = date1[0];
			var month:Number = date1[1];
			var date:Number = date1[2];
			var hour:Number = date2[0];
			var minute:Number = date2[1];
			var second:Number = date2[2];
			var newDate:Date = new Date(year, month, date, hour, minute, second);
			return newDate;
		}*/

		/**
		 * 将Date转换成20120125181506 
		 * @param date 标准时间
		 * @return 14位时间字符串
		 */		
		public static function dateTimeToStr14(date:Date):String{
			var year:int = date.getFullYear();
			
			var month:int = date.getMonth();
			
			var day:int = date.getDate();
			
			var hours:int = date.getHours();
			
			var minutes:int = date.getMinutes();
			
			var sec:int = date.getSeconds();
			
			return year + pack(month+1) + pack(day) + pack(hours) +pack(minutes)+pack(sec);
		}

		/**
		 * 码率转换为带单位的字符串
		 * @param b 码率，单位：位/秒
		 */
		public static function bandWidthStr(b:Number):String{
			var bw:String = "";
			if(b<1024) bw = Math.floor(b*100)/100 + " b/s";
			else if(b<1024*1024) bw = Math.floor(b*100 / 1024)/100 + " Kb/s";
			else if(b<1024*1024*1024) bw = Math.floor(b*100/1024/1024)/100 + " Mb/s";
			else if(b<1024*1024*1024*1024) bw = Math.floor(b*100/1024/1024/1024)/100 + " Gb/s";
			return bw;
		}
		
		/**
		 * 数据下载速度转换为带单位的字符串
		 * @param sp 数据下载速度，单位：字节/秒
		 */
		public static function dataSpeedStr(sp:Number):String{
			var speed:String = "";
			if(sp<1024) speed = Math.floor(sp*100)/100 + " B/s";
			else if(sp<1024*1024) speed = Math.floor(sp*100 / 1024)/100 + " KB/s";
			else if(sp<1024*1024*1024) speed = Math.floor(sp*100/1024/1024)/100 + " MB/s";
			else if(sp<1024*1024*1024*1024) speed = Math.floor(sp*100/1024/1024/1024)/100 + " GB/s";
			return speed;
		}


		/**
		 *  返回一个2位整数，单数补零，双数不变
		 * @param num 
		 */		
		public static function pack(num:int):String{
			var time:String;
			num<10 ? time = "0"   + num : time = String(num) ;
			return time;
		}





	}
}
