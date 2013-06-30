package components
{
	import flash.display.Sprite;
	
	public class RectangleSprite extends Sprite
	{
		public function RectangleSprite(w : int, h: int, color: uint = 0xc0ffee) {
			this.graphics.clear();
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, w, h);			
		}
	}
}