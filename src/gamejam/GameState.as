package gamejam {
	import flash.display.Sprite;
	import citrus.core.State;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	public class GameState extends State
	{
		public function GameState(){
			super();
		}
		
		override public function initialize():void {
			super.initialize();
			
			log('gamestate1');
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);

			add(new Platform("bottom", {x:stage.stageWidth / 2, y:stage.stageHeight, width:stage.stageWidth}));
			add(new Platform("cloud", {x:250, y:250, width:170, oneWay:true}));
			
			var coin:Coin = new Coin("coin", {x:360, y:200});
			add(coin);
			
			var hero:Hero = new Hero("hero", {x:100, y:350, width:60, height:135});
			add(hero);
			
			var enemy:Enemy = new Enemy("enemy", {x:stage.stageWidth - 50, y:350, width:46, height:68, leftBound:20, rightBound:stage.stageWidth - 20});
			add(enemy);
			
			log('gamestate2');
			
			var rectangle:Sprite = new Sprite; // initializing the variable named rectangle
			rectangle.graphics.beginFill(0xFF0000); // choosing the colour for the fill, here it is red
			rectangle.graphics.drawRect(0, 0, 100,100); // (x spacing, y spacing, width, height)
			rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
			stage.addChild(rectangle); // adds the rectangle to the stage
			
		}
		
	}
}