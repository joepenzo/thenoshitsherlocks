package components.hill{
	import citrus.objects.platformer.box2d.Hills;
	import components.hill.HillsView;
	import citrus.utils.AGameData;
	import global.GlobalData;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;

	/**
	 * @author ezrabotter
	 */
	public class HillManager extends Hills {
		
		private var _gameData:GlobalData;
		
		public function HillManager(name:String, params:Object=null)
		{
			super(name, params);
			_gameData = _ce.gameData as GlobalData;

		}

		override protected function _prepareSlices():void {

			if (view)
				//@todo random width slices
				(view as HillsView).init(sliceWidth, sliceHeight);

			super._prepareSlices();
		}
		
		override protected function _createSlice():void {
			// Every time a new hill has to be created this algorithm predicts where the slices will be positioned
			if (_indexSliceInCurrentHill >= _slicesInCurrentHill) {
				hillStartY += _randomHeight;
				
				if(roundFactor == 0) ++roundFactor;			
				
				_upAmplitude = 0;
				_downAmplitude = 0;
				
				var hillWidth:Number = sliceWidth * roundFactor + Math.ceil(Math.random() * roundFactor) * sliceWidth;
				
//				_slicesInCurrentHill = hillWidth / sliceWidth;
				_slicesInCurrentHill = hillWidth / sliceWidth*.5;
				notice(_slicesInCurrentHill);
				if(_slicesInCurrentHill % 2 != 0) ++_slicesInCurrentHill;
				
				_indexSliceInCurrentHill = 0;
				
				if (_realWidth > 0)
				{
					do {
//						_upAmplitude =  Math.random() * hillWidth / 7.5;
						_upAmplitude =  Math.random() * hillWidth / 15;
					} while (Math.abs(_realHeight  + _upAmplitude) > 600);
					
					do {
//						_downAmplitude =  Math.random() * hillWidth / 7.5;
						_downAmplitude =  Math.random() * hillWidth / 15;
					} while (Math.abs(_realHeight - _downAmplitude) < 10);
				} else {
					_upAmplitude = 0;
					_downAmplitude = 0;
				}
				
				_realWidth += hillWidth;
				
				_randomHeight = _upAmplitude;
				_realHeight += _upAmplitude;
				_realHeight -= _downAmplitude;
				hillStartY -= _randomHeight;
			}
			
			
			if (_indexSliceInCurrentHill == _slicesInCurrentHill / 2)
			{
				hillStartY -= _upAmplitude;
				_randomHeight = _downAmplitude;	
				hillStartY += _randomHeight;
			}
			
			// Calculate the position slice
			_currentYPoint = _sliceVectorConstructor[0].y = (hillStartY + _randomHeight *  Math.cos(2 * Math.PI / _slicesInCurrentHill * _indexSliceInCurrentHill)) / _box2D.scale;
			_nextYPoint =_sliceVectorConstructor[1].y = (hillStartY + _randomHeight *  Math.cos(2 * Math.PI / _slicesInCurrentHill * (_indexSliceInCurrentHill+1))) / _box2D.scale;
			
			var slicePolygon:b2PolygonShape = new b2PolygonShape();
			slicePolygon.SetAsVector(_sliceVectorConstructor, 2);
			
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set(_slicesCreated * sliceWidth/_box2D.scale, 0);
			
			var sliceFixture:b2FixtureDef = new b2FixtureDef();
			sliceFixture.shape = slicePolygon;
			
			_body = _box2D.world.CreateBody(_bodyDef);
			_body.SetUserData(this);
			_body.CreateFixture(sliceFixture);
			_pushHill();
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
