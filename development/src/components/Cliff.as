package components {
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusObject;
	import citrus.math.MathVector;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import citrus.utils.AGameData;
	
	import com.greensock.TweenMax;
	
	import flash.geom.Point;
	
	import global.Constants;
	import global.GlobalData;

	/**
	 * @author ezrabotter
	 */
	public class Cliff extends Sensor {
		
		private var _hero:RunnerHero;
		private var _gameData:GlobalData;
		
		public function Cliff(name:String,params:Object) {
			super(name, params);
			_gameData = _ce.gameData as GlobalData;
			updateCallEnabled = true;
			_hero = _ce.state.getObjectByName("Hero") as RunnerHero;

		}
		
		override public function handleBeginContact(contact:b2Contact):void {

			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);

			if (collider is RunnerHero) {
				var hero : RunnerHero = collider as RunnerHero;
				
				_gameData.gameOver = true;

				hero.body.SetAwake(false);
				_ce.state.view.camera.followTarget = false;
				TweenMax.to(hero, 2.5, {y: hero.y + _ce.stage.stageHeight, x:hero.x + 100, onComplete: doPause });
			}
		}
		
		private function doPause() : void {
			_ce.playing = false;
		}
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
			if (x <= _hero.x - 100) {
				destroy();
				updateCallEnabled = false;
			} 			
		}
		
	}
}