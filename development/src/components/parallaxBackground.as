package components {
	import com.greensock.TweenMax;
	import global.Sizes;
	import com.greensock.BlitMask;
	import global.Colors;
	import fla.bg.*;
	import flash.display.Sprite;
	
	/**
	 * @author ezrabotter
	 */
	public class parallaxBackground extends Sprite {
		private static var _backgrounds : Array = [new hillsOne(),hillsTwo,hillsThree,hillsFour];

		public function parallaxBackground():void {
			notice("parallax");
			//var blitMask:BlitMask = new BlitMask(_backgrounds[0], 0, 0, Sizes.gameWidth, Sizes.gameHeight, true, true, Colors.WHITE, true);
			//stage.addChild(_backgrounds[0]);
			//TweenMax.to(_backgrounds[0], 1, {x:0, x:-900});
		}
				
		public function get backgrounds() : Array {
			return _backgrounds;
		}
		
	}
}
