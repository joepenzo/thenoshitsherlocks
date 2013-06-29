package global {
	import citrus.utils.AGameData;
	import flash.geom.Point;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class GlobalData extends AGameData {
		
		private var _gameScore : Number = 0;
		private var _currentPowerValue : Number = 100;
		private var _currentCoinValue : Number = 0;
		private var _currentHillY : Number = 0;
		private var _currentHillX:Number = 0;
		private var _HeroPos:Point = new Point(0,0);
		
		
		public function GlobalData() {
			super();
		}

		public function get heroPos():Point
		{
			return _HeroPos;
		}

		public function set heroPos(value:Point):void
		{
			_HeroPos = value;
		}

		public function get currentHillX():Number
		{
			return _currentHillX;
		}

		public function set currentHillX(value:Number):void
		{
			_currentHillX = value;
		}

		public function get currentHillY():Number
		{
			return _currentHillY;
		}

		public function set currentHillY(value:Number):void
		{
			_currentHillY = value;
		}

		public function get gameScore() : Number {
			return _gameScore;
		}

		public function set gameScore(gameScore : Number) : void {
			_gameScore = gameScore;
		}

		public function get currentPowerValue() : Number {
			return _currentPowerValue;
		}

		public function set currentPowerValue(currentPowerValue : Number) : void {
			_currentPowerValue = currentPowerValue;
		}

		public function get currentCoinValue() : Number {
			return _currentCoinValue;
		}

		public function set currentCoinValue(currentCoinValue : Number) : void {
			_currentCoinValue = currentCoinValue;
		}
	}
}
