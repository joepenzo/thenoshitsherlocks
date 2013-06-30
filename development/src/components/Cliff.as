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
	import citrus.core.IState;
	import flash.utils.setTimeout;
	
	/**
	 * @author ezrabotter
	 */
	public class Cliff extends Sensor {
		
		private var _hero:RunnerHero;
		private var _gameData:GlobalData;
		private var _gameState:GameJamGameState;
		
		public function Cliff(name:String,params:Object) {
			super(name, params);
			_gameData = _ce.gameData as GlobalData;
			_gameState = _ce.state as GameJamGameState;
			updateCallEnabled = true;
			_hero = _ce.state.getObjectByName("Hero") as RunnerHero;

		}
		
		override public function handleBeginContact(contact:b2Contact):void {

			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);

			if (collider is RunnerHero) {
				var hero : RunnerHero = collider as RunnerHero;
				
				hero.body.SetAwake(false);
				_ce.state.view.camera.target = "";
				setTimeout(function():void{
					_gameState.handleGameOverState();
					hero.updateCallEnabled = false;
				}, 800); //4000
				TweenMax.to(hero, 2.5, {y: y + _ce.stage.stageHeight, x:x + 100}); 
				
			}
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