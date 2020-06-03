//------------------------------------------------------------------------------------------
package objects;
	
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
	class FarXGravityObject extends XLogicObjectCX2 {
		public static var ACCEL:Float = 1.25;
		public var gravity:XTask;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
		}

//------------------------------------------------------------------------------------------
		public function getGravityTaskX (DECCEL:Float):Array<Dynamic> { // <Dynamic>
			return [
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oDY = Math.min (oDY + ACCEL, 16);
					},
					
					updatePhysics,
					
					XTask.GOTO, "loop",
					
					XTask.RETN,
			];
		}

//------------------------------------------------------------------------------------------
		public function getNoGravityTaskX ():Array<Dynamic> { // <Dynamic>
			return [
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
						function ():Void {
							updatePhysics ();
						},
						
						function ():Void {
							oDX = oDY = 0;
						},
						
						XTask.GOTO, "loop",
					
					XTask.RETN,
			];
		}
		
//------------------------------------------------------------------------------------------
		public function getNoPhysicsTaskX ():Array<Dynamic> { // <Dynamic>
			return [
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,						
						XTask.GOTO, "loop",
					
					XTask.RETN,
			];
		}
		
//------------------------------------------------------------------------------------------
		public override function updatePhysics ():Void {
			super.updatePhysics ();

			if ((CX_Collide_Flag & XLogicObjectCX0.CX_COLLIDE_LF) != 0) {
				oDX = 0;
			}
			
			if ((CX_Collide_Flag & XLogicObjectCX0.CX_COLLIDE_RT) != 0) {
				oDX = 0;
			}
						
			if ((CX_Collide_Flag & XLogicObjectCX0.CX_COLLIDE_UP) != 0) {
				oDY = 0;
			}
			
			if ((CX_Collide_Flag & XLogicObjectCX0.CX_COLLIDE_DN) != 0) {
				oDY = 0;
			}
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
