//------------------------------------------------------------------------------------------
package assets;
	
	import kx.*;
	import kx.resource.manager.*;
	import kx.xml.*;
	
	import gx.*;
	
	import openfl.display.*;
	import openfl.media.*;
	import openfl.text.*;
	
	import openfl.Assets;
	
//------------------------------------------------------------------------------------------	
	class XAssets extends gx.assets.XAssets {
		
		//------------------------------------------------------------------------------------------
		public function new (__XApp:XApp, __parent:Sprite) {
			super (__XApp, __parent);
			
			m_XApp = __XApp;
			
			var __projectManager:XProjectManager = new XProjectManager (m_XApp);
			
			__projectManager.setupFromXML (
				__parent,
				"Assets\\Cows\\Project",
				getProjectXML (),
				null,
				null
			);
			
			m_XApp.setProjectManager (__projectManager);
			
			addEmbeddedAssets ();
		}
		
		//------------------------------------------------------------------------------------------
		public function addEmbeddedAssets ():Void {
			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\Assets.swf" , CircleClass
			);
		
			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\Assets.swf" , Level001_AClass
			);
		
			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\character_standing.swf" , Standing
			);
		
			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\character_walking_ready.swf" , Walking
			);
		
			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\Bee.swf" , BeeClassX
			);
		
			var __xml:XSimpleXMLNode = getProjectXML ();
			
			var __folderXML:Array<XSimpleXMLNode> = __xml.child ("manifest")[0].child ("manifest")[0].child ("folder");
			
			for (__resourcesXML in __folderXML) {
				for (__resourceXML in __resourcesXML.child ("resource")) {
					for (__classXML in __resourceXML.child ("*")) {
						trace (": xml: ", __classXML.attribute ("name"));
						
						m_XApp.getProjectManager ().addEmbeddedResource (
							__classXML.attribute ("name"), __classXML.attribute ("name")
						);
					}
				}
			}
		}
		
		//------------------------------------------------------------------------------------------
		public static inline var m_projectXML:String = "" +
		"<project>" +
		"<manifest name=\"manifest.xml\">" +
		"<manifest>" +
		
		"<folder name=\"root\">" +
		
		"<resource name=\"Assets\" type=\".fla=\" path=\"$FAR\\Embedded\" src=\"Assets.fla\" dst=\"Assets.swf\">" +
		"<classX name=\"BeeClass\"/>" +
		"<classX name=\"CircleClass\"/>" +																																																																																																																			
		"<classX name=\"Level001_AClass\"/>" +		
		"<classX name=\"Level002_AClass\"/>" +
		"<classX name=\"Level003_AClass\"/>" +
		"<classX name=\"Level004_AClass\"/>" +
		"<classX name=\"Level005_AClass\"/>" +
		"<classX name=\"Level006_AClass\"/>" +		
		"<classX name=\"Level007_AClass\"/>" +
		"<classX name=\"Level008_AClass\"/>" +
		"<classX name=\"Level009_AClass\"/>" +
		"<classX name=\"Level010_AClass\"/>" +
		"<classX name=\"Level011_AClass\"/>" +
		"<classX name=\"Level012_AClass\"/>" +
		"<classX name=\"Level013_AClass\"/>" +
		"<classX name=\"Level001_BClass\"/>" +		
		"<classX name=\"Level002_BClass\"/>" +
		"<classX name=\"Level003_BClass\"/>" +
		"<classX name=\"Level004_BClass\"/>" +
		"<classX name=\"Level005_BClass\"/>" +
		"<classX name=\"Level006_BClass\"/>" +		
		"<classX name=\"Level007_BClass\"/>" +
		"<classX name=\"Level008_BClass\"/>" +
		"<classX name=\"Level009_BClass\"/>" +
		"<classX name=\"Level010_BClass\"/>" +
		"<classX name=\"Level011_BClass\"/>" +
		"<classX name=\"Level012_BClass\"/>" +
		"<classX name=\"Level013_BClass\"/>" +
		"<classX name=\"Level001_CClass\"/>" +		
		"<classX name=\"Level002_CClass\"/>" +
		"<classX name=\"Level003_CClass\"/>" +
		"<classX name=\"Level004_CClass\"/>" +
		"<classX name=\"Level005_CClass\"/>" +
		"<classX name=\"Level006_CClass\"/>" +		
		"<classX name=\"Level007_CClass\"/>" +
		"<classX name=\"Level008_CClass\"/>" +
		"<classX name=\"Level009_CClass\"/>" +
		"<classX name=\"Level010_CClass\"/>" +
		"<classX name=\"Level011_CClass\"/>" +
		"<classX name=\"Level012_CClass\"/>" +
		"<classX name=\"Level013_CClass\"/>" +
		"<classX name=\"CloudBGClass\"/>" +
		"<classX name=\"SpaceBGClass\"/>" +
		"<classX name=\"WaterBGClass\"/>" +
		"<classX name=\"CloudTeenyClass\"/>" +	
		"<classX name=\"CloudSmallClass\"/>" +
		"<classX name=\"CloudMediumClass\"/>" +
		"<classX name=\"CloudLargeClass\"/>" +
		"<classX name=\"Fish1Class\"/>" +
		"<classX name=\"Fish2Class\"/>" +
		"<classX name=\"Fish3Class\"/>" +
		"<classX name=\"Fish4Class\"/>" +
		"<classX name=\"Star1Class\"/>" +
		"<classX name=\"Star2Class\"/>" +
		"<classX name=\"Star3Class\"/>" +
		"<classX name=\"Star4Class\"/>" +
		"<classX name=\"KeyClass\"/>" +
		"<classX name=\"DoorClass\"/>" +					
		"<classX name=\"StarburstClass\"/>" +	
		"<classX name=\"TransitionburstClass\"/>" +	
		"<classX name=\"BlackoutClass\"/>" +	
		"<classX name=\"LadderClass\"/>" +
		"<classX name=\"Ladder002Class\"/>" +
		"<classX name=\"Ladder003Class\"/>" +						
		"<classX name=\"GoombaClass\"/>" +
		"<classX name=\"ShellClass\"/>" +
		"<classX name=\"SpaceJunkClass\"/>" +
		"<classX name=\"PlanTrayClass\"/>" +
		"<classX name=\"DialogTrayClass\"/>" +
		"<classX name=\"ProgressBarBGClass\"/>" +	
		"<classX name=\"ProgressBarMiddleClass\"/>" +	
		"<classX name=\"ProgressBarFGClass\"/>" +	
		"<classX name=\"PlanIconClimbLadderClass\"/>" +
		"<classX name=\"PlanIconGetKeyClass\"/>" +
		"<classX name=\"PlanIconJumpPitClass\"/>" +
		"<classX name=\"PlanIconKillGoombaClass\"/>" +
		"<classX name=\"PlanIconOpenDoorClass\"/>" +
		"<classX name=\"PlanAndFocusSplashClass\"/>" +
		"<classX name=\"ActSplashClass\"/>" +
		"<classX name=\"ReflectSplashClass\"/>" +
		"<classX name=\"IrisClass\"/>" +
		"<classX name=\"ProgressIconPlan\"/>" +
		"<classX name=\"ProgressIconPlay\"/>" +
		"<classX name=\"ProgressIconReflect\"/>" +
		"<classX name=\"ScoreAndOptionsClass\"/>" +
		"<classX name=\"OptionsButtonClass\"/>" +
		"<classX name=\"OptionsDialogBoxClass\"/>" +
		"<classX name=\"PracticePlanningButtonClass\"/>" +
		"<classX name=\"PracticeActionButtonClass\"/>" +
		"<classX name=\"PlayLevelButtonClass\"/>" +
		"<classX name=\"SettingButtonClass\"/>" +
		"<classX name=\"UpButtonClass\"/>" +
		"<classX name=\"DownButtonClass\"/>" +
		"<classX name=\"ExitButtonClass\"/>" +
		"<classX name=\"MainInterfaceRightClass\"/>" +
		"<classX name=\"MainInterfaceBottomClass\"/>" +
		"<classX name=\"StartButtonClass\"/>" +
		"<classX name=\"PointyArrowClass\"/>" +
		"<classX name=\"SamplePlanClass\"/>" +
		"<classX name=\"FireworksParticle_Yellow\"/>" +
		"<classX name=\"FireworksParticle_Red\"/>" +
		"<classX name=\"FireworksParticle_Green\"/>" +
		"<classX name=\"FireworksParticle_Blue\"/>" +
		"<classX name=\"DPadLeftClass\"/>" +
		"<classX name=\"DPadRightClass\"/>" +
		"<classX name=\"DPadUpClass\"/>" +
		"<classX name=\"DPadDownClass\"/>" +
		"<classX name=\"DPadJumpClass\"/>" +
		"</resource>" +
		
		"<resource name=\"CharacterStanding\" type=\".fla=\" path=\"$FAR\\Embedded\" src=\"character_standing.fla\" dst=\"character_standing.swf\">" +
		"<classX name=\"Standing\"/>" +	
		"</resource>" +
		
		"<resource name=\"CharacterWalking\" type=\".fla=\" path=\"$FAR\\Embedded\" src=\"character_walking_ready.fla\" dst=\"character_walking_ready.swf\">" +
		"<classX name=\"Walking\"/>" +	
		"</resource>" +
		
		"<resource name=\"Bee\" type=\".fla=\" path=\"$FAR\\Embedded\" src=\"Bee.fla\" dst=\"Bee.swf\">" +
		"<classX name=\"BeeClass\"/>" +
		"<classX name=\"BeeClassX\"/>" +
		"</resource>" +
		
		"</folder>" +
		
		"</manifest>" +						
		"</manifest>" +
		"</project>";
		
		//------------------------------------------------------------------------------------------
		public static function getProjectXML ():XSimpleXMLNode {
			return new XSimpleXMLNode (m_projectXML);
		}
		
		
//------------------------------------------------------------------------------------------
		
//------------------------------------------------------------------------------------------
		
		//------------------------------------------------------------------------------------------
		public static function ArialFontClass():Font {
			return Assets.getFont("fonts/Aller_Rg.ttf");
		}
		
		public static function SoopafreshFontClass():Font {
			return Assets.getFont("fonts/sopfresh.TTF");
		}
		
//------------------------------------------------------------------------------------------	
		
		public static function AddTheNextStepToThePlan():Sound {
			return Assets.getSound("sounds/AddTheNextStepToThePlan.mp3");
		}
		public static function AddThisStepToThePlan():Sound {
			return Assets.getSound("sounds/AddThisStepToThePlan.mp3");
		}
		public static function AreYouReadyToDoTheStepsInYourPlanToAct():Sound {
			return Assets.getSound("sounds/AreYouReadyToDoTheStepsInYourPlanToAct.mp3");
		}
		public static function CheckYourPlan():Sound {
			return Assets.getSound("sounds/CheckYourPlan.mp3");
		}
		public static function CheckYourPlanFirstAndTryAgain():Sound {
			return Assets.getSound("sounds/CheckYourPlanFirstAndTryAgain.mp3");
		}
		public static function ChooseTheFirstStep():Sound {
			return Assets.getSound("sounds/ChooseTheFirstStep.mp3");
		}
		public static function ClickOnTheStepsToGetTheKey():Sound {
			return Assets.getSound("sounds/ClickOnTheStepsToGetTheKey.mp3");
		}
		public static function ClickStartWhenYouAreReady():Sound {
			return Assets.getSound("sounds/ClickStartWhenYouAreReady.mp3");
		}
		public static function ClimbTheLadder():Sound {
			return Assets.getSound("sounds/ClimbTheLadder.mp3");
		}
		public static function DoThisNext():Sound {
			return Assets.getSound("sounds/DoThisNext.mp3");
		}
		public static function EachStepInThePlanHasAStar():Sound {
			return Assets.getSound("sounds/EachStepInThePlanHasAStar.mp3");
		}
		public static function FocusMeansLookingAndListeningCarefully():Sound {
			return Assets.getSound("sounds/FocusMeansLookingAndListeningCarefully.mp3");
		}
		public static function ForTheLastPartClickOnTheStepsToReflectOnWhatYouDid():Sound {
			return Assets.getSound("sounds/ForTheLastPartClickOnTheStepsToReflectOnWhatYouDid.mp3");
		}
		public static function GetTheKey():Sound {
			return Assets.getSound("sounds/GetTheKey.mp3");
		}
		public static function GetTheKeyOpenTheDoor():Sound {
			return Assets.getSound("sounds/GetTheKeyOpenTheDoor.mp3");
		}
		public static function GoodJob():Sound {
			return Assets.getSound("sounds/GoodJob.mp3");
		}
		public static function GoodJobYouAreFarSmart():Sound {
			return Assets.getSound("sounds/GoodJobYouAreFarSmart.mp3");
		}
		public static function HelpMeGetTheKeyAndOpenTheDoor():Sound {
			return Assets.getSound("sounds/HelpMeGetTheKeyAndOpenTheDoor.mp3");
		}
		public static function ICantDoThatYet():Sound {
			return Assets.getSound("sounds/ICantDoThatYet.mp3");
		}
		public static function IDontRememberDoingThat():Sound {
			return Assets.getSound("sounds/IDontRememberDoingThat.mp3");
		}
		public static function INeedToDoThisNext():Sound {
			return Assets.getSound("sounds/INeedToDoThisNext.mp3");
		}
		public static function IReallyNeedToDoThisNext():Sound {
			return Assets.getSound("sounds/IReallyNeedToDoThisNext.mp3");
		}
		public static function JumpOverThePit():Sound {
			return Assets.getSound("sounds/JumpOverThePit.mp3");
		}
		public static function LetsFocusAndPlan():Sound {
			return Assets.getSound("sounds/LetsFocusAndPlan.mp3");
		}
		public static function LetsFollowThePlan():Sound {
			return Assets.getSound("sounds/LetsFollowThePlan.mp3");
		}
		public static function LetsRememberOurAdventure():Sound {
			return Assets.getSound("sounds/LetsRememberOurAdventure.mp3");
		}
		public static function LetsStartWithTheFirstLetterInFar():Sound {
			return Assets.getSound("sounds/LetsStartWithTheFirstLetterInFar.mp3");
		}
		public static function LookAtThePlan():Sound {
			return Assets.getSound("sounds/LookAtThePlan.mp3");
		}
		public static function MoveUsingTheArrowKeys():Sound {
			return Assets.getSound("sounds/MoveUsingTheArrowKeys.mp3");
		}
		public static function NowFocusOnTheGameAndMakeAPlan():Sound {
			return Assets.getSound("sounds/NowFocusOnTheGameAndMakeAPlan.mp3");
		}
		public static function NowYouHaveMadeAPlan():Sound {
			return Assets.getSound("sounds/NowYouHaveMadeAPlan.mp3");
		}
		public static function ReflectOnWhatWeDid():Sound {
			return Assets.getSound("sounds/ReflectOnWhatWeDid.mp3");
		}
		public static function RememberWhatOurStepsWere():Sound {
			return Assets.getSound("sounds/RememberWhatOurStepsWere.mp3");
		}
		public static function RememberWhatWeDid():Sound {
			return Assets.getSound("sounds/RememberWhatWeDid.mp3");
		}
		public static function RemindMeWhatWeDid():Sound {
			return Assets.getSound("sounds/RemindMeWhatWeDid.mp3");
		}
		public static function ShowMeTheNextStep():Sound {
			return Assets.getSound("sounds/ShowMeTheNextStep.mp3");
		}
		public static function Start():Sound {
			return Assets.getSound("sounds/Start.mp3");
		}
		public static function ThereIsSomethingYouNeedToDoFirstWhatIsIt():Sound {
			return Assets.getSound("sounds/ThereIsSomethingYouNeedToDoFirstWhatIsIt.mp3");
		}
		public static function ThereWillBeASurpriseBehindTheDoor():Sound {
			return Assets.getSound("sounds/ThereWillBeASurpriseBehindTheDoor.mp3");
		}
		public static function TimeForAction():Sound {
			return Assets.getSound("sounds/TimeForAction.mp3");
		}
		public static function TryAgain():Sound {
			return Assets.getSound("sounds/TryAgain.mp3");
		}
		public static function TryThisNext():Sound {
			return Assets.getSound("sounds/TryThisNext.mp3");
		}
		public static function WayToGo():Sound {
			return Assets.getSound("sounds/WayToGo.mp3");
		}
		public static function WeCallOurGameFar():Sound {
			return Assets.getSound("sounds/WeCallOurGameFar.mp3");
		}
		public static function WhatDoIDoBeforeThis():Sound {
			return Assets.getSound("sounds/WhatDoIDoBeforeThis.mp3");
		}
		public static function WhatDoIDoFirst():Sound {
			return Assets.getSound("sounds/WhatDoIDoFirst.mp3");
		}
		public static function WhatDoIDoNext():Sound {
			return Assets.getSound("sounds/WhatDoIDoNext.mp3");
		}
		public static function WhatHappensNext():Sound {
			return Assets.getSound("sounds/WhatHappensNext.mp3");
		}
		public static function WhatIsTheNextStep():Sound {
			return Assets.getSound("sounds/WhatIsTheNextStep.mp3");
		}
		public static function WhatIsTheNextStepToGetTheKeyAndOpenTheDoor():Sound {
			return Assets.getSound("sounds/WhatIsTheNextStepToGetTheKeyAndOpenTheDoor.mp3");
		}
		public static function WhatIsTheNextStepToGetToTheDoor():Sound {
			return Assets.getSound("sounds/WhatIsTheNextStepToGetToTheDoor.mp3");
		}
		public static function WhatIsTheNEXTStepToHelpMeGetToTheDoor():Sound {
			return Assets.getSound("sounds/WhatIsTheNEXTStepToHelpMeGetToTheDoor.mp3");
		}
		public static function WhatIsThePlan():Sound {
			return Assets.getSound("sounds/WhatIsThePlan.mp3");
		}
		public static function WhatWasOurNextStep():Sound {
			return Assets.getSound("sounds/WhatWasOurNextStep.mp3");
		}
		public static function WhenYouMakeAPlanYouThinkAboutWhatYouAreGoingToDo():Sound {
			return Assets.getSound("sounds/WhenYouMakeAPlanYouThinkAboutWhatYouAreGoingToDo.mp3");
		}
		public static function WhereDoIGoNext():Sound {
			return Assets.getSound("sounds/WhereDoIGoNext.mp3");
		}
		public static function YouAreAWinner():Sound {
			return Assets.getSound("sounds/YouAreAWinner.mp3");
		}
		public static function YouArentFollowingThePlanLetsStartAgain():Sound {
			return Assets.getSound("sounds/YouArentFollowingThePlanLetsStartAgain.mp3");
		}
		public static function YouGotItRight():Sound {
			return Assets.getSound("sounds/YouGotItRight.mp3");
		}
		public static function YouWonFarOut():Sound {
			return Assets.getSound("sounds/YouWonFarOut.mp3");
		}


//------------------------------------------------------------------------------------------
		
//------------------------------------------------------------------------------------------
		public override function load ():Bool {
			return m_XApp.cacheAllClasses (getProjectXML ());
		}
		
//------------------------------------------------------------------------------------------
	}
	
//------------------------------------------------------------------------------------------
// }