//------------------------------------------------------------------------------------------
package objects.obstacles;
	
	import assets.*;
	
	import objects.*;
	import objects.effects.*;
	
	import kx.*;
	import kx.geom.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class GoombaX extends FarXObstacle {
		private var m_sprite:XMovieClip;
		private var m_highlight:Bool;
		private static var GOOMBA_ANIM_SPEED:Float = 0x0400;
		private var script:XTask;

//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}

//------------------------------------------------------------------------------------------
		public override function setup (__xxx:XWorld, args:Array<Dynamic> /* <Dynamic> */):Void {
			super.setup (__xxx, args);
	
			m_levelX = getArg (args, 0);
			
			m_cmap = m_levelX.getCMap ();
			
			createSprites ();
		}

//------------------------------------------------------------------------------------------
		public override function setupX ():Void {
			super.setupX ();
			
			m_highlight = false;
			
			setupProps (1.5, 2.5);
			
			setNamedCX ("main", -32, 32, -16, 0);
			setNamedCX ("mouseOver", -32, 32, -64, 0);
			
			script = addEmptyTask ();
			
			Goomba_Idle_Script ();
		}

//------------------------------------------------------------------------------------------
		public function Goomba_Idle_Script ():Void {
			script.gotoTask ([
				function ():Void {
					script.addTask (getGoombaCollisionTaskX ());
				},
				
				XTask.EXEC, getGoombaAnimTaskX (),
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function Goomba_Die_Script ():Void {
			var rotateSpeed:Float = 4.0;
			
			m_planModel.completed = true;
			
			script.gotoTask ([
				function ():Void {
					script.addTask ([
						XTask.LABEL, "loop",
						function ():Void {
							oDY += .25;
								
							if (oDY > 12) {
								oDY = 12;
							}
							
							oY += oDY;
							
						}, XTask.WAIT, 0x0100,
						XTask.GOTO, "loop",
						XTask.RETN,
					]);
					
					script.addTask ([
						XTask.LABEL, "loop",
						function ():Void {
							oRotation += rotateSpeed;
							rotateSpeed += 1.0;
							rotateSpeed = Math.min (rotateSpeed, 24.0);
						}, XTask.WAIT, 0x0100,
						XTask.GOTO, "loop",
						XTask.RETN,
					]);
				},
					
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					XTask.GOTO, "loop",
					
				XTask.RETN,
			]);	
		}

//------------------------------------------------------------------------------------------
		public function getGoombaCollisionTaskX ():Array<Dynamic> { // <Dynamic>
			return [
				XTask.LABEL, "loop",
						
				XTask.WAIT, 0x0100,
						
				function ():Void {
					var __rect:XRect = getAdjustedNamedCX ("main");
						
					var __beePos:XPoint = G.app.getBee ().getPos ();
						
					if (G.getGameMode () != G.GAMEMODE_FINISHED) 
					if (__beePos.x >= __rect.left-16 && __beePos.x <= __rect.right+16) {
						if (__beePos.y > __rect.top && __beePos.y < __rect.bottom && G.app.getBee ().oDY > 0.0) {	
							if (!m_planModel.fake) {
								G.app.getBee ().Bee_Jump_Script (0.0, -12);
								
								Goomba_Die_Script ();
							}
							else
							{
								G.app.getBee ().beeGotoRequest (G.app.getBee ().Bee_Error_Script);								
							}
						}
					}
				},
						
				XTask.GOTO, "loop",
						
				XTask.RETN,
			];
		}

//------------------------------------------------------------------------------------------
		public function getGoombaAnimTaskX ():Array<Dynamic> { // <Dynamic>
			return [
				XTask.LABEL, "loop",
					function ():Void {
						m_sprite.gotoAndStop (1);
					}, XTask.WAIT, GOOMBA_ANIM_SPEED,
					function ():Void {
						m_sprite.gotoAndStop (2);
					}, XTask.WAIT, GOOMBA_ANIM_SPEED,
					function ():Void {
						m_sprite.gotoAndStop (3);
					}, XTask.WAIT, GOOMBA_ANIM_SPEED,
					function ():Void {
						m_sprite.gotoAndStop (4);
					}, XTask.WAIT, GOOMBA_ANIM_SPEED,
					function ():Void {
						m_sprite.gotoAndStop (5);
					}, XTask.WAIT, GOOMBA_ANIM_SPEED,
					function ():Void {
						m_sprite.gotoAndStop (6);
					}, XTask.WAIT, GOOMBA_ANIM_SPEED,
				XTask.GOTO, "loop",
				
				XTask.RETN,
			];
		}
				
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			m_sprite = createXMovieClip("Assets:GoombaClass");
			x_sprite = addSpriteAt (m_sprite, 0, 0);
			
			show ();
		}

//------------------------------------------------------------------------------------------
		public override function getType ():Int {
			return Game.GOAL_KILLGOOMBA;
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
