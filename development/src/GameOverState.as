package {
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import global.GlobalData;
	import flash.events.MouseEvent;
	import components.MenuButton;
	import citrus.objects.CitrusSprite;
	import fla.menus.GameOver;
	import global.Sizes;
	import citrus.core.State;
	import components.GuiManager;
	
	/**
	 * @author ezrabotter
	 */
	public class GameOverState extends State {
		private var _btnTryAgain:MenuButton;
		private var _tfHolder:GuiManager;
		private var _gameOver:GameOver;
		private var _gameData : GlobalData;
		
		public function GameOverState() {		
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			_gameData = _ce.gameData as GlobalData;

			//_ce.stage.addChildAt(_background, 0);
			_gameOver = new GameOver();
			add(new CitrusSprite("gameover", {view: _gameOver,x:0,y:0,width:Sizes.gameWidth,height:Sizes.gameHeight}));			
			
			_btnTryAgain = new MenuButton("tryAgain", {x:560,y:400,width:305,height:139});
			_btnTryAgain.addEventListener(MouseEvent.CLICK, PressButton);
			_ce.stage.addChild(_btnTryAgain);
			
			var tf :TextFormat = new TextFormat();
			tf.size = 40;
			tf.align = TextFormatAlign.CENTER;

			_gameOver.tf_score.defaultTextFormat = tf;

			_gameOver.tf_score.text = "WITH " + _gameData.score + " POINTS";
			//_gameOver.tf_score.border =true;
			
			
		}
		
		private function PressButton(event : MouseEvent) : void {
		
			var btn:MenuButton = event.currentTarget as MenuButton;
			var name : String = btn.title as String;
			notice(name);
			
			switch(name) {
				case "tryAgain":
					notice("Try Again!");
					
					//@TODO RESET GAME
					//@TODO RESET GAMEDATA
					_gameData.score = 0;
					
//					_gameData._currentPowerValue  = 100;
//					_gameData._currentCoinValue  = 0;
//					_gameData._currentHillY  = 0;
//					_gameData._currentHillX = 0;
//					_gameData._nextHillY = 0;
//					_gameData._nextHillX = 0;
//					_gameData._HeroPos = new Point(0,0);
					
					_ce.stage.removeChild(_btnTryAgain);
					
					//@TODO MAKE IT WORK NOW!
					_ce.state = new GameJamGameState();
					
				 }
		}
		
		
	}
}
