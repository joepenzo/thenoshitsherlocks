package com.epologee.util {
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	

		}
		
		public static function setTint(inTarget : DisplayObject, inColor : uint) : void {
			var tint : ColorTransform = new ColorTransform();
			tint.color = inColor;
			
			inTarget.transform.colorTransform = tint;
		}
		
	}