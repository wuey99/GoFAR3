//------------------------------------------------------------------------------------------
package interfaces;
	
	import assets.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
	//------------------------------------------------------------------------------------------
	class DPadTrayX extends XLogicObject {
		public var x_sprite:XDepthSprite;
		public var m_text:XTextSprite;
		public var x_textSprite:XDepthSprite;
		
		//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
			
			createSprites ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
		}
		
		//------------------------------------------------------------------------------------------
		// create sprites
		//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:Sprite;
			
			sprite = new Sprite ();
			x_sprite = addSpriteAt (sprite, 0, 0);
			
			sprite.graphics.beginFill (0xa0a0a0);
			sprite.graphics.drawRect (0, 0, 100, G.SCREEN_HEIGHT);
			sprite.graphics.endFill ();
			
			show ();
		}
			
		//------------------------------------------------------------------------------------------
	}
	
	//------------------------------------------------------------------------------------------
// }
