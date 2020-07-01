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
	
	import ui.XTextButton;
	import xlogicobject.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class SplashX extends XLogicObjectCX2 {
		public var m_iconClassName:String;
		public var m_iconObject:XLogicObject;
		public var m_textName:String;
		public var m_textObject:SplashTextX;
		public var m_doneSignal:XSignal;
		public var m_startButton:XTextButton;
		public var m_irisEffect:IrisEffectX;
		public var m_blackOut:BlackOutX;
		public var m_useBlackOut:Bool;
		public var m_finishCallback:Dynamic /* Function */;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

			m_iconClassName = getArg (args, 0);
			m_textName = getArg (args, 1);
			m_useBlackOut = getArg (args, 2);
			m_finishCallback = getArg (args, 3);
			
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
			m_iconObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new SplashIconX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 20000,
				// x, y, z
					-128, 340-64, 0,
				// scale, rotation
					1.0, 0,
					[
						m_iconClassName
					]
				) /* as SplashIconX */;

			addXLogicObject (m_iconObject);	

			m_textObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new SplashTextX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 20000,
				// x, y, z
					1024, 310-64, 0,
				// scale, rotation
					1.0, 0,
					[
						m_textName
					]
				) /* as SplashTextX */;
					
			addXLogicObject (m_textObject);
					
			if (m_useBlackOut) {
				createBlackOutEffect();
			}
			
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
					var __midPtX:Float = (900 - (m_textObject.getTextWidth () + 96))/2 + 96;
					addTask (getIconTaskX (__midPtX));
					addTask (getTextTaskX (__midPtX+96));
					
					addDoneListener (
						function ():Void {
							__done = true;
						}
					);
				},
				
				XTask.LABEL, "wait",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (__done);
					}, XTask.BNE, "wait",
				
				function ():Void {
					__start = false;
					
					addStartButton ();
					
					m_startButton.addMouseUpListener (
						function ():Void {
							__start = true;
							
							m_irisEffect.setStartFlag (true);
							
							m_startButton.kill ();
						}
					);
				},
				
				XTask.LABEL, "wait_start",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (__start);
					},
					
					XTask.BNE, "wait_start",
				
				function ():Void {
					if (m_useBlackOut) {
						m_blackOut.kill ();
					}
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
		public function getIconTaskX (__midPtX:Float):Array<Dynamic> { // <Dynamic>
			return [
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						m_iconObject.oX = Math.min (m_iconObject.oX + 32, __midPtX);
					},
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (m_iconObject.oX == __midPtX);
					}, 
					
					XTask.BNE, "loop",
				
					function ():Void {
						fireDoneSignal ();	
					},
					
				XTask.RETN,
			];
		}

//------------------------------------------------------------------------------------------		
		public function getTextTaskX (__midPtX:Float):Array<Dynamic>	 { // <Dynamic>	
			return [
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						m_textObject.oX = Math.max (m_textObject.oX - 32, __midPtX);
					},
					
					XTask.GOTO, "loop",
					
				XTask.RETN,
			];
		}
				
//------------------------------------------------------------------------------------------
		private function addStartButton ():Void {
			m_startButton = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new XTextButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 20000,
				// x, y, z
					966/2, 600/2 + 64, 0,
				// scale, rotation
					1.0, 0,
					[
						"Start!",
						"Aller_Rg",
						40,
						100,
						40
					]
				) /* as XTextButton */;
				
			addTask ([
				function ():Void {
					m_startButton.oAlpha = 0.0;
				},
				
				XTask.LOOP, 10,
					XTask.WAIT, 0x0100,
						
					function ():Void {
						m_startButton.oAlpha += 0.1;
					},
						
					XTask.NEXT,
						
					XTask.RETN
			]);
						
			addXLogicObject (m_startButton);
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
