//------------------------------------------------------------------------------------------
package;

	import kx.*;
	import kx.geom.*;
	
	import openfl.geom.*;
	
//------------------------------------------------------------------------------------------
	class G {
		public static var app:Game;
		public static var xApp:XApp;
		public static var cameraX:Float;
		public static var cameraY:Float;
		public static var m_gameMode:Int;
		
		public static var SCREEN_WIDTH:Float = 1060;
		public static var SCREEN_HEIGHT:Float = 600;
		public static var LEFT_MARGIN:Float = 0;
		
		public static var GAMEMODE_PLANNING:Int = 1;
		public static var GAMEMODE_PLAYING:Int = 2;
		public static var GAMEMODE_FINISHED:Int = 3;
		
//------------------------------------------------------------------------------------------
		public static function setup (__app:Game, __XApp:XApp):Void {
			app = __app;
			xApp = __XApp;
		}

//------------------------------------------------------------------------------------------
		public static function setCamera (__pos:XPoint):Void {
			cameraX = __pos.x;
			cameraY = __pos.y;
		}

//------------------------------------------------------------------------------------------
		public static function getCamera ():XPoint {
			return new XPoint (cameraX, cameraY);
		}

//------------------------------------------------------------------------------------------
		public static function setGameMode (__value:Int):Void {
			m_gameMode = __value;
		}
		
//------------------------------------------------------------------------------------------
		public static function getGameMode ():Int {
			return m_gameMode;	
		}
		
//------------------------------------------------------------------------------------------
	}
	
//------------------------------------------------------------------------------------------
// }
