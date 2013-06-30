package components {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import fla.bg.*;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.utils.setInterval;
	import global.Utils;
	import com.greensock.TweenLite;
	import com.greensock.plugins.TweenPlugin; 
	import com.greensock.plugins.ColorTransformPlugin; 
	import global.Colors;
	import global.Sizes;
	TweenPlugin.activate([ColorTransformPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.

	public class Background extends Sprite {
  	  	
		private static var _backgroundTimout : int = 8000;
		
		public function Background(name:String) {
			
			switch(name) {
				case "Game":
					
					//this.graphics.clear();
					var _bgcolor:Graphics = this.graphics;
					_bgcolor.beginFill(Colors.BACKGROUND_BLUE);
					_bgcolor.drawRect(0, 0, Sizes.gameWidth, Sizes.gameHeight);
					setInterval(ChangeColor,_backgroundTimout);
					
					var _hills:hillsbg = new hillsbg();
					_hills.x = 0;
					this.addChild(_hills);
					
					var _bg:back = new back();
					_bg.x = 0;
					_bg.alpha = 0.2;
					this.addChildAt(_bg,0);
					
					//var parallaxBg:parallaxBackground = new parallaxBackground();
					//stage.addChild(parallaxBg);
										
					break;
				case "Menu":
					this.graphics.clear();
					this.graphics.beginFill(Colors.BACKGROUND_BLUE);
					this.graphics.drawRect(0, 0, Sizes.gameWidth, Sizes.gameHeight);	
					break;
			}
		}
		
		public function ChangeColor():void {			
			var colors:Array = [Colors.BACKGROUND_BLUE,Colors.BACKGROUND_BLACK,Colors.BACKGROUND_ORANGE,Colors.BACKGROUND_GREEN];
			var bgColor:uint = Utils.getRandomElementOf(colors) as uint;
			TweenLite.to(this, 1, {colorTransform:{tint:bgColor, tintAmount:0.5}}); 
		}			
	}
}