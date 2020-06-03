//------------------------------------------------------------------------------------------
package objects.obstacles;
	
	import assets.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
	import kx.*;
	import kx.collections.XDict;
	import kx.geom.*;
	import kx.signals.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import levels.PlanModelX;
	
	import objects.*;
	import objects.effects.*;
	
	import xlogicobject.*;
	
//------------------------------------------------------------------------------------------
	class ProximitySensorX extends XLogicObjectCX2 {
		public var m_planModel:PlanModelX;
		public var x_sprite:XDepthSprite;
		public var m_inrange:Bool;
		public var m_goalObject:FarXObstacle;
		private var m_goalSignal:XSignal;
		private var m_goalListeners:Map<{}, Int>; // <Dynamic, Int>
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
	
			m_planModel = getArg (args, 0);
			m_goalObject = getArg (args, 1);
			
			m_goalSignal = createXSignal ();
			
			m_goalListeners = new Map<{}, Int> (); // <Dynamic, Int>
			
			createSprites ();
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
			
			setNamedCX ("main", -8, 8, -64, 0);
			
			createProximityTask ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
		/*
			var sprite:XMovieClip;

			sprite = createXMovieClip ("Assets:CircleClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
									
			show ();
		*/
		}

//------------------------------------------------------------------------------------------
		public function addGoalListener (__listener:Dynamic /* Function */):Void {
			var id:Int = m_goalSignal.addListener (__listener );
			
			m_goalListeners.set (__listener, id);
		}

//------------------------------------------------------------------------------------------
		public function removeGoalListener (__listener:Dynamic /* Function */):Void {
			var id:Int = m_goalListeners.get (__listener);
			
			m_goalSignal.removeListener (id);
		}
		
//------------------------------------------------------------------------------------------
		public function fireGoalSignal ():Void {
			m_goalSignal.fireSignal (m_planModel);
		}
		
//------------------------------------------------------------------------------------------
		public function createProximityTask ():Void {
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						var __rect:XRect = getAdjustedNamedCX ("main");
					
						m_inrange = G.app.getBee ().collidesWithNamedCX ("main", __rect);
						
						if (m_inrange && G.getGameMode () == G.GAMEMODE_PLAYING) {
							fireGoalSignal ();
						}
					},
				
					XTask.BNE, "loop",
					
				XTask.RETN,
			]);	
		}
			
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
