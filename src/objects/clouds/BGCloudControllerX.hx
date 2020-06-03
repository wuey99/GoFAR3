//------------------------------------------------------------------------------------------
package objects.clouds;
	
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
	class BGCloudControllerX extends XLogicObject {
		
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
			
			spawnInitialClouds ();
			
			createCloudSpawnerTask ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			show ();
		}

//------------------------------------------------------------------------------------------
		public function createCloudSpawnerTask ():Void {
			addTask ([
				XTask.LABEL, "loop",
				
				XTask.WAIT, 0x4000,
				
				function ():Void {
					spawnCloud ();
				},
				
				XTask.GOTO, "loop",
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function spawnInitialClouds ():Void {
			var i:Int;
			
			for (i in 0 ... 12) {
				var __x:Float = Math.random () * 960;
				var __y:Float = Math.random () * 540;
				var __cloud:Int = Std.int (Math.random () * 8);
			
				spawnCloudAt (__x, __y, __cloud);
			}
		}
				
//------------------------------------------------------------------------------------------
		public function spawnCloud ():Void {
			var __x:Float = -128;
			var __y:Float = Math.random () * 480;
			var __cloud:Int = Std.int (Math.random () * 8);
			
			spawnCloudAt (__x, __y, __cloud);
		}
				
//------------------------------------------------------------------------------------------
		public function spawnCloudAt (__x:Float, __y:Float, __cloud:Int):Void {
			var __cloudClassName:String = "";
			var __cloudSpeed:Float = 0;
			var __depth:Float = 0;

			switch (__cloud) {
				case 0:
				case 1:
				case 2:
					__cloudClassName = "Assets:CloudTeenyClass";
					__cloudSpeed = 0.5;
					__depth = 0;
					// break;
				case 3:
				case 4:
					__cloudClassName = "Assets:CloudSmallClass";
					__cloudSpeed = 1.0;
					__depth = 1;
					// break;
				case 5:	
				case 6:
					__cloudClassName = "Assets:CloudMediumClass";
					__cloudSpeed = 2.0;
					__depth = 2;
					// break;
				case 7:
					__cloudClassName = "Assets:CloudLargeClass";
					__cloudSpeed = 4.0;
					__depth = 2;
					// break;		
			}
			
			var logicObject:XLogicObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					self,
				// logicObject
					new BGCloudX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + __depth,
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
