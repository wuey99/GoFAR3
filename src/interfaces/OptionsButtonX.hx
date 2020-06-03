//------------------------------------------------------------------------------------------
package interfaces;
	
	import assets.*;
	
//	import Buttons.*;
	
	import xlogicobject.*;
	
	import kx.*;
	import kx.task.*;
	import kx.type.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.ui.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class OptionsButtonX extends __XButton {
		
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
		}
		
//------------------------------------------------------------------------------------------
// create sprite
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {			
			m_sprite = XType.createInstance (xxx.getClass (m_buttonClassName));
					
			x_sprite = addSpriteAt (m_sprite, 0, 0);
			
			gotoState (XButton.NORMAL_STATE);
			
			show ();
		}

//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
