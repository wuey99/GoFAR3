//------------------------------------------------------------------------------------------
package xlogicobject;

	import kx.*;
	import kx.task.*;
	import kx.type.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.events.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class XLogicObjectCX2 extends XLogicObjectCX0 {
		public static var LADDER_TOP_BEG:Float = 2;
		public static var LADDER_TOP_END:Float = 4;

		public static var LADDER_BOT_BEG:Float = 5;
		public static var LADDER_BOT_END:Float = 7;
		
		private var m_ladderTargetX:Float;
		
//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
		}

//------------------------------------------------------------------------------------------
		public function Ck_Ladder_Bottom ():Bool {
			var i:Int;
			var x:Float;
			
			i = GetLadderBottomCell ();
			
			if (i != 0) {
				x = (Std.int (oX) & (XLogicObjectCX0.CELLSIZE - 1)) + ((i - LADDER_BOT_BEG) * XLogicObjectCX0.CELLSIZE);
				
				m_ladderTargetX = oX + 24 - x;
				
				return true;
			}
				
			return false;
		}
		
//------------------------------------------------------------------------------------------
		public function GetLadderBottomCell ():Int {
			var i:Int, x:Float, y:Float;
			var x1:Float, x2:Float, y1:Float, y2:Float;
		
			x1 = Math.floor (oX);
			y2 = Math.floor (oY) + m_cx.bottom;
		
			x1 = Std.int (x1) & XLogicObjectCX0.CELLMASK;
			y2 = Std.int (y2) & XLogicObjectCX0.CELLMASK;
		
			i = Std.int (((y2/XLogicObjectCX0.CELLSIZE) * XLogicObjectCX0.CELLSWIDE) + x1/XLogicObjectCX0.CELLSIZE);
		
			i = m_cmap[i];
		
			if (i >= LADDER_BOT_BEG && i <= LADDER_BOT_END) {
				return (i);
			}
		
			return (0);
		}

//------------------------------------------------------------------------------------------
// the function updates all the children that live inside the XLogicObject container
//
// children in the XLogicObject sense aren't DisplayObject children.  This is done
// so that the depth sorting on each child can be controlled explicitly.
//------------------------------------------------------------------------------------------	
		public override function updateDisplay ():Void {
			if (m_delayed > 0) {
				m_delayed--;
				
				return;
			}

//------------------------------------------------------------------------------------------			
			var i:Dynamic /* */;

			var __x:Float = x;
			var __y:Float = y;
			var __visible:Bool = getMasterVisible ();
			var __scaleX:Float = getMasterScaleX ();
			var __scaleY:Float = getMasterScaleY ();
			var __rotation:Float = getMasterRotation ();
			var __depth:Float = getMasterDepth ();
			var __alpha:Float = getMasterAlpha ();
			
//------------------------------------------------------------------------------------------
			var logicObject:XLogicObject;
			
// update children XLogicObjects
			XType.forEach (m_XLogicObjects, 
				function (i:Dynamic /* */):Void {
					logicObject = cast i; /* as XLogicObject */
							
					if (logicObject != null) {	
						logicObject.x2 = __x;
						logicObject.y2 = __y;
						logicObject.rotation2 = __rotation;
						logicObject.visible = __visible;
						logicObject.scaleX2 = __scaleX;
						logicObject.scaleY2 = __scaleY;
						logicObject.alpha = __alpha;
						
						// propagate rotation, scale, visibility, alpha
						logicObject.setMasterRotation (logicObject.getRotation () + __rotation);
						logicObject.setMasterScaleX (logicObject.getScaleX () * __scaleX);
						logicObject.setMasterScaleY (logicObject.getScaleY () * __scaleY);
						logicObject.setMasterVisible (logicObject.getVisible () && __visible);
						if (logicObject.getRelativeDepthFlag ()) {
							logicObject.setMasterDepth (logicObject.getDepth () + __depth);
						}
						else
						{
							logicObject.setMasterDepth (logicObject.getDepth ());
						}
						logicObject.setMasterAlpha (logicObject.getAlpha () * __alpha);
						
						logicObject.updateDisplay ();
					}
				}
			);
			
//------------------------------------------------------------------------------------------
			var sprite:XDepthSprite;

// update child sprites that live as children of the Sprite
			XType.forEach (m_childSprites, 
				function (i:Dynamic /* */):Void {
				}
			);
					
// update child sprites that live in the World
			XType.forEach (m_worldSprites, 
				function (i:Dynamic /* */):Void {
					sprite = cast i; /* as XDepthSprite */
					
					if (sprite != null) {
						sprite.x2 = __x;
						sprite.y2 = __y;
						sprite.rotation2 = __rotation;
						sprite.visible = sprite.visible2 && __visible;
						if (sprite.relativeDepthFlag) {
							sprite.depth2 = sprite.depth + __depth;
						}
						else
						{
							sprite.depth2 = sprite.depth;
						}
						sprite.scaleX2 = __scaleX;
						sprite.scaleY2 = __scaleY;
						sprite.alpha = __alpha;
					}
				}
			);
			
// update child sprites that live in the HUD
			XType.forEach (m_hudSprites, 
				function (i:Dynamic /* */):Void {
					sprite = cast i; /* as XDepthSprite */
					
					if (sprite != null) {
						sprite.x2 = __x;
						sprite.y2 = __y;
						sprite.rotation2 = __rotation;
						sprite.visible = sprite.visible2 && __visible;
						if (sprite.relativeDepthFlag) {
							sprite.depth2 = sprite.depth + __depth;
						}
						else
						{
							sprite.depth2 = sprite.depth;
						}
						sprite.scaleX2 = __scaleX;
						sprite.scaleY2 = __scaleY;
						sprite.alpha = __alpha;
					}
				}
			);
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
