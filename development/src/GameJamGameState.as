package {
	import citrus.core.State;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;

	import components.Background;
	import components.ObstacleManager;
	import components.RectangleSprite;
	import components.RunnerHero;
	import components.TextFieldManager;
	import components.hill.HillManager;
	import components.hill.HillsView;
<<<<<<< HEAD

	import global.Colors;
	import global.GlobalData;

	import flash.display.Sprite;
	import flash.geom.Point;
=======
	
	import fla.hero.RunFullSpeed;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import global.Colors;
	import global.GlobalData;
>>>>>>> b15f1dd3416877772e7cad5de98d92352c66fd0b

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
		private var _tfManager:TextFieldManager;
		
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
			
			//var _backgroundTimout:int = 20000;
			//setInterval(_backgroundArt.ChangeColor,_backgroundTimout);

			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			_hero = new RunnerHero("Hero", {x:0, y:-100, radius:.5, jumpHeight:15});
			add(_hero);
							
			//_hero.view = New 
			
			add(new Platform ("Start", {y : stage.stageHeight, x:-stage.stageWidth/2, height : stage.stageHeight, width: stage.stageWidth, view: new RectangleSprite(stage.stageWidth, stage.stageHeight, Colors.BLACK)}));
			_hillsView = new HillsView();
			_hills = new HillManager("Hills",{hillStartY : stage.stageHeight/2, rider:_hero, sliceWidth:100, roundFactor:5, sliceHeight:stage.stageHeight, widthHills:stage.stageWidth, registration:"topLeft", view:_hillsView});
			add(_hills);
			
			_obstaclesManager = new ObstacleManager("obstacleManager", {});
			add(_obstaclesManager);

			add( new CitrusSprite("tfHolder" , {view: new TextFieldManager()}));
			
			view.camera.setUp(_hero, new Point(stage.stageWidth / 2, stage.stageHeight / 2));
			
			_mask = new Sprite();
			addChild(_mask);
			_mask.graphics.clear();
			_mask.graphics.beginFill(Colors.WHITE);
			_mask.graphics.drawRect( 100,0 ,stage.stageWidth,stage.stageHeight);
			_mask.graphics.endFill();
			_hillsView.mask = _mask;
<<<<<<< HEAD
			 
=======
			
			view.camera.setUp(_hero, new Point(stage.stageWidth / 2, stage.stageHeight / 2));
			//view.camera.offset = new Point(300,stage.stageHeight / 2);			
>>>>>>> b15f1dd3416877772e7cad5de98d92352c66fd0b
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
