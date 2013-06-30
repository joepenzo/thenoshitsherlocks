package {
	import flash.text.Font;
	/**
	 * @author Joep Suijkerbuijk � RocketScienceStudios.com
	 */
	public class ChineseRocks {
		
		[Embed(source='chinese_rocks_rg.otf', fontName='ChineseRocks' , fontWeight='normal' , fontStyle='normal' , mimeType='application/x-font')]
		private static var Normal : Class;

		private static var _registered : Boolean;

		public static function get FONT() : String {
			if (!_registered) {
				Font.registerFont(Normal);
				
				_registered = true;
			}
			return "ChineseRocks";
		}
	}
}
