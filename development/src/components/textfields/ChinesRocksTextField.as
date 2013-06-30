package components.textfields {
	import fonts.ChineseRocks;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import global.Colors;
	
	public class ChinesRocksTextField extends Sprite
	{
		public function ChinesRocksTextField() {
			
			var format:TextFormat = new TextFormat();
			format.size = 30;
			format.align = TextFormatAlign.CENTER;
			format.font = ChineseRocks.FONT;
			format.color = Colors.WHITE;
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.text = "Coole font yow";
			addChild(tf);
			
			tf.border = true;
			tf.wordWrap = true;
			tf.width = 150;
			tf.height = 40;
			
		}
	}
}