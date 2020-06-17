//------------------------------------------------------------------------------------------
package objects.win;
	
	import assets.*;
	
	import objects.effects.*;
	import objects.splash.*;
	
	import kx.*;
	import kx.task.*;
	import kx.sound.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class WinX extends XLogicObject {
		private var m_textObject:SplashTextX;
				
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

			var __iris:IrisEffectX;
			
			addTask ([	
				function ():Void {
					createSprites ();
					
					__iris = createIrisEffectX ();
				},
				
				XTask.WAIT, 0x2000,
				
				function ():Void {
					__iris.fadeOut ();
					
					G.app.getGameController ().endLevel ();
					
					G.app.getGameController ().createWinCloudController ();
				},
				
				XTask.WAIT1000, 5 * 1000,
				
				function ():Void {
					var __level:Int = G.app.getCurrLevel ();
					
					if (__level < G.app.getTotalLevels () - 1) {
						G.app.setCurrLevel (__level + 1);
						
						var nextButtonObject:NextButtonX = cast xxx.getXLogicManager ().initXLogicObject (
							// parent
							null,
							// logicObject
							new NextButtonX () /* as XLogicObject */,
							// item, layer, depth
							null, 0, 999999,
							// x, y, z
							962/2 - 50, 600/2 - 50, 0,
							// scale, rotation
							1.0, __alpha,
							[
								self
							]
						);
						
						nextButtonObject.addPressedListener (function ():Void {
							trace (": next pressed: ");
							
							G.app.getGameController ().getWinCloudController ().nukeLater ();
													
							G.app.loadLevel ();
							
							nextButtonObject.nukeLater ();
							
							nukeLater ();
						});
					}
				},
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
		}
		
//------------------------------------------------------------------------------------------
		public function createIrisEffectX ():IrisEffectX {
			var __iris:IrisEffectX = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					null,
				// logicObject
					new IrisEffectX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 15000,
				// x, y, z
					966/2, 600/2, 0,
				// scale, rotation
					1.0, 0
			) /* as IrisEffectX */;
			
			return __iris;
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
