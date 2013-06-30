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
	import citrus.core.CitrusObject;

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
				hero.body.SetLinearVelocity( new b2Vec2(hero.body.GetLinearVelocity().x/2, hero.body.GetLinearVelocity().y) );
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
			if (x <= _hero.x - _ce.stage.stageWidth) {
				destroy();
				updateCallEnabled = false;
			} 			
		}
		
	}
}