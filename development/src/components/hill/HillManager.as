package components.hill{
	import citrus.objects.platformer.box2d.Hills;
	import components.hill.HillsView;
	import citrus.utils.AGameData;
	import global.GlobalData;

	/**
	 * @author ezrabotter
	 */
	public class HillManager extends Hills {
		
		private var _range:int;
		private var _gameData:GlobalData;
		
		public function HillManager(name:String, params:Object=null)
		{
			super(name, params);
			_range = params.range;			
			_nextYPoint = params.y;
			_gameData = _ce.gameData as GlobalData;

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
			
			_gameData.currentHillY = _currentYPoint * _box2D.scale;
			_gameData.currentHillX = body.GetPosition().x * 30;
			
		}

		override protected function _deleteHill(index:uint):void {

			(view as HillsView).deleteHill(index);

			super._deleteHill(index);
		}
	}
}
