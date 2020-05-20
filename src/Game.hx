//------------------------------------------------------------------------------------------
package;
//	import assets.*;
	
	import openfl.display.*;
	import openfl.events.*;
	import openfl.geom.*;
	import openfl.media.*;
	import openfl.system.*;
	import openfl.ui.*;
	import openfl.utils.*;
	import openfl.Assets;
	
	import gx.*;
	import gx.game.*;
	import gx.levels.*;
	import gx.messages.*;
	import gx.messages.level.*;
	import gx.mickey.*;
	import gx.zone.*;
	
	import kx.*;
	import kx.bitmap.*;
	import kx.collections.*;
	import kx.game.*;
	import kx.geom.*;
	import kx.keyboard.*;
	import kx.resource.*;
	import kx.signals.*;
	import kx.sound.*;
	import kx.task.*;
	import kx.type.*;
	import kx.world.*;
	import kx.world.logic.*;
	import kx.xmap.*;
	import kx.xml.*;
	
	import nx.touch.*;
	import nx.task.*;
	
//------------------------------------------------------------------------------------------
	class Game extends GApp {
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setup (
			__assetsClass:Class<Dynamic> /* <Dynamic> */,
			__mickeyXClass:Class<Dynamic> /* <Dynamic> */,
			__parent:Dynamic /* */,
			__timerInterval:Float=16, 
			__layers:Int=4
		):Void {	
			trace (": Game: setup: ");
			
			super.setup (__assetsClass, __mickeyXClass, __parent, __timerInterval, __layers);
			
			G.setup (cast this /* as Game */, m_XApp);
		
			XType.forEach (m_XApp.getAllClassNames (),
				function (__className:String):Void {
					trace (": className: ", __className);
				}
			);
			
			addTask ([	
				XTask.WAIT, 0x0100,
				
				function ():Void {
					trace (": -------->: ", xxx.getClass ("Assets:BeeClass"));
					trace (": -------->: ", xxx.getClass ("Assets:CircleClass"));
					
					var sprite:Sprite = XType.createInstance (xxx.getClass ("Assets:BeeClass"));
					xxx.addChild (sprite);
					sprite.x = 256;
					sprite.y = 256;
				},
				
				XTask.RETN,
			]);	
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
