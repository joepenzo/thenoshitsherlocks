package components {
	import global.Colors;
	import global.Sizes;
	import flash.display.Shape;

	public class BackgroundArt extends Shape {
 
		public function BackgroundArt() {
						
			this.graphics.clear();
			this.graphics.beginFill(Colors.BACKGROUND_RED);
			this.graphics.drawRect(0, 0, Sizes.gameWidth, Sizes.gameHeight);
			this.graphics.endFill();
		}
		
	}
}