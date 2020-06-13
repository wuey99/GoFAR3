//------------------------------------------------------------------------------------------
package interfaces;
	
	import assets.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	import kx.world.ui.*;
	
	import xlogicobject.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class SelectionSpinnerX extends XLogicObject {
		public var m_upArrowButton:__XButton;
		public var m_downArrowButton:__XButton;
		public var m_selectionIndex:Int;
		public var m_selectionSetFunction:Dynamic /* Function */;
		public var m_selectionArray:Array<String>; // <String>
		public var m_selectionText:XTextSprite;
		public var x_selectionText:XDepthSprite;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

			m_selectionArray = args[0];
			m_selectionIndex = args[1];
			m_selectionSetFunction = args[2];
						
			createSprites ();
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
		}

//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {

			m_selectionText = new XTextSprite ();
			x_selectionText = addSpriteAt (m_selectionText, 0, 0);
			x_selectionText.setDepth (getDepth () + 5);
			
			setText (m_selectionArray[m_selectionIndex]);
			
			m_upArrowButton = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new __XButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					36, -24, 0,
				// scale, rotation
					1.0, 0,
					[
						"Assets:UpButtonClass"
					]
				) /* as __XButton */;
				
			addXLogicObject (m_upArrowButton);

			m_downArrowButton = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new __XButton () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					36, 32, 0,
				// scale, rotation
					1.0, 0,
					[
						"Assets:DownButtonClass"
					]
				) /* as __XButton */;
				
			addXLogicObject (m_downArrowButton);
					
			show ();
			
			function __up ():Void {
				if (m_selectionIndex > 0) {
					m_selectionIndex--;
					m_selectionSetFunction (m_selectionIndex);
				}
				
				setText (m_selectionArray[m_selectionIndex]);
			}
			
			function __down ():Void {
				if (m_selectionIndex != m_selectionArray.length-1) {
					m_selectionIndex++;
					m_selectionSetFunction (m_selectionIndex);
				}
				
				setText (m_selectionArray[m_selectionIndex]);
			}
			
			m_upArrowButton.addMouseUpListener (__down);
			m_downArrowButton.addMouseUpListener (__up);
		}
  		
 //------------------------------------------------------------------------------------------
		public function setText (__string:String):Void {
			m_selectionText.getTextField ().htmlText = __string;
			m_selectionText.getTextField ().selectable = false;
			m_selectionText.getTextField ().multiline = true;
			m_selectionText.getTextField ().wordWrap = true;
			m_selectionText.getTextField ().embedFonts = true;
			
			var __font:Font = XAssets.ArialFontClass ();
			
            var __format:TextFormat = new TextFormat();
			__format.font = __font.fontName;
  			          
            __format.color = 0xf0f0f0;
            __format.size = 16;
            __format.letterSpacing = 2.0;
            __format.align = TextFormatAlign.CENTER;
            
            m_selectionText.getTextField ().setTextFormat (__format);
            
            m_selectionText.getTextField ().width = 128;
            m_selectionText.getTextField ().height = 32;
  		}
  		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
