//------------------------------------------------------------------------------------------
package objects.demo;
	
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
	class PointyArrowX extends XLogicObjectCX2 {
		public var x_sprite:XDepthSprite;
		private var script:XTask;
		
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
			
			script = addEmptyTask ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;

			sprite = createXMovieClip("Assets:PointyArrowClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
		}

//------------------------------------------------------------------------------------------
		public function point (__x:Float, __y:Float, __direction:Float, __speed:Float):Void {
			oX = __x;
			oY = __y;
	
			oRotation = __direction;
			
			script.gotoTask ([
				XTask.WAIT, 0x0200,
				
				XTask.LABEL, "loop",
					XTask.LOOP, 12,
						function ():Void {
							oX += -Math.sin (__direction * Math.PI/180) * __speed;
							oY += Math.cos (__direction * Math.PI/180) * __speed;
						}, XTask.WAIT, 0x0100,
					XTask.NEXT,
					
					XTask.LOOP, 12,
						function ():Void {
							oX -= -Math.sin (__direction * Math.PI/180) * __speed;
							oY -= Math.cos (__direction * Math.PI/180) * __speed;
						}, XTask.WAIT, 0x0100,
					XTask.NEXT,	
					
					XTask.GOTO, "loop",
								
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
