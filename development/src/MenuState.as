package {
	import citrus.core.CitrusObject;
	import citrus.core.State;
	import citrus.objects.CitrusSprite;
	
	import components.Background;
	import components.MenuButton;
	
	import fla.menus.MenuScreen;
	import fla.menus.intro;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import global.GlobalData;
	import global.Sizes;
	import global.Sounds;

	/**
	 * @author ezrabotter
	 */
	public class MenuState extends State {
		private var _background : Background;
		private var _buttons : Array;
		private var _menuScreen : fla.menus.MenuScreen;
		private var _intro : fla.menus.intro;
		
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
			_menuScreen = new MenuScreen();
			
			add(new CitrusSprite("bg", {view: _menuScreen,x:0,y:0,width:Sizes.gameWidth,height:Sizes.gameHeight}));			
			
			var _startBtn:MenuButton = new MenuButton("Start", {x:410,y:240,width:150,height:90});
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
					
					_intro = new intro();
					add(new CitrusSprite("intro", {view: _intro,x:0,y:0,width:Sizes.gameWidth,height:Sizes.gameHeight}));			
					_ce.sound.playSound(Sounds.AVELLACNE_TWO);
						
					setTimeout(function():void{
						_ce.state.destroy();
						_ce.state = new GameJamGameState();
					}, 2000); //4000
					
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
