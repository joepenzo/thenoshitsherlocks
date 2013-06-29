package {
	import flash.geom.Point;
	import citrus.core.starling.StarlingState;
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
		private var _hillsView : HillsView;
		
		public function GameJamGameState() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			_gameData = _ce.gameData as GlobalData;

			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);

			_hero = new RunnerHero("Hero", {x:100, y:-100, radius:.5});
			add(_hero);
				
			//add(new Platform("bottom", {x:100 / 2, y:0, width:300}));			
			
			_hillsView = new HillsView();
			var hills:HillManager = new HillManager("hills",{hillStartY : 1000, rider:_hero, sliceWidth:30, roundFactor:20, sliceHeight:300, widthHills:stage.stageWidth, registration:"topLeft", view:_hillsView});
			add(hills);
			
//			var powerUp:Collectable = new Collectable("powerUp", 1, Constants.Power, {x: 400, y: 500});
//			add(powerUp);
			
			notice("State initialized");
			view.camera.setUp(_hero, new Point(stage.stageWidth/4 , stage.stageHeight/2));
		}
		
		override public function update(timeDelta:Number):void {

			super.update(timeDelta);
			_hillsView.update();
		}
		
		
		
	}
}
