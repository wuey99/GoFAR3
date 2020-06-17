//------------------------------------------------------------------------------------------
package objects.win;
	
	import assets.*;
	
	import objects.effects.*;
	import objects.splash.*;
	
	import sound.*;
	
	import kx.*;
	import kx.sound.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class BGWinCloudControllerX extends XLogicObject {
		private var m_textObject:SplashTextX;
		private var xm:XSoundTaskSubManager;
		private var m_soundFinished:Bool;
		private var m_fireworks:FireworksX;
			
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

			xm = new XSoundTaskSubManager (
				G.app.getXSoundTaskManager (), G.app.getOldSoundManager ()
			);
			
			addTask ([
				XTask.WAIT, 0x4000,
				
				function ():Void {
					createSprites ();
					
					xm.replaceAllSoundTasks ([
						XTask.FUNC, function (__task:XSoundTask):Void {	
							var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.SFX_YouWonTheGame ());
							__task.replaceSound (s[0]); G.app.setMessage (s[1]);
						}, XTask.EXEC, waitForSoundFinishedX (),
				
						XTask.RETN,
					]);
				},
				
				XTask.WAIT, 0x2800,
				
				function ():Void {
					createFireworks ();
					
					m_fireworks.oAlpha = 0.0;
				},
				
				XTask.LOOP, 10,
					XTask.WAIT, 0x0400,
					
					function ():Void {
						m_fireworks.oAlpha += 0.10;
					},
					
					XTask.NEXT,
				
				XTask.RETN,
			]);
						
			createCloudSpawnerTask ();
		}

//------------------------------------------------------------------------------------------
		public override function cleanup ():Void {
			super.cleanup ();
				
			xm.cleanup ();
		}
		
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			m_textObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					null,
				// logicObject
					new SplashTextX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 1500,
				// x, y, z
					350-48, 220-32, 0,
				// scale, rotation
					2.0, 0,
					[
						"GO FAR!"
					]
				) /* as SplashTextX */;
				
			addXLogicObject (m_textObject);
		}

//------------------------------------------------------------------------------------------
		public function createFireworks ():Void {
			m_fireworks = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					self,
				// logicObject
					new FireworksX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 1600,
				// x, y, z
					0, 0, 0,
				// scale, rotation
					1.0, 0
				) /* as FireworksX */;
				
			addXLogicObject (m_fireworks);
		} 
		
//------------------------------------------------------------------------------------------
		public function createCloudSpawnerTask ():Void {
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0800,
				
					function ():Void {
						spawnCloud ();
					},
				
					XTask.GOTO, "loop",
				
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
		public function spawnCloud ():Void {
			var __x:Float = Math.random () * 980 - 40;
			var __cloud:Int = Std.int (Math.random () * 8);
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
					__depth = 3;
					// break;		
			}
			
			var __logicObject:XLogicObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new BGWinCloudX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, __depth,
				// x, y, z
					__x, -128, 0,
				// scale, rotation
					1.0, 0,
					[
						__cloudClassName,
						__cloudSpeed*4
					]
				) /* as XLogicObject */;
				
			addXLogicObject (__logicObject);
		}
		
//------------------------------------------------------------------------------------------			
		public function waitForSoundFinishedX ():Array<Dynamic> { // <Dynamic>
			return [
				function ():Void {
					m_soundFinished = false;
				},
				
				XTask.LOOP, 0,
					XTask.WAIT, 0x0100,
					
					XTask.UNTIL, function (__task:XTask):Void {
						__task.ifTrue (m_soundFinished);
					},
					
				XTask.RETN,
			];
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
