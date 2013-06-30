package components {
	
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.math.MathVector;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import flash.geom.Point;
	import global.Constants;
	import citrus.utils.AGameData;
	import global.GlobalData;
	import citrus.objects.platformer.box2d.Sensor;
	import Box2D.Common.Math.b2Vec2;
	import nape.geom.Vec2;
	import citrus.objects.platformer.box2d.Missile;

	import citrus.core.CitrusObject;
	import com.greensock.TweenMax;

	/**
	 * @author ezrabotter
	 */
	public class Obstacle extends Sensor {
		
//		private static var _slowDownTime:int = 1800; //miliseconds
//		private static var _slowDownSpeed:int = 2;
		private var _size : String;
		private var _hero:RunnerHero;
		
		public function Obstacle(name:String,size:String,params:Object) {
			_size = size;
			super(name, params);
			updateCallEnabled = true;
			_hero = _ce.state.getObjectByName("Hero") as RunnerHero;
		}
		
		override public function handleBeginContact(contact:b2Contact):void {

			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);

			if (collider is RunnerHero) {
				var hero : RunnerHero = collider as RunnerHero;
				debug("slowdown");
				hero.hurt();
				hero.body.SetLinearVelocity( new b2Vec2(hero.body.GetLinearVelocity().x/2, hero.body.GetLinearVelocity().y) );
			}

			if (collider is Missile) {
				var missile : Missile = collider as Missile;
				missile.kill = true;
				missile.destroy();
				
				//body.SetActive(false);
				kill = true;
				destroy();
			}
		
			
			switch(_size) {
				case Constants.obstacleSmall:
					//@todo hero slowDownSpeed
					break;
				case Constants.obstacleMedium:
					//@todo hero slowDownSpeed
					break;
				case Constants.obstacleLarge:
					//@todo hero slowDownSpeed
					break;
			}

		}
		
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			
			if (x + _ce.state.view.camera.camPos.x <= 100) {
				TweenMax.to(this, 1.5, {y : y + 300, x : x - 50, rotation: -60, onComplete: removeObject });
			}
			
			
			if (x <= _hero.x - _ce.stage.stageWidth) {
				removeObject();
			} 			
		}
		
		private function removeObject():void {
			destroy();
			updateCallEnabled = false;
			
		}
		
	}
}