package components.hill{
	import citrus.objects.platformer.box2d.Hills;
	import components.hill.HillsView;

	/**
	 * @author ezrabotter
	 */
	public class HillManager extends Hills {
		public function HillManager(name:String, params:Object=null)
		{
			_nextYPoint = params.y;
			super(name, params);
		}

		override protected function _prepareSlices():void {

			if (view)
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
