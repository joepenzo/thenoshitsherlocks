package components
{
	import citrus.core.CitrusObject;
	import citrus.objects.CitrusSprite;
	import citrus.utils.AGameData;
	
	import global.Constants;
	import global.GlobalData;
	import components.RunnerHero;
	
	public class ObstacleManager extends CitrusObject
	{
		private const OBSTAClE_HEIGHT: int = 150;

		private var _gameData:GlobalData;
		
		public function ObstacleManager(name:String, params:Object=null) {
			super(name, params);
			this.updateCallEnabled = true;
			_gameData = _ce.gameData as GlobalData;
		
		
		}
		
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);

			if (_gameData.heroPos.x % 700 <= 5) {
				_ce.state.add( new Obstacle("tree",  Constants.obstacleLarge, {height: OBSTAClE_HEIGHT, x:_gameData.currentHillX, y:_gameData.currentHillY - OBSTAClE_HEIGHT/2 + 10}) );
			}
			
		}
		
	}
}