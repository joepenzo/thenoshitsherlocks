package components {
	/**
	 * @author ezrabotter
	 */
	public class AchievementManager {
		
		public static var Achievements:Array;
		public static var UserAchievements:Array;
		
		public function AchievementManager() {
			Achievements = [
				new Achievement("Test 1",1000,{description:"This is a description 1"}),
				new Achievement("Test 2",2000,{description:"This is a description 2"}),
				new Achievement("Test 3",3000,{description:"This is a description 3"}),
				new Achievement("Test 4",4000,{description:"This is a description 4"})
			];
		}
		
		public function addAchievement(score:Number):void {
			try{
				if (!checkScore(score)) {
					// no scores for achievements
					throw new Error("Invalid score!");
				}
				
				/*
				for each (var userAchievement : Object in UserAchievements.reverse()) {
					if (!checkAlreadyObtained(userAchievement.name)) {
						// achievement already obtained
						throw new Error("Invalid achievement!");				
					}
				}*/
				if (!checkAlreadyObtained(UserAchievements.reverse()[0].name)) {
					throw new Error("Last achievement already obtained");
				}
				
				//@todo Add last value of achievement to UserRewards XML
				//UserAchievements.reverse()[0]
				
			}catch(error:Error){
				// Nothing happens, no achievements obtained
			}
		}
		
		public function checkScore(score:Number):Boolean {
			for(var i:int=0;i<=Achievements.length;i++) {
				if (Achievements[i].score <= score) {
					UserAchievements.push(Achievements[i]);
				}
			}
			
			if (UserAchievements.length==0) {
				return false;
			} else {
				return true;
			}
		}
		
		public function checkAlreadyObtained(name:String):void {
			//@todo check UserRewards XML file if "name" is already obtained
			//@todo if not, return true;
		}
		
		public function get Achievements():Array
		{
			return Achievements;
		}
		
	}
}
