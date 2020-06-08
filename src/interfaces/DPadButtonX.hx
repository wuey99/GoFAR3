//------------------------------------------------------------------------------------------
package interfaces;
	
	import assets.*;
	
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
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import levels.*;
	
	//------------------------------------------------------------------------------------------
	class DPadButtonX extends XLogicObject {
		public var m_sprite:XMovieClip;
		public var x_sprite:XDepthSprite;
		
		private var script:XTask;
		
		private var m_levelX:LevelX;
		private var m_cursor:XPoint;
		
		private var m_pressedSignal:XSignal;
		private var m_releasedSignal:XSignal;
		private var m_pressedListeners:Map<{}, Int>; // <Dynamic, Int>
		private var m_releasedListeners:Map<{}, Int>; // <Dynamic, Int>
		
		//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
			
			m_levelX = getArg (args, 0);
			
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
			
			addTask ([
				XTask.WAIT, 0x0100,
				
				function ():Void {
					stage.addEventListener (MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
					stage.addEventListener (MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				},
				
				XTask.RETN,
			]);
		}
		
		//------------------------------------------------------------------------------------------
		public override function cleanup ():Void {
			super.cleanup ();
			
			stage.removeEventListener (MouseEvent.MOUSE_OVER, onMouseOver);
			stage.removeEventListener (MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener (MouseEvent.MOUSE_OUT, onMouseOut);
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
			return "";
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
		public function setCursorPos (e:MouseEvent):Void {
			var __p:Point = m_levelX.globalToLocal (new XPoint (e.stageX, e.stageY));
			
			m_cursor = new XPoint (__p.x, __p.y);	
		}
		
		//------------------------------------------------------------------------------------------
		public function isCursorOver (e:MouseEvent):Bool {
			var __rect:XRect = new XRect (oX - 50, oY - 50, 100, 100);
			
			trace (": isCursorOver: ", m_cursor, oX, oY, __rect);
			
			if (
				m_cursor.x >= __rect.left &&
				m_cursor.y >= __rect.top &&
				m_cursor.x <= __rect.right &&
				m_cursor.y <= __rect.bottom
			) {
				oScale = 1.25;
				
				return true;
			} else {
				oScale = 1.00;
				
				return false;
			}
			
			return false;
		}
		
		//------------------------------------------------------------------------------------------		
		public function onMouseOver (e:MouseEvent):Void {
			setCursorPos (e);
			
			isCursorOver (e);
		}	
		
		//------------------------------------------------------------------------------------------		
		public function onMouseDown (e:MouseEvent):Void {
			setCursorPos (e);
				
			if (isCursorOver (e)) {
				firePressedSignal ();
			}
		}	
		
		//------------------------------------------------------------------------------------------		
		public function onMouseUp (e:MouseEvent):Void {
			setCursorPos (e);
			
			if (isCursorOver (e)) {
				fireReleasedSignal ();
			}
		}
		
		//------------------------------------------------------------------------------------------		
		public function onMouseMove (e:MouseEvent):Void {
			setCursorPos (e);
			
			isCursorOver (e);
		}
		
		//------------------------------------------------------------------------------------------		
		public function onMouseOut (e:MouseEvent):Void {
			oScale = 1.0;
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
