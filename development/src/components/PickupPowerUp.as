package components {
	import global.GlobalData;
	import global.Constants;
	import citrus.objects.platformer.box2d.Coin;
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import citrus.utils.AGameData;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class PickupPowerUp extends Coin {
		
		//@todo Check REWARD class of citrus engine box2d for PowerUps (like mario mushrooms or stars)
		private var _gameData:GlobalData;
		
		public function PickupPowerUp(name : String, params : Object = null) {
			super(name, params);
			_gameData = _ce.gameData as GlobalData;
		}
		
		override public function handleBeginContact(contact:b2Contact):void {

			super.handleBeginContact(contact);

			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);

			if (_collectorClass && collider is _collectorClass) {
				addPower(Constants.ADD_POWER_VAL);
				kill = true;
			}
		}
		
		private function addPower(val : Number) : void {
			_gameData.currentPowerValue += val;
		}
		
	}
}
