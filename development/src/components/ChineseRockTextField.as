package components{
	import fla.textfields.ChineseRock;
	import flash.text.TextFormat;
	import flashx.textLayout.formats.TextAlign;
	import global.Colors;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class ChineseRockTextField extends ChineseRock {
		private var format : TextFormat;
		
		public function ChineseRockTextField(label : String = "" , fontSize : int = 35, color : uint = Colors.WHITE, alignType : String = TextAlign.LEFT) {
			format = new TextFormat();
			format.size = fontSize;
			format.color = color;
			format.align = alignType;
			
			textfield.defaultTextFormat = format;
			textfield.text = label;
			textfield.selectable = false;
		}
		
		public function set text(value : String) : void {
			textfield.text = value;
		}
			
			
	}
}
