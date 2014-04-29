/********************************************************************************
 * File        : IClarityLevel.as
 * Description : 清晰度级别接口
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Mar 29, 2013 5:44:37 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package interfaces.player {
	public interface IClarity {
		
		function get name():String;
		function set name(n:String):void;
		
		function get id():String;
		function set id(v:String):void;
		
		function get selected():Boolean;
		function set selected(v:Boolean):void;

		function get videoUrl():String;
		function set videoUrl(v:String):void;
		
	}
}
