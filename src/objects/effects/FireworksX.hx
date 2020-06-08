//------------------------------------------------------------------------------------------
package objects.effects;
	
	import assets.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
//------------------------------------------------------------------------------------------
	class FireworksX extends XLogicObject {
		private var x_sprite:XDepthSprite;
		
		private var script:XTask;
		
		public static var SCREEN_WIDTH:Float = 856;
		public static var SCREEN_HEIGHT:Float = 480;
		
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
	
			script = addEmptyTask ();
			
			Idle_Script ();
		}
		
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:Sprite = new Sprite ();
			x_sprite = addSpriteAt (sprite, 0, 0);
			
			sprite.graphics.beginFill (0x000000);
			sprite.graphics.drawRect (0, 0, G.SCREEN_WIDTH, G.SCREEN_HEIGHT);
			sprite.graphics.endFill ();
			
			show ();
		}

		//------------------------------------------------------------------------------------------
		public function createFireworksExplosion ():Void {
			var i:Int;
			
			var __x:Float;
			var __y:Float;
			
			__x = Math.random () * SCREEN_WIDTH;
			__y = Math.random () * SCREEN_HEIGHT * 0.75;
			
			var __fireworksExplosionObject:FireworksExplosionX = cast xxx.getXLogicManager ().initXLogicObjectFromPool (
				// parent
				this,
				// logicObject
				FireworksExplosionX,
				// item, layer, depth
				null, 0, getDepth () + 1,
				// x, y, z
				__x, __y, 0,
				// scale, rotation
				1.0, 0,
				[
					"Yellow",
					self
				]
			) /* as FireworksExplosionX */;
			
			addXLogicObject (__fireworksExplosionObject);
			
			i = 0;
			
			while (i < 360) {
				var __radians:Float = Math.PI * i / 180;
				
				var __dx:Float = Math.cos (__radians) * 8;
				var __dy:Float = Math.sin (__radians) * 8;
				
				createFireworksParticle (__x, __y, __dx, __dy);
				
				i += 15;
			}
		}
		
		//------------------------------------------------------------------------------------------
		public function createFireworksParticle (__x:Float, __y:Float, __dx:Float, __dy:Float):Void {
			var __colors:Array<String> /* <String> */ = ["Red", "Green", "Blue", "Yellow"];
			
			var __index:Int = Std.int (Math.random () * 4);
			
			var __fireworksParticleObject:FireworksParticleX = cast xxx.getXLogicManager ().initXLogicObjectFromPool (
				// parent
				this,
				// logicObject
				FireworksParticleX,
				// item, layer, depth
				null, 0, getDepth () + 1,
				// x, y, z
				__x, __y, 0,
				// scale, rotation
				1.0, 0,
				[
					__colors[__index],
					self
				]
			) /* as FireworksParticleX */;
			
			__fireworksParticleObject.oDX = __dx;
			__fireworksParticleObject.oDY = __dy;
			
			addXLogicObject (__fireworksParticleObject);
		}
		
		//------------------------------------------------------------------------------------------
		public function Idle_Script ():Void {
			
			script.gotoTask ([
				
				//------------------------------------------------------------------------------------------
				// control
				//------------------------------------------------------------------------------------------
				function ():Void {
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								createFireworksExplosion ();
							}, XTask.WAIT, 0x2000,
							
							XTask.GOTO, "loop",
						
						XTask.RETN,
					]);
				},
				
				//------------------------------------------------------------------------------------------
				// animation
				//------------------------------------------------------------------------------------------	
				XTask.LABEL, "loop",	
					XTask.WAIT, 0x0100,	
					
					XTask.GOTO, "loop",
				
				XTask.RETN,
				
				//------------------------------------------------------------------------------------------			
			]);
			
			//------------------------------------------------------------------------------------------
		}
		
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
