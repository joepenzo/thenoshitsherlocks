package components
{
	import components.textfields.ChinesRocksTextField;
	
	import flash.display.Sprite;
	
	public class TextFieldManager extends Sprite
	{
		public function TextFieldManager() {
			var title : ChinesRocksTextField = new ChinesRocksTextField();
			addChild(title);
		}
	}
}
