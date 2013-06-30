package {
	import citrus.core.State;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.CitrusSprite;
	import citrus.objects.common.Emitter;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;

	import components.Background;
	import components.GuiManager;
	import components.ObstacleManager;
	import components.RectangleSprite;
	import components.RunnerHero;
	import components.hill.HillManager;
	import components.hill.HillsView;

	import fla.graphics.HillMask;
	import fla.graphics.RocksFalling;

	import global.Colors;
	import global.Constants;
	import global.GlobalData;

	import flash.display.Sprite;
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

		private var _gameOverHandled:Boolean = false;
		
		private var _mask:Sprite;
		private var _tfHolder:GuiManager;
		private var _indicator:Crate;
		private var _fallingRocks:CitrusSprite;
		
		public function GameJamGameState() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			_gameData = _ce.gameData as GlobalData;

			_background = new Background("Game");
			_ce.stage.addChildAt(_background, 0);
			
			_ce.input.keyboard.addKeyAction("shoot", Keyboard.COMMAND);
			_ce.input.keyboard.addKeyAction("shoot", Keyboard.CTRL);

			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			_indicator = new Crate("Indicator", {x: 100, y: 0 ,radius:20});
			add(_indicator);
			
			_fallingRocks = new CitrusSprite("rocks", {x:-1000, y:0, view: fla.graphics.RocksFalling});
			add(_fallingRocks);
			
			
			_hero = new RunnerHero("Hero", {x:150, y:-100, radius:.5, jumpHeight:15});//_hero = new RunnerHero("Hero", {x:0, y:-100, radius:.5, jumpHeight:15, view : HeroGraphics});
			add(_hero);
			_gameData.currentPowerValue = Constants.MAX_POWER;
			
			add(new Platform ("Start", {y : stage.stageHeight, x:-stage.stageWidth/2, height : stage.stageHeight, width: stage.stageWidth, view: new RectangleSprite(stage.stageWidth, stage.stageHeight, Colors.BLACK)}));
			_hillsView = new HillsView();
			_gameData.hillView = _hillsView;
			_hills = new HillManager("Hills",{hillStartY : stage.stageHeight/2, rider:_hero, sliceWidth:100, roundFactor:5, sliceHeight:stage.stageHeight, widthHills:stage.stageWidth, registration:"topLeft", view:_hillsView});
			add(_hills);

			
			_tfHolder = new GuiManager();
			stage.addChild(_tfHolder);

			_obstaclesManager = new ObstacleManager("obstacleManager", {});
			add(_obstaclesManager);	
			
//			_mask = new Sprite();
//			addChild(_mask);
//			_mask.graphics.clear();
//			_mask.graphics.beginFill(Colors.WHITE);
//			_mask.graphics.drawRect( 60,0 ,stage.stageWidth,stage.stageHeight);
//			_mask.graphics.endFill();
			_mask = new fla.graphics.HillMask();
			addChild(_mask);
			_mask.x = 55;
			_hillsView.mask = _mask;
			
			view.camera.setUp(_hero, new Point(stage.stageWidth / 2 - _hero.width, stage.stageHeight/2 + 100));
			notice("State initialized");
			
			
		}
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			_hillsView.update();
			_gameData.score++;
			
			_tfHolder.updateScore(_gameData.score);
			_tfHolder.updatePower(_gameData.currentPowerValue);
			
			
			_indicator.x = -view.camera.camPos.x + 80;
			_fallingRocks.x = -view.camera.camPos.x + 170;
			_fallingRocks.y = _indicator.y - 75 ;
			if (_indicator.y >= 600) {
				_indicator.x = 100;
				_indicator.y = -100; 
			
			}
			
			if (_gameData.gameOver && !_gameOverHandled) handleGameOver();
		}
		
		private function handleGameOver():void {
			_gameOverHandled = true;
			fatal("GAMEOVER");
			//TODO: timeout ofzo, gaat tering snel hier..
			
			var bg:Background = new Background("Game");
			bg.RemoveBg();
			
			//_ce.state = new GameOverState();
			_tfHolder.visible = false;			
		}		

		
		
	}
}
