//------------------------------------------------------------------------------------------
package assets {
	
	import kx.*;
	import kx.resource.manager.*;
	
	import flash.display.*;
	import flash.media.*;
	
//------------------------------------------------------------------------------------------	
	public class XAssets extends Object {

//------------------------------------------------------------------------------------------		
		[Embed(source="Assets.swf", mimeType="application/octet-stream")]
		public static const AssetsBytesClass:Class;

		[Embed(source="fireworks.swf", mimeType="application/octet-stream")]
		public static const FireworksBytesClass:Class;
		
		[Embed(source="character_standing.swf", mimeType="application/octet-stream")]
		public static const CharacterStandingBytesClass:Class;

		[Embed(source="character_walking_ready.swf", mimeType="application/octet-stream")]
		public static const CharacterWalkingBytesClass:Class;

		[Embed(source="Bee.swf", mimeType="application/octet-stream")]
		public static const BeeClass:Class;
		
		[Embed(source="Aller_Rg.ttf",
			fontName="Aller",  
			mimeType = "application/x-font", 
			fontStyle="normal", 
			unicodeRange="U+0020-U+007E", 
			embedAsCFF="false"
		)]
		public static const ArialFontClass:Class;
		
    	[Embed(source="sopfresh.TTF",
			fontName="Soopafresh",  
			mimeType="application/x-font",
			fontStyle="normal", 
			unicodeRange="U+0020-U+007E", 
			embedAsCFF="false"
		)]
		public static const SoopafreshFontClass:Class;

		[Embed(source="sounds2/AddTheNextStepToThePlan.mp3")]
		public static const AddTheNextStepToThePlan:Class;
		[Embed(source="sounds2/AddThisStepToThePlan.mp3")]
		public static const AddThisStepToThePlan:Class;
		[Embed(source="sounds2/AreYouReadyToDoTheStepsInYourPlanToAct.mp3")]
		public static const AreYouReadyToDoTheStepsInYourPlanToAct:Class;
		[Embed(source="sounds2/CheckYourPlan.mp3")]
		public static const CheckYourPlan:Class;
		[Embed(source="sounds2/CheckYourPlanFirstAndTryAgain.mp3")]
		public static const CheckYourPlanFirstAndTryAgain:Class;
		[Embed(source="sounds2/ChooseTheFirstStep.mp3")]
		public static const ChooseTheFirstStep:Class;
		[Embed(source="sounds2/ClickOnTheStepsToGetTheKey.mp3")]
		public static const ClickOnTheStepsToGetTheKey:Class;
		[Embed(source="sounds2/ClickStartWhenYouAreReady.mp3")]
		public static const ClickStartWhenYouAreReady:Class;
		[Embed(source="sounds2/ClimbTheLadder.mp3")]
		public static const ClimbTheLadder:Class;
		[Embed(source="sounds2/DoThisNext.mp3")]
		public static const DoThisNext:Class;
		[Embed(source="sounds2/EachStepInThePlanHasAStar.mp3")]
		public static const EachStepInThePlanHasAStar:Class;
		[Embed(source="sounds2/FocusMeansLookingAndListeningCarefully.mp3")]
		public static const FocusMeansLookingAndListeningCarefully:Class;
		[Embed(source="sounds2/ForTheLastPartClickOnTheStepsToReflectOnWhatYouDid.mp3")]
		public static const ForTheLastPartClickOnTheStepsToReflectOnWhatYouDid:Class;
		[Embed(source="sounds2/GetTheKey.mp3")]
		public static const GetTheKey:Class;
		[Embed(source="sounds2/GetTheKeyOpenTheDoor.mp3")]
		public static const GetTheKeyOpenTheDoor:Class;
		[Embed(source="sounds2/GoodJob.mp3")]
		public static const GoodJob:Class;
		[Embed(source="sounds2/GoodJobYouAreFarSmart.mp3")]
		public static const GoodJobYouAreFarSmart:Class;
		[Embed(source="sounds2/HelpMeGetTheKeyAndOpenTheDoor.mp3")]
		public static const HelpMeGetTheKeyAndOpenTheDoor:Class;
		[Embed(source="sounds2/ICantDoThatYet.mp3")]
		public static const ICantDoThatYet:Class;
		[Embed(source="sounds2/IDontRememberDoingThat.mp3")]
		public static const IDontRememberDoingThat:Class;
		[Embed(source="sounds2/INeedToDoThisNext.mp3")]
		public static const INeedToDoThisNext:Class;
		[Embed(source="sounds2/IReallyNeedToDoThisNext.mp3")]
		public static const IReallyNeedToDoThisNext:Class;
		[Embed(source="sounds2/JumpOverThePit.mp3")]
		public static const JumpOverThePit:Class;
		[Embed(source="sounds2/LetsFocusAndPlan.mp3")]
		public static const LetsFocusAndPlan:Class;
		[Embed(source="sounds2/LetsFollowThePlan.mp3")]
		public static const LetsFollowThePlan:Class;
		[Embed(source="sounds2/LetsRememberOurAdventure.mp3")]
		public static const LetsRememberOurAdventure:Class;
		[Embed(source="sounds2/LetsStartWithTheFirstLetterInFar.mp3")]
		public static const LetsStartWithTheFirstLetterInFar:Class;
		[Embed(source="sounds2/LookAtThePlan.mp3")]
		public static const LookAtThePlan:Class;
		[Embed(source="sounds2/MoveUsingTheArrowKeys.mp3")]
		public static const MoveUsingTheArrowKeys:Class;
		[Embed(source="sounds2/NowFocusOnTheGameAndMakeAPlan.mp3")]
		public static const NowFocusOnTheGameAndMakeAPlan:Class;
		[Embed(source="sounds2/NowYouHaveMadeAPlan.mp3")]
		public static const NowYouHaveMadeAPlan:Class;
		[Embed(source="sounds2/ReflectOnWhatWeDid.mp3")]
		public static const ReflectOnWhatWeDid:Class;
		[Embed(source="sounds2/RememberWhatOurStepsWere.mp3")]
		public static const RememberWhatOurStepsWere:Class;
		[Embed(source="sounds2/RememberWhatWeDid.mp3")]
		public static const RememberWhatWeDid:Class;
		[Embed(source="sounds2/RemindMeWhatWeDid.mp3")]
		public static const RemindMeWhatWeDid:Class;
		[Embed(source="sounds2/ShowMeTheNextStep.mp3")]
		public static const ShowMeTheNextStep:Class;
		[Embed(source="sounds2/Start.mp3")]
		public static const Start:Class;
		[Embed(source="sounds2/ThereIsSomethingYouNeedToDoFirstWhatIsIt.mp3")]
		public static const ThereIsSomethingYouNeedToDoFirstWhatIsIt:Class;
		[Embed(source="sounds2/ThereWillBeASurpriseBehindTheDoor.mp3")]
		public static const ThereWillBeASurpriseBehindTheDoor:Class;
		[Embed(source="sounds2/TimeForAction.mp3")]
		public static const TimeForAction:Class;
		[Embed(source="sounds2/TryAgain.mp3")]
		public static const TryAgain:Class;
		[Embed(source="sounds2/TryThisNext.mp3")]
		public static const TryThisNext:Class;
		[Embed(source="sounds2/WayToGo.mp3")]
		public static const WayToGo:Class;
		[Embed(source="sounds2/WeCallOurGameFar.mp3")]
		public static const WeCallOurGameFar:Class;
		[Embed(source="sounds2/WhatDoIDoBeforeThis.mp3")]
		public static const WhatDoIDoBeforeThis:Class;
		[Embed(source="sounds2/WhatDoIDoFirst.mp3")]
		public static const WhatDoIDoFirst:Class;
		[Embed(source="sounds2/WhatDoIDoNext.mp3")]
		public static const WhatDoIDoNext:Class;
		[Embed(source="sounds2/WhatHappensNext.mp3")]
		public static const WhatHappensNext:Class;
		[Embed(source="sounds2/WhatIsTheNextStep.mp3")]
		public static const WhatIsTheNextStep:Class;
		[Embed(source="sounds2/WhatIsTheNextStepToGetTheKeyAndOpenTheDoor.mp3")]
		public static const WhatIsTheNextStepToGetTheKeyAndOpenTheDoor:Class;
		[Embed(source="sounds2/WhatIsTheNextStepToGetToTheDoor.mp3")]
		public static const WhatIsTheNextStepToGetToTheDoor:Class;
		[Embed(source="sounds2/WhatIsTheNEXTStepToHelpMeGetToTheDoor.mp3")]
		public static const WhatIsTheNEXTStepToHelpMeGetToTheDoor:Class;
		[Embed(source="sounds2/WhatIsThePlan.mp3")]
		public static const WhatIsThePlan:Class;
		[Embed(source="sounds2/WhatWasOurNextStep.mp3")]
		public static const WhatWasOurNextStep:Class;
		[Embed(source="sounds2/WhenYouMakeAPlanYouThinkAboutWhatYouAreGoingToDo.mp3")]
		public static const WhenYouMakeAPlanYouThinkAboutWhatYouAreGoingToDo:Class;
		[Embed(source="sounds2/WhereDoIGoNext.mp3")]
		public static const WhereDoIGoNext:Class;
		[Embed(source="sounds2/YouAreAWinner.mp3")]
		public static const YouAreAWinner:Class;
		[Embed(source="sounds2/YouArentFollowingThePlanLetsStartAgain.mp3")]
		public static const YouArentFollowingThePlanLetsStartAgain:Class;
		[Embed(source="sounds2/YouGotItRight.mp3")]
		public static const YouGotItRight:Class;
		[Embed(source="sounds2/YouWonFarOut.mp3")]
		public static const YouWonFarOut:Class;

//------------------------------------------------------------------------------------------
		private var m_projectXML:XML =
				<project>
					<manifest name="manifest.xml">
						<manifest>
						
							<folder name="root">
							
								<resource name="Assets" type=".fla" path="$FAR\\Embedded" src="Assets.fla" dst="Assets.swf">
									<classX name="BeeClass"/>	
									<classX name="CircleClass"/>																																																																																																																			
									<classX name="Level001_AClass"/>		
									<classX name="Level002_AClass"/>
									<classX name="Level003_AClass"/>
									<classX name="Level004_AClass"/>
									<classX name="Level005_AClass"/>
									<classX name="Level006_AClass"/>		
									<classX name="Level007_AClass"/>
									<classX name="Level008_AClass"/>
									<classX name="Level009_AClass"/>
									<classX name="Level010_AClass"/>
									<classX name="Level011_AClass"/>
									<classX name="Level012_AClass"/>
									<classX name="Level013_AClass"/>
									<classX name="Level001_BClass"/>		
									<classX name="Level002_BClass"/>
									<classX name="Level003_BClass"/>
									<classX name="Level004_BClass"/>
									<classX name="Level005_BClass"/>
									<classX name="Level006_BClass"/>		
									<classX name="Level007_BClass"/>
									<classX name="Level008_BClass"/>
									<classX name="Level009_BClass"/>
									<classX name="Level010_BClass"/>
									<classX name="Level011_BClass"/>
									<classX name="Level012_BClass"/>
									<classX name="Level013_BClass"/>
									<classX name="Level001_CClass"/>		
									<classX name="Level002_CClass"/>
									<classX name="Level003_CClass"/>
									<classX name="Level004_CClass"/>
									<classX name="Level005_CClass"/>
									<classX name="Level006_CClass"/>		
									<classX name="Level007_CClass"/>
									<classX name="Level008_CClass"/>
									<classX name="Level009_CClass"/>
									<classX name="Level010_CClass"/>
									<classX name="Level011_CClass"/>
									<classX name="Level012_CClass"/>
									<classX name="Level013_CClass"/>
									<classX name="CloudBGClass"/>
									<classX name="SpaceBGClass"/>
									<classX name="WaterBGClass"/>
									<classX name="CloudTeenyClass"/>	
									<classX name="CloudSmallClass"/>
									<classX name="CloudMediumClass"/>
									<classX name="CloudLargeClass"/>
									<classX name="Fish1Class"/>
									<classX name="Fish2Class"/>
									<classX name="Fish3Class"/>
									<classX name="Fish4Class"/>
									<classX name="Star1Class"/>
									<classX name="Star2Class"/>
									<classX name="Star3Class"/>
									<classX name="Star4Class"/>
									<classX name="KeyClass"/>
									<classX name="DoorClass"/>					
									<classX name="StarburstClass"/>	
									<classX name="TransitionburstClass"/>	
									<classX name="BlackoutClass"/>	
									<classX name="LadderClass"/>
									<classX name="Ladder002Class"/>
									<classX name="Ladder003Class"/>						
									<classX name="GoombaClass"/>
									<classX name="ShellClass"/>
									<classX name="SpaceJunkClass"/>
									<classX name="PlanTrayClass"/>
									<classX name="DialogTrayClass"/>
									<classX name="ProgressBarBGClass"/>	
									<classX name="ProgressBarMiddleClass"/>	
									<classX name="ProgressBarFGClass"/>	
									<classX name="PlanIconClimbLadderClass"/>
									<classX name="PlanIconGetKeyClass"/>
									<classX name="PlanIconJumpPitClass"/>
									<classX name="PlanIconKillGoombaClass"/>
									<classX name="PlanIconOpenDoorClass"/>
									<classX name="PlanAndFocusSplashClass"/>
									<classX name="ActSplashClass"/>
									<classX name="ReflectSplashClass"/>
									<classX name="IrisClass"/>
									<classX name="ProgressIconPlan"/>
									<classX name="ProgressIconPlay"/>
									<classX name="ProgressIconReflect"/>
									<classX name="ScoreAndOptionsClass"/>
									<classX name="OptionsButtonClass"/>
									<classX name="OptionsDialogBoxClass"/>
									<classX name="PracticePlanningButtonClass"/>
									<classX name="PracticeActionButtonClass"/>
									<classX name="PlayLevelButtonClass"/>
									<classX name="SettingButtonClass"/>
									<classX name="UpButtonClass"/>
									<classX name="DownButtonClass"/>
									<classX name="ExitButtonClass"/>
									<classX name="MainInterfaceRightClass"/>
									<classX name="MainInterfaceBottomClass"/>
									<classX name="StartButtonClass"/>
									<classX name="PointyArrowClass"/>
									<classX name="SamplePlanClass"/>
								</resource>

								<resource name="CharacterStanding" type=".fla" path="$FAR\\Embedded" src="character_standing.fla" dst="character_standing.swf">
									<classX name="Standing"/>	
								</resource>

								<resource name="CharacterWalking" type=".fla" path="$FAR\\Embedded" src="character_walking_ready.fla" dst="character_walking_ready.swf">
									<classX name="Walking"/>	
								</resource>

								<resource name="Bee" type=".fla" path="$FAR\\Embedded" src="Bee.fla" dst="Bee.swf">
									<classX name="BeeClass"/>
									<classX name="BeeClassX"/>
								</resource>

								<resource name="fireworks" type=".fla" path="$FAR\\Embedded" src="fireworks.fla" dst="fireworks.swf">
									<classX name="complete"/>
								</resource>
																																
							</folder>
							
						</manifest>						
					</manifest>
				</project>;

//------------------------------------------------------------------------------------------
		private var m_XApp:XApp;
		
//------------------------------------------------------------------------------------------
		public function XAssets (__XApp:XApp, __parent:Sprite) {
			m_XApp = __XApp;
			
			var __projectManager:XProjectManager = new XProjectManager (m_XApp);
			
			__projectManager.setupFromXML (
				__parent,
				"",
				m_projectXML,
				null,
				null
				);
			
			m_XApp.setProjectManager (__projectManager);
						
			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\Assets.swf", XAssets.AssetsBytesClass
			);
			
			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\character_standing.swf", XAssets.CharacterStandingBytesClass
			);

			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\character_walking_ready.swf", XAssets.CharacterWalkingBytesClass
			);
			
			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\Bee.swf", XAssets.BeeClass
			);

			m_XApp.getProjectManager ().addEmbeddedResource (
				"$FAR\\Embedded\\fireworks.swf", XAssets.FireworksBytesClass
			);
		}
		
//------------------------------------------------------------------------------------------
		public function load ():Boolean {			
			var __classXMLList:XMLList = m_projectXML.manifest.manifest.folder.resource.child ("*");
			
			var i:int;
			var ready:Boolean = true;

//			if (!m_XApp.getProjectManager ().cacheClassNames ()) {
//				return false;
//			}
			
			__classXMLList =  m_projectXML.manifest.manifest.folder.resource[0].child ("*");
			
			for (i=0; i<__classXMLList.length (); i++) {
				if (m_XApp.getClass ("Assets:" + __classXMLList[i].@name) == null) {
					ready = false;
				}
			}

			__classXMLList =  m_projectXML.manifest.manifest.folder.resource[1].child ("*");
			
			for (i=0; i<__classXMLList.length (); i++) {
				if (m_XApp.getClass ("CharacterStanding:" + __classXMLList[i].@name) == null) {
					ready = false;
				}
			}

			__classXMLList =  m_projectXML.manifest.manifest.folder.resource[2].child ("*");
			
			for (i=0; i<__classXMLList.length (); i++) {
				if (m_XApp.getClass ("CharacterWalking:" + __classXMLList[i].@name) == null) {
					ready = false;
				}
			}

			__classXMLList =  m_projectXML.manifest.manifest.folder.resource[3].child ("*");
			
			for (i=0; i<__classXMLList.length (); i++) {
				if (m_XApp.getClass ("Bee:" + __classXMLList[i].@name) == null) {
					ready = false;
				}
			}

			__classXMLList =  m_projectXML.manifest.manifest.folder.resource[4].child ("*");
			
			for (i=0; i<__classXMLList.length (); i++) {
				if (m_XApp.getClass ("fireworks:" + __classXMLList[i].@name) == null) {
					ready = false;
				}
			}
											
			return (ready);
		}
		
//------------------------------------------------------------------------------------------
	}
	
//------------------------------------------------------------------------------------------
}