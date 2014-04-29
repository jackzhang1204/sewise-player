package utils{
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	public class Colorer {
		/*public function SetColor() {

		}*/
		public static function SetRGB(obj:DisplayObject,color:Number):void {
			var colortrans:ColorTransform=new ColorTransform();
			colortrans.color=color;
			var trans:Transform=new Transform(obj);
			trans.colorTransform=colortrans;
		}
	}
}