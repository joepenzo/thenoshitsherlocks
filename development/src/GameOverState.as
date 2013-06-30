package {
	import global.Sizes;
	import citrus.objects.CitrusSprite;
	import citrus.core.State;
	import fla.menus.GameOver;
	/**
	 * @author ezrabotter
	 */
	public class GameOverState extends State {
		
		public function GameOverState() {		
			super();
		}
		
		override public function initialize():void {
			super.initialize();

//			//_ce.stage.addChildAt(_background, 0);
			add(new CitrusSprite("gameover", {view: new GameOver(),x:0,y:0,width:Sizes.gameWidth,height:Sizes.gameHeight}));			
//			
//			var _startBtn:MenuButton = new MenuButton("Start", {x:0,y:0,width:200,height:40});
//			_startBtn.addEventListener(MouseEvent.CLICK, PressButton);
//			
//			_buttons = [_startBtn];
//			
//			for each (var i : MenuButton in _buttons) {
//				_ce.stage.addChild(i);				
//			}
		}
		
	}
}
