package components
{
	import citrus.objects.CitrusSprite;
	import flash.display.Sprite;
	import global.Utils;
	import com.greensock.TweenMax;
	import global.Colors;
	import citrus.utils.AGameData;
	import global.GlobalData;
	
	public class SlopeSprite extends CitrusSprite
	{
		private var _gameData:GlobalData;
		
		public function SlopeSprite(name:String, params:Object=null)
		{
			super(name, params);
			
		}
	}
}