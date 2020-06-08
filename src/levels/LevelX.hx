//------------------------------------------------------------------------------------------
package levels;
	
	import assets.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.media.Sound;
	import openfl.text.*;
	import openfl.utils.*;
	
	import interfaces.*;
	
	import kx.*;
	import kx.geom.*;
	import kx.sound.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import objects.*;
	import objects.clouds.*;
	import objects.effects.*;
	import objects.fish.*;
	import objects.mickey.*;
	import objects.obstacles.*;
	import objects.space.*;
	import objects.splash.*;
	import objects.win.*;
	
	import sound.*;
	
//------------------------------------------------------------------------------------------
	class LevelX extends XLogicObject {
		public var x_sprite:XDepthSprite;
		
		private var m_beeObject:BeeX;
		private var m_keyObject:KeyX;
		private var m_doorObject:DoorX;
		private var m_ladderObject:LadderX;
		private var m_pitObject:PitX;
		private var m_goombaObject:GoombaX;
		private var script:XTask;
		private var m_plans:Array<PlanModelX>; // <PlanModelX>
		private var m_offPlans:Array<PlanModelX>; // <PlanModelX>
		private var m_cmap:Array<Int>; // <Int>
		private var m_beeStartingPos:XPoint;
		private var m_beeStartingDirection:Float;
		private var m_currPlanIndex:Int;
		private var m_lastCompletedPlanIndex:Int;
		private var m_totalSteps:Int;
		private var m_completedSteps:Int;
		
		private var xm:XSoundTaskSubManager;
		
		private var m_setting:Int;
		
		private var m_soundFinished:Bool;
		
		private static var m_standardVoiceDelay:Float = .5*1000;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {	
			super.setup (__xxx, args);
			
			m_setting = getArg (args, 0);
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
				
			m_plans = new Array<PlanModelX> (); // <PlanModelX>
			m_offPlans = new Array<PlanModelX> (); // <PlanModelX>
			
			script = addEmptyTask ();
			
			xm = new XSoundTaskSubManager (
				G.app.getXSoundTaskManager (), G.app.getOldSoundManager ()
			);
		}

//------------------------------------------------------------------------------------------
		public override function cleanup ():Void {
			super.cleanup ();
			
			xm.cleanup ();
		}
		
//------------------------------------------------------------------------------------------
		public override function setPos (__pos:XPoint):Void {
			m_pos = __pos;
		}
			
//------------------------------------------------------------------------------------------
		public override function getPos ():XPoint {
			return m_pos;
		}
				
//------------------------------------------------------------------------------------------				
		public function createFreePlayLevel ():Void {
		}

//------------------------------------------------------------------------------------------				
		public function createPlanningLevel ():Void {
		}

//------------------------------------------------------------------------------------------
		public function createLevel ():Void {
			var levelArray:Array<Dynamic> /* <Dynamic> */  = getLevelData (); 
			
			var beeArray:Array<Dynamic> /* <Dynamic> */ = levelArray[0]; 
			var offPlanListArray:Array<Dynamic> /* <Dynamic> */ = levelArray[1];
			var goalListArray:Array<Dynamic> /* <Dynamic> */ = levelArray[2];
// bee
			createBeeObjectFromLevel (beeArray);
// off-plan
			createOffPlanObjectsFromLevel (offPlanListArray);
// plans
			createPlanObjectsFromLevel (goalListArray);
// goals	
			createGoalObjectsFromPlan (goalListArray);
			
			hideOutOfOrderGoals ();
		}

//------------------------------------------------------------------------------------------
		public function countGoalSteps ():Int {
			var levelArray:Array<Dynamic> /* <Dynamic> */ = getLevelData ();
			
			var steps:Int = Std.int (levelArray[2].length * 3);
			
			return steps;
		}
		
//------------------------------------------------------------------------------------------
		public function getBgClass ():String {
			switch (m_setting) {
				case 0:
					return "Assets:CloudBGClass";
				case 1:
					return "Assets:WaterBGClass";
				case 2:
					return "Assets:SpaceBGClass";
			}
			
			return "Assets:CloudBGClass";
		}
		
//------------------------------------------------------------------------------------------
		public function getLevelClass ():String {
			switch (m_setting) {
				case 0:
					return "AClass";
				case 1:
					return "BClass";
				case 2:
					return "CClass";
			}
			
			return "AClass";
		}
		
//------------------------------------------------------------------------------------------
		public function recreateLevel ():Void {
			var levelArray:Array<Dynamic> /* <Dynamic> */ = getLevelData ();
			
			var beeArray:Array<Dynamic> /* <Dynamic> */ = levelArray[0];
			var offPlanListArray:Array<Dynamic> /* <Dynamic> */ = levelArray[1];
			var goalListArray:Array<Dynamic> /* <Dynamic> */ = levelArray[2];
// off-plan
			createOffPlanObjectsFromLevel (offPlanListArray);
// goals	
			createGoalObjectsFromPlan (goalListArray);
			
			hideOutOfOrderGoals ();
		}
		
//------------------------------------------------------------------------------------------
		public function createBeeObjectFromLevel (beeArray:Array<Dynamic> /* <Dynamic> */):Void {
			m_beeStartingPos = beeArray[1];
			spawnBee (m_beeStartingPos.x, m_beeStartingPos.y);
			m_beeStartingDirection = beeArray[2];
			m_beeObject.oScaleX = m_beeStartingDirection;
		}

//------------------------------------------------------------------------------------------
		public function createPlanObjectsFromLevel (goalListArray:Array<Dynamic> /* <Dynamic> */):Void {
			var i:Int;
	
			m_plans = new Array<PlanModelX>  (); // <PlanModelX> 
// goals	
			for (i in 0 ... goalListArray.length) {
				var goalArray:Array<Dynamic> /* <Dynamic> */ = goalListArray[i];
				
				var __planModel:PlanModelX = new PlanModelX ();
				
				__planModel.type = goalArray[0];
				__planModel.assetName = goalArray[1];
				__planModel.goalPos = goalArray[2];
				__planModel.sensorPosList = goalArray[3];
				__planModel.beePos = goalArray[4];
				__planModel.beeDirection = goalArray[5];
				__planModel.beePos2 = goalArray[6];
				__planModel.beeDirection2 = goalArray[7];
				__planModel.index = i;
				__planModel.completed = false;
				__planModel.fake = false;
				
				m_plans.push (__planModel);
			}	
		}
				
//------------------------------------------------------------------------------------------
		public function createGoalObjectsFromPlan (goalListArray:Array<Dynamic> /* <Dynamic> */):Void {
			var i:Int;
			var j:Int;
			var __depth:Int = 1010;
// goals	
			for (i in 0 ... m_plans.length) {
				var __planModel:PlanModelX = m_plans[i];

				__planModel.index = i;
				__planModel.completed = false;

				spawnGoal (__planModel, __planModel.type, __planModel.goalPos);
				
				__planModel.logicObject.setDepth (__depth--);
				
				/*
				for (j in 0 ... i) {
					var __previousPlanModel:PlanModelX = m_plans[j];
					
					if (__previousPlanModel.type == __planModel.type &&
						__previousPlanModel.logicObject.oX == __planModel.logicObject.oX &&
						__previousPlanModel.logicObject.oY == __planModel.logicObject.oY
						) {
							__planModel.logicObject.setVisible (false);
						}
				}
				*/
			}	
		}

//------------------------------------------------------------------------------------------
		public function hideOutOfOrderGoals ():Void {
			var i:Int;
			var j:Int;
			var __depth:Int = 1010;
			var __planModel:PlanModelX;
			
// goals	
			for (i in 0 ... m_plans.length) {
				__planModel = m_plans[i];
			
				__planModel.logicObject.setVisible (true);	
			}
			
			for (i in 0 ... m_plans.length) {
				__planModel = m_plans[i];

				__planModel.index = i;
//				__planModel.completed = false;

				__planModel.logicObject.setDepth (__depth--);
				
				for (j in 0 ... i) {
					var __previousPlanModel:PlanModelX = m_plans[j];
					
					if (__previousPlanModel.type == __planModel.type &&
						__previousPlanModel.logicObject.oX == __planModel.logicObject.oX &&
						__previousPlanModel.logicObject.oY == __planModel.logicObject.oY
						) {
							__planModel.logicObject.setVisible (false);
						}
				}
			}	
		}
//------------------------------------------------------------------------------------------
		public function createOffPlanObjectsFromLevel (offPlanListArray:Array<Dynamic> /* <Dynamic> */):Void {
			var i:Int;
// off-plan	
			for (i in 0 ... offPlanListArray.length) {
				var goalArray:Array<Dynamic> /* <Dynamic> */ = offPlanListArray[i];
				
				var __planModel:PlanModelX = new PlanModelX ();
				
				__planModel.type = goalArray[0];
				__planModel.assetName = goalArray[1];
				__planModel.goalPos = goalArray[2];
				__planModel.sensorPosList = goalArray[3];
				__planModel.beePos = goalArray[4];
				__planModel.beeDirection = goalArray[5];
				__planModel.beePos2 = goalArray[6];
				__planModel.beeDirection2 = goalArray[7];
				__planModel.index = i+999;
				__planModel.completed = false;
				__planModel.fake = true;

				m_offPlans.push (__planModel);
							
				spawnGoal (__planModel, __planModel.type, __planModel.goalPos);
			}	
		}
		
//------------------------------------------------------------------------------------------
		public function spawnGoal (
			__planModel:PlanModelX,
			__type:Int,
			__pos:XPoint
			):Void {
				
			switch (__type) {
				case Game.GOAL_CLIMBLADDER:
					spawnLadder (__planModel, __pos.x, __pos.y);
					// break;
				case Game.GOAL_GETKEY:
					spawnKey (__planModel, __pos.x, __pos.y);
					// break;
				case Game.GOAL_JUMPPIT:
					spawnPit (__planModel, __pos.x, __pos.y);
					// break;
				case Game.GOAL_KILLGOOMBA:
					spawnGoomba (__planModel, __pos.x, __pos.y);
					// break;
				case Game.GOAL_OPENDOOR:
					spawnDoor (__planModel, __pos.x, __pos.y);
					// break;
			}
		}

//------------------------------------------------------------------------------------------
		public function getLevelData ():Array<Dynamic> /* <Dynamic> */ {
			return [];
		}
				
//------------------------------------------------------------------------------------------
		public function getCMap ():Array<Int> /* <Int> */ {
			return m_cmap;
		}
		
//------------------------------------------------------------------------------------------
		public function getBee ():BeeX {
			return m_beeObject;
		}

//------------------------------------------------------------------------------------------
		public function getBeeStartingPos ():XPoint {
			return m_beeStartingPos;
		}

//------------------------------------------------------------------------------------------
		public function getBeeStartingDirection():Float {
			return m_beeStartingDirection;
		}
		
//------------------------------------------------------------------------------------------
		public function getPlan (__plan:Int):PlanModelX {
			return m_plans[__plan];
		}

//------------------------------------------------------------------------------------------
		public function getPlans ():Array<PlanModelX> /* <PlanModelX> */ {
			return m_plans;
		}

//------------------------------------------------------------------------------------------
		public function geOfftPlan (__plan:Int):PlanModelX {
			return m_offPlans[__plan];
		}

//------------------------------------------------------------------------------------------
		public function getOffPlans ():Array<PlanModelX> /* <PlanModelX> */ {
			return m_offPlans;
		}
		
//------------------------------------------------------------------------------------------
		public function setCurrPlanIndex (__index:Int):Void {
			m_currPlanIndex = __index;
		}
		
//------------------------------------------------------------------------------------------
		public function getCurrPlanIndex ():Int {
			return m_currPlanIndex;
		}

//------------------------------------------------------------------------------------------
		public function setLastCompletedPlanIndex (__index:Int):Void {
			m_lastCompletedPlanIndex = __index;
		}
		
//------------------------------------------------------------------------------------------
		public function getLastCompletedPlanIndex ():Int {
			return m_lastCompletedPlanIndex;
		}

//------------------------------------------------------------------------------------------
		public function addCompletedStep ():Void {
			m_completedSteps++;
			
			G.app.getProgressBar ().setProgress (m_completedSteps/m_totalSteps);
			
			G.app.getScoreAndOptions ().addToScore (1);
		}
		
//------------------------------------------------------------------------------------------
		public function Level_Planning_Script ():Void {
			var __planModel:PlanModelX;
			var __nextPlanModel:PlanModelX;
			var __currIndex:Int;
			var i:Int;
			var s:Array<Dynamic>; // <Dynamic>

			//------------------------------------------------------------------------------------------			
			function __waitForSelect ():Array<Dynamic> /* <Dynamic> */ {
				return [
					function ():Void {
						__planModel = null;
					},
					
					XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (__planModel != null);
					},
					
					XTask.BNE, "loop",
					
					XTask.RETN,
				];
			}
			
			//------------------------------------------------------------------------------------------			
			function __selected (args:Dynamic /* */ /* Dynamic */):Void {
				__planModel = cast args; /* as PlanModelX */
				
				trace (": selected: ", __planModel, __planModel.type);
			}
			
			//------------------------------------------------------------------------------------------			
			function __selectedPlan (args:Dynamic /* */ /* Dynamic */):Void {
				__planModel = cast args; /* as PlanModelX */
				
				var i:Int;
				
				for (i in __planModel.index+1 ... m_plans.length) {
					var __planModel2:PlanModelX = m_plans[i];
					
					if (__planModel.type == __planModel2.type &&
						__planModel.logicObject.oX == __planModel2.logicObject.oX &&
						__planModel.logicObject.oY == __planModel2.logicObject.oY
					) {
						trace (": ***: ");
						
						var __logicObject:XLogicObject = __planModel.logicObject;
						
						addTask ([
							XTask.WAIT, 0x0800,
							
							function ():Void {
								__logicObject.setVisible (false);		
							},
							
							XTask.RETN,
						]);
						
						addTask ([
							XTask.WAIT, 0x1800,
							
							function ():Void {							
								__planModel2.logicObject.setVisible (true);
							},
							
							XTask.RETN,
						]);
						
						return;
					}
				}
				
				trace (": selectedPlan: ", __planModel, __planModel.type);
			}
			
			//------------------------------------------------------------------------------------------			
			function __planningCorrect ():Void {
				var s:Array<Dynamic>; // <Dynamic>
				var __type:Int = __planModel.type;
				var __soundDone:Bool = false;
				
				
				function __whatsNextX (__last:Bool = false):Array<Dynamic> /* <Dynamic> */ {
					if (!__last) {
						return [
							function ():Void {
								xm.replaceAllSoundTasks ([
									XTask.FUNC, function (__task:XSoundTask):Void {
										var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_WhatsNext());
										__task.replaceSound (s[0], soundFinished);
										G.app.setMessage (s[1]);
									},  XTask.EXEC, waitForSoundFinishedX (),
									
									XTask.WAIT1000, m_standardVoiceDelay,
									
									function ():Void {
										G.app.setSoundPlaying (false);
									},
									
									XTask.RETN,
								]);
									},
							
							XTask.RETN,
						];
						}
							else
							{
								return [
									function ():Void {
										G.app.setSoundPlaying (false);
									},
									
									XTask.RETN,
								];
							}
					}
					
				G.app.setSoundPlaying (true);
				
				xm.replaceAllSoundTasks ([
					XTask.FUNC, function (__task:XSoundTask):Void {
						s = G.app.getSoundFromGroup (__type, G.app.Plan_SFX_PickedRightStep());
						__task.replaceSound (s[0], soundFinished);
						G.app.setMessage (s[1]);
					},  XTask.EXEC, waitForSoundFinishedX (),
					
					XTask.WAIT1000, m_standardVoiceDelay,
					
					XTask.FUNC, function (__task:XSoundTask):Void {
						s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_GoodJob());
						__task.replaceSound (s[0], soundFinished);
						G.app.setMessage (s[1]);
					},  XTask.EXEC, waitForSoundFinishedX (),
					
					XTask.WAIT1000, m_standardVoiceDelay,
					
					XTask.FLAGS, function (__task:XSoundTask):Void {
						__task.ifTrue (__currIndex == getPlans ().length);
					},
					
					XTask.BEQ, "last",
					
					XTask.EXEC, __whatsNextX (false), XTask.GOTO, "cont",
					
					XTask.LABEL, "last", XTask.EXEC, __whatsNextX (true),
					
					XTask.LABEL, "cont",
					
					function ():Void {
						__soundDone = true;
					},
					
					XTask.RETN,
				]);		
				
				__planModel.iconObject = G.app.getPlanTray ().addGoalType (__planModel.type);
				
				var __logicObject:FarXObstacle = __planModel.logicObject;							
				__logicObject.getCursorHighlightObject ().setExplodeAway ();
				
				addCompletedStep ();
				
				addTask ([
					XTask.WAIT, 0x0800,
					
					function ():Void {
						__logicObject.oAlpha = 0.25;
					},
					
					XTask.RETN,
				]);
				
				trace (": ", __currIndex, getPlans ().length);
				
				__currIndex++;
				
				if (__currIndex < getPlans ().length) {								
					__nextPlanModel = getPlans ()[__currIndex];
					
					G.app.getBee ().setPos (__nextPlanModel.beePos);
					G.app.getBee ().oScaleX = __nextPlanModel.beeDirection;
				}
				else
				{
					for (i in 0 ... getPlans ().length) {
						//						getPlans ()[i].logicObject.removeSelectedListener (__selected);
						getPlans ()[i].logicObject.removeSelectedListener (__selectedPlan);
					}
					
					//					G.app.getScoreAndOptions ().addToScore (1);
					
					addTask ([
						XTask.LABEL, "__wait",
						
						XTask.WAIT, 0x0100,
						
						XTask.FLAGS, function (__task:XTask):Void {
							__task.ifTrue (__soundDone);
						}, XTask.BNE, "__wait",
						
						function ():Void {
							Level_Playing_Script ();
						},
						
						XTask.RETN,
					]);
				}

			}
					
			//------------------------------------------------------------------------------------------
			function __planningIncorrect ():Void {
						var s:Array<Dynamic>; // <Dynamic>
						var __rightModel:PlanModelX = getPlans()[__currIndex];	
						__rightModel.incorrectGuesses++;
						
						__planModel.logicObject.buzzWrong ();
						
						if (__rightModel.incorrectGuesses == 3) {
							xm.replaceAllSoundTasks ([
								XTask.WAIT, 0x1000,
								
								XTask.FUNC, function (__task:XSoundTask):Void {
									s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_3Errors());
									__task.replaceSound (s[0], soundFinished);
									G.app.setMessage (s[1]);
									
									__rightModel.logicObject.setHint (true);
									
									G.app.setSoundPlaying (true);
								},  XTask.EXEC, waitForSoundFinishedX (),
								
								XTask.WAIT1000, m_standardVoiceDelay,
								
								function ():Void {
									G.app.setSoundPlaying (false);
								},
								
								XTask.RETN,
							]);
						}							
						else if (__rightModel.incorrectGuesses > 3) {
							xm.replaceAllSoundTasks ([
								XTask.WAIT, 0x1000,
								
								XTask.FUNC, function (__task:XSoundTask):Void {
									s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_StillWrong());
									__task.replaceSound (s[0], soundFinished);
									G.app.setMessage (s[1]);
									
									__rightModel.logicObject.setHint (true);
									
									G.app.setSoundPlaying (true);
								},  XTask.EXEC, waitForSoundFinishedX (),
								
								XTask.WAIT1000, m_standardVoiceDelay,
								
								function ():Void {
									G.app.setSoundPlaying (false);
								},
								
								XTask.RETN,
							]);
						}
						else
						{
							xm.replaceAllSoundTasks ([
								XTask.WAIT, 0x1000,
								
								XTask.FUNC, function (__task:XSoundTask):Void {
									s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_1Error());
									__task.replaceSound (s[0], soundFinished);
									G.app.setMessage (s[1]);
									
									G.app.setSoundPlaying (true);
								},  XTask.EXEC, waitForSoundFinishedX (),
								
								XTask.WAIT1000, m_standardVoiceDelay,
								
								function ():Void {
									G.app.setSoundPlaying (false);
								},
								
								XTask.RETN,
							]);		
						}
			}
					
//------------------------------------------------------------------------------------------
			G.setGameMode (G.GAMEMODE_PLANNING);
			
			G.app.setMessage ("");
			
//			G.app.getProgressBar ().addStageType (FAR.STAGE_PLAN);

			m_completedSteps = 0;
			m_totalSteps = countGoalSteps ();
			G.app.getScoreAndOptions ().setScore (G.app.getCumalativeScore ());
			G.app.getProgressBar ().setProgress (0);
			G.app.getPlanTray ().removeAllGoals ();
			
			doLevelPlanningSFX ();
				
//------------------------------------------------------------------------------------------			
			for (i in 0 ... getPlans ().length) {
//				getPlans ()[i].logicObject.addSelectedListener (__selected);
				getPlans ()[i].logicObject.addSelectedListener (__selectedPlan);
			}

//------------------------------------------------------------------------------------------
			trace (": m_offPlans: ", m_offPlans.length);
						
			for (i in 0 ... getOffPlans ().length) {
				getOffPlans ()[i].logicObject.addSelectedListener (__selected);
			}
			
//------------------------------------------------------------------------------------------				
			script.gotoTask ([
				/*
				function ():Void {
					createWinX ();
				},
				
				XTask.LABEL, "wait",
					XTask.WAIT, 0x0100,
					
					XTask.GOTO, "wait",
				*/
				
				function ():Void {		
					var __splash:SplashX = cast xxx.getXLogicManager ().initXLogicObject (
						// parent
							self,
						// logicObject
							new SplashX () /* as XLogicObject */,
						// item, layer, depth
							null, 0, 20000,
						// x, y, z
							0, 0, 0,
						// scale, rotation
							1.0, 0,
							[
								"Assets:PlanAndFocusSplashClass",
								"Go FAR!",
								true,
								function ():Void {
									xm.replaceAllSoundTasks ([
										XTask.FUNC, function (__task:XSoundTask):Void {
											G.app.setSoundPlaying (true);
											
											var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_Start());
											__task.replaceSound (s[0], soundFinished);
											G.app.setMessage (s[1]);
										},  XTask.EXEC, waitForSoundFinishedX (),
						
										XTask.WAIT1000, m_standardVoiceDelay,
										
										XTask.FUNC, function (__task:XSoundTask):Void {
											var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Act_SFX_StartNext());
											__task.replaceSound (s[0], soundFinished);
											G.app.setMessage (s[1]);
										},  XTask.EXEC, waitForSoundFinishedX (),
	
										XTask.WAIT1000, m_standardVoiceDelay,
																				
										function ():Void {
											G.app.setSoundPlaying (false);
										},
										
										XTask.RETN,
									]);				
								}
							]
						) /* as SplashX */;
						
					addXLogicObject	(__splash);	
				},

				function ():Void {
					__currIndex = 0;
				},
					
				XTask.LABEL, "loop",
					XTask.EXEC, __waitForSelect (),
					
					function ():Void {
						trace (": selected >>>: ", __currIndex, __planModel.type, __planModel.index);
					},
									
					XTask.FLAGS, function (__task:XTask):Void {
						if (__currIndex == __planModel.index) {		
							__planningCorrect ();
						}
						else
						{
							__planningIncorrect ();
						}
					},
					
					XTask.GOTO, "loop",
					
				XTask.RETN,
			]);


		}
				
//------------------------------------------------------------------------------------------
		public function Level_Playing_Script ():Void {
			var i:Int;
			var __planModel:PlanModelX;
			var __soundDone:Bool = false;
						
			//------------------------------------------------------------------------------------------			
			function __waitForGoal ():Array<Dynamic> /* <Dynamic> */ {
				return [
					XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (__planModel != null && __planModel.completed);
					},
					
					XTask.BNE, "loop",
					
					function ():Void {
						trace (": ", __planModel, __planModel.index);
					},
					
					XTask.RETN,
				];
			}
			
			//------------------------------------------------------------------------------------------
			m_currPlanIndex = 0;
			
			setLastCompletedPlanIndex (m_currPlanIndex);

//------------------------------------------------------------------------------------------
			G.setGameMode (G.GAMEMODE_PLAYING);
			
//			G.app.setMessage ("");

//			G.app.getProgressBar ().addStageType (FAR.STAGE_PLAY);
		
//------------------------------------------------------------------------------------------			
			for (i in 0 ... getOffPlans ().length) {
				getOffPlans ()[i].logicObject.getCursorHighlightObject ().setExplodeAway ();
			}
			
			hideOutOfOrderGoals ();
			
//------------------------------------------------------------------------------------------			
			script.gotoTask ([			
				function ():Void {
					G.app.setMessage ("");
				},
				
				function ():Void {
					doLevelPlayingSFX ();
					
					xm.removeAllSounds ();
				},
				
				function ():Void {
					var __splash:SplashX = cast xxx.getXLogicManager ().initXLogicObject (
						// parent
							self,
						// logicObject
							new SplashX () /* as XLogicObject */,
						// item, layer, depth
							null, 0, 20000,
						// x, y, z
							0, 0, 0,
						// scale, rotation
							1.0, 0,
							[
								"Assets:ActSplashClass",
								"Go FAR!",
								false,
								function ():Void {
									xm.replaceAllSoundTasks ([
										XTask.FUNC, function (__task:XSoundTask):Void {
											G.app.setSoundPlaying (true);
											
											var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Act_SFX_Start());
											__task.replaceSound (s[0], soundFinished);
											G.app.setMessage (s[1]);
										},  XTask.EXEC, waitForSoundFinishedX (),
						
										XTask.WAIT1000, m_standardVoiceDelay,
										
										XTask.FUNC, function (__task:XSoundTask):Void {
											var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Act_SFX_StartNext());
											__task.replaceSound (s[0], soundFinished);
											G.app.setMessage (s[1]);
										},  XTask.EXEC, waitForSoundFinishedX (),
										
										XTask.WAIT1000, m_standardVoiceDelay,
													
										function ():Void {
											G.app.setSoundPlaying (false);
										},
										
										XTask.RETN,
									]);
								}
							]
						) /* as SplashX */;
						
					addXLogicObject	(__splash);	
				},
				
				XTask.WAIT, 0x0a00,
				
				function ():Void {
					G.app.getBee ().freePlayMode (getBeeStartingPos (), getBeeStartingDirection ());
						
					for (i in 0 ... getPlans ().length) {
						getPlans ()[i].logicObject.oAlpha = 1.0;
					}
				},
		
				/*
				function ():Void {
					xm.replaceAllSoundTasks ([
						XTask.FUNC, function (__task:XSoundTask):Void {
							G.app.setSoundPlaying (true);
							
							var s:Array = G.app.getRandomSoundFromGroup (G.app.Act_SFX_Start());
							__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
						},  XTask.EXEC, waitForSoundFinishedX (),
		
						XTask.FUNC, function (__task:XSoundTask):Void {
							var s:Array = G.app.getRandomSoundFromGroup (G.app.Act_SFX_StartNext());
							__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
						},  XTask.EXEC, waitForSoundFinishedX (),
									
						function ():Void {
							G.app.setSoundPlaying (false);
						},
						
						XTask.RETN,
					]);
				},
				*/
								
				XTask.LABEL, "loop",		
					function ():Void {
						__planModel = getPlans ()[m_currPlanIndex];
					},
					
					function ():Void {
						__planModel.iconObject.FlashingMode_Script ();
					},
	
					XTask.EXEC, __waitForGoal (),
		
					function ():Void {						
						__planModel.iconObject.Finished_Script ();
							
						var __logicObject:FarXObstacle = __planModel.logicObject;							
						__logicObject.getCursorHighlightObject ().Highlighted_CompletedGoal_Script ();
						
						addCompletedStep ();
					},
			
					function ():Void {
						setLastCompletedPlanIndex (m_currPlanIndex);
						
						m_currPlanIndex++;
					},
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (m_currPlanIndex < getPlans ().length);
					},
							
					XTask.BEQ, "loop",
					
					function ():Void {
						var s:Array<Dynamic>; // <Dynamic>
						
						G.setGameMode (G.GAMEMODE_FINISHED);
						
//						G.app.getScoreAndOptions ().addToScore (1);
								
						xm.replaceAllSoundTasks ([
							function ():Void {
								G.app.setSoundPlaying (true);
							},
			
							XTask.FUNC, function (__task:XSoundTask):Void {
								s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_GoodJob());
								__task.replaceSound (s[0], soundFinished);
								G.app.setMessage (s[1]);
							},  XTask.EXEC, waitForSoundFinishedX (),
			
							XTask.WAIT1000, m_standardVoiceDelay,
												
							function ():Void {
								__soundDone = true;
								
								G.app.setSoundPlaying (false);
							},
							
							XTask.RETN,
						]);	
					},
					
					XTask.LABEL, "__wait",
							
					XTask.WAIT, 0x0100,
							
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (__soundDone);
					}, XTask.BNE, "__wait",
							
					function ():Void {
						Level_Reflect_Script ();
					},
					
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function Act_SFX_GoodJob ():Void {
			var s:Array<Dynamic>; // <Dynamic>
			
			G.app.setSoundPlaying (true);
						
			xm.replaceAllSoundTasks ([
				XTask.WAIT, 0x4000,
							
				XTask.FUNC, function (__task:XSoundTask):Void {
					s = G.app.getRandomSoundFromGroup (G.app.Act_SFX_GoodJob());
					__task.replaceSound (s[0], soundFinished);
					G.app.setMessage (s[1]);
				},  XTask.EXEC, waitForSoundFinishedX (),
							
				XTask.WAIT1000, m_standardVoiceDelay,
									
				function ():Void {
					G.app.setSoundPlaying (false);
				},
							
				XTask.RETN,
			]);	
		}

//------------------------------------------------------------------------------------------
		public function Act_SFX_1Error ():Void {
			var s:Array<Dynamic>; // <Dynamic>
			
			G.app.setSoundPlaying (true);
						
			xm.replaceAllSoundTasks ([
				XTask.WAIT, 0x4000,
							
				XTask.FUNC, function (__task:XSoundTask):Void {
					s = G.app.getRandomSoundFromGroup (G.app.Act_SFX_1Error());
					__task.replaceSound (s[0], soundFinished);
					G.app.setMessage (s[1]);
				},  XTask.EXEC, waitForSoundFinishedX (),
				
				XTask.WAIT1000, m_standardVoiceDelay,
												
				function ():Void {
					G.app.setSoundPlaying (false);
				},
							
				XTask.RETN,
			]);	
		}
			
//------------------------------------------------------------------------------------------
		public function Act_SFX_2Errors ():Void {
			var s:Array<Dynamic>; // <Dynamic>
			
			G.app.setSoundPlaying (true);
						
			xm.replaceAllSoundTasks ([
				XTask.WAIT, 0x4000,
							
				XTask.FUNC, function (__task:XSoundTask):Void {
					s = G.app.getRandomSoundFromGroup (G.app.Act_SFX_2Errors());
					__task.replaceSound (s[0], soundFinished);
					G.app.setMessage (s[1]);
				},  XTask.EXEC, waitForSoundFinishedX (),
				
				XTask.WAIT1000, m_standardVoiceDelay,
												
				function ():Void {
					G.app.setSoundPlaying (false);
				},
							
				XTask.RETN,
			]);	
		}
				
//------------------------------------------------------------------------------------------
		public function Level_Reflect_Script ():Void {
			var i:Int;
			var __planModel:PlanModelX;
			var __nextPlanModel:PlanModelX;
			var __currIndex:Int;
					
			//------------------------------------------------------------------------------------------			
			function __waitForSelect ():Array<Dynamic> /* <Dynamic> */ {
				return [
					function ():Void {
						__planModel = null;
					},
					
					XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (__planModel != null);
					},
					
					XTask.BNE, "loop",
					
					function ():Void {
						trace (": ", __planModel, __planModel.index);
					},
					
					XTask.RETN,
				];
			}
			
			//------------------------------------------------------------------------------------------			
			function __selected (args:Dynamic /* */ /* Dynamic */):Void {
				__planModel = cast args; /* as PlanModelX */
				
				trace (": __planModel: ", __planModel, __planModel.completed);
			}
			
			//------------------------------------------------------------------------------------------			
			function __selectedPlan (args:Dynamic /* */ /* Dynamic */):Void {
				__planModel = cast args; /* as PlanModelX */
				
				var i:Float;
				
				for (i in __planModel.index+1 ... m_plans.length) {
					var __planModel2:PlanModelX = m_plans[i];
					
					if (__planModel.type == __planModel2.type &&
						__planModel.logicObject.oX == __planModel2.logicObject.oX &&
						__planModel.logicObject.oY == __planModel2.logicObject.oY
					) {
						trace (": *** >>>: ", __planModel, __planModel.index);
						
						var __logicObject:XLogicObject = __planModel.logicObject;
						
						addTask ([
							XTask.WAIT, 0x0800,
							
							function ():Void {
								__logicObject.setVisible (false);		
							},
							
							XTask.RETN,
						]);
						
						addTask ([
							XTask.WAIT, 0x1800,
							
							function ():Void {	
								__planModel2.logicObject.setVisible (true);
							},
							
							XTask.RETN,
						]);
						
						return;
					}
				}
				
				trace (": selectedPlan: ", __planModel, __planModel.type);
			}
			
			//------------------------------------------------------------------------------------------	
			m_currPlanIndex = 0;
			
			setLastCompletedPlanIndex (m_currPlanIndex);

//------------------------------------------------------------------------------------------
			G.setGameMode (G.GAMEMODE_PLANNING);
			
			G.app.getBee ().hideKey ();			

//			G.app.getProgressBar ().addStageType (FAR.STAGE_REFLECT);
			
			__planModel = getPlans ()[m_currPlanIndex];
						
			G.app.getBee ().setPos (__planModel.beePos2);
			G.app.getBee ().oScaleX = __planModel.beeDirection2;
					
			doLevelReflectSFX ();
			
//------------------------------------------------------------------------------------------			
			script.gotoTask ([
				function ():Void {
					var __splash:SplashX = cast xxx.getXLogicManager ().initXLogicObject (
						// parent
							self,
						// logicObject
							new SplashX () /* as XLogicObject */,
						// item, layer, depth
							null, 0, 20000,
						// x, y, z
							0, 0, 0,
						// scale, rotation
							1.0, 0,
							[
								"Assets:ReflectSplashClass",
								"Go FAR!",
								false,
								function ():Void {
									xm.replaceAllSoundTasks ([
										XTask.FUNC, function (__task:XSoundTask):Void {
											G.app.setSoundPlaying (true);
									
											var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Reflect_SFX_Start());
											__task.replaceSound (s[0], soundFinished);
											G.app.setMessage (s[1]);
										},  XTask.EXEC, waitForSoundFinishedX (),
						
										XTask.WAIT1000, m_standardVoiceDelay,
										
										XTask.FUNC, function (__task:XSoundTask):Void {	
											var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Reflect_SFX_StartNext());
											__task.replaceSound (s[0], soundFinished);
											G.app.setMessage (s[1]);
										},  XTask.EXEC, waitForSoundFinishedX (),
										
										XTask.WAIT1000, m_standardVoiceDelay,
													
										function ():Void {
											G.app.setSoundPlaying (false);
										},
										
										XTask.RETN,
									]);
								}
							]
						) /* as SplashX */;
						
					addXLogicObject	(__splash);	
				},
							
				function ():Void {	
					for (i in 0 ... getPlans ().length) {
						getPlans ()[i].logicObject.kill ();
					}

					for (i in 0 ... getOffPlans ().length) {
						getOffPlans ()[i].logicObject.kill ();
					}
										
					G.app.getBee ().planningMode ();
						
					for (i in 0 ... getPlans ().length) {
						getPlans ()[i].iconObject.InvisiMode_Script ();
						
						getPlans ()[i].completed = false;
					}
				},
		
				function ():Void {		
					recreateLevel ();

					for (i in 0 ... getPlans ().length) {
//						getPlans ()[i].logicObject.addSelectedListener (__selected);
						getPlans ()[i].logicObject.addSelectedListener (__selectedPlan);
					}

					for (i in 0 ... getOffPlans ().length) {
						getOffPlans ()[i].logicObject.addSelectedListener (__selected);
					}
										
					__currIndex = 0;
				},	
						
				XTask.LABEL, "loop",					
					XTask.EXEC, __waitForSelect (),
				
					XTask.FLAGS, function (__task:XTask):Void {
						if (__currIndex == __planModel.index && !__planModel.fake) {		
							xm.replaceAllSoundTasks ([
								XTask.FUNC, function (__task:XSoundTask):Void {
									var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Reflect_SFX_GoodJob());
									__task.replaceSound (s[0], soundFinished);
									G.app.setMessage (s[1]);
								},  XTask.EXEC, waitForSoundFinishedX (),
								
								XTask.WAIT1000, m_standardVoiceDelay,
									
								function ():Void {
									G.app.setSoundPlaying (false);
								},
								
								XTask.RETN,
							]);	

//							__planModel.iconObject = G.app.getPlanTray ().addGoalType (__planModel.type);

							__planModel.iconObject.NormalMode_Script ();
							
							var __logicObject:FarXObstacle = __planModel.logicObject;							
							__logicObject.getCursorHighlightObject ().setExplodeAway ();

							addCompletedStep ();
							
							addTask ([
								XTask.WAIT, 0x0800,
								
								function ():Void {
									__logicObject.oAlpha = 0.25;
								},
								
								XTask.RETN,
							]);
							
							trace (": ", __currIndex, getPlans ().length);
							
							__currIndex++;
							
							if (__currIndex < getPlans ().length) {								
								__nextPlanModel = getPlans ()[__currIndex];
								
								G.app.getBee ().setPos (__nextPlanModel.beePos2);
								G.app.getBee ().oScaleX = __nextPlanModel.beeDirection2;
							}
							else
							{
								for (i in 0 ... getPlans ().length) {
//									getPlans ()[i].logicObject.removeSelectedListener (__selected);
									getPlans ()[i].logicObject.removeSelectedListener (__selectedPlan);
								}
								
//								G.app.getScoreAndOptions ().addToScore (1);
								
								addTask ([
									XTask.WAIT1000, 2*1000,
									
									function ():Void {
										G.app.setCumalativeScore (G.app.getScoreAndOptions ().getScore ());
										
										createWinX ();
									},
									
									XTask.RETN,
								]);
							}
						}
						else
						{
							var __rightModel:PlanModelX = getPlans()[__currIndex];	
							__rightModel.incorrectGuesses++;
							
							__planModel.logicObject.buzzWrong ();
							
							if (true) {
								addTask ([
									XTask.WAIT, 0x1000,
									
									function ():Void {
										xm.replaceAllSoundTasks ([
											XTask.WAIT, 0x1000,
														
											XTask.FUNC, function (__task:XSoundTask):Void {
												var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Reflect_SFX_1Error());
												__task.replaceSound (s[0], soundFinished);
												G.app.setMessage (s[1]);
							
												// XTask.WAIT1000, m_standardVoiceDelay,
									
												G.app.setSoundPlaying (true);
											},  XTask.EXEC, waitForSoundFinishedX (),
											
											XTask.WAIT1000, m_standardVoiceDelay,
												
											function ():Void {
												G.app.setSoundPlaying (false);
											},
																					
											XTask.RETN,
										]);	
									},	

									XTask.RETN,
								]);
							}
						}
					},

					XTask.GOTO, "loop",
									
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function createWinX ():Void {
			cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					null,
				// logicObject
					new WinX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 0,
				// x, y, z
					0, 0, 0,
				// scale, rotation
					1.0, 0
			) /* as XLogicObject */;
		}
								
//------------------------------------------------------------------------------------------
		public function spawnBee (__x:Float, __y:Float):Void {
			m_beeObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new BeeX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 2000,
				// x, y, z
					__x, __y, 0,
				// scale, rotation
					1.0, 0,
					[
						this
					]
				) /* as BeeX */;

			addXLogicObject (m_beeObject);
		}
		
//------------------------------------------------------------------------------------------
		public function spawnDoor (__planModel:PlanModelX, __x:Float, __y:Float):Void {
			m_doorObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new DoorX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 1000,
				// x, y, z
					__x, __y, 0,
				// scale, rotation
					1.0, 0,
					[
						this
					]
				) /* as DoorX */;
				
			m_doorObject.setPlan (__planModel);
			__planModel.logicObject = m_doorObject;
			
			addXLogicObject (m_doorObject);
		}
		
//------------------------------------------------------------------------------------------
		public function spawnKey (__planModel:PlanModelX, __x:Float, __y:Float):Void {
			m_keyObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new KeyX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 1000,
				// x, y, z
					__x, __y, 0,
				// scale, rotation
					1.0, 0,
					[
						this
					]
				) /* as KeyX */;
				
			m_keyObject.setPlan (__planModel);
			__planModel.logicObject = m_keyObject;
										
			addXLogicObject (m_keyObject);
		}

//------------------------------------------------------------------------------------------
		public function spawnLadder (__planModel:PlanModelX, __x:Float, __y:Float):Void {
			m_ladderObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new LadderX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 1000,
				// x, y, z
					__x, __y, 0,
				// scale, rotation
					1.0, 0,
					[
						this,
						__planModel.assetName
					]
				) /* as LadderX */;

			m_ladderObject.setPlan (__planModel);
			__planModel.logicObject = m_ladderObject;
							
			addXLogicObject (m_ladderObject);
		}

//------------------------------------------------------------------------------------------
		public function spawnGoomba (__planModel:PlanModelX, __x:Float, __y:Float):Void {
			m_goombaObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new GoombaX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 1000,
				// x, y, z
					__x, __y, 0,
				// scale, rotation
					1.0, 0,
					[
						this
					]
				) /* as GoombaX */;

			m_goombaObject.setPlan (__planModel);
			__planModel.logicObject = m_goombaObject;
								
			addXLogicObject (m_goombaObject);
		}

//------------------------------------------------------------------------------------------
		public function spawnPit (__planModel:PlanModelX, __x:Float, __y:Float):Void {
			m_pitObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new PitX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 1000,
				// x, y, z
					__x, __y, 0,
				// scale, rotation
					1.0, 0,
					[
						this
					]
				) /* as PitX */;

			m_pitObject.setPlan (__planModel);
			__planModel.logicObject = m_pitObject;
									
			addXLogicObject (m_pitObject);
		}
				
//------------------------------------------------------------------------------------------
		public function createBGController (__setting:Float = 0, __depth:Float = 0):Void {
			var __controller:XLogicObject;
			var __logicObject:XLogicObject;
			
			switch (__setting) {
				case 0:
					__logicObject = cast new BGCloudControllerX (); /* as XLogicObject */
					// break;
					
				case 1:
					__logicObject = cast new BGUnderwaterControllerX (); /* as XLogicObject */
					// break;
					
				case 2:
					__logicObject = cast new BGSpaceControllerX (); /* as XLogicObject */
					// break;
					
				default:
					__logicObject = cast new BGCloudControllerX (); /* as XLogicObject */
					// break;
			}
			
			__controller = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					self,
				// logicObject
					__logicObject,
				// item, layer, depth
					null, 0, __depth + 1,
				// x, y, z
					0, 0, 0,
				// scale, rotation`
					1.0, 0
				) /* as XLogicObject */;
				
			addXLogicObject (__controller);
		}
	
//------------------------------------------------------------------------------------------
		public function createIrisEffectX ():IrisEffectX {
			var __iris:IrisEffectX = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					null,
				// logicObject
					new IrisEffectX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 15000,
				// x, y, z
					966/2, 600/2, 0,
				// scale, rotation
					1.0, 0
			) /* as IrisEffectX */;
			
			return __iris;
		}
			
//------------------------------------------------------------------------------------------
		public function doLevelPlanningSFX ():Void {
			var s:Array<Dynamic>; // <Dynamic>
			
			xm.replaceAllSoundTasks ([
				XTask.WAIT, 0x0100,
				
				function ():Void {
					G.app.setSoundPlaying (true);
				},
	
				XTask.WAIT, 0x4000,
							
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.WeCallOurGameFar () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),
				
				XTask.WAIT1000, m_standardVoiceDelay,
									
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.FocusMeansLookingAndListeningCarefully () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),
				
				XTask.WAIT1000, m_standardVoiceDelay,
									
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.WhenYouMakeAPlanYouThinkAboutWhatYouAreGoingToDo () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),
				
				XTask.WAIT1000, m_standardVoiceDelay,
									
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.NowFocusOnTheGameAndMakeAPlan () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),
				
				XTask.WAIT1000, m_standardVoiceDelay,
									
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.ClickOnTheStepsToGetTheKey () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),
				
				XTask.WAIT1000, m_standardVoiceDelay,
									
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.EachStepInThePlanHasAStar () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),
				
				XTask.WAIT1000, m_standardVoiceDelay,
									
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.ClickStartWhenYouAreReady () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),
				
				XTask.WAIT1000, m_standardVoiceDelay,
																
				function ():Void {
					G.app.setSoundPlaying (false);
				},
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function doLevelPlayingSFX ():Void {
			var s:Array<Dynamic>; // <Dynamic>
			
			xm.replaceAllSoundTasks ([
				XTask.WAIT, 0x0100,
				
				function ():Void {
					G.app.setSoundPlaying (true);
				},
	
				XTask.WAIT, 0x4000,
							
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.NowYouHaveMadeAPlan () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
									
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.AreYouReadyToDoTheStepsInYourPlanToAct () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
									
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.MoveUsingTheArrowKeys () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,

//				XTask.FUNC, function (__task:XSoundTask):void {
//					__task.replaceSound (XAssets.ThereWillBeASurpriseBehindTheDoor () , soundFinished);
//				}, XTask.EXEC, waitForSoundFinishedX (),
//				
//				XTask.WAIT1000, m_standardVoiceDelay,
																																	
				function ():Void {
					xm.removeAllSounds();
					
					G.app.setSoundPlaying (false);
				},
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function doLevelReflectSFX ():Void {
			var s:Array<Dynamic> ; // <Dynamic> 
			
			xm.replaceAllSoundTasks ([
				XTask.WAIT, 0x0100,
				
				function ():Void {
					G.app.setSoundPlaying (true);
				},
	
				XTask.WAIT, 0x4000,
							
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.ForTheLastPartClickOnTheStepsToReflectOnWhatYouDid () , soundFinished);
				}, XTask.EXEC, waitForSoundFinishedX (),
										
				XTask.WAIT1000, m_standardVoiceDelay,
																											
				function ():Void {
					G.app.setSoundPlaying (false);
				},
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------			
		public function waitForSoundFinishedX ():Array<Dynamic> /* <Dynamic> */ {
			return [
				function ():Void {
					m_soundFinished = false;
				},
				
				XTask.LOOP, 0,
					XTask.WAIT, 0x0100,
					
					XTask.UNTIL, function (__task:XTask):Void {
						__task.ifTrue (m_soundFinished);
					},
					
				XTask.RETN,
			];
		}
			
//------------------------------------------------------------------------------------------
		public function soundFinished ():Void {
			m_soundFinished = true;
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
