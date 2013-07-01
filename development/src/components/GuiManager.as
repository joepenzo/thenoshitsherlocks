package components
{
	import components.ChineseRockTextField;
	
	import fla.graphics.Splash;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import global.Colors;
	import global.Constants;
	
	public class GuiManager extends Sprite
	{
		
		private var _scoreTF:TextField;
		private var _powerBar:Sprite;
		
		public function GuiManager() {
			var title : ChineseRockTextField = new ChineseRockTextField("dhajskfhkjsdhfjdhsgf");
			addChild(title);
			
			var guiContainer : fla.graphics.Splash = new Splash();
			addChild(guiContainer);
			guiContainer.x = 700;

			_scoreTF = guiContainer.tf_score;
			_powerBar = guiContainer.powerfill;
		}
		
		public function updateScore(score:int):void {
			_scoreTF.text = String(score);
		}
		
		public function updatePower(val : Number):void {
			var percentage : Number = val/Constants.MAX_POWER;
			if (percentage >= 1) percentage = 1;
			_powerBar.scaleX = percentage;
		}
	}
}
