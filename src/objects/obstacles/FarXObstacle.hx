//------------------------------------------------------------------------------------------
package objects.obstacles;
	
	import assets.*;
	
	import openfl.display.*;
	import openfl.events.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
	import kx.*;
	import kx.collections.XDict;
	import kx.geom.*;
	import kx.signals.XSignal;
	import kx.task.*;
	import kx.type.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;

	import nx.touch.XTouchTracker;
	
	import levels.*;
	
	import objects.effects.*;
	
	import xlogicobject.*;
	
//------------------------------------------------------------------------------------------
	class FarXObstacle extends XLogicObjectCX2 {
		private var x_sprite:XDepthSprite;
		private var m_cursorHighlightObject:CursorHighlightX;
		private var m_cursor:XPoint;
		private var m_mouse:XPoint;
		private var m_levelX:LevelX;
		private var m_selectedSignal:XSignal;
		private var m_planModel:PlanModelX;
		private var m_sensors:Array<ProximitySensorX>; // <ProximitySensorX>
		private var m_selectedListeners:Map<{}, Int>; // <Dynamic, Int>
		
		private var m_touchBeginListenerID:Int;
		
		private var m_touchTrackers:Map<XTouchTracker, Bool>;
		
		private var m_mouseOver:Bool;
		private var m_mouseDown:Bool;
		private var m_prev:Bool;
		
		private var m_fired:Int;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
			
			m_sensors = new Array ();
			
			m_cursorHighlightObject = null;
			
			m_selectedListeners = new Map<{}, Int> (); // <Dynamic, Int>
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
		
			mouseEnabled = true;
			
			m_fired = 0;
			
			m_selectedSignal = createXSignal ();
			
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						if (m_fired > 0) {
							m_fired--;
						}
					},
					
					XTask.GOTO, "loop",
					
				XTask.RETN,
			]);
		}
		
		//------------------------------------------------------------------------------------------
		public override function cleanup ():Void {
			super.cleanup ();
			
			stage.removeEventListener (MouseEvent.MOUSE_OVER, onMouseOver);
			stage.removeEventListener (MouseEvent.CLICK, onMouseClick);
			stage.removeEventListener (MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener (MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
//------------------------------------------------------------------------------------------
		public function setupProps (__minScale:Float, __maxScale:Float):Void {		
			addTask ([
				XTask.WAIT, 0x0100,
				
				function ():Void {
					createCursorProximityTask ();
					createCursorHighlightObject (__minScale, __maxScale, m_planModel.fake);
					createGoalCompletionProximitySensors ();
				},
				
				XTask.RETN,
			]);
			
			m_cursor = new XPoint ();
			
			m_touchTrackers = new Map<XTouchTracker, Bool> ();
			
			m_mouseOver = false;
			m_mouseDown = false;
			m_prev = false;
			
			addTask ([
				XTask.WAIT, 0x0100,
				
				function ():Void {
					stage.addEventListener (MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
					stage.addEventListener (MouseEvent.CLICK, onMouseClick, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
					
					m_touchBeginListenerID = G.app.getTouchManager ().addTouchBeginListener (function (e:TouchEvent):Void {
						var __touchTracker:XTouchTracker;
						
						__touchTracker = G.app.getTouchManager ().getTouchTracker (e, "primary", []);
						
						if (m_touchTrackers.exists (__touchTracker)) {
							return;
						}
						
						prevTouches ();
						m_touchTrackers.set (__touchTracker, false);
						setCursorPosFromTouch (__touchTracker.getCurrentStageX  (), __touchTracker.getCurrentStageY ());
						if (isTouchOver (__touchTracker) && m_prev == false) {
							fireSelectedSignal ();
						}
						
						__touchTracker.addTouchMoveListener (function (__tracker:XTouchTracker):Void {
							setCursorPosFromTouch (__touchTracker.getCurrentStageX  (), __touchTracker.getCurrentStageY ());
							
							prevTouches ();
							
							if (isTouchOver (__touchTracker)) {
								trace (": TOUCH_MOVE: " /* getName () */);
							}
						});
						
						__touchTracker.addTouchEndListener (function (__tracker:XTouchTracker):Void {
							m_touchTrackers.remove (__touchTracker);
							
							prevTouches ();
							
							isCursorOver ();
							
							trace (": TOUCH_END: ", /* getName (), */ m_mouseOver);
							
							if (hasTouches () == false) {
								// fireReleasedSignal ();
							}
						});
					});
				},
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function setPlan (__model:PlanModelX):Void {
			m_planModel = __model;
		}
		
//------------------------------------------------------------------------------------------
		public function addSelectedListener (__listener:Dynamic /* Function */):Void {
			var id:Int = m_selectedSignal.addListener (__listener);
			
			m_selectedListeners.set (__listener, id);
		}

//------------------------------------------------------------------------------------------
		public function removeSelectedListener (__listener:Dynamic /* Function */):Void {
			var id:Int = m_selectedListeners.get (__listener);
			
			m_selectedSignal.removeListener (id);
		}
		
//------------------------------------------------------------------------------------------
		public function fireSelectedSignal ():Void {
			if (m_fired == 0) {
				m_selectedSignal.fireSignal (m_planModel);
				
				m_fired = 16;
			}
		}

//------------------------------------------------------------------------------------------
		public function goalListener (args:Dynamic /* */ /* Dynamic */):Void {
			var __planModel:PlanModelX = cast args; /* as PlanModelX */
		}

//------------------------------------------------------------------------------------------			
		public function selectedPlan (__planModel:PlanModelX):Void {
			addTask ([
				XTask.WAIT, 0x0800,
				
				function ():Void {
					__selectedPlan (__planModel);
				},
				
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------			
		public function __selectedPlan (__planModel:PlanModelX):Void {
			var i:Int;
				
			for (i in __planModel.index+1 ... G.app.getLevel ().getPlans ().length) {
				var __planModel2:PlanModelX = G.app.getLevel ().getPlans ()[i];
					
				if (__planModel.type == __planModel2.type &&
					__planModel.logicObject.oX == __planModel2.logicObject.oX &&
					__planModel.logicObject.oY == __planModel2.logicObject.oY
					) {
						trace (": ***: ");
								
						var __logicObject:XLogicObject = __planModel.logicObject;
							
						addTask ([
							XTask.WAIT, 0x0800,
								
							function ():Void {
								__logicObject.setVisible (false);		
							},
								
							XTask.RETN,
						]);
							
						addTask ([
							XTask.WAIT, 0x1800,
								
							function ():Void {							
								__planModel2.logicObject.setVisible (true);
							},
								
							XTask.RETN,
						]);
							
						return;
				}
			}
		}

		//------------------------------------------------------------------------------------------	
		public function setCursorPosFromMouse (e:MouseEvent):Void {
			var __p:Point = m_levelX.globalToLocal (new XPoint (e.stageX, e.stageY));
			
			m_cursor = m_mouse = new XPoint (__p.x, __p.y);	
		}
		
		//------------------------------------------------------------------------------------------	
		public function setCursorPosFromTouch (__x:Float, __y:Float):Void {	
			var __p:Point = m_levelX.globalToLocal (new XPoint (__x, __y));
			
			m_cursor = new XPoint (__p.x, __p.y);	
		}
		
		//------------------------------------------------------------------------------------------
		public function isCursorOver ():Bool {
			var __rect:XRect = getAdjustedNamedCX ("mouseOver");
			
			// trace (": isCursorOver: ", m_cursor, oX, oY, __rect);
			
			if (
				getVisible () &&
				G.app.isGameMouseEventsAllowed () &&
				m_cursor.x >= __rect.left &&
				m_cursor.y >= __rect.top &&
				m_cursor.x <= __rect.right &&
				m_cursor.y <= __rect.bottom
			) {
				m_mouseOver = true;
			} else {
				m_mouseOver = false;
			}
			
			return m_mouseOver;
		}
		
		//------------------------------------------------------------------------------------------
		public function isTouchOver (__touchTracker:XTouchTracker):Bool {
			var __rect:XRect = new XRect (oX - 50, oY - 50, 100, 100);
			
			if (
				m_cursor.x >= __rect.left &&
				m_cursor.y >= __rect.top &&
				m_cursor.x <= __rect.right &&
				m_cursor.y <= __rect.bottom
			) {
				trace (": isTouchOver: ", m_cursor, oX, oY, __rect);
			
				m_touchTrackers.set (__touchTracker, true);
				
				return hasTouches ();
			} else {
				m_touchTrackers.set (__touchTracker, false);
				
				return hasTouches ();
			}
			
			return hasTouches ();
		}

		//------------------------------------------------------------------------------------------
		public function hasTouches ():Bool {
			var __hasTouches = m_mouseDown;
			
			XType.forEach (m_touchTrackers,
				function (__touchTracker:XTouchTracker):Void {
					if (m_touchTrackers.get (__touchTracker)) {
						__hasTouches = true;
					}
				}
			);
			
			if (__hasTouches) {
				// oScale = 1.25;
			} else {
				// oScale = 1.0;
			}
			
			return __hasTouches;
		}
		
		//------------------------------------------------------------------------------------------		
		public function onMouseOver (e:MouseEvent):Void {
			prevTouches ();
			
			setCursorPosFromMouse (e);
			
			isCursorOver ();
			
			hasTouches ();
		}	
		
		//------------------------------------------------------------------------------------------		
		public function onMouseClick (e:MouseEvent):Void {
			if (isCursorOver ()) {
				fireSelectedSignal ();
			}
			
			addTask ([
				XTask.WAIT, 0x0200,
				
				function ():Void {
					// fireReleasedSignal ();
				},
				
				XTask.RETN,
			]);
		}	
		
		//------------------------------------------------------------------------------------------		
		public function onMouseDown (e:MouseEvent):Void {
			prevTouches (); 
			
			setCursorPosFromMouse (e);
				
			if (isCursorOver ()) {
				// fireSelectedSignal ();
				m_mouseDown = true;
			}
			
			if (hasTouches () && m_prev == false) {
				fireSelectedSignal ();
			}
		}	
		
		//------------------------------------------------------------------------------------------		
		public function onMouseUp (e:MouseEvent):Void {
			prevTouches ();
			
			setCursorPosFromMouse (e);
			
			#if true
			if (isCursorOver ()) {
				// fireReleasedSignal ();
				m_mouseDown = false;
			}
			#end
			
			// fireReleasedSignal ();
			
			return;
			
			if (hasTouches () == false && m_prev == true) {
				// fireReleasedSignal ();
			}
		}
		
		//------------------------------------------------------------------------------------------		
		public function onMouseMove (e:MouseEvent):Void {
			prevTouches ();
			
			setCursorPosFromMouse (e);
			
			if (isCursorOver ()) {
				
			} else {
				m_mouseOver = false;
				m_mouseDown = false;
			}
			
			hasTouches ();
		}
		
		//------------------------------------------------------------------------------------------		
		public function onMouseOut (e:MouseEvent):Void {
			m_mouseOver = false;
			m_mouseDown = false;
			
			hasTouches ();
		}
	
		//------------------------------------------------------------------------------------------	
		public function prevTouches ():Void {
			m_prev = hasTouches ();
		}
		
//------------------------------------------------------------------------------------------
		public function createCursorProximityTask ():Void {
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						var __rect:XRect = getAdjustedNamedCX ("mouseOver");

						m_cursorHighlightObject.setHighlighted (false);
						
						if (
							G.app.isGameMouseEventsAllowed () &&
							/* !G.app.isSoundPlaying () && */
							m_cursor.x >= __rect.left &&
							m_cursor.y >= __rect.top &&
							m_cursor.x <= __rect.right &&
							m_cursor.y <= __rect.bottom
						) {
							m_cursorHighlightObject.setHighlighted (true);
						}
					},
				
					XTask.BNE, "loop",
					
				XTask.RETN,
			]);	
		}

//------------------------------------------------------------------------------------------
		public function createCursorHighlightObject (
			__minScale:Float,
			__maxScale:Float,
			__fake:Bool
			):Void {

			var __rect:XRect = getNamedCX ("mouseOver");
			
			__rect.left = (__rect.left + __rect.right)/2;
			__rect.top = (__rect.top + __rect.bottom)/2;
			
			m_cursorHighlightObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new CursorHighlightX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 1,
				// x, y, z
					__rect.x, __rect.y, 0,
				// scale, rotation
					1.0, 0
			) /* as CursorHighlightX */;
			
			m_cursorHighlightObject.setupProps (__minScale, __maxScale);
			
			if (__fake) {
				m_cursorHighlightObject.setUnHighlightedAlpha (0.25);
			}
			
			addXLogicObject (m_cursorHighlightObject);
		}

//------------------------------------------------------------------------------------------
		public function getCursorHighlightObject ():CursorHighlightX {
			return m_cursorHighlightObject;
		}
		
//------------------------------------------------------------------------------------------
		public function getType ():Int {
			return 0;
		}

//------------------------------------------------------------------------------------------
		public function createGoalCompletionProximitySensors ():Void {
			var i:Int;
			
			for (i in 0 ... m_planModel.sensorPosList.length) {
				var __pos:XPoint = m_planModel.sensorPosList[i];
				
				trace (": sensor: ", i, __pos, getParent ());
				
				var __object:ProximitySensorX = cast xxx.getXLogicManager ().initXLogicObject (
					// parent
						getParent (),
					// logicObject
						new ProximitySensorX () /* as XLogicObject */,
					// item, layer, depth
						null, 0, getDepth () + 1,
					// x, y, z
						__pos.x, __pos.y, 0,
					// scale, rotation
						1.0, 0,
						[
							m_planModel,
							this
						]
				) /* as ProximitySensorX */;

				getParent ().addXLogicObject (__object);
				
				__object.addGoalListener (goalListener);
				
				m_sensors.push (__object);
			}
		}

//------------------------------------------------------------------------------------------
		public function removeAllSensors ():Void {
			var i:Int;
			
			for (i in 0 ... m_sensors.length) {
				m_sensors[i].kill ();
			}
		}

//------------------------------------------------------------------------------------------
		public function setHint (__value:Bool):Void {
			m_cursorHighlightObject.setHint (__value);
		}

//------------------------------------------------------------------------------------------
		public function setHighlighted (__flag:Bool):Void {
			trace ("zzzzzzzzzzzzzzzzzzzz", m_cursorHighlightObject);
			
			if (m_cursorHighlightObject != null) {
				m_cursorHighlightObject.setHighlighted (__flag);
			}
		}
		
//------------------------------------------------------------------------------------------
		public function buzzWrong ():Void {
			m_cursorHighlightObject.buzzWrong ();
		}
				
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
