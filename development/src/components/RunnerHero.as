package components {
	import citrus.objects.platformer.box2d.Missile;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;

	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.PhysicsCollisionCategories;
	import citrus.physics.box2d.Box2DShapeMaker;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;

	import fla.graphics.AllSlopes;
	import fla.graphics.Bullet;
	import fla.hero.DamageFullSpeed;
	import fla.hero.Dead;
	import fla.hero.JumpFullSpeed;
	import fla.hero.RunFullSpeed;
	import fla.hero.actionOneFullSpeed;
	import fla.hero.actionTwoFullSpeed;

	import global.GlobalData;

	import com.greensock.*;
	import com.greensock.easing.*;

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.*;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.core.IState;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class RunnerHero extends Hero {
		private const MIN_VELOCITY:Number = 3.5;
		private const MAX_VELOCITY:Number = 8;
		private const JUMP_DELAY:int = 750;

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
		private var _collisionAngle:Number;
		private var _topPart:Crate;
		private var _heroTopPart:Crate;
		private var _mayJump: Boolean = true;;
		private var _gameState:GameJamGameState;
		
		
		public function RunnerHero(name : String, params : Object = null) {
					
			super(name, params);
			_gameData = _ce.gameData as GlobalData;
			
			_friction = 40;
			maxVelocity = MAX_VELOCITY;
			hurtDuration = 600;
			
			_gameState = _ce.state as GameJamGameState;
			
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
			
			
			_heroTopPart = new Crate("HeroTopPart", {x:150, y:0, width :25, height : 50});
			_ce.state.add(_heroTopPart);
			_heroTopPart.body.SetFixedRotation(true);
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
			
			TweenMax.to(_ce.state.view.camera.offset, 2, {x : _ce.state.view.camera.offset.x - 50} );
			
			//Makes sure that the hero is not frictionless while his control is disabled
			if (_playerMovingHero)
			{
				_playerMovingHero = false;
				_fixture.SetFriction(_friction);
			}
		}

		override public function update(timeDelta:Number):void {
				
			var velocity:b2Vec2 = _body.GetLinearVelocity();
			
			if (x + _ce.state.view.camera.camPos.x <= 70) {
				body.SetAwake(false);
				TweenMax.to(this, 2.5, {y: y + _ce.stage.stageHeight, x:x + 100}); 
				_gameState.handleGameOverState();
			}
			
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
				
				if ( _gameData.currentPowerValue >= 1 ) {
					
//					if ((this.body.GetContactList() != null) && _onGround && _ce.input.justDid("jump", inputChannel)) {
					if (_mayJump && _onGround && _ce.input.justDid("jump", inputChannel)) {
						_mayJump = false;
						setTimeout(function():void{
							_mayJump = true
						}, JUMP_DELAY); 
						drawSlope();
						_gameData.currentPowerValue--;
						velocity.x = + jumpHeight/3;
						velocity.y = -jumpHeight;
						onJump.dispatch();
					} else if (_ce.input.isDoing("jump", inputChannel) && !_onGround && velocity.y < 0) {
						velocity.y -= jumpAcceleration;
					}
					
					if (_ce.input.justDid("shoot") && _gameData.currentPowerValue >= 1){
						_gameData.currentPowerValue--;
						var bullet:Missile;
						bullet = new Missile("bullet"+bulletcounter, {x:x + width, y:y - 60, width:15, height:15, speed:15, angle:0, view: fla.graphics.Bullet});
						bulletcounter++;
						_ce.state.add(bullet);
					}
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
			updateTopPart();
			_gameData.heroPos = new Point(x,y);
			
		}
		
		private function updateTopPart():void {
			_heroTopPart.x = x;
			_heroTopPart.y = y - 50;
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
//			var slope:Sprite = new Sprite();
//			slope.graphics.clear();
//			slope.graphics.beginFill(Colors.BLACK);
//			slope.graphics.moveTo(0, 0); 
//			slope.graphics.lineTo(150,Utils.RandomIntBetween(-80,-130)); 
//			slope.graphics.lineTo(150,100); 
//			slope.graphics.lineTo(150,0); 
//			slope.graphics.lineTo(0,0); 
//			slope.graphics.endFill();
			
			var slope : AllSlopes = new fla.graphics.AllSlopes();
			var random : int = Math.random() * (slope.totalFrames)+1;
			slope.gotoAndStop(random);			

			slope.rotation = 30;	
			
			slope.x = x - 35; 
			slope.y = y + 25;
			
			_gameData.hillView.addChild(slope);
			
			TweenMax.to(slope, .3 ,{y : slope.y - 10, rotation : 0, ease:Bounce.easeOut});
			TweenMax.to(slope, .3 ,{delay: .6, y : slope.y + 60, rotation : 60, ease:Bounce.easeOut});
		}		
		
		
		override public function handleBeginContact(contact:b2Contact):void {
			
			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			
			//Collision angle if we don't touch a Sensor.
			if (contact.GetManifold().m_localPoint && !(collider is Sensor)) //The normal property doesn't come through all the time. I think doesn't come through against sensors.
			{			
				_collisionAngle = (((new MathVector(contact.normal.x, contact.normal.y).angle) * 180 / Math.PI) + 360) % 360;// 0º <-> 360º
				//if ((collisionAngle > 45 && collisionAngle < 135)){
					_groundContacts.push(collider.body.GetFixtureList());
					_onGround = true;
					updateCombinedGroundAngle();
				//}
			}
		}
		
		
		
		
		
	}
}
