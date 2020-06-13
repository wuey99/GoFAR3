//------------------------------------------------------------------------------------------
package;
	// application classes
	import assets.*;
	
	import interfaces.*;
	
	import levels.*;
	import levels.level001.*;
	
	import objects.*;
	import objects.clouds.*;
	import objects.mickey.*;
	import objects.obstacles.*;
	
	import xlogicobject.*;
	
	import sound.*;
	
	import ui.*;
	
	import openfl.display.Sprite;
	import openfl.events.*;
	import openfl.geom.*;
	import openfl.media.Sound;
	import openfl.system.*;
	import openfl.utils.*;
	
	import kx.*;
	import kx.geom.*;
	import kx.keyboard.*;
	import kx.resource.*;
	import kx.texture.*;
	import kx.sound.*;
	import kx.task.*;
	import kx.type.*;
	import kx.world.*;
	import kx.world.logic.*;
	import kx.world.ui.*;
	
	import nx.touch.*;
	
	//------------------------------------------------------------------------------------------
	class Game extends Sprite {
		private var m_XApp:XApp;
		private var xxx:XWorld;
		private var m_app:GoFAR2;
		private var m_assets:XAssets;
		private var m_keyboardManager:XKeyboardManager;
		private var m_gameController:GameControllerX;
		private var m_soundPlayingCount:Int;
		private var m_gameMouseEvents:Int;
		public var m_XSoundTaskManager:XSoundTaskManager;
		public var m_XSoundManager:XOldSoundManager;
		private var m_touchManager:XTouchManager;	
		
		public static var m_cumalativeScore:Int = 0;	
		
		//------------------------------------------------------------------------------------------
		public static var app:Game;
		
		//------------------------------------------------------------------------------------------
		public static inline var GOAL_OPENDOOR:Int = 1;
		public static inline var GOAL_GETKEY:Int = 2;
		public static inline var GOAL_CLIMBLADDER:Int = 3;
		public static inline var GOAL_JUMPPIT:Int = 4;
		public static inline var GOAL_KILLGOOMBA:Int = 5;
		public static inline var OBJECT_BEE:Int = 6;
		
		public static inline var SENSOR_JUMPPIT:Int = 7;
		public static inline var SENSOR_CLIMBLADDER:Int = 8;
		
		public static inline var STAGE_PLAN:Int = 1;
		public static inline var STAGE_PLAY:Int = 2;
		public static inline var STAGE_REFLECT:Int = 3;
		
		public var m_panelMask:Sprite;
		
		//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

		//------------------------------------------------------------------------------------------
		public /* override */ function setup (
			__assetsClass:Class<Dynamic> /* <Dynamic> */,
			__mickeyXClass:Class<Dynamic> /* <Dynamic> */,
			__parent:Dynamic /* */,
			__timerInterval:Float=32, 
			__layers:Int=4
		):Void {	
			trace (": Game: setup: ");
			
			/// super.setup (__assetsClass, __mickeyXClass, __parent, __timerInterval, __layers);
			
			app = this;
			
			m_XApp = new XApp ();
			m_XApp.setup (m_XApp.getDefaultPoolSettings ());
			
			xxx = new XWorld (this, m_XApp);
			addChild (xxx);
			
			G.setup (this, m_XApp);
			
			m_XSoundTaskManager = new XSoundTaskManager (m_XApp);
			m_XSoundManager = new XOldSoundManager (m_XApp);
			
			m_soundPlayingCount = 0;
			m_gameMouseEvents = 1;
			
			xxx.grabFocus ();
			
			m_assets = new XAssets (m_XApp, this);
			m_assets.load ();
			
			m_panelMask = new Sprite ();	
			m_panelMask.graphics.beginFill (0xFFFFFF);
			m_panelMask.graphics.drawRect (0, 0, G.SCREEN_WIDTH, G.SCREEN_HEIGHT);	
			mask = m_panelMask;
			addChild (m_panelMask);
			
			cacheAllMovieClips ();
			
			xxx.getXTaskManager ().addTask ([
				XTask.LABEL, "loop",
				XTask.WAIT, 0x0100,
				
				function ():Void {				
					m_XSoundTaskManager.updateTasks ();
				},
				
				XTask.GOTO, "loop",
				
				XTask.RETN,
			]);
			
			xxx.getXTaskManager ().addTask ([
				XTask.WAIT, 0x0400,
				
				function ():Void {	
					trace (": ---------------->: xyzzy: ", xxx.getClass ("Assets:Level001_AClass"));
					m_touchManager = new XTouchManager ();
					m_touchManager.setup (m_XApp, xxx);
				
					initGameController ();
				},
				
				XTask.RETN,
			]);
			
			G.setCamera (new XPoint (-48, -96));
		}
		
		//------------------------------------------------------------------------------------------
		public function initGameController ():Void {		
			m_gameController = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
				null,
				// logicObject
				new GameControllerX () /* as XLogicObject */,
				// item, layer, depth
				null, 0, 0,
				// x, y, z
				0, 0, 0,
				// scale, rotation
				1.0, 0
			) /* as GameControllerX */;
		}
		
		//------------------------------------------------------------------------------------------
		public function cacheAllMovieClips ():Void {
			var t:XSubTextureManager = xxx.getTextureManager ().createSubManager ("__global__");
			
			t.start ();
			
			XType.forEach (m_XApp.getAllClassNames (), 
				function (x:Dynamic /* */):Void {
					t.add (cast(x, String) );					
				}
			);
			
			t.finish ();
		}
		
		//------------------------------------------------------------------------------------------
		public function getTouchManager ():XTouchManager {
			return m_touchManager;
		}
		
		//------------------------------------------------------------------------------------------
		public function getGameController ():GameControllerX {
			return m_gameController;
		}
		
		//------------------------------------------------------------------------------------------
		public function getXSoundTaskManager ():XSoundTaskManager {
			return m_XSoundTaskManager;
		}
		
		//------------------------------------------------------------------------------------------
		public function getOldSoundManager ():XOldSoundManager {
			return m_XSoundManager;
		}
		
		//------------------------------------------------------------------------------------------
		public function getBee ():BeeX {
			return m_gameController.getBee ();	
		}
		
		//------------------------------------------------------------------------------------------
		public function getLevel ():LevelX {
			return m_gameController.getLevel ();	
		}
		
		//------------------------------------------------------------------------------------------
		public function setMessage (__message:String):Void {
			m_gameController.setMessage (__message);
		}
		
		//------------------------------------------------------------------------------------------
		public function loadLevel ():Void {
			m_gameController.loadLevel ();
		}	
		
		//------------------------------------------------------------------------------------------
		public function practicePlanning ():Void {
			m_gameController.practicePlanning ();
		}	
		
		//------------------------------------------------------------------------------------------
		public function practicePlaying ():Void {
			m_gameController.practicePlaying ();
		}
		
		//------------------------------------------------------------------------------------------
		public function endLevel ():Void {
			m_gameController.endLevel ();
		}
		
		//------------------------------------------------------------------------------------------
		public function getCurrLevel ():Int {
			return m_gameController.getCurrLevel ();
		}
		
		//------------------------------------------------------------------------------------------
		public function setCurrLevel (__level:Int):Void {
			m_gameController.setCurrLevel (__level);
		}
		
		//------------------------------------------------------------------------------------------
		public function getCurrSetting ():Int {
			return m_gameController.getCurrSetting ();
		}
		
		//------------------------------------------------------------------------------------------
		public function setCurrSetting (__setting:Int):Void {
			m_gameController.setCurrSetting (__setting);
		}
		
		//------------------------------------------------------------------------------------------
		public function getPlanTray ():PlanTrayX {
			return m_gameController.getPlanTray ();
		}
		
		//------------------------------------------------------------------------------------------
		public function getProgressBar ():ProgressBarX {
			return m_gameController.getProgressBar ();
		}
		
		//------------------------------------------------------------------------------------------
		public function getOptionsButton ():__XButton {
			return m_gameController.getScoreAndOptions ().getOptionsButton ();	
		}
		
		//------------------------------------------------------------------------------------------
		public function getScoreAndOptions ():ScoreAndOptionsX {
			return m_gameController.getScoreAndOptions ();	
		}
		
		//------------------------------------------------------------------------------------------
		public function getCumalativeScore ():Int {
			return m_cumalativeScore;
		}
		
		//------------------------------------------------------------------------------------------
		public function setCumalativeScore (__score:Int):Void {
			m_cumalativeScore = __score;
		}
		
		//------------------------------------------------------------------------------------------
		public function blockGameMouseEvents ():Void {
			m_gameMouseEvents--;
		}
		
		//------------------------------------------------------------------------------------------
		public function allowGameMouseEvents ():Void {
			m_gameMouseEvents++;
		}
		
		//------------------------------------------------------------------------------------------
		public function isGameMouseEventsAllowed ():Bool {
			if (m_gameMouseEvents > 0) {
				return true;
			}
			else
			{
				return false;
			}
		}
		
		//------------------------------------------------------------------------------------------
		public function getSoundFromGroup (__index:Int, __soundGroup:Array<Dynamic>):Array<Dynamic> {	
			var __sound:Sound = cast /* XType.createInstance */ (__soundGroup[__index * 2 + 0]); /* as Sound */
			return [__sound, __soundGroup[__index * 2 + 1]];
		}
		
		//------------------------------------------------------------------------------------------
		public function getRandomSoundFromGroup (__soundGroup:Array<Dynamic>):Array<Dynamic> {	
			var __rand:Float = Math.random () * __soundGroup.length/2;
			
			var __index:Int = Math.floor (__rand);
			
			var __sound:Sound = cast /* XType.createInstance */ (__soundGroup[__index * 2 + 0]); /* as Sound */
			return [__sound, __soundGroup[__index * 2 + 1]];
		}
		
		//------------------------------------------------------------------------------------------
		public function setSoundPlaying (__flag:Bool):Void {
			if (__flag) {
				m_soundPlayingCount++;
			}
			else
			{
				if (m_soundPlayingCount > 0) {
					m_soundPlayingCount--;
				}
			}
		}
		
		//------------------------------------------------------------------------------------------
		public function isSoundPlaying ():Bool {
			return m_soundPlayingCount != 0;
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_Start ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.LetsFocusAndPlan (), "Let's Focus and Plan!"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_StartNext ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.HelpMeGetTheKeyAndOpenTheDoor (), "Help me get the key and open the door!"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_WhatDoIDoFirst ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.ChooseTheFirstStep (), "Choose the first step",
				XAssets.WhatDoIDoFirst (), "What do I do first?"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_BetweenLevels ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.WhatDoIDoNext (), "",
				XAssets.WhatHappensNext (), "",
				XAssets.WhatIsTheNEXTStepToHelpMeGetToTheDoor (), "",
				XAssets.WhatIsTheNextStepToGetToTheDoor (), "",
				XAssets.WhatIsTheNextStepToGetTheKeyAndOpenTheDoor (), "",
				XAssets.LetsFocusAndPlan (), ""
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_1Error ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.ICantDoThatYet (), "I can't do that yet.",
				XAssets.WhatDoIDoBeforeThis (), "What do I do before this?"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_3Errors ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.DoThisNext (), "Do this next.",
				XAssets.INeedToDoThisNext (), "I need to do this next.",
				XAssets.TryThisNext (), "Try this next."
				//				XAssets.AddThisStepToThePlan, ""
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_StillWrong ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.IReallyNeedToDoThisNext (), "I really need to do this next.",
				XAssets.IReallyNeedToDoThisNext (), "I really need to do this next."
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_GoodJob ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.YouGotItRight (), "You got it right!",
				XAssets.GoodJob (), "Good job!",
				XAssets.WayToGo (), "Way to go!"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_WhatsNext ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.ShowMeTheNextStep (), "Show me the next step.",
				XAssets.WhatIsTheNextStep (), "What is the next step."
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Plan_SFX_PickedRightStep ():Array<Dynamic> /* <Dynamic> */ {
			return [
				null, null,
				XAssets.GetTheKeyOpenTheDoor (), "Open the door.",
				XAssets.GetTheKey (), "Get the key.",
				XAssets.ClimbTheLadder (), "Climb the ladder.",
				XAssets.JumpOverThePit (), "Jump over the pit.",
				//				XAssets.SquishTheMonster (), "Squish the monster."	
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Act_SFX_Start ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.LetsFollowThePlan (), "Let's follow the plan!",
				XAssets.TimeForAction (), "Time for action!"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Act_SFX_StartNext ():Array<Dynamic> /* <Dynamic> */ {
			return [
				//				XAssets.WhatIsTheFirstStep (), "What is the first step?",
				XAssets.WhatDoIDoFirst (), "What do I do first?"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Act_SFX_BetweenSteps ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.WhatHappensNext (), "What happens next?",
				XAssets.WhatDoIDoNext (), "What do I do next?",
				XAssets.WhereDoIGoNext (), "Where do i go next?",
				XAssets.WhatIsTheNEXTStepToHelpMeGetToTheDoor (), "What is the NEXT step to help me get to the door?",
				XAssets.WhatIsTheNextStepToGetToTheDoor (), "What is the next step to get to the door?"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Act_SFX_GoodJob ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.YouGotItRight (), "You got it right!",
				XAssets.GoodJob (), "Good job!",
				XAssets.WayToGo (), "Way to Go!"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Act_SFX_1Error ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.LookAtThePlan (), "Look at the plan.",
				XAssets.CheckYourPlan (), "Check your plan.",
				XAssets.WhatIsThePlan (), "What is the plan?",
				XAssets.TryAgain (), "Try again."
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Act_SFX_2Errors ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.YouArentFollowingThePlanLetsStartAgain (), "You aren't following the plan.  Let's start again.",
				XAssets.CheckYourPlanFirstAndTryAgain (), "Check your plan first and try again"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Reflect_SFX_Start ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.ReflectOnWhatWeDid (), "Reflect on what we did."
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Reflect_SFX_StartNext ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.RememberWhatOurStepsWere (), "Remember what our steps were?",
				XAssets.RememberWhatWeDid (), "Remember what we did?",
				XAssets.LetsRememberOurAdventure (), "Let's remember our adventure.",
				XAssets.RemindMeWhatWeDid (), "Remind me what we did."
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Reflect_SFX_GoodJob ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.YouGotItRight (), "You got it right!",
				XAssets.GoodJob (), "Good job!",
				XAssets.WayToGo (), "Way to go!"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function Reflect_SFX_1Error ():Array<Dynamic> /* <Dynamic> */ {
			return [
				//				XAssets.IDontRememberDoingThat (), "I don't remember doing that.",
				XAssets.WhatWasOurNextStep (), "What was our next step?"
			];
		}
		
		//------------------------------------------------------------------------------------------
		public function SFX_YouWonTheGame ():Array<Dynamic> /* <Dynamic> */ {
			return [
				XAssets.YouAreAWinner (), "You are a Winner!",
				XAssets.YouWonFarOut (), "You Won!  Far Out!",
				XAssets.GoodJobYouAreFarSmart (), "Good Job!  And you are F-A-R Smart!",
			];
		}
		
		//------------------------------------------------------------------------------------------
	}
	
	//------------------------------------------------------------------------------------------
// }
