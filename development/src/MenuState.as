package {
	import flash.display.DisplayObject;
	import citrus.core.CitrusObject;
	import global.Sizes;
	import global.GlobalData;
	import citrus.objects.CitrusSprite;
	import components.MenuButton;
	import flash.events.MouseEvent;
	import components.Background;
	import citrus.core.State;

	/**
	 * @author ezrabotter
	 */
	public class MenuState extends State {
		private var _background : Background;
		private var _buttons : Array;
		
		public function MenuState() {		
			//@todo show menu & buttons	
			//@todo CreateButton
			//@todo PressButton("Start") etc
			//@todo (pre)loader
			super();
						
		}
		
		override public function initialize():void {
			super.initialize();

			//_ce.stage.addChildAt(_background, 0);
			add(new CitrusSprite("bg", {view: new Background("Menu"),x:0,y:0,width:Sizes.gameWidth,height:Sizes.gameHeight}));			
			
			var _startBtn:MenuButton = new MenuButton("Start", {x:0,y:0,width:200,height:40});
			_startBtn.addEventListener(MouseEvent.CLICK, PressButton);
			
			_buttons = [_startBtn];
			
			for each (var i : MenuButton in _buttons) {
				_ce.stage.addChild(i);				
			}
		}

		private function PressButton(event : MouseEvent) : void {
		
			var btn:MenuButton = event.currentTarget as MenuButton;
			var name : String = btn.title as String;
			notice(name);
			
			switch(name) {
				case "Start":
					_ce.state.destroy();
					//@todo reset GameData
					//@todo load IntroScreen
					//@todo if Intro==false -> GameState.
					//state.destroy();
					for each (var i : MenuButton in _buttons) {
						_ce.stage.removeChild(i);				
					}
					_ce.state = new GameJamGameState();
					notice("Button start");
					break;
				case "Instructions":
					//@todo Instructions
					break;
				case "Highscores":
					//@todo Highscores
					break;
				case "Rewards":
					//@todo Rewards
					break;
				case "SkipIntro":
					//@todo Intro==false
					break;	
				 }
		}
		
	}
}
