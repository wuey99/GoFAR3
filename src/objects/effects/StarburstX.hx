//------------------------------------------------------------------------------------------
package objects.effects;
	
	import assets.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class StarburstX extends XLogicObjectCX2 {
		private var x_sprite:XDepthSprite;

//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx);
	
			createSprites ();
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
			
			oScale = 0.25;
			
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oRotation += 4;
					},
					
					XTask.GOTO, "loop",
				
					XTask.RETN,
			]);
			
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oScale += .075;
					},
					
					XTask.FLAGS, function (__XTask:XTask):Void {
						__XTask.ifTrue (oScale > 2.5);
					},
					
					XTask.BNE, "loop",
				
					XTask.LOOP, 10,
						XTask.WAIT, 0x100,
						
						function ():Void {
							oAlpha -= 0.1;
						},
						
						XTask.NEXT,
		
					function ():Void {
						killLater ();
					},
					
					XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;

			sprite = createXMovieClip("Assets:StarburstClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
									
			show ();
		}

//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
