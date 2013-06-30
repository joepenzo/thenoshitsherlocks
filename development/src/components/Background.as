package components {
	import flash.display.DisplayObject;
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
		private static var _backgrounds : Array = [new hillsOne(),new hillsTwo(),new hillsThree(), new hillsFour()];
		private var _nextBg : back;
		private var _currentBg : back;
		//private var _hill : *;
		private var _currentHill : *;
		private var _nextHill : *;
		private var _bgSpeed : Number = 20;
		private var _hillSpeed : Number = 10;
		private var _hill : *;
			  
		public function Background(name:String) {
			addEventListener(Event.ENTER_FRAME, updateHills);
			
			switch(name) {
				case "Game":
					this.graphics.clear();
					this.graphics.beginFill(Colors.BACKGROUND_BLACK);
					this.graphics.drawRect(0, 0, Sizes.gameWidth, Sizes.gameHeight);
					this.alpha = 0.2;			
					setInterval(ChangeColor,_backgroundTimout);
					
					//var parallaxBg:parallaxBackground = new parallaxBackground();
					//stage.addChild(parallaxBg);
					
					var _bg:back = new back();
					_currentBg = _bg;
					_currentBg.x = 0;
					this.addChild(_currentBg);
					
					_nextBg = _bg;
					_nextBg.x = _nextBg.width;
					this.addChild(_nextBg);
							
					_currentHill = Utils.getRandomElementOf(_backgrounds);
					_currentHill.x = _currentHill.width;
					this.addChild(_currentHill);
									
					_nextHill = Utils.getRandomElementOf(_backgrounds);
					_nextHill.x = _currentHill.width*2;
					this.addChild(_nextHill);
										
					break;
				case "Menu":
					this.graphics.clear();
					this.graphics.beginFill(Colors.BACKGROUND_BLUE);
					this.graphics.drawRect(0, 0, Sizes.gameWidth, Sizes.gameHeight);	
					break;
			}
		}

		private function updateHills(event : Event) : void {
			_currentHill.x -= _hillSpeed;
			_nextHill.x -= _hillSpeed;
			_currentBg.x -= _bgSpeed;
			_nextBg.x -= _bgSpeed;
			
			if(_currentHill.x== -_currentHill.width + Sizes.gameWidth) {
				//@todo create new nextBg
				_nextHill = Utils.getRandomElementOf(_backgrounds);
				_nextHill.x = _currentHill.width;
				this.addChild(_nextHill);
			}
			
			if(_currentHill.x<=-_currentHill.width){
				this.removeChild(_currentHill);
				_currentHill = _nextHill;
			}
			
			if(_currentBg.x== -_currentBg.width + Sizes.gameWidth) {
				//@todo create new nextBg
				_nextBg = new back();
				_nextBg.x = _currentBg.width;
				this.addChild(_nextBg);
			}
			
			if(_currentBg.x<=-_currentBg.width){
				this.removeChild(_currentBg);
				_currentBg = _nextBg;
			}
			
		}
		
		public function ChangeColor():void {			
			var colors:Array = [Colors.BACKGROUND_BLUE,Colors.BACKGROUND_BLACK,Colors.BACKGROUND_ORANGE,Colors.BACKGROUND_GREEN];
			var bgColor:uint = Utils.getRandomElementOf(colors) as uint;
			TweenLite.to(this, 1, {colorTransform:{tint:bgColor, tintAmount:0.5}}); 
		}			
	}
}