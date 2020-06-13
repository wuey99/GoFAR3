//------------------------------------------------------------------------------------------
package ;
	
	import assets.*;
	
	import interfaces.*;
	
	import levels.*;
	import levels.level001.*;
	import levels.level002.*;
	import levels.level003.*;
	import levels.level004.*;
	import levels.level005.*;
	import levels.level006.*;
	import levels.level007.*;
	import levels.level008.*;
	import levels.level009.*;
	import levels.level010.*;
	import levels.level011.*;
	import levels.level012.*;
	import levels.level013.*;
	import levels.practiceplanning.*;
	import levels.practiceplaying.*;
	
	import objects.*;
	import objects.clouds.*;
	import objects.effects.*;
	import objects.mickey.*;
	import objects.obstacles.*;
	import objects.splash.*;
	import objects.win.*;
	
	import xlogicobject.*;
	
	import ui.*;
	
	import kx.*;
	import kx.keyboard.*;
	import kx.resource.*;
	import kx.task.*;
	import kx.type.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	import kx.world.ui.*;
	
	import nx.touch.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class GameControllerX extends XLogicObject {
		private var m_beeObject:BeeX;
		private var m_levelObject:LevelX;
		private var m_planTrayObject:PlanTrayX;
		private var m_dialogTrayObject:DialogTrayX;
		private var m_progressBarObject:ProgressBarX;
		private var m_progressBarFGObject:ProgressBarFGX;
		private var script:XTask;
		private var m_scoreAndOptions:ScoreAndOptionsX;
		private var m_optionsDialogBox:OptionsDialogBoxX;
		private var m_mainInterface:MainInterfaceX;
		private var m_currLevel:Int;
		private var m_currSetting:Int;
		private var m_winController:XLogicObject;
		private var m_dpadTrayObject:DPadTrayX;

//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
			
			m_currLevel = 0;
			m_currSetting = 0;
			
			m_levelObject = null;
			m_winController = null;
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();

			createSprites ();
			
			script = addEmptyTask ();
			
			addTask ([
				XTask.WAIT, 0x0400,
				
				function ():Void {	
					initLevel ();
					
//					loadLevel ();
				},
				
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {			
			show ();
		}

//------------------------------------------------------------------------------------------
		public function initLevel ():Void {	
			m_mainInterface = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new MainInterfaceX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 2000,
				// x, y, z
					G.LEFT_MARGIN, 0, 0,
				// scale, rotation
					1.0, 0
				) /* as MainInterfaceX */;
					
			addXLogicObject (m_mainInterface);

			m_dpadTrayObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
				this,
				// logicObject
				new DPadTrayX () /* as XLogicObject */,
				// item, layer, depth
				null, 0, 999999 - 1,
				// x, y, z
				962, 0, 0,
				// scale, rotation
				1.0, 0
			) /* as DPadTrayX */;
			
			addXLogicObject (m_dpadTrayObject);
			
			m_planTrayObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new PlanTrayX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 8000,
				// x, y, z
					G.LEFT_MARGIN, 480, 0,
				// scale, rotation
					1.0, 0
				) /* as PlanTrayX */;

			addXLogicObject (m_planTrayObject);
			
			m_dialogTrayObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new DialogTrayX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 8000,
				// x, y, z
					580 + G.LEFT_MARGIN, 480, 0,
				// scale, rotation
					1.0, 0
				) /* as DialogTrayX */;
					
			addXLogicObject (m_dialogTrayObject);
						
			m_progressBarObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new ProgressBarX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 4000,
				// x, y, z
					864 + G.LEFT_MARGIN, 96, 0,
				// scale, rotation
					1.0, 0
				) /* as ProgressBarX */;
				
			addXLogicObject (m_progressBarObject);

			m_progressBarFGObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new ProgressBarFGX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 10000,
				// x, y, z
					864 + G.LEFT_MARGIN, 96, 0,
				// scale, rotation
					1.0, 0
				) /* as ProgressBarFGX */;
				
			addXLogicObject (m_progressBarFGObject);
			
			m_scoreAndOptions = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new ScoreAndOptionsX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 4000,
				// x, y, z
					864 + G.LEFT_MARGIN, 0, 0,
				// scale, rotation
					1.0, 0
				) /* as ScoreAndOptionsX */;
				
			addXLogicObject (m_scoreAndOptions);
		
			getOptionsButton ().addMouseUpListener (
				function ():Void {
					openOptionsDialogBox ();
				}
			);
			
			openOptionsDialogBox ();
		}

//------------------------------------------------------------------------------------------
		public function openOptionsDialogBox ():Void {
			if (!OptionsDialogBoxX.isRunning) {
				m_optionsDialogBox = cast xxx.getXLogicManager ().initXLogicObject (
					// parent
						self,
					// logicObject
						new OptionsDialogBoxX () /* as XLogicObject */,
					// item, layer, depth
						null, 0, 100000,
					// x, y, z
						160, 96, 0,
					// scale, rotation
						1.0, 0
					) /* as OptionsDialogBoxX */;
							
				addXLogicObject (m_optionsDialogBox);
			}		
		}
		
//------------------------------------------------------------------------------------------
		public function loadLevel ():Void {
			var __levelTable:Array<Class<Dynamic>> /* <Class<Dynamic>> */ = [
				Level001X,
				Level002X,
				Level003X,
				Level004X,
				Level005X,
				Level006X,
				Level007X,
				Level008X,
				Level009X,
				Level010X,
				Level011X,
				Level012X,
				Level013X
			];
			
			var __levelX:LevelX = XType.createInstance (__levelTable[getCurrLevel ()]);
			
			m_levelObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					cast __levelX,
				// item, layer, depth
					null, 0, 500,
				// x, y, z
					-48 + G.LEFT_MARGIN, -96, 0,
				// scale, rotation
					1.0, 0,
					[
						getCurrSetting ()
					]
				) /* as LevelX */;
				
			addXLogicObject (m_levelObject);
			
			m_levelObject.createPlanningLevel ();
		}

//------------------------------------------------------------------------------------------
		public function practicePlanning ():Void {
			m_levelObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new PracticePlanningX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 500,
				// x, y, z
					-48 + G.LEFT_MARGIN, -96, 0,
				// scale, rotation
					1.0, 0,
					[
						getCurrSetting ()
					]
				) /* as LevelX */;
				
			addXLogicObject (m_levelObject);
			
			m_levelObject.createPlanningLevel ();
		}

//------------------------------------------------------------------------------------------
		public function practicePlaying ():Void {
			m_levelObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new PracticePlayingX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 500,
				// x, y, z
					-48 + G.LEFT_MARGIN, -96, 0,
				// scale, rotation
					1.0, 0,
					[
						getCurrSetting ()
					]
				) /* as LevelX */;
				
			addXLogicObject (m_levelObject);
			
			m_levelObject.createFreePlayLevel ();
		}
		
//------------------------------------------------------------------------------------------
		public function endLevel ():Void {
//			m_planTrayObject.kill ();
//			m_dialogTrayObject.kill ();
//			m_progressBarObject.kill ();

			getPlanTray ().removeAllGoals ();
			
			if (m_levelObject != null) {
				m_levelObject.cleanup ();
				m_levelObject = null;
			}

			if (m_winController != null) {
				m_winController.kill ();
				
				m_winController = null;
			}
			
//			m_scoreAndOptions.kill ();
		}
		
//------------------------------------------------------------------------------------------
		public function getCurrLevel ():Int {
			return m_currLevel;
		}
		
//------------------------------------------------------------------------------------------
		public function setCurrLevel (__level:Int):Void {
			m_currLevel = __level;
		}

//------------------------------------------------------------------------------------------
		public function getCurrSetting ():Int {
			return m_currSetting;
		}
		
//------------------------------------------------------------------------------------------
		public function setCurrSetting (__setting:Int):Void {
			m_currSetting = __setting;
		}
		
//------------------------------------------------------------------------------------------
		public function initMenu ():Void {
			var __level001FreePlay:XTextButton;
			var __level001Planning:XTextButton;
						
			var y:Float = 0;
			
			__level001FreePlay = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new XTextButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 4000,
				// x, y, z
					970, y, 0,
				// scale, rotation
					1.0, 0,
					[
						"Level001, FreePlay"
					]
				) /* as XTextButton */;
				
			addXLogicObject (__level001FreePlay);
			
			y += 16;
			
			__level001Planning = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new XTextButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 4000,
				// x, y, z
					970, y, 0,
				// scale, rotation
					1.0, 0,
					[
						"Level001, Planning"
					]
				) /* as XTextButton */;
				
			addXLogicObject (__level001Planning);
		}

//------------------------------------------------------------------------------------------
		public function getBee ():BeeX {
			return m_levelObject.getBee ();	
		}

//------------------------------------------------------------------------------------------
		public function getLevel ():LevelX {
			return m_levelObject;	
		}
		
//------------------------------------------------------------------------------------------
		public function setMessage (__message:String):Void {
			m_dialogTrayObject.setMessage (__message);
		}
		
//------------------------------------------------------------------------------------------
		public function getPlanTray ():PlanTrayX {
			return m_planTrayObject;
		}

//------------------------------------------------------------------------------------------
		public function getProgressBar ():ProgressBarX {
			return m_progressBarObject;	
		}

//------------------------------------------------------------------------------------------
		public function getOptionsButton ():__XButton {
			return m_scoreAndOptions.getOptionsButton ();	
		}
		
//------------------------------------------------------------------------------------------
		public function getScoreAndOptions ():ScoreAndOptionsX {
			return m_scoreAndOptions;	
		}
		
//------------------------------------------------------------------------------------------
		public function createWinCloudController ():Void {
			m_winController = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					null,
				// logicObject
					new BGWinCloudControllerX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 0,
				// x, y, z
					0, 0, 0,
				// scale, rotation`
					1.0, 0
				) /* as XLogicObject */;
				
			m_winController.show ();
		}
					
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
