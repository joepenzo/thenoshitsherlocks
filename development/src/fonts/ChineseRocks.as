package fonts{
	import flash.text.Font;
	/**
	 * @author Joep Suijkerbuijk � RocketScienceStudios.com
	 */
	public class ChineseRocks {
		
		[Embed(source='chinese_rocks_rg.otf', fontName='ChineseRocks' , fontWeight='regular' , fontStyle='regular' , mimeType='application/x-font')]
		private static var Regular : Class;

		private static var _registered : Boolean;

		public static function get FONT() : String {
			if (!_registered) {
				Font.registerFont(Regular);
				
				_registered = true;
			}
			return "ChineseRocks";
		}
	}
}
