package components
{
	import flash.display.Sprite;
	
	public class Rectangle extends Sprite
	{
		public function Rectangle(w : int, h: int, color: uint = 0xc0ffee) {
			this.graphics.clear();
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, w, h);			
		}
	}
}