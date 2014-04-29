/***************************************************************
 * Author      : Jack Zhang
 * Date        : 2013-11-28 下午2:12:54
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ---------------------------------------------------------------
 * File        : IPlayerSkin.as
 * Description : IPlayerSkin.as
 ***************************************************************/

package interfaces.modules
{
	import flash.display.MovieClip;

	public interface IPlayerSkin
	{
		/**
		 * 获取皮肤广告MC容器对象
		 */
		function get ads():MovieClip;
		
		/**
		 * 获取皮肤视频容器对象
		 */
		function get videoBox():MovieClip;
		
	}
}