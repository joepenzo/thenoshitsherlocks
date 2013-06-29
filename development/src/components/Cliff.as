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

	/**
	 * @author ezrabotter
	 */
	public class Cliff extends Sensor {
		
		
		public function Cliff(name:String,params:Object) {
			super(name, params);
		}
		
		override public function handleBeginContact(contact:b2Contact):void {

			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);

			if (collider is RunnerHero) {
				var hero : RunnerHero = collider as RunnerHero;
				fatal("DIE");
			}
		
			
			

		}
		
	}
}