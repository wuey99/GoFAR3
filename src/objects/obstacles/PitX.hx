//------------------------------------------------------------------------------------------
package objects.obstacles;
	
	import assets.*;
	
	import levels.*;
	
	import objects.*;
	import objects.effects.*;
	
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
	class PitX extends FarXObstacle {
		private var m_highlight:Bool;

//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
	
			m_levelX = getArg (args, 0);
			
			m_cmap = m_levelX.getCMap ();
			
			createSprites ();
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
			
			m_highlight = false;
			
			setupProps (1.5, 2.25);
			
			setNamedCX ("main", -8, 8, -12, 12);
			setNamedCX ("mouseOver", -32, 32, -32, 32);
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			show ();
		}

//------------------------------------------------------------------------------------------
		public override function goalListener (args:Dynamic /* */ /* Dynamic */):Void {
			var __planModel:PlanModelX = cast args; /* as PlanModelX */
			
			if (!__planModel.logicObject.getVisible ()) {
				return;
			}
			
			if (m_levelX.getCurrPlanIndex () == __planModel.index) {
				__planModel.completed = true;

				m_levelX.Act_SFX_GoodJob ();
				
				removeAllSensors ();
				
				selectedPlan (__planModel);
			}
			else
			{
				G.app.getBee ().beeGotoRequest (G.app.getBee ().Bee_Error_Script);

				m_levelX.Act_SFX_1Error ();
			}
		}
		
//------------------------------------------------------------------------------------------
		public override function getType ():Int {
			return Game.GOAL_JUMPPIT;
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
