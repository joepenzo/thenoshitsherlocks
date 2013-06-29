package components.hill {
	import global.Colors;
	import Box2D.Dynamics.b2Body;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author ezrabotter
	 */
	public class HillsView extends Sprite {
		private var _sliceWidth:uint;
		private var _sliceHeight:uint;
 
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
 			
			//notice('currentYPoint: ' + (currentYPoint) + "   " + 'nextYPoint: ' + (nextYPoint));
			var graphic : Sprite = new Sprite();
 			addChild(graphic);
			
			_graphics.push(graphic);	
 
			graphic.graphics.clear();
			graphic.graphics.beginFill(Colors.BLACK);
//			graphic.graphics.lineStyle(1, Colors.WHITE);
			graphic.graphics.moveTo((rider.GetPosition().x * 30), currentYPoint); 
			graphic.graphics.lineTo((rider.GetPosition().x * 30) + _sliceWidth, nextYPoint); 
			graphic.graphics.lineTo((rider.GetPosition().x * 30) + _sliceWidth, nextYPoint+_sliceHeight); 
			graphic.graphics.lineTo((rider.GetPosition().x * 30), currentYPoint+_sliceHeight); 
			graphic.graphics.lineTo((rider.GetPosition().x * 30), currentYPoint); 
			graphic.graphics.endFill();

		}
 
		public function deleteHill(index:uint):void {
 			//@todo fix delete
//			removeChild(_images[index], true);
//			_images.slice(index, 1);
		}
	}
}
