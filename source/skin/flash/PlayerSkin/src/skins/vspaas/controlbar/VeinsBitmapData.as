/***************************************************************
 * Author      : Jack Zhang
 * Date        : 2013-12-26 下午4:41:55
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ---------------------------------------------------------------
 * File        : VeinsBitmapData.as
 * Description : VeinsBitmapData.as
 ***************************************************************/

package skins.vspaas.controlbar
{
	import flash.display.BitmapData;
	
	public class VeinsBitmapData extends BitmapData
	{
		public function VeinsBitmapData(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}