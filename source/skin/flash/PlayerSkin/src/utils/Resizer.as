/********************************************************************************
 * File        : ResizeTool.as
 * Description : 大小重置工具
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Feb 13, 2013 8:32:08 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package utils {
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	public class Resizer {


		/**
		 * 使用可视对象在指定容器里面，按照某一宽度的比例最大居中显示
		 * @param displayObj 被操作的可视对象
		 * @param con 指定的容器
		 * @param whObject 指定的包含宽高属性的对象
		 */
		public static function resizeInContainer(displayObj : Object,con:DisplayObject,whObject:Object) : Object{
			var newWHobj : Object = new Object();
			if(con.width/con.height <= whObject['width']/whObject['height']){
				displayObj['width'] = newWHobj['width']=con.width;
				displayObj['height'] = newWHobj['height'] = whObject['height']*newWHobj['width']/whObject['width'];
				displayObj['x'] = newWHobj['x'] = (con.width-newWHobj['width'])/2;
				displayObj['y'] = newWHobj['y'] = (con.height-newWHobj['height'])/2;
			}
			else{
				displayObj['height'] = newWHobj['height'] = con.height;
				displayObj['width'] = newWHobj['width'] = whObject['width']*newWHobj['height']/whObject['height'];
				displayObj['y'] = newWHobj['y'] = (con.height-newWHobj['height'])/2;
				displayObj['x'] = newWHobj['x'] = (con.width-newWHobj['width'])/2;
			}
			return newWHobj;
		}

		/**
		 * 使用可视对象在舞台里面，按照某一宽度的比例最大居中显示
		 * @param displayObj 被操作的可视对象
		 * @param stg 指定的容器
		 * @param whObject 指定的包含宽高属性的对象
		 */
		public static function resizeInStage(displayObj : Object,stg : Stage,whObject:Object) : Object{
			var newWHobj : Object = new Object();
			//LuminicBox.debug('ResizeParser', stg.stageWidth/stg.stageHeight+':'+displayObj['width']/displayObj['height']);
			if(stg.stageWidth/stg.stageHeight <= whObject['width']/whObject['height']){
				displayObj['width'] = newWHobj['width']=stg.stageWidth<whObject['width']?stg.stageWidth:whObject['width'];
				displayObj['height'] = newWHobj['height'] = whObject['height']*newWHobj['width']/whObject['width'];
				displayObj['x'] = newWHobj['x'] = (stg.stageWidth-newWHobj['width'])/2;
				displayObj['y'] = newWHobj['y'] = (stg.stageHeight-newWHobj['height'])/2;
			}
			else{
				displayObj['height'] = newWHobj['height'] = stg.stageHeight<whObject['height']?stg.stageHeight:whObject['height'];
				displayObj['width'] = newWHobj['width'] = whObject['width']*newWHobj['height']/whObject['height'];
				displayObj['y'] = newWHobj['y'] = (stg.stageHeight-newWHobj['height'])/2;
				displayObj['x'] = newWHobj['x'] = (stg.stageWidth-newWHobj['width'])/2;
			}
			return newWHobj;
		}


	}
}
