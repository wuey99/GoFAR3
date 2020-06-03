//------------------------------------------------------------------------------------------
package objects.splash;
	
	import assets.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import xlogicobject.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class SplashTextX extends XLogicObjectCX2 {
		public var m_splashText:String;
		public var x_sprite:XDepthSprite;
		public var m_text:XTextSprite;

//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

			m_splashText = getArg (args, 0);
			
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
			m_text = new XTextSprite ();
			m_text.getTextField ().text = m_splashText;
			m_text.getTextField ().selectable = false;
			m_text.getTextField ().multiline = true;
			m_text.getTextField ().wordWrap = true;
			m_text.getTextField ().embedFonts = true;
			
			var __font:Font = XAssets.SoopafreshFontClass ();
			
            var __format:TextFormat = new TextFormat();
			__format.font = __font.fontName;
  			          
            __format.color = 0x00004891;
            __format.size = 40;
            __format.letterSpacing = 2.0;
            __format.align = TextFormatAlign.LEFT;
            
            m_text.getTextField ().setTextFormat (__format);
            
            m_text.getTextField ().width = 900;
			m_text.getTextField ().height = 300;
			
			x_sprite = addSpriteAt (m_text, 0, 0);
			
			show ();
		}

//------------------------------------------------------------------------------------------
		public function getTextWidth ():Float {
			return m_text.getTextField ().textWidth;
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
