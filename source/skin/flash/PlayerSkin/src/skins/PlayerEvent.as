/********************************************************************************
 * File        : PlayerEvent.as
 * Description : 播放器皮肤的事件
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : May 14, 2013 2:50:50 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins {
	public class PlayerEvent {
		
		/**播放操作*/
		public static const PLAY:String = "skin_op_play";
		
		/**跳转播放操作*/
		public static const SEEK:String = "skin_op_seek";
		
		/**暂停操作*/
		public static const PAUSE:String = "skin_op_pause";
		
		/**停止播放操作*/
		public static const STOP:String = "skin_op_stop";

		/**直接回到直播操作*/
		public static const LIVE:String = "skin_op_live";
		
		//音量调整
		public static const VOLUME_CHANGE:String = "volume_change";
		
		//切换清晰度
		public static const CLARITY_CHANGE:String = "clarity_change";

	}
}
