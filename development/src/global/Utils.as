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
		
	}
}
