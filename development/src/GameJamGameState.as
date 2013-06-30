package {
	import components.ObstacleManager;
	import citrus.core.State;
	import citrus.physics.box2d.Box2D;

	import components.Background;
	import components.RunnerHero;
	import components.hill.HillManager;
	import components.hill.HillsView;

	import global.GlobalData;

	import flash.geom.Point;
		
	/**
	 * @author joepsuijkerbuijk
	 */
	public class GameJamGameState extends State {
	
		private var _gameData : GlobalData;
		private var _hero : RunnerHero;
		private var _hillsView : HillsView;
		private var _hills:HillManager;
		private var _obstaclesManager:ObstacleManager;
		public var _background:Background;
		
		public function GameJamGameState() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			_gameData = _ce.gameData as GlobalData;

			_background = new Background("Game");
			_ce.stage.addChildAt(_background, 0);
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);

			_hero = new RunnerHero("Hero", {x:100, y:-100, radius:.5, jumpHeight:15});
			add(_hero);
							
			_hillsView = new HillsView();
			_hills = new HillManager("Hills",{hillStartY : 1000, rider:_hero, sliceWidth:100, roundFactor:5, sliceHeight:stage.stageHeight, widthHills:stage.stageWidth, registration:"topLeft", view:_hillsView});
			add(_hills);
			
			_obstaclesManager = new ObstacleManager("obstacleManager", {});
			add(_obstaclesManager);
			
			notice("State initialized");
			view.camera.setUp(_hero, new Point(stage.stageWidth / 2, stage.stageHeight / 2));
		}
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			_hillsView.update();
		}
		
		
		
	}
}
