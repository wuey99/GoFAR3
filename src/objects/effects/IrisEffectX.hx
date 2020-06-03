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
	class IrisEffectX extends XLogicObject {
		private var x_sprite:XDepthSprite;
		private var m_startFlag:Bool;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
			
			m_startFlag = false;
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
	
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
						oRotation += 6;
					},
					
					XTask.GOTO, "loop",
				
					XTask.RETN,
			]);
			
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oScale += 0.75;
					},
					
					XTask.FLAGS, function (__XTask:XTask):Void {
						__XTask.ifTrue (oScale > 30);
					},
					
					XTask.BNE, "loop",
					
					XTask.LABEL, "wait_start",
						XTask.WAIT, 0x0100,
						
						XTask.FLAGS, function (__task:XTask):Void {
							__task.ifTrue (m_startFlag);
						},
						
						XTask.BNE, "wait_start",
				
					XTask.LOOP, 10,
						XTask.WAIT, 0x0100,
						
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
		public function fadeOut ():Void {
			addTask ([
				XTask.LABEL, "loop",
					XTask.LOOP, 10,
						XTask.WAIT, 0x0100,
						
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
		public function setStartFlag (__flag:Bool):Void {
			m_startFlag = __flag;
		}
		
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;

			sprite = createXMovieClip("Assets:TransitionburstClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
							
			show ();
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
