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
	class FireworksParticleX extends XLogicObject {
		private var m_sprite:XMovieClip;
		private var x_sprite:XDepthSprite;
		
		private var script:XTask;
		
		public var oDX:Float;
		public var oDY:Float;
		
		public var m_color:String;
		public var m_fireworks:FireworksX;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
	
			m_color = getArg (args, 0);
			m_fireworks = getArg (args, 1);
			
			createSprites ();
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
			
			script = addEmptyTask ();
			
			Explode_Script ();
			
			oScale = 0.125;
			
			addTask([
				XTask.WAIT, 0x0800,
				
				XTask.LABEL, "loop",
					function ():Void {
						createTrail ();
					}, XTask.WAIT, 0x0200,
					
					XTask.GOTO, "loop",
				XTask.RETN,
			]);
			
			var __alpha:Float = 1.0;
			
			addTask ([
				XTask.LOOP, 40,
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oScale += 0.0125;
					},
				XTask.NEXT,
				
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
			
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oX += oDX;
						oY += oDY;
						
						oDY = Math.min (16.0, oDY + 0.25);
					},
					
					XTask.GOTO, "loop",
					
				XTask.RETN,
			]);
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
		public function createTrail ():Void {
			var __fireworksTrailObject:FireworksTrailX = cast xxx.getXLogicManager ().initXLogicObjectFromPool (
				// parent
				m_fireworks,
				// logicObject
				FireworksTrailX,
				// item, layer, depth
				null, 0, getDepth () + 1,
				// x, y, z
				oX, oY, 0,
				// scale, rotation
				oScale, 0,
				[
					m_color
				]
			) /* as FireworksTrailX */;
			
			m_fireworks.addXLogicObject (__fireworksTrailObject);
		}
		
		//------------------------------------------------------------------------------------------
		public function Explode_Script ():Void {
			
			script.gotoTask ([
				
				//------------------------------------------------------------------------------------------
				// control
				//------------------------------------------------------------------------------------------
				function ():Void {
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
							},
							
							XTask.GOTO, "loop",
							
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
