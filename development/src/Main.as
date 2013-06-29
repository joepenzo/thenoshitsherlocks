package 
{
	import citrus.core.CitrusEngine;

	import logmeister.LogMeister;
	import logmeister.connectors.TrazzleConnector;

	public class Main extends CitrusEngine
	{
		public function Main() {
			//TrazzleLogger.instance();			
			//zz_init(stage, 'Game Jam');
		
			LogMeister.addLogger(new TrazzleConnector(stage, "GAME JAM"));
			
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
