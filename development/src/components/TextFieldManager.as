package components
{
	import components.ChineseRockTextField;
	
	import fla.graphics.Splash;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class TextFieldManager extends Sprite
	{
		
		private var _scoreTF:TextField;
		
		public function TextFieldManager() {
			var title : ChineseRockTextField = new ChineseRockTextField("dhajskfhkjsdhfjdhsgf");
			addChild(title);
			
			var guiContainer : Splash = new Splash();
			addChild(guiContainer);
			guiContainer.x = 700;
			
			_scoreTF = guiContainer.tf_score;
		}
		
		public function updateScore(score:int):void {
			_scoreTF.text = String(score);
		}
	}
}
