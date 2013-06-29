package global {
	import citrus.utils.AGameData;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class GlobalData extends AGameData {
		
		private var _gameScore : Number = 0;
		private var _currentPowerValue : Number = 100;
		
		
		public function GlobalData() {
			super();
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
	}
}
