//------------------------------------------------------------------------------------------
// <$begin$/>
// Copyright (C) 2014 Jimmy Huey
//
// Some Rights Reserved.
//
// The "X-Engine" is licensed under a Creative Commons
// Attribution-NonCommerical-ShareAlike 3.0 Unported License.
// (CC BY-NC-SA 3.0)
//
// You are free to:
//
//      SHARE - to copy, distribute, display and perform the work.
//      ADAPT - remix, transform build upon this material.
//
//      The licensor cannot revoke these freedoms as long as you follow the license terms.
//
// Under the following terms:
//
//      ATTRIBUTION -
//          You must give appropriate credit, provide a link to the license, and
//          indicate if changes were made.  You may do so in any reasonable manner,
//          but not in any way that suggests the licensor endorses you or your use.
//
//      SHAREALIKE -
//          If you remix, transform, or build upon the material, you must
//          distribute your contributions under the same license as the original.
//
//      NONCOMMERICIAL -
//          You may not use the material for commercial purposes.
//
// No additional restrictions - You may not apply legal terms or technological measures
// that legally restrict others from doing anything the license permits.
//
// The full summary can be located at:
// http://creativecommons.org/licenses/by-nc-sa/3.0/
//
// The human-readable summary of the Legal Code can be located at:
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// The "X-Engine" is free for non-commerical use.
// For commercial use, you will need to provide proper credits.
// Please contact me @ wuey99[dot]gmail[dot]com for more details.
// <$end$/>
//------------------------------------------------------------------------------------------
package xlogicobject;
	
	import kx.collections.*;
	import kx.geom.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	import kx.xmap.*;
	
	//	import flash.display.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
	//------------------------------------------------------------------------------------------
	class XLogicObjectCX0 extends XLogicObject {
		private var m_vel:XPoint;
		private var m_oldPos:XPoint;
		
		private var m_cx:XRect;
		private var m_namedCX:Map<String, XRect>; // <String, XRect>
		
		public static var CELLSWIDE:Int = 80;
		public static var CELLSHIGH:Int = 60;
		
		private var m_cmap:Array<Int>; // <Int>
		
		private var m_CX_Collide_Flag:Int;
		
		public static var CELLSIZE:Int = 16;
		public static var CELLMASK:Int = 0xfffffff0;
		
		public static var CX_COLLIDE_LF:Int = 0x0001;
		public static var CX_COLLIDE_RT:Int = 0x0002;
		public static var CX_COLLIDE_HORZ:Int = (CX_COLLIDE_LF+CX_COLLIDE_RT);
		public static var CX_COLLIDE_UP:Int = 0x0004;
		public static var CX_COLLIDE_DN:Int = 0x0008;
		public static var CX_COLLIDE_VERT:Int = (CX_COLLIDE_UP+CX_COLLIDE_DN);
		
		public static var CX_SOLID:Int = 1;
		
		//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
		}
		
		//------------------------------------------------------------------------------------------
		public override function cleanup ():Void {
			super.cleanup ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			setVel (new XPoint (0, 0));
			setOld (new XPoint (0, 0));
			
			m_cx = new XRect (0, 0, 0, 0);
			m_namedCX = new Map<String, XRect> (); // <String, XRect>
		}
		
		//------------------------------------------------------------------------------------------
		public function setCX (
			__x1:Float,
			__x2:Float,
			__y1:Float,
			__y2:Float
		):Void {
			
			m_cx = new XRect (__x1, __y1, __x2-__x1+1, __y2-__y1+1);
		}
		
		//------------------------------------------------------------------------------------------
		public function setNamedCX (
			__name:String,
			__x1:Float,
			__x2:Float,
			__y1:Float,
			__y2:Float
		):Void {
			
			m_namedCX.set (__name, new XRect (__x1, __y1, __x2-__x1+1, __y2-__y1+1));
		}
		
		//------------------------------------------------------------------------------------------
		public function getNamedCX (__name:String):XRect {
			return m_namedCX.get (__name).cloneX ();
		}
		
		//------------------------------------------------------------------------------------------
		public function getAdjustedNamedCX (__name:String):XRect {
			var __rect:XRect = m_namedCX.get (__name).cloneX ();
			__rect.offset (oX, oY);
			return __rect;
		}
		
		//------------------------------------------------------------------------------------------
		public function setVel (__vel:XPoint):Void {
			m_vel = __vel;
		}
		
		//------------------------------------------------------------------------------------------
		public function getVel ():XPoint {
			return m_vel;
		}
		
		//------------------------------------------------------------------------------------------
		public var oDX (get, set):Float;
		
		public function get_oDX ():Float {
			return getVel ().x;
		}
		
		public function set_oDX (__value:Float): Float {
			var __vel:XPoint = getVel ();
			__vel.x = __value;
			setVel (__vel);
			
			return __value;	
		}
		/* @:end */
		
		//------------------------------------------------------------------------------------------
		public var oDY (get, set):Float;
		
		public function get_oDY ():Float {
			return getVel ().y;
		}
		
		public function set_oDY (__value:Float): Float {
			var __vel:XPoint = getVel ();
			__vel.y = __value;
			setVel (__vel);
			
			return __value;	
		}
		/* @:end */
		
		//------------------------------------------------------------------------------------------
		public function getOld ():XPoint {
			return m_oldPos;
		}
		
		public function setOld (__pos:XPoint):Void {
			m_oldPos = __pos;
		}
		
		//------------------------------------------------------------------------------------------
		public var oldX (get, set):Float;
		
		public function get_oldX ():Float {
			return getOld ().x;
		}
		
		public function set_oldX (__value:Float): Float {
			var __pos:XPoint = getOld ();
			__pos.x = __value;
			setOld (__pos);
			
			return __value;	
		}
		/* @:end */
		
		//------------------------------------------------------------------------------------------
		public var oldY (get, set):Float;
		
		public function get_oldY ():Float {
			return getOld ().y;
		}
		
		public function set_oldY (__value:Float): Float {
			var __pos:XPoint = getOld ();
			__pos.y = __value;
			setOld (__pos);
			
			return __value;	
		}
		/* @:end */
		
		//------------------------------------------------------------------------------------------
		public function collidesWithNamedCX (__name:String, __rectDst:XRect):Bool {
			var __rectSrc:XRect = getAdjustedNamedCX (__name);
			
			return __rectSrc.intersects (__rectDst);
		}
		
		//------------------------------------------------------------------------------------------
		public var CX_Collide_Flag (get, set):Int;
		
		public function get_CX_Collide_Flag ():Int {
			return m_CX_Collide_Flag;
		}
		
		public function set_CX_Collide_Flag (__value:Int): Int {
			m_CX_Collide_Flag = __value;
			
			return __value;	
		}
		/* @:end */
		
		//------------------------------------------------------------------------------------------
		public override function updatePhysics ():Void {
			m_CX_Collide_Flag = 0;
			
			//------------------------------------------------------------------------------------------
			oX += oDX;
			
			//			if (int (oX) != int (oldX)) {
			{
				if (oDX < 0) {
					Ck_Collide_LF ();
				}
				else
				{
					Ck_Collide_RT ();
				}
			}
			
			//------------------------------------------------------------------------------------------
			oY += oDY;
			
			//			if (int (oY) != int (oldY)) {
			{
				if (oDY < 0) {
					Ck_Collide_UP ();
				}
				else
				{
					Ck_Collide_DN ();
				}
			}
		}
		
		//------------------------------------------------------------------------------------------
		public function Ck_Collide_UP ():Bool {
			var x1:Float, y1:Float, x2:Float, y2:Float;
			var i:Int;
			var __x:Float, __y:Float;
			var collided:Bool;
			
			x1 = Std.int (oX) + m_cx.left;
			x2 = Std.int (oX) + m_cx.right;
			y1 = Std.int (oY) + m_cx.top;
			y2 = Std.int (oY) + m_cx.bottom;
			
			y1 = Std.int (y1) & CELLMASK;
			
			collided = false;
			
			__x = (Std.int (x1) & CELLMASK);
			
			while (__x <= (Std.int (x2) & CELLMASK)) {
				i = (Std.int (y1/CELLSIZE) * CELLSWIDE);
				i += Std.int (__x/CELLSIZE);
				var cx:Int = m_cmap[i];
				if (cx >=0 && cx < XSubmapModel.CX_MAX)
					if (cx == CX_SOLID) {
							m_CX_Collide_Flag |= CX_COLLIDE_UP;
							
							oY = (y1 + CELLSIZE - m_cx.top);
							
							collided = true;
					}
				
				if (collided) {
					return true;
				}
				
				__x += CELLSIZE;
			}
			
			return false;
		}
		
		//------------------------------------------------------------------------------------------
		public function Ck_Collide_DN ():Bool {
			var x1:Float, y1:Float, x2:Float, y2:Float;
			var i:Int;
			var __x:Float, __y:Float;
			var collided:Bool;
			
			x1 = Std.int (oX) + m_cx.left;
			x2 = Std.int (oX) + m_cx.right;
			y1 = Std.int (oY) + m_cx.top;
			y2 = Std.int (oY) + m_cx.bottom;
			
			y2 = Std.int (y2) & CELLMASK;
			
			collided = false;
			
			__x = (Std.int (x1) & CELLMASK);
				
			while (__x <= (Std.int (x2) & CELLMASK)) {
				i = (Std.int (y2/CELLSIZE) * CELLSWIDE);
				i += Std.int (__x/CELLSIZE);
				var cx:Int = m_cmap[i];
				if (cx >=0 && cx < XSubmapModel.CX_MAX)
						if (cx == CX_SOLID) {
							m_CX_Collide_Flag |= CX_COLLIDE_DN;
							
							oY = (y2 - m_cx.bottom - 1);
							
							collided = true;
						}
		
				if (collided) {
					return true;
				}
				
				__x += CELLSIZE;
			}
			
			return false;
		}
		
		//------------------------------------------------------------------------------------------
		public function Ck_Collide_LF ():Bool {
			var x1:Float, y1:Float, x2:Float, y2:Float;
			var i:Int;
			var __x:Float, __y:Float;
			var collided:Bool;
			
			x1 = Std.int (oX) + m_cx.left;
			x2 = Std.int (oX) + m_cx.right;
			y1 = Std.int (oY) + m_cx.top;
			y2 = Std.int (oY) + m_cx.bottom;
			
			x1 = Std.int (x1) & CELLMASK;
			
			collided = false;
			
			__y = (Std.int (y1) & CELLMASK);
			
			while (__y <= (Std.int (y2) & CELLMASK)) {
				i = (Std.int (__y/CELLSIZE) * CELLSWIDE);
				i += Std.int (x1/CELLSIZE);
				var cx:Int = m_cmap[i];
				if (cx >=0 && cx < XSubmapModel.CX_MAX)
					if (cx == CX_SOLID) {
							m_CX_Collide_Flag |= CX_COLLIDE_LF;
							
							oX = (x1 + CELLSIZE - m_cx.left);
							
							collided = true;
					}
				
				if (collided) {
					return true;
				}
				
				__y += CELLSIZE;
			}
			
			return false;
		}
		
		//------------------------------------------------------------------------------------------
		public function Ck_Collide_RT ():Bool {
			var x1:Float, y1:Float, x2:Float, y2:Float;
			var i:Int;
			var __x:Float, __y:Float;
			var collided:Bool;
			
			x1 = Std.int (oX) + m_cx.left;
			x2 = Std.int (oX) + m_cx.right;
			y1 = Std.int (oY) + m_cx.top;
			y2 = Std.int (oY) + m_cx.bottom;
			
			x2 = Std.int (x2) & CELLMASK;
			
			collided = false;
			
			__y = (Std.int (y1) & CELLMASK);
			
			while (__y <= (Std.int (y2) & CELLMASK)) {
				i = (Std.int (__y/CELLSIZE) * CELLSWIDE);
				i += Std.int (x2/CELLSIZE);
				var cx:Int = m_cmap[i];
				if (cx >=0 && cx < XSubmapModel.CX_MAX)
						if (cx == CX_SOLID) {
							m_CX_Collide_Flag |= CX_COLLIDE_RT;
							
							oX = (x2 - m_cx.right - 1);
							
							collided = true;
				}
				
				if (collided) {
					return true;
				}

				__y += CELLSIZE;
			}
			
			return false;
		}
		
		//------------------------------------------------------------------------------------------
	}
// }