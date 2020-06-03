//------------------------------------------------------------------------------------------
package objects.obstacles;
	
	import assets.*;
	
	import levels.*;
	
	import objects.*;
	import objects.effects.*;
	import objects.mickey.*;
	
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
	class KeyX extends FarXObstacle {
		private var m_highlight:Bool;
		private var m_inrange:Bool;

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
			
			m_inrange = false;
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
			
			m_highlight = false;
			
			setNamedCX ("main", -8, 8, -48, 0);
			setNamedCX ("mouseOver", -32, 32, -64, 0);

			setupProps (1.0, 2.0);
			
			createHighlightTask ();
			createPickupTask ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;

			sprite = createXMovieClip("Assets:KeyClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
									
			show ();
		}

//------------------------------------------------------------------------------------------
		public override function goalListener (args:Dynamic /* */ /* Dynamic */):Void {
			var __planModel:PlanModelX = cast args; /* as PlanModelX */
			
			if (!m_inrange) {
				m_inrange = true;
				
				addTask ([
					XTask.WAIT, 0x0800,
					
					function ():Void {
						m_inrange = false;
					},
					
					XTask.RETN,
				]);
			}
		}
		
//------------------------------------------------------------------------------------------
		public function createPickupTask ():Void {
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__XTask:XTask):Void {
						__XTask.ifTrue (m_inrange);
					},
					
					XTask.BNE, "loop",
					
					XTask.FLAGS, function (__task:XTask):Void {
						if (m_levelX.getCurrPlanIndex () == m_planModel.index) {
							m_planModel.completed = true;
							
							m_levelX.Act_SFX_GoodJob ();
				
							G.app.getBee ().showKey ();
							
							removeAllSensors ();
							
							__task.setFlagsBool (true);
						}
						else
						{
							G.app.getBee ().beeGotoRequest (G.app.getBee ().Bee_Error_Script);

							m_levelX.Act_SFX_1Error ();
							
							__task.setFlagsBool (false);
						}
					},
					
					XTask.BEQ, "cont",
					
					XTask.WAIT, 0x1000,
					
					XTask.BNE, "loop",
					
				XTask.LABEL, "cont",	
					function ():Void {				
						addTask ([
							XTask.LOOP, 20,
								XTask.WAIT, 0x0100,
								
								function ():Void {
									oAlpha -= 0.05;
								},
								
								XTask.NEXT,
								
								XTask.RETN,
						]);
					},
				
					XTask.WAIT, 0x4000,
					XTask.WAIT, 0x4000,
										
					XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
		public function createHighlightTask ():Void {		
			addTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0400,
					
					XTask.FLAGS, function (__XTask:XTask):Void {
						__XTask.ifTrue (m_inrange);
					},
				
					XTask.BNE, "loop",

				XTask.LABEL, "highlight",				
					XTask.LOOP, 8,
						XTask.WAIT, 0x0100,
						
						function ():Void {
							oScale += .01;
						},
					XTask.NEXT,
					
					XTask.LOOP, 8,
						XTask.WAIT, 0x0100,
						
						function ():Void {
							oScale -= .01;
						},
					XTask.NEXT,
					
					XTask.FLAGS, function (__XTask:XTask):Void {
						__XTask.ifTrue (m_inrange);
					},
				
					XTask.BEQ, "highlight",
									
				XTask.GOTO, "loop",
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public override function getType ():Int {
			return Game.GOAL_GETKEY;
		}
			
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
