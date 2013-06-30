package {
	import flash.utils.setInterval;
	import global.Utils;
	import global.Colors;
	import flash.geom.ColorTransform;
	import components.ObstacleManager;
	import citrus.core.State;
	import citrus.physics.box2d.Box2D;

	import components.BackgroundArt;
	import components.RunnerHero;
	import components.hill.HillManager;
	import components.hill.HillsView;

	import global.GlobalData;

	import flash.geom.Point;
	import components.ObstacleManager;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class GameJamGameState extends State {
	
		private var _gameData : GlobalData;
		private var _hero : RunnerHero;
		private var _hillsView : HillsView;
		private var _hills:HillManager;
		private var _obstaclesManager:ObstacleManager;
		private var _gameOverHandled:Boolean = false;
		
		public var _backgroundArt:BackgroundArt;
		
		public function GameJamGameState() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			_gameData = _ce.gameData as GlobalData;
			
			_backgroundArt = new BackgroundArt;
			_ce.stage.addChildAt(_backgroundArt, 0);
			//var _backgroundTimout:int = 20000;
			//setInterval(_backgroundArt.ChangeColor,_backgroundTimout);

			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);

			_hero = new RunnerHero("Hero", {x:100, y:-100, radius:.5, jumpHeight:15});
			add(_hero);
				
			_hillsView = new HillsView();
			_hills = new HillManager("Hills",{hillStartY : stage.stageHeight/2, rider:_hero, sliceWidth:100, roundFactor:5, sliceHeight:stage.stageHeight, widthHills:stage.stageWidth, registration:"topLeft", view:_hillsView});
			add(_hills);
			
			_obstaclesManager = new ObstacleManager("obstacleManager", {});
			add(_obstaclesManager);
			
			view.camera.setUp(_hero, new Point(stage.stageWidth / 2, stage.stageHeight / 2));
			notice("State initialized");
		}
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			_hillsView.update();
			
			if (_gameData.gameOver && !_gameOverHandled) handleGameOver();
		}
		
		private function handleGameOver():void {
			_gameOverHandled = true;
			fatal("GAMEOVER");
		}		

		
		
	}
}
