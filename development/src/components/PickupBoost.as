package components {
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import citrus.utils.AGameData;
	
	import com.greensock.TweenMax;
	
	import global.Constants;
	import global.GlobalData;
	import global.Sounds;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class PickupBoost extends Coin {
		
		//@todo Check REWARD class of citrus engine box2d for PowerUps (like mario mushrooms or stars)
		private var _gameData:GlobalData;
		
		public function PickupBoost(name : String, params : Object = null) {
			super(name, params);
			_gameData = _ce.gameData as GlobalData;
		}
		
		override public function handleBeginContact(contact:b2Contact):void {

			super.handleBeginContact(contact);

			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			
			if (collider is _collectorClass ||  collider is Crate ) {
				_ce.sound.playSound(Sounds.POWERUP);
				if (_ce.state.view.camera.offset.x <= _ce.stage.stageWidth/2 - 120) TweenMax.to(_ce.state.view.camera.offset, 2, {x : _ce.state.view.camera.offset.x + 120} );
				kill = true;
			}
		}
		
		
	}
}
