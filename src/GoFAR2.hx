//------------------------------------------------------------------------------------------
package;
	// application classes
	import assets.*;
	
	import interfaces.*;
	
	import levels.*;
	import levels.level001.*;
	
	import objects.*;
	import objects.clouds.*;
	import objects.mickey.*;
	import objects.obstacles.*;
	
	import sound.*;
	
	import ui.*;
	
	import openfl.display.Sprite;
	import openfl.events.*;
	import openfl.geom.*;
	import openfl.media.Sound;
	import openfl.system.*;
	import openfl.utils.*;
	
	import kx.*;
	import kx.geom.*;
	import kx.keyboard.*;
	import kx.resource.*;
	import kx.sound.*;
	import kx.task.*;
	import kx.type.*;
	import kx.world.*;
	import kx.world.logic.*;
	import kx.world.ui.*;
	
	//------------------------------------------------------------------------------------------
	
	//------------------------------------------------------------------------------------------
	class GoFAR2 extends Sprite {
		
		//------------------------------------------------------------------------------------------
		public function new () {
			super ();
			
			trace (": starting: ");
			
			var __game:Game = new Game ();
			addChild (__game);
			
			__game.setup (null, null, this, 32);
		}
		
		//------------------------------------------------------------------------------------------
	}
	
	//------------------------------------------------------------------------------------------
// }
