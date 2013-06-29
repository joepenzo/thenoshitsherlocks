package {
	import global.Colors;
	import away3d.events.ParserEvent;
	import components.RunnerHero;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author ezrabotter
	 */
	public class HillsView extends Sprite {
//		private var _groundTexture:Texture;
		private var _sliceWidth:uint;
		private var _sliceHeight:uint;
 
//		private var _images:Vector.<Image>;
 		private var _graphics:Array;
		
		private var _flagAdded:Boolean = false;
 
		public function HillsView() {
		}
 
		public function init(sliceWidth:uint, sliceHeight:uint):void {
 
			_sliceWidth = sliceWidth;
			_sliceHeight = sliceHeight;
 
 			_graphics = new Array();
			addEventListener(Event.ADDED, _added);
		}
 
		private function _added(evt:Event):void {
 
			_flagAdded = true;
 
			removeEventListener(Event.ADDED_TO_STAGE, _added);
		}
 
		public function update():void {
			// we don't want to move the parent like StarlingArt does!
			if (_flagAdded)
				this.parent.x = this.parent.y = 0;
		}

		public function createSlice(rider : b2Body, nextYPoint : uint, currentYPoint : uint) : void {
 			
			notice('currentYPoint: ' + (currentYPoint) + "   " + 'nextYPoint: ' + (nextYPoint));
			var graphic : Sprite = new Sprite();
 			addChild(graphic);
			
			_graphics.push(graphic);	
 
			graphic.graphics.clear();
			graphic.graphics.beginFill(Colors.BLACK);
			graphic.graphics.drawRect( (rider.GetPosition().x * 30),currentYPoint ,_sliceWidth,_sliceHeight);
			
			//graphic.graphics.moveTo((rider.GetPosition().x * 30), currentYPoint); 
			//graphic.graphics.lineTo((rider.GetPosition().x * 30) + _sliceWidth, currentYPoint); 
			
			graphic.graphics.endFill();
			
			
			/*my_shape.graphics.moveTo(50, 50); 
			my_shape.graphics.lineTo(100, 50);
			my_shape.graphics.lineTo(100, 100);
			my_shape.graphics.lineTo(50, 100);
			my_shape.graphics.lineTo(50, 50);*/
		}
 
		public function deleteHill(index:uint):void {
 
//			removeChild(_images[index], true);
//			_images.slice(index, 1);
		}
	}
}
