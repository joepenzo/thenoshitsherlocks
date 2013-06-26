package {
	import Box2D.Dynamics.Contacts.b2Contact;

	import citrus.core.State;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class GameJamGameState extends State {
		
		public function GameJamGameState() {
			super();
		}
		
			override public function initialize():void {
			super.initialize();

			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);

			add(new Platform("bottom", {x:stage.stageWidth / 2, y:stage.stageHeight, width:stage.stageWidth}));

			add(new Platform("cloud", {x:250, y:250, width:170, oneWay:true}));

			var coin:Coin = new Coin("coin", {x:360, y:200});
			add(coin);
			coin.onBeginContact.add(coinTouched);

			var hero:Hero = new Hero("Hero", {x:stage.stageWidth - 50, y:350});
			add(hero);
		}
		
		
		private function coinTouched(contact:b2Contact):void {
			log('coin touched by an object');
		}
		
		
	}
}
