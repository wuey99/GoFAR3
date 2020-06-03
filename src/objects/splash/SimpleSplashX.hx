//------------------------------------------------------------------------------------------
package objects.splash;
	
	import assets.*;
	
	import objects.effects.*;
	
	import kx.*;
	import kx.signals.XSignal;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	import kx.world.ui.XButton;
	
	import xlogicobject.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class SimpleSplashX extends XLogicObject {
		public var m_doneSignal:XSignal;
		public var m_blackOut:BlackOutX;
		public var m_irisEffect:IrisEffectX;
		public var m_finishCallback:Dynamic /* Function */;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

			m_finishCallback = getArg (args, 0);
			
			m_doneSignal = new XSignal ();
			
			createSprites ();
			
			createAnimationTask ();
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
		}

//------------------------------------------------------------------------------------------
		public function addDoneListener (__listener:Dynamic /* Function */):Void {
			m_doneSignal.addListener (__listener);
		}
		
//------------------------------------------------------------------------------------------
		public function fireDoneSignal ():Void {
			m_doneSignal.fireSignal ();
		}
		
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			createBlackOutEffect();
				
			show ();
		}

//------------------------------------------------------------------------------------------
		public function createAnimationTask ():Void {
			var __done:Bool = false;
			var __start:Bool = false;
			
			G.app.blockGameMouseEvents ();
					
			addTask ([
				function ():Void {
					createIrisEffectX ();
				},
				
				XTask.WAIT, 0x2000,
				
				function ():Void {
					m_irisEffect.setStartFlag (true);	
					
					m_blackOut.kill ();				
				},	
				
				XTask.LOOP, 10,
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oAlpha -= 0.10;
					},
					
					XTask.NEXT,
					
				function ():Void {	
					G.app.allowGameMouseEvents ();
					
					m_finishCallback ();
									
					killLater ();
				},
				
				XTask.WAIT, 0x8000,
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function createBlackOutEffect ():Void {
			m_blackOut = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					null,
				// logicObject
					new BlackOutX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 15000,
				// x, y, z
					0, 0, 0,
				// scale, rotation
					1.0, 0
			) /* as BlackOutX */;
		}
			
//------------------------------------------------------------------------------------------
		public function createIrisEffectX ():Void {
			m_irisEffect = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					null,
				// logicObject
					new IrisEffectX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 15001,
				// x, y, z
					966/2, 600/2, 0,
				// scale, rotation
					1.0, 0
			) /* as IrisEffectX */;
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
