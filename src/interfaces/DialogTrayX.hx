//------------------------------------------------------------------------------------------
package interfaces;
	
	import assets.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class DialogTrayX extends XLogicObject {
		public var x_sprite:XDepthSprite;
		public var m_text:XTextSprite;
		public var x_textSprite:XDepthSprite;

//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);

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
			var sprite:XMovieClip;

			sprite = createXMovieClip ("Assets:DialogTrayClass");
			x_sprite = addSpriteAt (sprite, 0, 0);

			m_text = new XTextSprite ();            			
			x_sprite = addSpriteAt (m_text, -20, -36);
			x_sprite.setDepth (getDepth () + 5);
										
			setMessage ("");
				
			show ();
		}
		
//------------------------------------------------------------------------------------------
		public function setMessage (__message:String):Void {
			m_text.getTextField ().text = __message;
			m_text.getTextField ().selectable = false;
			m_text.getTextField ().multiline = true;
			m_text.getTextField ().wordWrap = true;
			m_text.getTextField ().embedFonts = true;
			
			var __font:Font = XAssets.ArialFontClass ();
			
            var __format:TextFormat = new TextFormat();
			__format.font = __font.fontName;
  			          
            __format.color = 0xe0e0e0;
            __format.size = 24;
            __format.letterSpacing = 2.0;
            __format.align = TextFormatAlign.CENTER;
            
            m_text.getTextField ().setTextFormat (__format);
            
            m_text.getTextField ().width = 350;
            m_text.getTextField ().height = 120;
            
			if (m_text.getTextField ().textHeight > 30) {
				x_sprite.setRegistration (-20, -28);
			}
			else
			{
				x_sprite.setRegistration (-20, -40);
			}
  		}
  
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
