//------------------------------------------------------------------------------------------
package levels;
	
	import interfaces.*;
	import objects.obstacles.*;
	
	import kx.geom.*;
	
	import openfl.geom.*;
	
//------------------------------------------------------------------------------------------
	class PlanModelX {
		public var m_type:Int;
		public var m_assetName:String;
		public var m_name:String;
		public var m_goalPos:XPoint;
		public var m_beePos:XPoint;
		public var m_beeDirection:Float;
		public var m_beePos2:XPoint;
		public var m_beeDirection2:Float;
		public var m_logicObject:FarXObstacle;
		public var m_index:Int;
		public var m_iconObject:PlanIconX;
		public var m_sensorPosList:Array<Dynamic>; /* <Dynamic> */
		public var m_completed:Bool;
		public var m_incorrectGuesses:Int;
		public var m_fake:Bool;

//------------------------------------------------------------------------------------------
		public function new () {
			incorrectGuesses = 0;
		}

//------------------------------------------------------------------------------------------
		public var name (get, set):String;
		
		public function get_name ():String {
			return m_name;
		}
		
		public function set_name (__value:String): String {
			m_name = __value;
			
			return __value;	
		}
		/* @:end */

//------------------------------------------------------------------------------------------
		public var assetName (get, set):String;
		
		public function get_assetName():String {
			return m_assetName;
		}
		
		public function set_assetName (__value:String): String {
			m_assetName = __value;
			
			return __value;	
		}
		/* @:end */
		
//------------------------------------------------------------------------------------------
		public var index (get, set):Int;
		
		public function get_index ():Int {
			return m_index;
		}
		
		public function set_index (__value:Int): Int {
			m_index = __value;
			
			return __value;	
		}
		/* @:end */
				
//------------------------------------------------------------------------------------------
		public var type (get, set):Int;
		
		public function get_type ():Int {
			return m_type;
		}
		
		public function set_type (__value:Int): Int {
			m_type = __value;
			
			return __value;	
		}
		/* @:end */
		
//------------------------------------------------------------------------------------------
		public var goalPos (get, set):XPoint;
		
		public function get_goalPos ():XPoint {
			return m_goalPos;
		}
		
		public function set_goalPos (__value:XPoint): XPoint {
			m_goalPos = __value;
			
			return __value;	
		}
		/* @:end */
		
//------------------------------------------------------------------------------------------
		public var beePos (get, set):XPoint;
		
		public function get_beePos ():XPoint {
			return m_beePos;
		}
		
		public function set_beePos (__value:XPoint): XPoint {
			m_beePos = __value;
			
			return __value;	
		}
		/* @:end */

//------------------------------------------------------------------------------------------
		public var beeDirection (get, set):Float;
		
		public function get_beeDirection ():Float {
			return m_beeDirection;
		}
		
		public function set_beeDirection (__value:Float): Float {
			m_beeDirection = __value;
			
			return __value;	
		}
		/* @:end */

//------------------------------------------------------------------------------------------
		public var beePos2 (get, set):XPoint;
		
		public function get_beePos2 ():XPoint {
			return m_beePos2;
		}
		
		public function set_beePos2 (__value:XPoint): XPoint {
			m_beePos2 = __value;
			
			return __value;	
		}
		/* @:end */

//------------------------------------------------------------------------------------------
		public var beeDirection2 (get, set):Float;
		
		public function get_beeDirection2 ():Float {
			return m_beeDirection2;
		}
		
		public function set_beeDirection2 (__value:Float): Float {
			m_beeDirection2 = __value;
			
			return __value;	
		}
		/* @:end */
		
//------------------------------------------------------------------------------------------
		public var logicObject (get, set):FarXObstacle;
		
		public function get_logicObject ():FarXObstacle {
			return m_logicObject;
		}
		
		public function set_logicObject (__value:FarXObstacle): FarXObstacle {
			m_logicObject = __value;
			
			return __value;	
		}
		/* @:end */

//------------------------------------------------------------------------------------------
		public var iconObject (get, set):PlanIconX;
		
		public function get_iconObject ():PlanIconX {
			return m_iconObject;
		}
		
		public function set_iconObject (__value:PlanIconX): PlanIconX {
			m_iconObject = __value;
			
			return __value;	
		}
		/* @:end */

//------------------------------------------------------------------------------------------
		public var sensorPosList (get, set):Array<Dynamic>;
		
		public function get_sensorPosList ():Array<Dynamic> /* <Dynamic> */ {
			return m_sensorPosList;
		}
		
		public function set_sensorPosList (__value:Array<Dynamic> /* <Dynamic> */): Array<Dynamic> {
			m_sensorPosList = __value;
			
			return __value;	
		}
		/* @:end */

//------------------------------------------------------------------------------------------
		public var completed (get, set):Bool;
		
		public function get_completed ():Bool {
			return m_completed;
		}
		
		public function set_completed (__value:Bool): Bool {
			m_completed = __value;
			
			return __value;	
		}
		/* @:end */

//------------------------------------------------------------------------------------------
		public var fake (get, set):Bool;
		
		public function get_fake ():Bool {
			return m_fake;
		}
		
		public function set_fake (__value:Bool): Bool {
			m_fake = __value;
			
			return __value;	
		}
		/* @:end */
		
//------------------------------------------------------------------------------------------
		public var incorrectGuesses (get, set):Int;
		
		public function get_incorrectGuesses ():Int {
			return m_incorrectGuesses;
		}
		
		public function set_incorrectGuesses (__value:Int): Int {
			m_incorrectGuesses = __value;

			return __value;	
		}
		/* @:end */
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
