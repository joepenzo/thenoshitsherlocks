package components {
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import global.Colors;
	import global.Sizes;
	import flash.display.Sprite;
	/**
	 * @author ezrabotter
	 */
	public class MenuButton extends Sprite {
		private var _title:String;
		
		public function MenuButton(title:String,params:Object) {
			_title = title;
			
			graphics.clear();
			graphics.beginFill(Colors.BACKGROUND_RED);
			graphics.drawRect(params.x, params.y, params.width, params.height);
				
			addEventListener(MouseEvent.ROLL_OVER,overButton);
			addEventListener(MouseEvent.ROLL_OUT,outClip);	
					
			mouseEnabled = true;
			
		}
		
		public function overButton(e:MouseEvent):void {
			Mouse.cursor="button";
		}
		
		public function outClip(e:MouseEvent):void {
			Mouse.cursor="auto";
		}

		public function get title() : String {
			return _title;
		}
	}
}
