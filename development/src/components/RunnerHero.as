package components {
	import Box2D.Common.Math.b2Vec2;

	import citrus.objects.platformer.box2d.Hero;

	import global.GlobalData;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class RunnerHero extends Hero {
		private var _gameData : GlobalData;
		
		public function RunnerHero(name : String, params : Object = null) {
			super(name, params);
			_gameData = _ce.gameData as GlobalData;
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);

			// we get a reference to the actual velocity vector
			var velocity:b2Vec2 = _body.GetLinearVelocity();
				
			velocity.Add(getSlopeBasedMoveAngle());
			
			//Cap velocities
			if (velocity.x > (maxVelocity)) {
				velocity.x = maxVelocity;
			} else if (velocity.x < (-maxVelocity)) {
				velocity.x = -maxVelocity;
			}
			
		}
		
		
		
	}
}
