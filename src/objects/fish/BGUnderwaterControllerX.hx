//------------------------------------------------------------------------------------------
package objects.fish;
	
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
	class BGUnderwaterControllerX extends XLogicObject {
		
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

			createSprites ();
			
			spawnInitialFishes ();
			
			createFishSpawnerTask ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			show ();
		}

//------------------------------------------------------------------------------------------
		public function createFishSpawnerTask ():Void {
			addTask ([
				XTask.LABEL, "loop",
				
				XTask.WAIT, 0x4000,
				
				function ():Void {
					spawnFish ();
				},
				
				XTask.GOTO, "loop",
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function spawnInitialFishes ():Void {
			var i:Float;
			
			for (i in 0 ... 24) {
				var __x:Float = Math.random () * 960;
				var __y:Float = Math.random () * 540;
				var __cloud:Int = Std.int (Math.random () * 8);
				var __cloudSpeed:Float = Math.random () * 0.75 + 0.25;
				
				if (Math.random () > 0.5) {
					__cloudSpeed *= 1.0;
				}
				else
				{
					__cloudSpeed *= -1.0;
				}
				
				spawnFishAt (__x, __y, __cloud, __cloudSpeed);
			}
		}
				
//------------------------------------------------------------------------------------------
		public function spawnFish ():Void {
			var __x:Float;
			var __y:Float = Math.random () * 540;
			var __cloud:Int = Std.int (Math.random () * 8);
			var __cloudSpeed:Float = Math.random () * 0.75 + 0.25;
			
			if (Math.random () > 0.5) {
				__x = -32;
				__cloudSpeed *= 1.0;
			}
			else
			{
				__x = 960+32;
				__cloudSpeed *= -1.0;
			}
			
			spawnFishAt (__x, __y, __cloud, __cloudSpeed);
		}
		
//------------------------------------------------------------------------------------------
		public function spawnFishAt (
			__x:Float, __y:Float,
			__cloud:Int, __cloudSpeed:Float
			):Void {
				
			var __cloudClassName:String = "";
			
			switch (__cloud) {
				case 0:
				case 1:
				case 2:
					__cloudClassName = "Assets:Fish1Class";
					// break;
				case 3:
				case 4:
					__cloudClassName = "Assets:Fish2Class";
					// break;
				case 5:	
				case 6:
					__cloudClassName = "Assets:Fish3Class";
					// break;
				case 7:
					__cloudClassName = "Assets:Fish4Class";
					// break;		
			}
			
			var logicObject:XLogicObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					self,
				// logicObject
					new BGFishX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth (),
				// x, y, z
					__x, __y, 0,
				// scale, rotation
					1.0, 0,
					[
						__cloudClassName,
						__cloudSpeed
					]
				) /* as XLogicObject */;
				
			addXLogicObject (logicObject);
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
