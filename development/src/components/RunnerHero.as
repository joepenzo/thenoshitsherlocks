package components {
	import Box2D.Common.Math.b2Vec2;
	
	import citrus.objects.platformer.box2d.Hero;
	import citrus.physics.PhysicsCollisionCategories;
	import citrus.physics.box2d.Box2DShapeMaker;
	
	import flash.geom.Point;
	
	import global.GlobalData;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class RunnerHero extends Hero {
		private const MIN_VELOCITY:Number = 2;

		private var _gameData : GlobalData;
		
		public function RunnerHero(name : String, params : Object = null) {
					
			super(name, params);
			_gameData = _ce.gameData as GlobalData;
			
			_friction = 40;
			maxVelocity = 10;
					
		}
		
		override public function addPhysics():void {
			super.addPhysics();

			body.SetFixedRotation(false);
		}

		override public function destroy():void {

			super.destroy();
		}

		override protected function createShape():void
		{
			_shape = Box2DShapeMaker.Circle(radius*2, radius*2);
		}

		override protected function defineFixture():void
		{
			super.defineFixture();
			_fixtureDef.friction = _friction;
			_fixtureDef.filter.categoryBits = PhysicsCollisionCategories.Get("GoodGuys");
			_fixtureDef.filter.maskBits = PhysicsCollisionCategories.GetAll();
		}


		override public function update(timeDelta:Number):void
		{

			var velocity:b2Vec2 = _body.GetLinearVelocity();
			
			friction = _friction;
			//velocity.Add(getSlopeBasedMoveAngle());
			velocity.Add(new b2Vec2(getSlopeBasedMoveAngle().x/8, getSlopeBasedMoveAngle().y/3));
					
			if (controlsEnabled)
			{
				var moveKeyPressed:Boolean = false;

				//If player just started moving the hero this tick.
				if (moveKeyPressed && !_playerMovingHero){
					_playerMovingHero = true;
				}
				//Player just stopped moving the hero this tick.
				else if (!moveKeyPressed && _playerMovingHero) {
					_playerMovingHero = false;
					_fixture.SetFriction(_friction);
				}

//				if (_onGround && _ce.input.justDid("jump", inputChannel) && !_ducking)
//				{
//					velocity.y = -jumpHeight;
//					onJump.dispatch();
//				}
//
//				if (_ce.input.isDoing("jump", inputChannel) && !_onGround && velocity.y < 0)
//				{
//					velocity.y -= jumpAcceleration;
//				}

//				if (_springOffEnemy != -1)
//				{
//					if (_ce.input.isDoing("jump", inputChannel))
//						velocity.y = -enemySpringJumpHeight;
//					else
//						velocity.y = -enemySpringHeight;
//					_springOffEnemy = -1;
//				}

			
			}
			
			//Cap velocities
			if (velocity.x > (maxVelocity))
				velocity.x = maxVelocity;
			else if (velocity.x < (-maxVelocity))
				velocity.x = -maxVelocity;
			
			
			if (velocity.x <= MIN_VELOCITY) velocity.x = MIN_VELOCITY;
			
			
			
			//update physics with new velocity
			_body.SetLinearVelocity(velocity);
			
			updateAnimation();
			_gameData.heroPos = new Point(x,y);
			
			
		}
		
		
		
	}
}
