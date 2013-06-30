package global {
	/**
	 * @author ezrabotter
	 */
	public class Utils {
		
		public static function RandomIntBetween(min:Number,max:Number):int {
			return Math.floor(Math.random() * (1 + max - min) + min);
		}
		
		public static function getRandomElementOf(array:Array):Object {
		    var idx:int=Math.floor(Math.random() * array.length);
		    return array[idx];
		}
		
		
		public static function getLength(o:Object):uint {
			var len:uint = 0;
			for (var item:* in o)
				if (item != "mx_internal_uid")
					len++;
			return len;
		}
		
		public static function scaleObject(object:Object,scaleX:Number,scaleY:Number):Object {
			object.scaleX = scaleX;
			object.scaleY = scaleY;
			return object;
		}
		
	}
}
