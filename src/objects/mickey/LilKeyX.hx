//------------------------------------------------------------------------------------------
package objects.mickey;
	
	import assets.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import xlogicobject.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class LilKeyX extends XLogicObjectCX2 {

		public var x_sprite:XDepthSprite;

//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

			createSprites ();
			
			oScale = 0.05;
			
			addTask ([
				XTask.LABEL, "loop",
					XTask.LOOP, 5,
						XTask.WAIT, 0x0100, function ():Void { oScale += .025; },
					XTask.NEXT,
					
					XTask.LOOP, 5,
						XTask.WAIT, 0x0100, function ():Void { oScale -= .025; },
					XTask.NEXT,
					
					XTask.GOTO, "loop",
				
				XTask.RETN,		
			]);
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;

			sprite = createXMovieClip("Assets:KeyClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
									
			show ();
		}

//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
