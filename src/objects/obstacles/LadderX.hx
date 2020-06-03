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
	class LadderX extends FarXObstacle {
		private var m_highlight:Bool;
		private var m_assetName:String;

//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
	
			m_levelX = getArg (args, 0);
			m_assetName = getArg (args, 1);
			
			m_cmap = m_levelX.getCMap ();
			
			createSprites ();
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
			
			m_highlight = false;
			
			setupProps (1.75, 3.00);
			
			setNamedCX ("main", -8, 8, -48, 0);
			setNamedCX ("mouseOver", -32, 32, -240, 0);
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;

			if (m_assetName == "") {
				m_assetName = "Assets:LadderClass";
			}
			
			sprite = createXMovieClip (m_assetName);
			x_sprite = addSpriteAt (sprite, 0, 0);
									
			show ();
		}

//------------------------------------------------------------------------------------------
		public override function goalListener (args:Dynamic /* */ /* Dynamic */):Void {
			var __planModel:PlanModelX = cast args; /* as PlanModelX */
	
			if (m_levelX.getCurrPlanIndex () == __planModel.index) {
				__planModel.completed = true;
							
				m_levelX.Act_SFX_GoodJob ();
				
				removeAllSensors ();
			}
			else
			{	
				G.app.getBee ().beeGotoRequest (G.app.getBee ().Bee_Error_Script);
				
				m_levelX.Act_SFX_1Error ();
			}
		}
	
//------------------------------------------------------------------------------------------
		public override function getType ():Int {
			return Game.GOAL_CLIMBLADDER;
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
