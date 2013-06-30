package global {
	import citrus.utils.AGameData;
	import flash.geom.Point;
	import flash.display.Sprite;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class GlobalData extends AGameData {
		
		private var _gameScore : Number = 0;
		private var _currentPowerValue : Number = 100;
		private var _currentCoinValue : Number = 0;
		private var _currentHillY : Number = 0;
		private var _currentHillX:Number = 0;
		private var _nextHillY : Number = 0;
		private var _nextHillX:Number = 0;
		private var _HeroPos:Point = new Point(0,0);
		private var _slopeView : Sprite;
		
		private var _gameOver:Boolean = false;
		
		public function GlobalData() {
			super();
		}

		public function get hillView():Sprite
		{
			return _slopeView;
		}

		public function set hillView(value:Sprite):void
		{
			_slopeView = value;
		}

		public function get gameOver():Boolean
		{
			return _gameOver;
		}

		public function set gameOver(value:Boolean):void
		{
			_gameOver = value;
		}

		public function get nextHillX():Number
		{
			return _nextHillX;
		}

		public function set nextHillX(value:Number):void
		{
			_nextHillX = value;
		}

		public function get nextHillY():Number
		{
			return _nextHillY;
		}

		public function set nextHillY(value:Number):void
		{
			_nextHillY = value;
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
