//------------------------------------------------------------------------------------------
package objects.win;
	
	import assets.*;
	import nx.touch.XTouchTracker;
	
	import openfl.display.*;
	import openfl.events.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
	import kx.*;
	import kx.collections.*;
	import kx.geom.*;
	import kx.signals.*;
	import kx.task.*;
	import kx.type.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import levels.*;
	
	//------------------------------------------------------------------------------------------
	class NextButtonX extends XLogicObject {
		public var m_sprite:XMovieClip;
		public var x_sprite:XDepthSprite;
		
		private var script:XTask;
		
		private var m_winX:WinX;
		private var m_cursor:XPoint;
		private var m_mouse:XPoint;
		
		private var m_pressedSignal:XSignal;
		private var m_releasedSignal:XSignal;
		private var m_pressedListeners:Map<{}, Int>; // <Dynamic, Int>
		private var m_releasedListeners:Map<{}, Int>; // <Dynamic, Int>
		
		private var m_touchBeginListenerID:Int;
		
		private var m_touchTrackers:Map<XTouchTracker, Bool>;
		
		private var m_mouseOver:Bool;
		private var m_mouseDown:Bool;
		private var m_prev:Bool;
		
		//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
			
			m_winX = getArg (args, 0);
			
			createSprites ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
			
			oAlpha = 0.75;
			
			m_pressedListeners = new Map<{}, Int> (); // <Dynamic, Int>
			m_releasedListeners = new Map<{}, Int> (); // <Dynamic, Int>
			
			m_pressedSignal = createXSignal ();
			m_releasedSignal = createXSignal ();
			
			script = addEmptyTask ();
			
			Idle_Script ();
			
			m_touchTrackers = new Map<XTouchTracker, Bool> ();
			
			m_mouseOver = false;
			m_mouseDown = false;
			m_prev = false;
			
			addTask ([
				XTask.WAIT, 0x0100,
				
				function ():Void {
					#if true
					stage.addEventListener (MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
					stage.addEventListener (MouseEvent.CLICK, onMouseClick, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
					#end
					
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
							firePressedSignal ();
						}
						
						__touchTracker.addTouchMoveListener (function (__tracker:XTouchTracker):Void {
							setCursorPosFromTouch (__touchTracker.getCurrentStageX  (), __touchTracker.getCurrentStageY ());
							
							prevTouches ();
							
							if (isTouchOver (__touchTracker)) {
								trace (": TOUCH_MOVE: ", getName ());
							}
						});
						
						__touchTracker.addTouchEndListener (function (__tracker:XTouchTracker):Void {
							m_touchTrackers.remove (__touchTracker);
							
							prevTouches ();
							
							isCursorOver ();
							
							trace (": TOUCH_END: ", getName (), m_mouseOver);
							
							if (hasTouches () == false) {
								fireReleasedSignal ();
							}
						});
					});
				},
				
				XTask.RETN,
			]);
		}
		
		//------------------------------------------------------------------------------------------
		public override function cleanup ():Void {
			super.cleanup ();
			
			#if true
			stage.removeEventListener (MouseEvent.MOUSE_OVER, onMouseOver);
			stage.removeEventListener (MouseEvent.CLICK, onMouseClick);
			stage.removeEventListener (MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener (MouseEvent.MOUSE_OUT, onMouseOut);
			#end
			
			G.app.getTouchManager ().removeTouchBeginListener (m_touchBeginListenerID);
		}
		
		//------------------------------------------------------------------------------------------
		// create sprites
		//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			m_sprite = createXMovieClip (getName ());
			x_sprite = addSpriteAt (m_sprite, 0, 0);
			
			show ();
		}

		//------------------------------------------------------------------------------------------
		public function getName ():String {
			return "Assets:NextButtonClass";
		}
		
		//------------------------------------------------------------------------------------------
		public function addPressedListener (__listener:Dynamic /* Function */):Void {
			var id:Int = m_pressedSignal.addListener (__listener);
			
			m_pressedListeners.set (__listener, id);
		}
		
		//------------------------------------------------------------------------------------------
		public function removePressedListener (__listener:Dynamic /* Function */):Void {
			var id:Int = m_pressedListeners.get (__listener);
			
			m_pressedSignal.removeListener (id);
		}
		
		//------------------------------------------------------------------------------------------
		public function firePressedSignal ():Void {
			m_pressedSignal.fireSignal (this);
		}
		
		//------------------------------------------------------------------------------------------
		public function addReleasedListener (__listener:Dynamic /* Function */):Void {
			var id:Int = m_releasedSignal.addListener (__listener);
			
			m_releasedListeners.set (__listener, id);
		}
		
		//------------------------------------------------------------------------------------------
		public function removeReleasedListener (__listener:Dynamic /* Function */):Void {
			var id:Int = m_releasedListeners.get (__listener);
			
			m_releasedSignal.removeListener (id);
		}
		
		//------------------------------------------------------------------------------------------
		public function fireReleasedSignal ():Void {
			m_releasedSignal.fireSignal (this);
		}
		
		//------------------------------------------------------------------------------------------	
		public function setCursorPosFromMouse (e:MouseEvent):Void {
			var __p:Point = m_winX.globalToLocal (new XPoint (e.stageX,  e.stageY));
			
			m_cursor = m_mouse = new XPoint (__p.x, __p.y);	
		}
		
		//------------------------------------------------------------------------------------------	
		public function setCursorPosFromTouch (__x:Float, __y:Float):Void {	
			var __p:Point = m_winX.globalToLocal (new XPoint (__x, __y));
			
			m_cursor = new XPoint (__p.x, __p.y);	
		}
		
		//------------------------------------------------------------------------------------------
		public function isCursorOver ():Bool {
			var __rect:XRect = new XRect (oX - 100, oY - 100, 200, 200);
			
			// trace (": isCursorOver: ", m_cursor, oX, oY, __rect);
			
			if (
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
				oScale = 1.25;
			} else {
				oScale = 1.0;
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
			firePressedSignal ();
		}
		
		//------------------------------------------------------------------------------------------		
		public function onMouseDown (e:MouseEvent):Void {
			prevTouches (); 
			
			setCursorPosFromMouse (e);
				
			if (isCursorOver ()) {
				// firePressedSignal ();
				m_mouseDown = true;
			}
			
			trace (": mouseDown: ", e, m_prev, hasTouches () );
			
			if (hasTouches () && m_prev == false) {
				firePressedSignal ();
			}
		}	
		
		//------------------------------------------------------------------------------------------		
		public function onMouseUp (e:MouseEvent):Void {
			prevTouches ();
			
			setCursorPosFromMouse (e);
			
			if (isCursorOver ()) {
				// fireReleasedSignal ();
				m_mouseDown = false;
			}
			
			if (hasTouches () == false && m_prev == true) {
				fireReleasedSignal ();
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
		public function Idle_Script ():Void {
			
			script.gotoTask ([
				
				//------------------------------------------------------------------------------------------
				// control
				//------------------------------------------------------------------------------------------
				function ():Void {
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							XTask.GOTO, "loop",
						
						XTask.RETN,
					]);
				},
				
				//------------------------------------------------------------------------------------------
				// animation
				//------------------------------------------------------------------------------------------	
				XTask.LABEL, "loop",	
					XTask.WAIT, 0x0100,	
					
					XTask.GOTO, "loop",
				
				XTask.RETN,
				
				//------------------------------------------------------------------------------------------			
			]);
			
			//------------------------------------------------------------------------------------------
		}
		
		//------------------------------------------------------------------------------------------
	}
	
	//------------------------------------------------------------------------------------------
// }
