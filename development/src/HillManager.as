package {
	import citrus.objects.platformer.box2d.Hills;

	/**
	 * @author ezrabotter
	 */
	public class HillManager extends Hills {
		
		private var _range:int;
		
		public function HillManager(name:String, params:Object=null)
		{
			_range = params.range;			
			_nextYPoint = params.y;
			super(name, params);
		}

		override protected function _prepareSlices():void {

			if (view)
				//@todo random width slices
				(view as HillsView).init(sliceWidth, sliceHeight);

			super._prepareSlices();
		}

		override protected function _pushHill():void {
			
			if (view)
				(view as HillsView).createSlice(body, _nextYPoint * _box2D.scale, _currentYPoint * _box2D.scale);

			super._pushHill();
		}

		override protected function _deleteHill(index:uint):void {

			(view as HillsView).deleteHill(index);

			super._deleteHill(index);
		}
	}
}
