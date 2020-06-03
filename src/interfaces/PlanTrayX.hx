//------------------------------------------------------------------------------------------
package interfaces;
	
	import assets.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class PlanTrayX extends XLogicObject {
		public var x_sprite:XDepthSprite;
		public var m_currentX:Float;
		public var m_goals:Array<XLogicObject>; // <XLogicObject>
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
				
			createSprites ();

			m_goals = new Array<XLogicObject>  (); // <XLogicObject> 
					
			m_currentX = 24;
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
		}

//------------------------------------------------------------------------------------------
		public function removeAllGoals ():Void {
			var i:Int;
			
			for (i in 0 ... m_goals.length) {
				removeXLogicObject (m_goals[i]);
			}
			
			m_goals = new Array<XLogicObject> (); // <XLogicObject>
			
			m_currentX = 24;
		}
		
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;

			trace (": PlanTrayX: createSprites: ");
			
			sprite = createXMovieClip("Assets:PlanTrayClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
									
			show ();
		}

//------------------------------------------------------------------------------------------
		public function addGoalType (__goalType:Int):PlanIconX {
			var __planIcon:PlanIconX;
			var __iconClassName:String = "";
			
			switch (__goalType) {
				case Game.GOAL_CLIMBLADDER:
					__iconClassName = "Assets:PlanIconClimbLadderClass";
					// break;
				
				case Game.GOAL_GETKEY:
					__iconClassName = "Assets:PlanIconGetKeyClass";
					// break;
					
				case Game.GOAL_JUMPPIT:
					__iconClassName = "Assets:PlanIconJumpPitClass";
					// break;
					
				case Game.GOAL_KILLGOOMBA:
					__iconClassName = "Assets:PlanIconKillGoombaClass";
					// break;
					
				case Game.GOAL_OPENDOOR:
					__iconClassName = "Assets:PlanIconOpenDoorClass";
					// break;
			}
			
			__planIcon = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new PlanIconX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 1,
				// x, y, z
					m_currentX, 12, 0,
				// scale, rotation
					1.0, 0,
					[
						__iconClassName
					]
				) /* as PlanIconX */;
				
			m_currentX += 96;
			
			addXLogicObject (__planIcon);
			
			m_goals.push (__planIcon);
			
			return __planIcon;
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
