package 
{
	import citrus.core.CitrusEngine;

	import com.nesium.logging.TrazzleLogger;

	public class Main extends CitrusEngine
	{
		public function Main() {
			TrazzleLogger.instance();			
			zz_init(stage, 'Game Jam');
			
			state = new GameJamGameState();
			
//			log('d debug');
//			log('i info');
//			log('n notice');
//			log('w warning');
//			log('e error');
//			log('c critical');
//			log('f fatal');
		}
		
	}
}
