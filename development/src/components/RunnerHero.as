package components {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusObject;
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
	
	import com.greensock.*;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import fla.hero.DamageFullSpeed;
	import fla.hero.Dead;
	import fla.hero.JumpFullSpeed;
	import fla.hero.RunFullSpeed;
	import fla.hero.RunSlow;
	import fla.hero.actionOneFullSpeed;
	import fla.hero.actionTwoFullSpeed;
	import fla.hero.actionTwoSlow;
	
	import flash.utils.*;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import global.Colors;
	import global.GlobalData;
	import global.Utils;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class RunnerHero extends Hero {
		private const MIN_VELOCITY:Number = 3.5;
		private const MAX_VELOCITY:Number = 8;

		private var bulletcounter:int=0;
		private var _gameData : GlobalData;
		
		private var A_RUN : CitrusSprite;
		private var A_ACTION_TWO : CitrusSprite;
		private var A_ACTION_ONE : CitrusSprite;
		private var A_DAMAGE : CitrusSprite;
		private var A_JUMP : CitrusSprite;
		private var A_DEAD : CitrusSprite;

		private var _heroGraphicArray : Array = [];
		private var _currAnimation:CitrusSprite;
		
		public function RunnerHero(name : String, params : Object = null) {
					
			super(name, params);
			_gameData = _ce.gameData as GlobalData;
			
			_friction = 40;
			maxVelocity = MAX_VELOCITY;
			hurtDuration = 600;
			
			
			
			
			var sprite : MovieClip = new RunFullSpeed();
			sprite.scaleX = sprite.scaleY = .3;
			A_RUN  = new CitrusSprite("A_RUN", {view :  sprite});
			A_RUN.visible = false;
			_ce.state.add(A_RUN);
			_heroGraphicArray.push(A_RUN);

			sprite = new DamageFullSpeed();
			sprite.scaleX = sprite.scaleY = .3;
			A_DAMAGE  = new CitrusSprite("A_DAMAGE", {view :  sprite});
			A_DAMAGE.visible = false;
			_ce.state.add(A_DAMAGE);
			_heroGraphicArray.push(A_DAMAGE);
			
			sprite = new JumpFullSpeed();
			sprite.scaleX = sprite.scaleY = .3;
			A_JUMP  = new CitrusSprite("A_JUMP", {view :  sprite});
			A_JUMP.visible = false;
			_ce.state.add(A_JUMP);
			_heroGraphicArray.push(A_JUMP);

			sprite  = new actionOneFullSpeed();
			sprite.scaleX = sprite.scaleY = .3;
			A_ACTION_ONE  = new CitrusSprite("A_ACTION_ONE", {view :  sprite});
			A_ACTION_ONE.visible = false;
			_ce.state.add(A_ACTION_ONE);
			_heroGraphicArray.push(A_ACTION_ONE);
			
			sprite = new actionTwoFullSpeed();
			sprite.scaleX = sprite.scaleY = .3;
			A_ACTION_TWO = new CitrusSprite("A_ACTION_TWO", {view :  sprite});
			A_ACTION_TWO.visible = false;
			_ce.state.add(A_ACTION_TWO);
			_heroGraphicArray.push(A_ACTION_TWO);

			sprite = new Dead();
			sprite.scaleX = sprite.scaleY = .3;
			A_DEAD = new CitrusSprite("A_DEAD", {view :  sprite});
			A_DEAD.visible = false;
			_ce.state.add(A_DEAD);
			_heroGraphicArray.push(A_DEAD);
			
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

		override public function hurt():void {
			_hurt = true;
			controlsEnabled = false;
			_hurtTimeoutID = setTimeout(endHurtState, hurtDuration);
			onTakeDamage.dispatch();
			
			TweenMax.to(_ce.state.view.camera.offset, 2, {x : _ce.state.view.camera.offset.x - 200} );
			
			//Makes sure that the hero is not frictionless while his control is disabled
			if (_playerMovingHero)
			{
				_playerMovingHero = false;
				_fixture.SetFriction(_friction);
			}
		}

		override public function update(timeDelta:Number):void {
				
			var velocity:b2Vec2 = _body.GetLinearVelocity();
			
			if (x + _ce.state.view.camera.camPos.x <= 70) handleGamerOver();
			
			friction = _friction;
			//velocity.Add(getSlopeBasedMoveAngle());
			if (_hurt) {
				velocity.Add(new b2Vec2(-35,0));
			} else {
				velocity.Add(new b2Vec2(getSlopeBasedMoveAngle().x/15, getSlopeBasedMoveAngle().y/10));
			}
			
			
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
			
			updateGraphicPostition();
			updateAnimation();
			_gameData.heroPos = new Point(x,y);
			
		}
		
		private function updateGraphicPostition():void {
			for each (var animation : CitrusSprite in _heroGraphicArray) {
				animation.x = x;
				animation.y = y - 30;
			}
		}
		
		override protected function updateAnimation():void {
			var prevAnimation : CitrusSprite = _currAnimation;
			
			var walkingSpeed:Number = getWalkingSpeed();
			if (_gameData.gameOver) {
				_currAnimation = A_DEAD;
			} else {
				if ((_body.GetContactList() != null)) { // ON GROUND
					_currAnimation = A_RUN;
				} else { // JUMP
					_currAnimation = A_JUMP;
				}
				if (_ce.input.justDid("shoot")){ 
					_currAnimation = this.A_ACTION_TWO;
				}
			}
			
			if (prevAnimation != _currAnimation) {
				for each (var animation : CitrusSprite in _heroGraphicArray) {
					animation.visible = false;
					if (_currAnimation == animation) animation.visible = true;
				}
			}
			
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
		
		
		
		
		public function handleGamerOver():void {
			_gameData.gameOver = true;
			body.SetAwake(false);
			_ce.state.view.camera.followTarget = false;
			TweenMax.to(this, 2.5, {y: y + _ce.stage.stageHeight, x:x + 100, onComplete: doPause });
		}
		
		private function doPause() : void {
			_ce.playing = false;
		}
	}
}
