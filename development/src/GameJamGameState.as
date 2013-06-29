package {
	import flash.display.Shape;
	import global.Colors;
	import components.BackgroundArt;
	import citrus.objects.CitrusSprite;
	import citrus.core.State;
	import citrus.physics.box2d.Box2D;
	import components.RunnerHero;
	import global.GlobalData;
	import flash.geom.Point;
	import components.hill.HillManager;
	import components.hill.HillsView;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class GameJamGameState extends State {
		
		private var _gameData : GlobalData;
		private var _hero : RunnerHero;
		private var _hillsView : HillsView;
		
		public function GameJamGameState() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			_gameData = _ce.gameData as GlobalData;

			_ce.stage.addChildAt(new BackgroundArt, 0);

			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
						
			_hero = new RunnerHero("Hero", {x:100, y:-100, radius:.5});
			add(_hero);
				
			//add(new Platform("bottom", {x:100 / 2, y:0, width:300}));			
			
			_hillsView = new HillsView();
			var hills:HillManager = new HillManager("hills",{hillStartY : 1000, rider:_hero, sliceWidth: 50, roundFactor:8, sliceHeight:300, widthHills:stage.stageWidth, registration:"topLeft", view:_hillsView});
			add(hills);
			
//			var powerUp:Collectable = new Collectable("powerUp", 1, Constants.Power, {x: 400, y: 500});
//			add(powerUp);
			
			notice("State initialized");
			view.camera.setUp(_hero, new Point(stage.stageWidth / 4, stage.stageHeight / 2));
		}
		
		override public function update(timeDelta:Number):void {

			super.update(timeDelta);
			_hillsView.update();
		}
		
		
		
	}
}
