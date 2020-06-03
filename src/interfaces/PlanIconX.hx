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
	class PlanIconX extends XLogicObject {
		public var m_sprite:XMovieClip;
		public var x_sprite:XDepthSprite;
		public var m_planIconClassName:String;
		public var script:XTask;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

			m_planIconClassName = getArg (args, 0);
			
			createSprites ();
			
			script = addEmptyTask ();
			
			NormalMode_Script ();
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

			m_sprite = createXMovieClip (m_planIconClassName);
			x_sprite = addSpriteAt (m_sprite, 0, 0);
			
			m_sprite.gotoAndStop (2);
									
			show ();
		}

//------------------------------------------------------------------------------------------
		public function NormalMode_Script ():Void {
			script.gotoTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
						
					function ():Void {
						setVisible (true);
						
						m_sprite.gotoAndStop (2);
					},
					
					XTask.GOTO, "loop",
				
				XTask.RETN,	
			]);
		}

//------------------------------------------------------------------------------------------
		public function InvisiMode_Script ():Void {
			script.gotoTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
						
					function ():Void {
						setVisible (false);
					},
					
					XTask.GOTO, "loop",
				
				XTask.RETN,	
			]);
		}
		
//------------------------------------------------------------------------------------------
		public function FlashingMode_Script ():Void {
			script.gotoTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0600,
						
					function ():Void {
						setVisible (true);
					},
					
					XTask.WAIT, 0x0600,
					
					function ():Void {
						setVisible (false);
					},
					
					XTask.GOTO, "loop",
				
				XTask.RETN,	
			]);
		}	

//------------------------------------------------------------------------------------------
		public function Finished_Script ():Void {
			script.gotoTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
						function ():Void {
							setVisible (true);
							
							m_sprite.gotoAndStop (1);
						},
						
					XTask.GOTO, "loop",
				
				XTask.RETN,	
			]);
		}
					
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
