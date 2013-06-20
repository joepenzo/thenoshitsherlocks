package gamejam
{
	//import com.epologee.util.drawing.Draw;
	import citrus.core.CitrusEngine;
	import com.nesium.logging.TrazzleLogger;
	
	
	public class gameJamMain extends CitrusEngine {
		public function gameJamMain() {
			TrazzleLogger.instance();			
			zz_init(stage, 'Game Jam');
			
			state = new GameState();
			
			
			log('d debug');
			log('i info');
			log('n notice');
			log('w warning');
			log('e error');
			log('c critical');
			log('f fatal');
			
			
		}
	}
}