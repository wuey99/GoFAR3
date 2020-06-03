//------------------------------------------------------------------------------------------
package objects.ui;

// X classes
	import kx.*;
	import kx.signals.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	
	import openfl.display.*;
	import openfl.events.*;
	import openfl.text.*;
	import openfl.utils.*;

//------------------------------------------------------------------------------------------
	class FarToggleButton extends FarButton {
		private var m_selectedFlag:Bool;
		
//------------------------------------------------------------------------------------------
		public function new () {
			m_selectedFlag = false;
			m_disabledFlag = false;
		}
		
//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
		}

//------------------------------------------------------------------------------------------		
		public override function onMouseOver (e:MouseEvent):Void {
		}	
		
//------------------------------------------------------------------------------------------		
		public override function onMouseDown (e:MouseEvent):Void {	
			if (!m_disabledFlag) {
				m_selectedFlag = true;
			
				setNormalState ();
			
				fireMouseDownSignal ();
				fireMouseUpSignal ();
			}
		}	
		
//------------------------------------------------------------------------------------------		
		public override function onMouseUp (e:MouseEvent):Void {
		}

//------------------------------------------------------------------------------------------		
		public override function onMouseOut (e:MouseEvent):Void {
			if (m_disabledFlag) {
				return;
			}
			
			setNormalState ();
		}
		
//------------------------------------------------------------------------------------------
		public function isSelected ():Bool {
			return m_selectedFlag;
		}
		
//------------------------------------------------------------------------------------------
		public function setSelected (__selected:Bool):Void {
			m_selectedFlag = __selected;
			
			if (__selected) {
				goto (SELECTED_STATE);
				
				m_currState = SELECTED_STATE;			
			}
			else
			{
				goto (NORMAL_STATE);
				
				m_currState = NORMAL_STATE;	
			}
		}
		
//------------------------------------------------------------------------------------------
		public override function setNormalState ():Void {
			if (m_selectedFlag) {
				goto (SELECTED_STATE);
				
				m_currState = SELECTED_STATE;				
			}
			else
			{
				goto (NORMAL_STATE);
				
				m_currState = NORMAL_STATE;	
			}	
		}
		
//------------------------------------------------------------------------------------------	
	}
	
//------------------------------------------------------------------------------------------	
// }
