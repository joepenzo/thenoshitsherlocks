package {
	import citrus.core.State;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;

	import components.RunnerHero;

	import global.GlobalData;

	import flash.geom.Point;

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

			_hero = new RunnerHero("Hero", {x:100, y:stage.stageHeight/2});
			add(_hero);
				
	
				
//			add(new Collectables("test", "2" ,{type:"Coole type", x: 50, y:50}));
			
			//_hillsTexture = new HillsTexture();

			//var hills:HillsManagingGraphics = new HillsManagingGraphics("hills",{rider:_ball, sliceWidth:30, roundFactor:20, sliceHeight:800, widthHills:stage.stageWidth, registration:"topLeft", view:_hillsTexture});
			//add(hills);
			
			add(new Platform("bottom", {x:10000 / 2, y:stage.stageHeight - 50, width:10000}));			
			
			view.camera.setUp(_hero, new Point(stage.stageWidth/4 , stage.stageHeight/2));
			notice("State initialized");
		}
		
		override public function update(timeDelta:Number):void {

			super.update(timeDelta);
//			_hillsTexture.update();
		}
		
		
		
	}
}
