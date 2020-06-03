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
	class ScoreAndOptionsX extends XLogicObject {
		public var x_sprite:XDepthSprite;
		public var m_currentY:Float;
		public var m_sprite:Sprite;
		public var m_text:XTextSprite;
		public var x_text:XDepthSprite;
		public var m_optionsButton:__XButton;
		public var m_score:Int;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

			createSprites ();
			
			m_currentY = 16;
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

			sprite = createXMovieClip("Assets:ScoreAndOptionsClass");
			x_sprite = addSpriteAt (sprite, 0, 0);
			
			m_text = new XTextSprite ();            			
			x_text = addSpriteAt (m_text, 0, -65);
			x_text.setDepth (getDepth () + 5);
			
			setScore (0);
			
			m_optionsButton = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new OptionsButtonX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 5,
				// x, y, z
					6, 4, 0,
				// scale, rotation
					1.0, 0,
					[
						"Assets:OptionsButtonClass"
					]
				) /* as __XButton */;
				
			addXLogicObject (m_optionsButton);
			
			show ();
		}

//------------------------------------------------------------------------------------------
		public function getOptionsButton ():__XButton {
			return m_optionsButton;
		}
		
//------------------------------------------------------------------------------------------
		public function setScore (__points:Int):Void {
			m_score = __points;
			
			setText (m_score);
		}

//------------------------------------------------------------------------------------------
		public function getScore ():Int {
			return m_score;
		}
		
//------------------------------------------------------------------------------------------
		public function addToScore (__points:Int):Void {
			m_score += __points;
			
			setText (m_score);
		}
		
//------------------------------------------------------------------------------------------
		public function setText (__score:Float):Void {
			m_text.getTextField ().htmlText = "" + __score;
			m_text.getTextField ().selectable = false;
			m_text.getTextField ().multiline = true;
			m_text.getTextField ().wordWrap = true;
			m_text.getTextField ().embedFonts = true;
			
			var __font:Font = XAssets.ArialFontClass ();
			
            var __format:TextFormat = new TextFormat();
			__format.font = __font.fontName;
  			          
            __format.color = 0xf0f0f0;
            __format.size = 16;
            __format.letterSpacing = 2.0;
            __format.align = TextFormatAlign.CENTER;
            
            m_text.getTextField ().setTextFormat (__format);
            
            m_text.getTextField ().width = 96;
            m_text.getTextField ().height = 32;
  		}
  		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
