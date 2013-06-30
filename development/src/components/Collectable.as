package components {
	import global.GlobalData;
	import global.Constants;
	import citrus.objects.platformer.box2d.Coin;
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class Collectable extends Coin {
		
		//@todo Check REWARD class of citrus engine box2d for PowerUps (like mario mushrooms or stars)
		
		private var _gameData : GlobalData;
		private var _type : String;
		//private var _value : Number;
		
		public function Collectable(name : String, type : String, value : Number, params : Object = null) {
			_gameData = _ce.gameData as GlobalData;
			_type = type;
//			_value = value;
			super(name, params);
		}
		
		override public function handleBeginContact(contact:b2Contact):void {

			super.handleBeginContact(contact);

			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);

			if (_collectorClass && collider is _collectorClass)
				kill = true;
				
			notice("Obtained power");
			
			switch(_type) {
				case(Constants.collPower):
					notice("Power");
//					addPower();
					break;
				case(Constants.collCoin):	
					notice("Coin");
//					addCoin();
					break;
			}
		}
		
//		private function addPower() : void {			
//			_gameData.currentPowerValue += _value;
//		}
//		
//		private function addCoin() : void {
//			_gameData.currentCoinValue += _value;
//		}
	}
}
