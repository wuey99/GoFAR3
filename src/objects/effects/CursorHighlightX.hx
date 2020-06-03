//------------------------------------------------------------------------------------------
package objects.effects;
	
	import assets.*;
	
	import kx.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import xlogicobject.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class CursorHighlightX extends XLogicObjectCX2 {
		private var m_sprite:XMovieClip;
		private var x_sprite:XDepthSprite;
		private var script:XTask;
		private var m_highlighted:Bool;
		private var m_minScale:Float;
		private var m_maxScale:Float;
		private var m_hint:Bool;
		private var m_highlightedAlpha:Float;
		private var m_unHighlightedAlpha:Float;
		private var m_hintAlpha:Float;
		
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
		public function setupProps (__minScale:Float, __maxScale:Float):Void {
			m_minScale = __minScale;
			m_maxScale = __maxScale;
			
			script = addEmptyTask ();
			
			if (G.app.getCurrSetting () != 2) {
				m_unHighlightedAlpha = 0.20;
				m_highlightedAlpha = 0.50;
				m_hintAlpha = 0.70;
			}
			else
			{
				m_unHighlightedAlpha = 0.40;
				m_highlightedAlpha = 0.70;
				m_hintAlpha = 0.90;
			}
			
			m_hint = false; m_highlighted = false; oAlpha = 0.25; oScale = m_minScale;
			
			UnHighlighted_Script ();
		}

//------------------------------------------------------------------------------------------
		public function setUnHighlightedAlpha (__alpha:Float):Void {
			m_unHighlightedAlpha = __alpha;
		}
		
//------------------------------------------------------------------------------------------
		public function setHiglightedAlpha (__alpha:Float):Void {
			m_highlightedAlpha = __alpha;
		}
		
//------------------------------------------------------------------------------------------
		public function setHintAlpha (__alpha:Float):Void {
			m_hintAlpha = __alpha;
		}
		
//------------------------------------------------------------------------------------------
		public function buzzWrong ():Void {
			addTask ([
				XTask.LOOP, 4,
					function ():Void {
						m_sprite.gotoAndStop (2);
					}, XTask.WAIT, 0x0400,
					function ():Void {
						m_sprite.gotoAndStop (1);
					}, XTask.WAIT, 0x0200,
				XTask.NEXT,	
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
		public function UnHighlighted_Script ():Void {
			script.gotoTask ([
				function ():Void {
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
					
							function ():Void {
								if (m_highlighted) {
									Highlighted_Script ();
								}
								
								if (m_hint) {
									Hint_Script ();
								}
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);
	
//------------------------------------------------------------------------------------------
// scale
//------------------------------------------------------------------------------------------				
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oScale = Math.max (oScale - 0.125, m_minScale);
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);

//------------------------------------------------------------------------------------------
// alpha
//------------------------------------------------------------------------------------------				
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oAlpha = Math.max (oAlpha - 0.125, m_unHighlightedAlpha);
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);
				},
				
//------------------------------------------------------------------------------------------				
// rotation
//------------------------------------------------------------------------------------------
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oRotation += 1.0;
					},
					
					XTask.GOTO, "loop",
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function Hint_Script ():Void {
			script.gotoTask ([
				function ():Void {
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
					
							function ():Void {
								if (m_highlighted) {
									Highlighted_Script ();
								}
								
								if (!m_hint) {
									UnHighlighted_Script ();
								}
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);
	
//------------------------------------------------------------------------------------------
// scale
//------------------------------------------------------------------------------------------				
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.LOOP, 10,
								XTask.WAIT, 0x0100,
							
								function ():Void {
									oScale = Math.max (oScale - 0.125, m_minScale);
								},

								XTask.NEXT, 
								
							XTask.LOOP, 10,
								XTask.WAIT, 0x0100,
							
								function ():Void {
									oScale = Math.min (oScale + 0.125, m_maxScale);
								},
																
								XTask.NEXT,
										
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);

//------------------------------------------------------------------------------------------
// alpha
//------------------------------------------------------------------------------------------				
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oAlpha = Math.max (oAlpha - 0.125, m_hintAlpha);
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);
				},
				
//------------------------------------------------------------------------------------------				
// rotation
//------------------------------------------------------------------------------------------
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oRotation += 3.0;
					},
					
					XTask.GOTO, "loop",
				
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
		public function Highlighted_Script ():Void {
			script.gotoTask ([
				function ():Void {
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
					
							function ():Void {
								if (!m_highlighted) {
									UnHighlighted_Script ();
								}
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);
					
//------------------------------------------------------------------------------------------
// scale
//------------------------------------------------------------------------------------------
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oScale = Math.min (oScale + 0.125, m_maxScale*0.75);
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);
		
//------------------------------------------------------------------------------------------
// alpha
//------------------------------------------------------------------------------------------			
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oAlpha = Math.min (oAlpha + 0.125, m_highlightedAlpha);
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);
				},
				
//------------------------------------------------------------------------------------------
// rotation
//------------------------------------------------------------------------------------------
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
						oRotation += 1.0;
					},
					
					XTask.GOTO, "loop",
				
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public function Highlighted_ExplodeAway_Script ():Void {
			script.gotoTask ([
				function ():Void {
					
//------------------------------------------------------------------------------------------
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oAlpha = Math.max (oAlpha - 0.0625, 0.0);
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);

//------------------------------------------------------------------------------------------				
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oScale = Math.max (oScale + 0.0625, 4.0);
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);

//------------------------------------------------------------------------------------------				
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oRotation += 4;
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);
				},

//------------------------------------------------------------------------------------------
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					function ():Void {
					},
					
					XTask.GOTO, "loop",
						
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
		public function Highlighted_CompletedGoal_Script ():Void {
			script.gotoTask ([
				function ():Void {
					oAlpha = 0.0;
					oRotation = 0.0;
					oScale = 1.0;
					
//------------------------------------------------------------------------------------------
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oAlpha = Math.min (oAlpha + 0.10, 1.0);
							},
							
							XTask.FLAGS, function (__task:XTask):Void {
								__task.ifTrue (oScale == 4.0);
							},
							
							XTask.BNE, "loop",
	
						XTask.LABEL, "fade",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oAlpha = Math.max (oAlpha - 0.10, 0.0);
							},
				
							XTask.GOTO, "fade",
											
						XTask.RETN,
					]);

//------------------------------------------------------------------------------------------									
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oScale = Math.min (oScale + 0.20, 4.0);
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);

//------------------------------------------------------------------------------------------				
					script.addTask ([
						XTask.LABEL, "loop",
							XTask.WAIT, 0x0100,
							
							function ():Void {
								oRotation += 4;
							},
							
							XTask.GOTO, "loop",
							
						XTask.RETN,
					]);
				},

//------------------------------------------------------------------------------------------
				XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,

					XTask.GOTO, "loop",
					
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
		public function setHighlighted (__flag:Bool):Void {
			m_highlighted = __flag;
		}

//------------------------------------------------------------------------------------------
		public function setHint (__flag:Bool):Void {
			m_hint = __flag;
		}
		
//------------------------------------------------------------------------------------------
		public function setExplodeAway ():Void {
			Highlighted_ExplodeAway_Script ();
		}
		
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			m_sprite = createXMovieClip("Assets:StarburstClass");
			x_sprite = addSpriteAt (m_sprite, 0, 0);
									
			show ();
		}

//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
