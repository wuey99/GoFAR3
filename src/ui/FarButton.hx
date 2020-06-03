//------------------------------------------------------------------------------------------
package objects.ui;

// X classes
	import kx.*;
	import kx.signals.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.XDepthSprite;
	
	import openfl.display.*;
	import openfl.events.*;
	import openfl.text.*;
	import openfl.utils.*;

//------------------------------------------------------------------------------------------
	class FarButton extends XLogicObject {
		private var m_buttonClassName:String;	
		private var m_currState:Int;
		private var m_mouseDownSignal:XSignal;
		private var m_mouseUpSignal:XSignal;
		private var m_disabledFlag:Bool;
		private var m_label:Int;
		private var m_sprite:XMovieClip;
						
		public var NORMAL_STATE:Int = 1;
		public var OVER_STATE:Int = 2;
		public var DOWN_STATE:Int = 4;
		public var SELECTED_STATE:Int = 3;
		public var DISABLED_STATE:Int = 5;
		
//------------------------------------------------------------------------------------------
		public function new () {
		}
		
//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx);
			
			m_buttonClassName = getArg (args, 0);

			m_mouseDownSignal = createXSignal ();	
			m_mouseUpSignal = createXSignal ();
			
			mouseEnabled = true;

			createSpriteButton ();
		}

//------------------------------------------------------------------------------------------		
		public function onMouseOver (e:MouseEvent):Void {
			if (m_disabledFlag) {
				return;
			}
			
			if (m_currState == OVER_STATE) {
				return;
			}

			goto (OVER_STATE);

			m_currState = OVER_STATE;
		}	

//------------------------------------------------------------------------------------------		
		public function onMouseDown (e:MouseEvent):Void {
			if (m_disabledFlag) {
				return;
			}
			
			goto (DOWN_STATE);			

			m_currState = DOWN_STATE;
			
			fireMouseDownSignal ();
		}	

//------------------------------------------------------------------------------------------		
		public function onMouseUp (e:MouseEvent):Void {
			if (m_disabledFlag) {
				return;
			}
			
			setNormalState ();
			
			fireMouseUpSignal ();
		}

//------------------------------------------------------------------------------------------		
		public function onMouseMove (e:MouseEvent):Void {	
		}
									
//------------------------------------------------------------------------------------------		
		public function onMouseOut (e:MouseEvent):Void {	
			if (m_disabledFlag) {
				return;
			}
			
			setNormalState ();
		}

//------------------------------------------------------------------------------------------
		public function setNormalState ():Void {
			goto (getNormalState ());
			
			m_currState = getNormalState ();		
		}

//------------------------------------------------------------------------------------------
		public function isDisabled ():Bool {
			return m_disabledFlag;
		}
			
//------------------------------------------------------------------------------------------
		public function setDisabled (__disabled:Bool):Void {
			if (__disabled) {
				goto (DISABLED_STATE);
							
				m_disabledFlag = true;
			}
			else
			{
				setNormalState ();
				
				m_disabledFlag = false;
			}
		}

//------------------------------------------------------------------------------------------
		private function goto (__label:Int):Void {
			m_label = __label;
		}

//------------------------------------------------------------------------------------------
		public function updateLabel ():Void {
			m_sprite.gotoAndStop (m_label);
		}

//------------------------------------------------------------------------------------------
		private function getNormalState ():Int {
			return NORMAL_STATE;
		}
		
//------------------------------------------------------------------------------------------
// create sprite
//------------------------------------------------------------------------------------------
		public function createSpriteButton ():Void {
			var x_sprite:XDepthSprite;
					
			m_sprite = createXMovieClip (m_buttonClassName);		
			x_sprite = addSpriteAt (m_sprite, 0, 0);
			
			setNormalState ();

			m_sprite.mouseEnabled = true;
						
			addTask ([
				function ():Void {
					m_sprite.addEventListener (MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
					m_sprite.addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
					m_sprite.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
					m_sprite.addEventListener (MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
					m_sprite.addEventListener (MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				},
				
				XTask.RETN,
			]);
			
			m_currState = getNormalState ();
			m_label = getNormalState ();
			
			addTask ([
				XTask.LABEL, "__loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						updateLabel ();
					},
									
					XTask.GOTO, "__loop",
			]);
		}

//------------------------------------------------------------------------------------------
		public function addMouseDownListener (__listener:Dynamic /* Function */):Void {
			m_mouseDownSignal.addListener (__listener);
		}

//------------------------------------------------------------------------------------------
		public function fireMouseDownSignal ():Void {
			m_mouseDownSignal.fireSignal ();
		}
						
//------------------------------------------------------------------------------------------
		public function addMouseUpListener (__listener:Dynamic /* Function */):Void {
			m_mouseUpSignal.addListener (__listener);
		}

//------------------------------------------------------------------------------------------
		public function fireMouseUpSignal ():Void {
			m_mouseUpSignal.fireSignal ();
		}
	
//------------------------------------------------------------------------------------------
		public function removeAllListeners ():Void {
			m_mouseUpSignal.removeAllListeners ();
		}
			
//------------------------------------------------------------------------------------------	
	}
	
//------------------------------------------------------------------------------------------	
// }
