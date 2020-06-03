//------------------------------------------------------------------------------------------
package sound;
	
	import kx.*;
	import kx.collections.*;
	import kx.pool.*;
	import kx.task.*;
	import kx.sound.*;
	import kx.world.logic.*;
	import kx.type.*;
	
	//------------------------------------------------------------------------------------------	
	class XSoundTaskManager extends XTaskManager {
		
	//------------------------------------------------------------------------------------------
		public function new (__XApp:XApp) {
			super (__XApp);	
		}
		
	//------------------------------------------------------------------------------------------	
		public override function createPoolManager ():XObjectPoolManager {
			return new XObjectPoolManager (
				function ():Dynamic /* */ {
					return new XSoundTask ();
				},
				
				function (__src:Dynamic /* */, __dst:Dynamic /* */):Dynamic /* */ {
					return null;
				},
				
				1024, 256,
				
				function (x:Dynamic /* */):Void {
				}
			);
		}
	
	//------------------------------------------------------------------------------------------
	}
	
//------------------------------------------------------------------------------------------
// }