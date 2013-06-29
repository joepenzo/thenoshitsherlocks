package {
	import global.Constants;
	import components.Collectable;
	import components.RunnerHero;
	import citrus.core.State;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;

	import global.GlobalData;
	
	/**
	 * @author joepsuijkerbuijk
	 */
	public class GameJamGameState extends State {
		
		private var _gameData : GlobalData;
		private var _hero : RunnerHero;
		private var _powerUp : Collectable;
		
		public function GameJamGameState() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();

			_gameData = _ce.gameData as GlobalData;

			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);

			add(new Platform("bottom", {x:10000 / 2, y:stage.stageHeight - 50, width:10000}));

			_hero = new RunnerHero("Hero", {x:100, y:stage.stageHeight/2});
			add(_hero);

//			var coin:Coin = new Coin("coin", {x:360, y:400});
//			add(coin);
//			coin.onBeginContact.add(coinTouched);

			// In a GameState, the parameters are the object to follow, the offset, the bounds and the easing.
			//view.camera.setUp(_hero, new Point(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, stage.stageWidth, stage.stageHeight), new Point(.25, .05));
			
			
			//_powerUp = new Collectable("Power", Constants.Power, 1, {x: 400, y: 500});
			//add(_powerUp);
			
//			_powerUp = new Collectable("Power", Constants.Power, 1, {x: 500, y: 500});
//			add(_powerUp);

			notice("State initialized");
			debug(_hero.x);
			error(_gameData.currentPowerValue);
			
		}
		
		
//		private function coinTouched(contact:b2Contact):void {
//			log('coin touched by an object');
//		}
		
		
	}
}
