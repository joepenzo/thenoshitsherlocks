package components {
	/**
	 * @author ezrabotter
	 */
	public class Achievement {
		
		private var _name:String;
		private var _score:Number;
		private var _extra:Object;
		
		public function Achievement (name : String, score : Number, extra : Object = null) {
			_name = name;
			_score = score;
			_extra = extra;
		}
		
		public function checkAchievement(userScore : Number):Boolean {
			if(userScore==_score) {
				return true;
			}
		}
		
	}
}
