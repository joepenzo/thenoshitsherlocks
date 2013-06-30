package 
{
	import com.nesium.logging.TrazzleLogger;
	import citrus.core.CitrusEngine;
	
	import global.GlobalData;
	
	import logmeister.LogMeister;
	import logmeister.connectors.TrazzleConnector;
	import citrus.input.controllers.Keyboard;

	[SWF(width="960", height="600", frameRate="60")]
		
	public class Main extends CitrusEngine
	{
		
		public function Main() {
			//TrazzleLogger.instance();			
			//zz_init(stage, 'Game Jam');
			LogMeister.addLogger(new TrazzleConnector(stage, "GAME JAM"));
			this.gameData = new GlobalData();
		//	gameData.dataChanged.add(onDataChanged);

			
			state = new MenuState();
			
			//state = new GameJamGameState();

		}
		
//		private function onDataChanged(data:String, value:Object):void {
//		}

	}
}
