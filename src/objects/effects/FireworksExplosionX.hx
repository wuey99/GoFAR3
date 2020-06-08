//------------------------------------------------------------------------------------------
package objects.effects;
	
	import assets.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	//------------------------------------------------------------------------------------------
	class FireworksExplosionX extends XLogicObject {
		private var m_sprite:XMovieClip;
		private var x_sprite:XDepthSprite;
		
		private var script:XTask;
		
		public var m_color:String;
		
		//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
			
			m_color = getArg (args, 0);
			
			createSprites ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
			
			script = addEmptyTask ();
			
			Idle_Script ();
		}
		
		//------------------------------------------------------------------------------------------
		// create sprites
		//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			m_sprite = createXMovieClip("Assets:FireworksParticle_" + m_color);
			x_sprite = addSpriteAt (m_sprite, 0, 0);
			
			show ();
		}
		
		//------------------------------------------------------------------------------------------
		public function Idle_Script ():Void {
			
			var __scale:Float = 0.33;
			var __alpha:Float = 1.0;
			
			script.gotoTask ([
				
				//------------------------------------------------------------------------------------------
				// control
				//------------------------------------------------------------------------------------------
				function ():Void {
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								__scale += 0.25;
								
								oScale = __scale;
							},
							
							XTask.GOTO, "loop",
						
						XTask.RETN,
					]);
					
					script.addTask ([
						XTask.LOOP, 20,
							XTask.WAIT, 0x0100,
							
							function ():Void {
								__alpha = Math.max (0.0, __alpha - 0.05);
								
								oAlpha = __alpha;
							},
							
							XTask.NEXT,
							
							function ():Void {
								nukeLater ();
							},
						
						XTask.RETN,
					]);
				},
				
				//------------------------------------------------------------------------------------------
				// animation
				//------------------------------------------------------------------------------------------	
				XTask.LABEL, "loop",	
					XTask.WAIT, 0x0100,	
					
					XTask.GOTO, "loop",
				
				XTask.RETN,
				
				//------------------------------------------------------------------------------------------			
			]);
			
			//------------------------------------------------------------------------------------------
		}
		
		//------------------------------------------------------------------------------------------
	}
	
	//------------------------------------------------------------------------------------------
// }
