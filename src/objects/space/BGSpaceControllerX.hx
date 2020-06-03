//------------------------------------------------------------------------------------------
package objects.space;
	
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
	class BGSpaceControllerX extends XLogicObject {
		
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
			
			spawnInitialStars ();
			
			createStarSpawnerTask ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			show ();
		}

//------------------------------------------------------------------------------------------
		public function createStarSpawnerTask ():Void {
			addTask ([
				XTask.LABEL, "loop",
				
				XTask.WAIT, 0x1000,
				
				function ():Void {
					spawnStar ();
				},
				
				XTask.GOTO, "loop",
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function spawnInitialStars ():Void {
			var i:Int;
			
			for (i in 0 ... 32) {
				var __x:Float = Math.random () * 960;
				var __y:Float = Math.random () * 540;
				var __cloud:Int = Std.int (Math.random () * 8);
			
				spawnStarAt (__x, __y, __cloud);
			}
		}
				
//------------------------------------------------------------------------------------------
		public function spawnStar ():Void {
			var __x:Float = 960 + 16;
			var __y:Float = Math.random () * 480;
			var __star:Int = Std.int (Math.random () * 8);
			
			spawnStarAt (__x, __y, __star);
		}
				
//------------------------------------------------------------------------------------------
		public function spawnStarAt (__x:Float, __y:Float, __star:Int):Void {
			var __starClassName:String = "";
			var __starSpeed:Float = 0;
			var __depth:Float = 0;

			switch (__star) {
				case 0:
				case 1:
				case 2:
					__starClassName = "Assets:Star1Class";
					__starSpeed = -0.5;
					__depth = 0;
					// break;
				case 3:
				case 4:
					__starClassName = "Assets:Star2Class";
					__starSpeed = -1.0;
					__depth = 1;
					// break;
				case 5:	
				case 6:
					__starClassName = "Assets:Star3Class";
					__starSpeed = -2.0;
					__depth = 2;
					// break;
				case 7:
					__starClassName = "Assets:Star4Class";
					__starSpeed = -4.0;
					__depth = 3;
					// break;		
			}
			
			var logicObject:XLogicObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					self,
				// logicObject
					new BGStarX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + __depth,
				// x, y, z
					__x, __y, 0,
				// scale, rotation
					1.0, 0,
					[
						__starClassName,
						__starSpeed
					]
				) /* as XLogicObject */;
				
			addXLogicObject (logicObject);
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
