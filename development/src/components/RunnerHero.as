package components {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Missile;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.PhysicsCollisionCategories;
	import citrus.physics.box2d.Box2DShapeMaker;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import global.Colors;
	import global.GlobalData;
	import global.Utils;
	import com.greensock.TweenMax;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class RunnerHero extends Hero {
		private const MIN_VELOCITY:Number = 3.5;
		private const MAX_VELOCITY:Number = 8;

		private var bulletcounter:int=0;
		private var _gameData : GlobalData;
		
		public function RunnerHero(name : String, params : Object = null) {
					
			super(name, params);
			_gameData = _ce.gameData as GlobalData;
			
			_friction = 40;
			maxVelocity = MAX_VELOCITY;
					
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


		override public function update(timeDelta:Number):void {
			
				
			var velocity:b2Vec2 = _body.GetLinearVelocity();
			
			friction = _friction;
			//velocity.Add(getSlopeBasedMoveAngle());
			velocity.Add(new b2Vec2(getSlopeBasedMoveAngle().x/15, getSlopeBasedMoveAngle().y/10));
			
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

				if ((_body.GetContactList() != null) && _onGround && _ce.input.justDid("jump", inputChannel)) {
					drawSlope();
					velocity.x = + jumpHeight/3;
					velocity.y = -jumpHeight;
					onJump.dispatch();
				} else if (_ce.input.isDoing("jump", inputChannel) && !_onGround && velocity.y < 0) {
					velocity.y -= jumpAcceleration;
				}
				
				if (_ce.input.justDid("shoot")){
					var bullet:Missile;
					bullet = new Missile("bullet"+bulletcounter, {x:x + width, y:y, width:10, height:6, speed:15, angle:0});
					bulletcounter++
					_ce.state.add(bullet);
				}
				

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
		
		private function drawSlope():void {
			var slope:Sprite = new Sprite();
			slope.graphics.clear();
			slope.graphics.beginFill(Colors.BLACK);
			slope.graphics.moveTo(0, 0); 
			slope.graphics.lineTo(150,Utils.RandomIntBetween(-80,-130)); 
			slope.graphics.lineTo(150,100); 
			slope.graphics.lineTo(150,0); 
			slope.graphics.lineTo(0,0); 
			slope.graphics.endFill();
			
			//this.view = slope
			slope.rotation = 30;	
			
			slope.x = x - 35; 
			slope.y = y + 50;
			
			_gameData.hillView.addChild(slope);
			
			TweenMax.to(slope, .3 ,{y : slope.y - 10, rotation : 0, ease:Bounce.easeOut});	
		}		
		
		override public function handleBeginContact(contact:b2Contact):void {
			
			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			
			/*if (_enemyClass && collider is _enemyClass)
			{
				if (_body.GetLinearVelocity().y < killVelocity && !_hurt)
				{
					hurt();
					
					//fling the hero
					var hurtVelocity:b2Vec2 = _body.GetLinearVelocity();
					hurtVelocity.y = -hurtVelocityY;
					hurtVelocity.x = hurtVelocityX;
					if (collider.x > x)
						hurtVelocity.x = -hurtVelocityX;
					_body.SetLinearVelocity(hurtVelocity);
				}
				else
				{
					_springOffEnemy = collider.y - height;
					onGiveDamage.dispatch();
				}
			}*/
			
			//Collision angle if we don't touch a Sensor.
			if (contact.GetManifold().m_localPoint && !(collider is Sensor)) //The normal property doesn't come through all the time. I think doesn't come through against sensors.
			{			
				var collisionAngle:Number = (((new MathVector(contact.normal.x, contact.normal.y).angle) * 180 / Math.PI) + 360) % 360;// 0º <-> 360º
				//if ((collisionAngle > 45 && collisionAngle < 135)){
					_groundContacts.push(collider.body.GetFixtureList());
					_onGround = true;
					updateCombinedGroundAngle();
				//}
			}
		}
		
		
		
		
	}
}
