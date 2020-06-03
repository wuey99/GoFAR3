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
	class SamplePlanX extends XLogicObjectCX2 {
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
	
			script = addEmptyTask ();
			

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

			sprite = createXMovieClip("Assets:SamplePlanClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
		}

//------------------------------------------------------------------------------------------
		public function flashPlan ():Void {
			script.gotoTask ([
				XTask.LABEL, "loop",
					function ():Void {
						setVisible (true);
					},
					
					XTask.WAIT, 0x0800,
					
					function ():Void {
						setVisible (false);
					},
									
					XTask.WAIT, 0x0800,
						
					XTask.GOTO, "loop",
				
				XTask.RETN,
			]);	
		}
		
//------------------------------------------------------------------------------------------
		public function hidePlan ():Void {
			script.gotoTask ([
				function ():Void {
					hide ();
				},
				
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
