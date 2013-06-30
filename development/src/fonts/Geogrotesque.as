package {
	import flash.text.Font;
	/**
	 * @author Joep Suijkerbuijk � RocketScienceStudios.com
	 */
	public class Geogrotesque {
		
		[Embed(source='Geogtq-Rg.otf', fontName='Geogrotesque' , fontWeight='normal' , fontStyle='normal' , mimeType='application/x-font')]
		private static var Normal : Class;

		private static var _registered : Boolean;

		public static function get FONT() : String {
			if (!_registered) {
				Font.registerFont(Normal);
				
				_registered = true;
			}
			return "Geogrotesque";
		}
	}
}
