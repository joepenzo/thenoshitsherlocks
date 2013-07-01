package components
{
	import citrus.core.CitrusObject;
	import citrus.objects.CitrusSprite;
	import citrus.utils.AGameData;
	
	import components.RunnerHero;
	import components.hill.HillManager;
	
	import fla.graphics.Boost;
	import fla.graphics.PowerUp;
	import fla.graphics.Tree;
	
	import flash.display.Sprite;
	
	import global.Constants;
	import global.GlobalData;
	import global.Utils;
	
	public class ObstacleManager extends CitrusObject
	{
		private const OBSTAClE_HEIGHT: int = 280;
//		private const CLIFF_WIDTH: int = 20;
		private const CLIFF_WIDTH: int = 150;
		private const CLIFF_HEIGHT: int = 20;

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
					_ce.state.add( new Obstacle("tree",  Constants.obstacleLarge, {height: OBSTAClE_HEIGHT, x:_gameData.currentHillX, y:_gameData.currentHillY - OBSTAClE_HEIGHT/2 + 10, view: Tree}) );
				} else {
					var hill : HillManager =  _ce.state.getObjectByName("Hills") as HillManager;
					hill.createGap();
				
					var cliff : Cliff=  new Cliff( "cliff", {height: CLIFF_HEIGHT, width: CLIFF_WIDTH, x:_gameData.currentHillX + 100 + CLIFF_WIDTH/2, y:_gameData.nextHillY} );
					_ce.state.add(cliff);
				}
			} 
			
			if (_gameData.heroPos.x % 350 <= 5) { 
				
				//var powerUp : PickupPowerUp =  new PickupPowerUp( "PowerUp", {height: 20, width: 20, x:_gameData.currentHillX + 100, y:Utils.RandomIntBetween(_ce.state.view.camera.camPos.y, _gameData.nextHillY)} );
				var powerUp : PickupPowerUp =  new PickupPowerUp( "PowerUp", {radius: 25, x:_gameData.currentHillX + 100, y:Utils.RandomIntBetween(_gameData.nextHillY-360, _gameData.nextHillY- 30), view: fla.graphics.PowerUp} );
				_ce.state.add(powerUp);
			}
			
			if (_gameData.heroPos.x % 1500 <= 5) { 
				var boost : PickupBoost =  new PickupBoost( "Boost", {radius: 25, x:_gameData.currentHillX + 100, y:Utils.RandomIntBetween(_gameData.nextHillY-360, _gameData.nextHillY- 30), view: fla.graphics.Boost} );
				_ce.state.add(boost);
			}
			
		}
		
	}
}