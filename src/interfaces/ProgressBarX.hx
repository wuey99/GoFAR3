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
	class ProgressBarX extends XLogicObject {
		public var x_sprite:XDepthSprite;
		public var m_sprite:Sprite;
		public var m_progressBarMiddleObject:ProgressBarMiddleX;
		public var m_progressF:ProgressLetterX;
		public var m_progressA:ProgressLetterX;
		public var m_progressR:ProgressLetterX;
		
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

			sprite = createXMovieClip("Assets:ProgressBarBGClass");
			x_sprite = addSpriteAt (sprite, -12, 0);

//			m_sprite = new Sprite ();
//			(addSpriteAt (m_sprite, 0, 0)).setDepth (5000);						
//			m_sprite.graphics.clear ();

			m_progressBarMiddleObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new ProgressBarMiddleX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 1000,
				// x, y, z
					12, 384, 0,
				// scale, rotation
					1.0, 0
				) /* as ProgressBarMiddleX */;
				
			addXLogicObject (m_progressBarMiddleObject);
			
			setProgress (0.0);
			
			m_progressF = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new ProgressLetterX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 9999,
				// x, y, z
					48, 325, 0,
				// scale, rotation
					1.0, 0,
					[
						"F"
					]
				) /* as ProgressLetterX */;
				
			addXLogicObject (m_progressF);
			
			m_progressA = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new ProgressLetterX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 9999,
				// x, y, z
					48, 200, 0,
				// scale, rotation
					1.0, 0,
					[
						"A"
					]
				) /* as ProgressLetterX */;
				
			addXLogicObject (m_progressA);
			
			m_progressR = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					this,
				// logicObject
					new ProgressLetterX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, getDepth () + 9999,
				// x, y, z
					48, 75, 0,
				// scale, rotation
					1.0, 0,
					[
						"R"
					]
				) /* as ProgressLetterX */;
				
			addXLogicObject (m_progressR);
			
			show ();
		}

//------------------------------------------------------------------------------------------
		public function setProgress (__percentage:Float):Void {
			var __height:Float = 384*__percentage;
			
			m_progressBarMiddleObject.oY = 384-__height;

//			m_sprite.graphics.clear ();
//			m_sprite.graphics.beginFill (0x303030);
//			m_sprite.graphics.drawRect (0, 384-__height, 96, __height)
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
