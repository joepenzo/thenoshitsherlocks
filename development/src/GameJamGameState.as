package {
	import components.Collectables;
	import components.RunnerHero;
	import flash.geom.Point;
	import citrus.core.State;
	import citrus.math.MathVector;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;

	import global.GlobalData;

	import flash.geom.Rectangle;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class GameJamGameState extends State {
		
		private var _gameData : GlobalData;
		private var _hero : RunnerHero;
		
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
			
			notice("State initialized");
			debug(_hero.x);
			error(_gameData.currentPowerValue);
			
			add(new Collectables("test", "2" ,{type:"Coole type", x: 50, y:50}));
		}
		
		
//		private function coinTouched(contact:b2Contact):void {
//			log('coin touched by an object');
//		}
		
		
	}
}
