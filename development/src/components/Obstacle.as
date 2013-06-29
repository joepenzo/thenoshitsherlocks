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

	/**
	 * @author ezrabotter
	 */
	public class Obstacle extends Sensor {
		
//		private static var _slowDownTime:int = 1800; //miliseconds
//		private static var _slowDownSpeed:int = 2;
		private var _size : String;
		
		public function Obstacle(name:String,size:String,params:Object) {
			_size = size;
			super(name, params);
		}
		
		override public function handleBeginContact(contact:b2Contact):void {

			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);

//			if (collider is Sensor && collider.body.GetLinearVelocity().y > enemyKillVelocity)
//				hurt();
//
//			if (_body.GetLinearVelocity().x < 0 && (contact.GetFixtureA() == _rightSensorFixture || contact.GetFixtureB() == _rightSensorFixture))
//				return;
//
//			if (_body.GetLinearVelocity().x > 0 && (contact.GetFixtureA() == _leftSensorFixture || contact.GetFixtureB() == _leftSensorFixture))
//				return;

			if (contact.GetManifold().m_localPoint) {

				var normalPoint:Point = new Point(contact.GetManifold().m_localPoint.x, contact.GetManifold().m_localPoint.y);
				var collisionAngle:Number = new MathVector(normalPoint.x, normalPoint.y).angle * 180 / Math.PI;

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
		
	}
}