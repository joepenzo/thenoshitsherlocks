package components
{
	import citrus.core.CitrusObject;
	import citrus.objects.CitrusSprite;
	import citrus.utils.AGameData;
	
	import components.RunnerHero;
	import components.hill.HillManager;
	
	import flash.display.Sprite;
	
	import global.Constants;
	import global.GlobalData;
	
	public class ObstacleManager extends CitrusObject
	{
		private const OBSTAClE_HEIGHT: int = 150;
		private const CLIFF_SIZE: int = 20;

		private var _gameData:GlobalData;
		
		public function ObstacleManager(name:String, params:Object=null) {
			super(name, params);
			this.updateCallEnabled = true;
			_gameData = _ce.gameData as GlobalData;
			
		}
		
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);

			if (_gameData.heroPos.x % 1000 <= 5) {
				if( Math.random() <= .5) {
					_ce.state.add( new Obstacle("tree",  Constants.obstacleLarge, {height: OBSTAClE_HEIGHT, x:_gameData.currentHillX, y:_gameData.currentHillY - OBSTAClE_HEIGHT/2 + 10}) );
				} else {
					var hill : HillManager =  _ce.state.getObjectByName("Hills") as HillManager;
					hill.createGap();
				
					var cliff : Cliff=  new Cliff( "cliff", {height: CLIFF_SIZE, width: CLIFF_SIZE, x:_gameData.currentHillX + 100 + CLIFF_SIZE/2, y:_gameData.nextHillY} );
					_ce.state.add(cliff);
				}
				
			}
			
		}
		
	}
}