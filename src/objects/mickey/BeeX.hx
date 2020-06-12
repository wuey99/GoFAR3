//------------------------------------------------------------------------------------------
package objects.mickey;
	
	import assets.*;
	
	import levels.*;
	
	import objects.*;
	
	import xlogicobject.*;
	
	import kx.*;
	import kx.geom.*;
	import kx.collections.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class BeeX extends FarXGravityObject {
		public var x_sprite:XDepthSprite;
		public static var DECCEL:Float = 0.50;
		public var script:XTask;
		public var m_levelX:LevelX;
		public static var BUTTON_JUMP:Int = 32;
		public static var LEFT_SPEED:Float = -6.0;
		public static var RIGHT_SPEED:Float = 6.0;
		public var m_beeGotoScript:Dynamic /* Function */;
		public var m_lilKey:XLogicObject;
		public var m_sprite:XMovieClip;
		public var m_dpadKeys:Map<Int, Bool>; // <Int, Bool>
		
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
			
			trace (": ", G.app);
			
			m_beeGotoScript = null;
			
			setCX (-15, 15, -48, 0);
			setNamedCX ("main", -15, 15, -48, 0);
			
			gravity = addEmptyTask ();
			script = addEmptyTask ();
			
			setupDPad ();
		}

//------------------------------------------------------------------------------------------
		public function setupDPad ():Void {
			m_dpadKeys = new Map<Int, Bool> (); // <Int, Bool>
			
			//------------------------------------------------------------------------------------------
			m_levelX.addDPadButtonLeftPressedListener (function ():Void {
				m_dpadKeys.set (37, true);
			});
			
			m_levelX.addDPadButtonRightPressedListener (function ():Void {
				m_dpadKeys.set (39, true);
			});
			
			m_levelX.addDPadButtonUpPressedListener (function ():Void {	
				m_dpadKeys.set (38, true);
			});
			
			m_levelX.addDPadButtonDownPressedListener (function ():Void {
				m_dpadKeys.set (40, true);
			});
			
			m_levelX.addDPadButtonJumpPressedListener (function ():Void {
				m_dpadKeys.set (BUTTON_JUMP, true);
			});
			
			//------------------------------------------------------------------------------------------
			m_levelX.addDPadButtonLeftReleasedListener (function ():Void {	
				m_dpadKeys.set (37, false);
			});
			
			m_levelX.addDPadButtonRightReleasedListener (function ():Void {	
				m_dpadKeys.set (39, false);
			});
			
			m_levelX.addDPadButtonUpReleasedListener (function ():Void {
				m_dpadKeys.set (38, false);
			});
			
			m_levelX.addDPadButtonDownReleasedListener (function ():Void {	
				m_dpadKeys.set (40, false);
			});
			
			m_levelX.addDPadButtonJumpReleasedListener (function ():Void {
				m_dpadKeys.set (BUTTON_JUMP, false);
			});
		}
		
//------------------------------------------------------------------------------------------
		public function freePlayMode (__pos:XPoint, __direction:Float):Void {		
			setPos (new XPoint (__pos.x, __pos.y));
			oScaleX = __direction;
			
			gravity.gotoTask (getGravityTaskX (DECCEL));
					
			Bee_Idle_Script ();
		}

//------------------------------------------------------------------------------------------
		public function planningMode ():Void {			
			Bee_Watching_Script ();
		}
				
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
//			sprite = new (xxx.getClass ("CharacterStanding:Standing")) ();
//			sprite = new (xxx.getClass ("CharacterStanding:Walking")) ();
			m_sprite = createXMovieClip("Bee:BeeClass");
			x_sprite = addSpriteAt (m_sprite, 0, 0);
	
			createLilKey ();
						
			show ();
		}

//------------------------------------------------------------------------------------------
		public function getKeyCode (__key:Int):Bool {
			if (G.app.isGameMouseEventsAllowed ()) {
				if (m_dpadKeys.get (__key)) {
					return true;
				}
				
				return xxx.getKeyCode (__key);
			}
			else
			{
				return false;
			}
		}
		
//------------------------------------------------------------------------------------------
		public function createLilKey ():Void {
			m_lilKey = cast xxx.getXLogicManager ().initXLogicObjectRel (
				// parent
					this,
				// logicObject
					new LilKeyX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 1, true,
				// x, y, z
					0, -64, 0,
				// scale, rotation
					1.0, 0
				) /* as LilKeyX */;
			
			addXLogicObject (m_lilKey);
			
			hideKey ();
		}

//------------------------------------------------------------------------------------------
		public function hideKey ():Void {
			m_lilKey.setVisible (false);
		}
		
//------------------------------------------------------------------------------------------
		public function showKey ():Void {
			m_lilKey.setVisible (true);
		}
		
//------------------------------------------------------------------------------------------
		public function beeGotoRequest (__script:Dynamic /* Function */):Void {
			m_beeGotoScript = __script;
		}

//------------------------------------------------------------------------------------------
		public function checkBeeFall ():Bool {
			return oDY > 6;
		}
		
//------------------------------------------------------------------------------------------
		public function Bee_Idle_Script ():Void {
			script.gotoTask ([
					
//------------------------------------------------------------------------------------------
// control
//------------------------------------------------------------------------------------------
			function ():Void {
				oDX = 0.0;
				
				script.addTask ([
					XTask.LABEL, "loop",
						XTask.WAIT, 0x0100,
							
						function ():Void {
							Bee_Idle_Control ();
							
							if (m_beeGotoScript != null) {
								m_beeGotoScript ();
								
								m_beeGotoScript = null;
							}
						
							if (checkBeeFall ()) {
								Bee_Fall_Script ();
							}
						},
							
						XTask.GOTO, "loop",
							
					XTask.RETN,
				]);
			},
			
//------------------------------------------------------------------------------------------
// animation
//------------------------------------------------------------------------------------------	
			XTask.LABEL, "loop",
				XTask.WAIT, 0x0100,
					
				XTask.GOTO, "loop",
					
			XTask.RETN,
		]);

//------------------------------------------------------------------------------------------
		}

//------------------------------------------------------------------------------------------
		public function Bee_Idle_Control ():Bool {
			var __goto:Bool = false;
						{
							if (getKeyCode (37)) {
								Bee_Left_Script ();
								
								__goto = true;
							}
							else if (getKeyCode (39)) {
								Bee_Right_Script ();
								
								__goto = true;
							}						
							if (getKeyCode (BUTTON_JUMP)) {
								if (oScaleX < 0.0) {
									Bee_Jump_Script (-10, -12);
									
									__goto = true;
								}
								else
								{
									Bee_Jump_Script (10, -12);
									
									__goto = true;
								}
													
								return __goto;
							}
							if (getKeyCode (38)) {
								if (Ck_Ladder_Bottom ()) {
									Bee_Climb_Script ();
									
									__goto = true;
								}
							}
							if (getKeyCode (13)) {
								Bee_Fly_Script ();
								
								__goto = true;
								
								return __goto;
							}
							
							oDX = 0.0;
						}
						
			return __goto;
		}
						
//------------------------------------------------------------------------------------------
		public function Bee_Left_Script ():Void {
			script.gotoTask ([
			
//------------------------------------------------------------------------------------------
// control
//------------------------------------------------------------------------------------------
			function ():Void {
				oScaleX = -1.0;
						
				script.addTask ([
					XTask.LABEL, "loop",						
						function ():Void {
							oDX = 0;
							
							if (getKeyCode (37)) {
								oDX = LEFT_SPEED; oDX = Math.max (-8, oDX);
							}
							else if (getKeyCode (39)) {
								oDX = RIGHT_SPEED;
								
								Bee_Right_Script ();
							}						
							if (getKeyCode (BUTTON_JUMP)) {
								if (oScaleX < 0.0) {
									Bee_Jump_Script (-10, -12);
								}
								else
								{
									Bee_Jump_Script (10, -12);
								}
							}
							if (oDX == 0) {
								Bee_Idle_Script ();
							}
							if (getKeyCode (38)) {
								if (Ck_Ladder_Bottom ()) {
									Bee_Climb_Script ();
								}
							}
							if (checkBeeFall ()) {
								Bee_Fall_Script ();
							}
						},
							
						XTask.WAIT, 0x0100,
						
						XTask.GOTO, "loop",
							
					XTask.RETN,
				]);
			},
			
//------------------------------------------------------------------------------------------
// animation
//------------------------------------------------------------------------------------------	
			XTask.LABEL, "loop",
				XTask.WAIT, 0x0100,
					
				XTask.GOTO, "loop",
					
			XTask.RETN,
		]);

//------------------------------------------------------------------------------------------
		}

//------------------------------------------------------------------------------------------
		public function Bee_Right_Script ():Void {
			script.gotoTask ([
			
//------------------------------------------------------------------------------------------
// control
//------------------------------------------------------------------------------------------
			function ():Void {
				oScaleX = 1.0;
				
				script.addTask ([
					XTask.LABEL, "loop",				
						function ():Void {
							oDX = 0;
							
							if (getKeyCode (37)) {
								oDX = LEFT_SPEED;
								
								Bee_Left_Script (); 
							}
							else if (getKeyCode (39)) {
								oDX = RIGHT_SPEED; oDX = Math.min (8, oDX);
							}						
							if (getKeyCode (BUTTON_JUMP)) {
								if (oScaleX < 0.0) {
									Bee_Jump_Script (-10, -12);
								}
								else
								{
									Bee_Jump_Script (10, -12);
								}
							}
							if (oDX == 0) {
								Bee_Idle_Script ();
							}
							if (getKeyCode (38)) {
								if (Ck_Ladder_Bottom ()) {
									Bee_Climb_Script ();
								}
							}
							
							if (checkBeeFall ()) {
								Bee_Fall_Script ();
							}
						},

						XTask.WAIT, 0x0100,
									
						XTask.GOTO, "loop",
							
					XTask.RETN,
				]);
			},
			
//------------------------------------------------------------------------------------------
// animation
//------------------------------------------------------------------------------------------	
			XTask.LABEL, "loop",
				XTask.WAIT, 0x0100,
					
				XTask.GOTO, "loop",
					
			XTask.RETN,
		]);

//------------------------------------------------------------------------------------------
		}
		
//------------------------------------------------------------------------------------------
		public function Bee_Jump_Script (__dx:Float, __dy:Float):Void {
			script.gotoTask ([

//------------------------------------------------------------------------------------------	
			XTask.WAIT, 0x0100,
									
//------------------------------------------------------------------------------------------			
			function ():Void {
				oDX = __dx;
				oDY = __dy;
				
				oDY = Math.max (-16, oDY);
				
				updatePhysics ();
			},
			
//------------------------------------------------------------------------------------------
// control
//------------------------------------------------------------------------------------------
			function ():Void {
				script.addTask ([
					XTask.LOOP, 20,
					
					function ():Void {
						if (getKeyCode (BUTTON_JUMP)) {
							oDY = -12; oDY = Math.max (-16, oDY);
						}	
					},
					
					XTask.NEXT,
					
					XTask.RETN,
				]);
				
				script.addTask ([
					XTask.LABEL, "loop",				
						function ():Void {
							if (getKeyCode (37)) {
								oScaleX = -1.0;
								
								oDX = -8.0; 
							}
							if (getKeyCode (39)) {
								oScaleX = 1.0;
								
								oDX = 8.0;
							}								
							if ((CX_Collide_Flag & XLogicObjectCX0.CX_COLLIDE_DN) != 0) {
								oDX = 0.0;
								
								Bee_Idle_Script ();
							}
							
							if (checkBeeFall ()) {
								Bee_Fall_Script ();
							}
						},

						XTask.WAIT, 0x0100,
									
						XTask.GOTO, "loop",
							
					XTask.RETN,
				]);
			},
			
//------------------------------------------------------------------------------------------
// animation
//------------------------------------------------------------------------------------------	
			XTask.LABEL, "loop",
				XTask.WAIT, 0x0100,
					
				XTask.GOTO, "loop",
					
			XTask.RETN,
		]);

//------------------------------------------------------------------------------------------
		}

//------------------------------------------------------------------------------------------
		public function Bee_Climb_Script ():Void {
			var __firstTime:Int = 4;
			
			oDX = oDY = 0;
			
			script.gotoTask ([

//------------------------------------------------------------------------------------------
			XTask.EXEC, __moveToTarget (),
			
			function ():Void {
				gravity.gotoTask (getNoGravityTaskX ());				
			},
			
//------------------------------------------------------------------------------------------
// control
//------------------------------------------------------------------------------------------
			function ():Void {			
				script.addTask ([	
					XTask.LABEL, "loop",				
						function ():Void {
							if (__firstTime == 0 && ((CX_Collide_Flag & XLogicObjectCX0.CX_COLLIDE_DN) != 0)) {
								gravity.gotoTask (getGravityTaskX (DECCEL));
								
								Bee_Idle_Script ();
								
								return;
							}
							if (__firstTime > 0) {
								__firstTime--;
							}							
							if (getKeyCode (38)) {		
								oDY = -4.0;
							}
							if (getKeyCode (40)) {								
								oDY = 4.0;
							}
							if (__firstTime == 0 && getKeyCode (37)) {
								gravity.gotoTask (getGravityTaskX (DECCEL));
								
								Bee_Jump_Script (oDX, -8.0);
							}
							if (__firstTime == 0 && getKeyCode (39)) {
								gravity.gotoTask (getGravityTaskX (DECCEL));
								
								Bee_Jump_Script (oDX, -8.0);
							}
							if (!Ck_Ladder_Bottom ()) {
								gravity.gotoTask (getGravityTaskX (DECCEL));	
								
								if (oScaleX < 0) {
									// Bee_Jump_Script (-10, -12);
								}
								else
								{
									// Bee_Jump_Script (10, -12);
								}	
							}
						},

						XTask.WAIT, 0x0100,
									
						XTask.GOTO, "loop",
							
					XTask.RETN,
				]);
			},
			
//------------------------------------------------------------------------------------------
// animation
//------------------------------------------------------------------------------------------	
			XTask.LABEL, "loop",
				XTask.WAIT, 0x0100,
					
				XTask.GOTO, "loop",
					
			XTask.RETN,
		]);
		
//------------------------------------------------------------------------------------------
		}

//------------------------------------------------------------------------------------------
		public function __moveToTarget ():Array<Dynamic> { // <Dynamic>
			return [
				XTask.LABEL, "loop",
					XTask.FLAGS, function (__task:XTask):Void {
						if (oX <= m_ladderTargetX) {
							oX = Math.min (oX + 4, m_ladderTargetX);
						}
						
						if (oX >= m_ladderTargetX) {
							oX = Math.max (oX - 4, m_ladderTargetX);
						}
						
						__task.ifTrue (oX == m_ladderTargetX);
						
					}, XTask.WAIT, 0x0100,
	
					XTask.BNE, "loop",
					
				XTask.RETN,
			];
		}

//------------------------------------------------------------------------------------------
		public function Bee_Watching_Script ():Void {
			script.gotoTask ([

//------------------------------------------------------------------------------------------
// control
//------------------------------------------------------------------------------------------
			function ():Void {
				script.addTask ([
					XTask.LABEL, "loop",
						XTask.WAIT, 0x0100,
						
						XTask.GOTO, "loop",
							
					XTask.RETN,
				]);
			},
			
//------------------------------------------------------------------------------------------
// animation
//------------------------------------------------------------------------------------------	
			XTask.LABEL, "loop",
				XTask.WAIT, 0x0100,
					
				XTask.GOTO, "loop",
					
			XTask.RETN,
		]);

//------------------------------------------------------------------------------------------
		}

//------------------------------------------------------------------------------------------
		public function Bee_Halt_Script ():Void {
			script.gotoTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					XTask.GOTO, "loop",
					
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
		public function Bee_Error_Script ():Void {			
			script.gotoTask ([
				function ():Void {
					var __planModel:PlanModelX = m_levelX.getPlans ()[m_levelX.getCurrPlanIndex ()];
					
					G.app.getBee ().setPos (__planModel.beePos.cloneX ());
					G.app.getBee ().oScaleX = __planModel.beeDirection;

					oDX = oDY = 0;
				},
				
				function ():Void {
					gravity.gotoTask (getNoGravityTaskX ());
					script.addTask (getFlashingTaskX ());
				},
				
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						if (Bee_Idle_Control ()) {
							gravity.gotoTask (getGravityTaskX (DECCEL));
							
							setVisible (true);
						}
					},
					
					XTask.GOTO, "loop",
					
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function getFlashingTaskX ():Array<Dynamic> { // <Dynamic>
			return [
				XTask.LABEL, "loop",			
					XTask.LOOP, 10,
							
					function ():Void {
						setVisible (true);
					}, XTask.WAIT, 0x0200,
							
					function ():Void {
						setVisible (false);
					}, XTask.WAIT, 0x0200,
												
					XTask.NEXT,
	
					XTask.GOTO, "loop",
				
				XTask.RETN,
			];
		}

//------------------------------------------------------------------------------------------
		public function Bee_Fall_Script ():Void {
			script.gotoTask ([

//------------------------------------------------------------------------------------------
// control
//------------------------------------------------------------------------------------------
			function ():Void {
				script.addTask ([
					XTask.LABEL, "loop",
						XTask.WAIT, 0x0100,
						
						function ():Void {
							if ((CX_Collide_Flag & XLogicObjectCX0.CX_COLLIDE_DN) != 0) {
								oDX = 0.0;
	
								Bee_Idle_Script ();
							}
							
							if (oY > 600) {
								resetBeeAfterFall ();
							}
						},
								
						XTask.GOTO, "loop",
							
					XTask.RETN,
				]);
			},
			
//------------------------------------------------------------------------------------------
// animation
//------------------------------------------------------------------------------------------	
			XTask.LABEL, "loop",
				XTask.WAIT, 0x0100,
					
				function ():Void {
				},
				
				XTask.GOTO, "loop",
					
			XTask.RETN,
		]);

//------------------------------------------------------------------------------------------
		}			
//------------------------------------------------------------------------------------------
		public function Bee_Fly_Script ():Void {
			gravity.gotoTask (getNoPhysicsTaskX ());				
			
			script.gotoTask ([
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						if (getKeyCode (37)) {
							oX -= 8;
						}
						if (getKeyCode (39)) {
							oX += 8;
						}
						if (getKeyCode (38)) {
							oY -= 8;
						}
						if (getKeyCode (40)) {
							oY += 8;
						}
						if (getKeyCode (32)) {
							gravity.gotoTask (getGravityTaskX (DECCEL));
							
							Bee_Jump_Script (0, -12);
						}
					},
					
					XTask.GOTO, "loop",
					
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function resetBeeAfterFall ():Void {
			var i:Int;
			var __dist:Float = 9999;
			var __closestPlanModel:PlanModelX = null;
					
			for (i in 0 ... m_levelX.getPlans ().length) {
				var __planModel:PlanModelX = cast m_levelX.getPlans ()[i]; /* as PlanModelX */
				
				if (__planModel.type == Game.GOAL_JUMPPIT && __planModel.logicObject.getVisible ()) {
					trace (": planModel: ", __planModel.beePos);
			
					var pos:XPoint = cast __planModel.sensorPosList[0]; /* as XPoint */
					
					if (Math.abs (oX - pos.x) < __dist) {
						__dist = Math.abs (oX - pos.x);
						
						__closestPlanModel = __planModel;
					}
				}
			}
			
			if (__closestPlanModel != null) {
				setToClosestPit (__closestPlanModel);
			}
		}

//------------------------------------------------------------------------------------------
		public function setToClosestPit (__planModel:PlanModelX):Void {
			var pos:XPoint = cast __planModel.sensorPosList[0]; /* as XPoint */
					
			if (pos.x < __planModel.logicObject.oX) {
				setPos (new XPoint (pos.x+108+108, pos.y));
			}
			else
			{
				setPos (new XPoint (pos.x-108-108, pos.y));
			}
									
			Bee_Idle_Script ();
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
