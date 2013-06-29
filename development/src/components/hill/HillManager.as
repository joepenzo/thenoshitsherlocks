package components.hill{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Hills;
	import citrus.utils.AGameData;
	
	import components.hill.HillsView;
	
	import flash.utils.*;
	
	import global.GlobalData;

	/**
	 * @author ezrabotter
	 */
	public class HillManager extends Hills {
		
		private var _gameData:GlobalData;
		private var _createGap:Boolean = false;;
		private var _gc:int = 0;
		
		public function HillManager(name:String, params:Object=null)
		{
			super(name, params);
			_gameData = _ce.gameData as GlobalData;

		}

		override protected function _prepareSlices():void {

			if (view)
				(view as HillsView).init(sliceWidth, sliceHeight);

			_slices = new Vector.<b2Body>();
			
			// Generate a line made of b2Vec2
			_sliceVectorConstructor = new Vector.<b2Vec2>();
			_sliceVectorConstructor.push(new b2Vec2(0, _realHeight));
			_sliceVectorConstructor.push(new b2Vec2(sliceWidth/_box2D.scale, _realHeight));
			
			// fill the stage with slices of hills
			for (var i:uint = 0; i < widthHills / sliceWidth * 1.5; ++i) {
				_createSlice();
			}
			
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
			if (view) {
				if (_createGap) {
					setTimeout(function() : void {
						_createGap = false;
					}, 300);
				} else {
					(view as HillsView).createSlice(body, _nextYPoint * _box2D.scale, _currentYPoint * _box2D.scale);
				}
			}
			super._pushHill();
			
			_gameData.currentHillY = _currentYPoint * _box2D.scale;
			_gameData.currentHillX = body.GetPosition().x * 30;
			
			_gameData.nextHillY = _nextYPoint * _box2D.scale;
			
		}
		
		override protected function _deleteHill(index:uint):void {

			(view as HillsView).deleteHill(index);

			super._deleteHill(index);
		}
		
		
		override protected function _checkHills():void {
			
			if (!rider)
				rider = _ce.state.getFirstObjectByType(Hero) as Hero;

			var length:uint = _slices.length;
			
			for (var i:uint = 0; i < length; ++i) {
				
				if (rider.x - _slices[i].GetPosition().x*_box2D.scale > widthHills/2) {
					
					_deleteHill(i);
					--i;
					_createSlice();
					
				} else
					break;
			}
		}
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			_checkHills();
		}
		
		public function createGap():void {
			_createGap = true;
		}
	}
}
