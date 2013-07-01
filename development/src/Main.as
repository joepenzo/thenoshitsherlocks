package 
{
	import citrus.core.CitrusEngine;
	import citrus.input.controllers.Keyboard;
	import citrus.sounds.SoundManager;
	
	import com.nesium.logging.TrazzleLogger;
	
	import fla.sound.AvalanceOne;
	import fla.sound.BackgroundTwo;
	import fla.sound.FallDead;
	import fla.sound.FallDeadTwo;
	import fla.sound.Hurt;
	import fla.sound.Jump;
	import fla.sound.Shoot;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import global.GlobalData;
	import global.Sounds;
	
	import logmeister.LogMeister;
	import logmeister.connectors.TrazzleConnector;

	[SWF(width="960", height="600", frameRate="60", backgroundColor="#000")]
		
	public class Main extends CitrusEngine
	{
		
		private var soundClip:Sound;
		private var _bgMusic:BackgroundTwo;
		public function Main() {
			//TrazzleLogger.instance();			
			//zz_init(stage, 'Game Jam');
			LogMeister.addLogger(new TrazzleConnector(stage, "GAME JAM"));
			this.gameData = new GlobalData();

			
			sound.addSound(Sounds.BACKGROUND, {sound:fla.sound.BackgroundTwo, volume:1.2});
			sound.addSound(Sounds.JUMP, {sound:fla.sound.Jump, volume:.6});
			//sound.addSound(Sounds.POWERUP, {sound:fla.sound.});
			sound.addSound(Sounds.SHOOT, {sound:fla.sound.Shoot, volume:.8});
			sound.addSound(Sounds.FALLDEAD, {sound:fla.sound.FallDead, volume:.1});
			sound.addSound(Sounds.FALLDEADTWO, {sound:fla.sound.FallDeadTwo, volume:.1});
			sound.addSound(Sounds.HURT, {sound:fla.sound.Hurt, volume:1});
			sound.addSound(Sounds.AVELLACNE_ONE, {sound:fla.sound.AvalanceOne, volume:.5});
			sound.addSound(Sounds.AVELLACNE_TWO, {sound:fla.sound.AvalanceTwo, volume:.5});
			
			
			sound.playSound(Sounds.BACKGROUND);
			
			//var menuState : MenuState = new MenuState();
			//var gameState : GameJamGameState = new GameJamGameState();
			
			state = new MenuState();
//			state = new GameJamGameState();
			
			
		}
		

	}
}
