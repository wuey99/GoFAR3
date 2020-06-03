//------------------------------------------------------------------------------------------
package objects.win;
	
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
	class BGWinCloudX extends XLogicObjectCX2 {
		public var m_className:String;
		public var m_speed:Float;
		public var x_sprite:XDepthSprite;

//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

			m_className = getArg (args, 0);
			m_speed = getArg (args, 1);
			
			createSprites ();
			
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oY += m_speed;
						
						if (oY > 640 + 128) {
							killLater ();
						}
					},
					
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

			sprite = createXMovieClip (m_className);
			x_sprite = addSpriteAt (sprite, 0, 0);
									
			show ();
		}

//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
