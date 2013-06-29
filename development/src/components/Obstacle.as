package components {
	
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	/**
	 * @author ezrabotter
	 */
	public class Obstacle {
		
		private var _type;
		
		public function Obstacle(type:String) {
			_type = type;
			switch(_type) {
				case "tree":
					break;
			}
		}
		
	}
}
