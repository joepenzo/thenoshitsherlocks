package components
{
	import citrus.objects.CitrusSprite;
	import flash.display.Sprite;
	import global.Utils;
	import com.greensock.TweenMax;
	import global.Colors;
	
	public class SlopeSprite extends CitrusSprite
	{
		public function SlopeSprite(name:String, params:Object=null)
		{
			super(name, params);

			var slope:Sprite = new Sprite();
			slope.graphics.clear();
			//slope.graphics.beginFill(0xd3d3d3);
			slope.graphics.beginFill(Colors.BLACK);
			slope.graphics.moveTo(0, 0); 
			slope.graphics.lineTo(150,Utils.RandomIntBetween(-80,-130)); 
			slope.graphics.lineTo(150,100); 
			slope.graphics.lineTo(150,0); 
			slope.graphics.lineTo(0,0); 
			slope.graphics.endFill();
			 
			this.view = slope
			this.rotation = 25;	
				
			TweenMax.to(this, .1 ,{y : this.y - 10, rotation : 0});	
		}
	}
}