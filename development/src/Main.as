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
			
		}
		
	}
}
