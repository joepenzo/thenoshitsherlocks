package components {
	/**
	 * @author ezrabotter
	 */
	public class Achievement {
		
		private var _name:String;
		private var _score:Number;
		
		public function Achievement (score : Number) {
			_score = score;
			checkAchievement();
		}
		
		public function checkAchievement():void {
			if(_score<=1000) {
				_name = "Someone who tried";
			} else if(_score<=2000) {
				_name = "Lifesaver";
			} else if(_score<=3000) {
				_name = "Modest Hero";
			} else if(_score<=4000) {
				_name = "Mountain Slayer";
			} else if(_score<=5000) {
				_name = "The Messiah";
			} else if(_score<=6000) {
				_name = "Epic Mountain Basher";
			} else if(_score>=100000) {
				_name = "Chuck Norris!";
			} else {
				_name = "Shining Golden God";
			}
		}
		public function get name() : String {
			return _name;
		}
		
	}
}