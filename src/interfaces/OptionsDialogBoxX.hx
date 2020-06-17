//------------------------------------------------------------------------------------------
package interfaces;
	
	import assets.*;
	
	import ui.XTextButton;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	import kx.world.ui.XButton;
	
	import xlogicobject.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class OptionsDialogBoxX extends XLogicObject {
		public var x_sprite:XDepthSprite;
		public var m_text:XTextSprite;
		public var m_exitButton:__XButton;
		public var m_practicePlanningButton:__XButton;
		public var m_practicePlanningSpinner:SelectionSpinnerX;
		public var m_practiceActionButton:__XButton;
		public var m_practiceActionSpinner:SelectionSpinnerX;
		public var m_settingButton:__XButton;
		public var m_settingSpinner:SelectionSpinnerX;
		public var m_playLevelButton:__XButton;
		public var m_playLevelSpinner:SelectionSpinnerX;

		public static var isRunning:Bool = false;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

			createSprites ();
			
			G.app.blockGameMouseEvents ();
			
			isRunning = true;
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;
			var x:Float;
			var y:Float;
			
			sprite = createXMovieClip("Assets:OptionsDialogBoxClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
			
			m_exitButton = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new __XButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					520, 16, 0,
				// scale, rotation
					1.0, 0,
					[
						"Assets:ExitButtonClass"
					]
				) /* as __XButton */;
				
			addXLogicObject (m_exitButton);
			
			x = 96;
			y = 64;
			
			m_practicePlanningButton = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new __XButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					x - 64, y, 0,
				// scale, rotation
					2.0, 0,
					[
						"Assets:PracticePlanningButtonClass"
					]
				) /* as __XButton */;
				
			addXLogicObject (m_practicePlanningButton);
			
			y = y+80;
			
			m_practiceActionButton = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new __XButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					x - 64, y, 0,
				// scale, rotation
					2.0, 0,
					[
						"Assets:PracticeActionButtonClass"
					]
				) /* as __XButton */;
				
			addXLogicObject (m_practiceActionButton);

			y = y+80;
			
			m_playLevelButton = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new __XButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					x - 64, y, 0,
				// scale, rotation
					2.0, 0,
					[
						"Assets:PlayLevelButtonClass"
					]
				) /* as __XButton */;
				
			addXLogicObject (m_playLevelButton);

			m_playLevelSpinner = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new SelectionSpinnerX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					x+128+64, y + 16, 0,
				// scale, rotation
					1.0, 0,
					[
						["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen"],				
						G.app.getCurrLevel (),
						G.app.setCurrLevel
					]
				) /* as SelectionSpinnerX */;
				
			addXLogicObject (m_playLevelSpinner);

			m_settingSpinner = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new SelectionSpinnerX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					x+256+64, y + 16, 0,
				// scale, rotation
					1.0, 0,
					[
						["clouds", "underwater", "space"],
						G.app.getCurrSetting (),
						G.app.setCurrSetting
					]
				) /* as SelectionSpinnerX */;
				
			addXLogicObject (m_settingSpinner);
				
//------------------------------------------------------------------------------------------	
			m_practicePlanningButton.addMouseUpListener (
				function ():Void {
					G.app.endLevel ();
					
					G.app.practicePlanning ();
							
					G.app.allowGameMouseEvents ();
					
					killLater ();
					
					isRunning = false;
				}
			);

//------------------------------------------------------------------------------------------	
			m_practiceActionButton.addMouseUpListener (
				function ():Void {
					G.app.endLevel ();
			
					G.app.practicePlaying ();
					
					G.app.allowGameMouseEvents ();
					
					killLater ();
					
					isRunning = false;
				}
			);
						
//------------------------------------------------------------------------------------------
			m_playLevelButton.addMouseUpListener (
				function ():Void {
					G.app.endLevel ();
					
					G.app.loadLevel ();
					
					G.app.allowGameMouseEvents ();
					
					killLater ();
					
					isRunning = false;
				}
			);

//------------------------------------------------------------------------------------------										
			m_exitButton.addMouseUpListener (
				function ():Void {
					G.app.allowGameMouseEvents ();
					
					killLater ();
					
					isRunning = false;
				}
			);
			
			show ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public function createSpritesX ():Void {
			var sprite:XMovieClip;

			sprite = createXMovieClip("Assets:OptionsDialogBoxClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
				
			var movieClip:MovieClip;
			
			// TODO FAR
			// trace (": movieClip: ", findClassByName (sprite, "LevelComboBox"));
			// trace (": movieClip: ", findClassByName (sprite, "SettingComboBox"));
			
			
			m_exitButton = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new __XButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					500, 300, 0,
				// scale, rotation
					1.0, 0,
					[
						"Assets:ExitButtonClass"
					]
				) /* as __XButton */;
				
			addXLogicObject (m_exitButton);
			
			m_exitButton.addMouseUpListener (
				function ():Void {
					killLater ();
					
					isRunning = false;
				}
			);
			
			show ();
		}
  
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
