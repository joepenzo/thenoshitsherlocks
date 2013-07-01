package 
{
	import citrus.input.controllers.Keyboard;
	import citrus.sounds.SoundManager;
	
	import com.nesium.logging.TrazzleLogger;
	
	import global.GlobalData;
	import global.Sounds;
	
	import logmeister.LogMeister;
	import logmeister.connectors.TrazzleConnector;
	import citrus.core.CitrusEngine;

	[SWF(width="960", height="600", frameRate="60")]
		
	public class Main extends CitrusEngine
	{
		
		public function Main() {
			//TrazzleLogger.instance();			
			//zz_init(stage, 'Game Jam');
			LogMeister.addLogger(new TrazzleConnector(stage, "GAME JAM"));
			this.gameData = new GlobalData();
		//	gameData.dataChanged.add(onDataChanged);

			//sound.addSound(Sounds.BACKGROUND, {sound:."../assets/sounds/background_music_4.mp3",timesToPlay:-1});
			//sound.addSound(Sounds.POWERUP, {sound:"../assets/sounds/throw_a_rock.mp3"});
			sound.addSound(Sounds.JUMP, {sound:"../assets/sounds/single_retro_laser.mp3"});
			
			
			//state = new MenuState();
			state = new GameJamGameState();

		}
		
//		private function onDataChanged(data:String, value:Object):void {
//		}

	}
}
