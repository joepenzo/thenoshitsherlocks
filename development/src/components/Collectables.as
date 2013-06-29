package components {
	import citrus.objects.platformer.box2d.Coin;

	/**
	 * @author joepsuijkerbuijk
	 */
	public class Collectables extends Coin {
		public function Collectables(name : String, type : String, params : Object = null) {
			notice(params.type);
			error(type);
			super(name, params);
		}
		
		
	}
}
