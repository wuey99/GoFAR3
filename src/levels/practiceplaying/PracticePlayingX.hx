//------------------------------------------------------------------------------------------
package levels.practiceplaying;
	
	import assets.*;
	
	import interfaces.*;
	
	import levels.*;
	
	import objects.*;
	import objects.clouds.*;
	import objects.demo.*;
	import objects.effects.*;
	import objects.fish.*;
	import objects.mickey.*;
	import objects.obstacles.*;
	import objects.space.*;
	import objects.splash.*;
	import objects.win.*;
	
	import sound.*;
	
	import kx.*;
	import kx.geom.*;
	import kx.sound.*;
	import kx.task.*;
	import kx.world.*;
	import kx.world.collision.*;
	import kx.world.logic.*;
	import kx.world.sprite.*;
	
	import openfl.display.*;
	import openfl.geom.*;
	import openfl.media.Sound;
	import openfl.text.*;
	import openfl.utils.*;
	
//------------------------------------------------------------------------------------------
	class PracticePlayingX extends LevelX {
		private var m_pointyArrowObject:PointyArrowX;
		private var m_playingStage:Int;
		private static var m_standardVoiceDelay:Float = .5*1000;
		private var xm2:XSoundTaskSubManager;
		
//------------------------------------------------------------------------------------------		
		// begin include "cmap.as";
var CMapArray:Array<Int> = [ // <Int>
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,5,6,7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,5,6,7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,5,6,7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
];
		// end include "cmap.as";
		
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
			
			m_cmap = CMapArray;
			
			createSprites ();
			
			xm2 = new XSoundTaskSubManager (
				G.app.getXSoundTaskManager (), G.app.getOldSoundManager ()
			);
			
			m_playingStage = 0;
			
			createPointyArrow ();
		}
		
//------------------------------------------------------------------------------------------				
		public override function createFreePlayLevel ():Void {
			createBGController (m_setting, getDepth ());
			
			createLevel ();
			
			Practice_Playing_Script ();
		}
		
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;

			sprite = createXMovieClip(getBgClass ());
			x_sprite = addSpriteAt (sprite, 0, 0);
			x_sprite.setDepth (getDepth () + 0);
			
			sprite = createXMovieClip("Assets:Level005_" + getLevelClass ());
			x_sprite = addSpriteAt (sprite, 0, 0);
			x_sprite.setDepth (getDepth () + 4);
									
			show ();
		}

//------------------------------------------------------------------------------------------
		public override function getLevelData ():Array<Dynamic> /* <Dynamic> */ {
			var dx:Float = 48;
			var dy:Float = 48+48;
			
			return [
			
			// bee
				[Game.OBJECT_BEE, new XPoint (96+dx, 330+dy), 1.0],
				
			// off-plan objects
				[
					[
						Game.GOAL_KILLGOOMBA, "", new XPoint (792+dx, 88+dy),
						[],
						new XPoint (634, 339-4), -1.0,
						new XPoint (634, 339-4), -1.0
					],
				],
			// goal/plan objects
				[
					[
// type, assetClassName, position
						Game.GOAL_JUMPPIT, "", new XPoint (216+dx, 392+dy),
// [sensorPosList]
						[new XPoint (334+dx, 334+dy)],
// beePos, beeDirection 1
						new XPoint (96+dx, 330+dy), 1.0,
// beePos, beeDirection 2
						new XPoint (16+dx, 140+dy), 1.0
					],
					[
// type, assetClassName, position
						Game.GOAL_CLIMBLADDER, "Assets:LadderClass", new XPoint (648+dx, 434+dy),
// [sensorPosList]
						[new XPoint (648-64+dx, 238+dy), new XPoint (648+64+dx, 238+dy)],
// beePos, beeDirection 1
						new XPoint (96+dx, 330+dy), 1.0,
// beePos, beeDirection 2
						new XPoint (16+dx, 140+dy), 1.0
					],
					[
// type, assetClassName, position
						Game.GOAL_GETKEY, "", new XPoint (272+dx, 134+dy),
// [sensorPosList]
						[new XPoint (272+dx, 134+dy)],
// beePos, beeDirection 1
						new XPoint (96+dx, 330+dy), 1.0,
// beePos, beeDirection 2
						new XPoint (16+dx, 140+dy), 1.0
					],
					[
// type, assetClassName, position
						Game.GOAL_OPENDOOR, "", new XPoint (72+dx, 140+dy),
// [sensorPosList]
						[new XPoint (72+dx, 140+dy)],
// beePos, beeDirection 1
						new XPoint (96+dx, 330+dy), 1.0,
// beePos, beeDirection 2
						new XPoint (16+dx, 140+dy), 1.0
					],
				],
				
			// proximity sensors
				[
					[Game.SENSOR_JUMPPIT, new XPoint (334, 334)],
					[Game.SENSOR_CLIMBLADDER, new XPoint (589, 238)],
					[Game.SENSOR_CLIMBLADDER, new XPoint (705, 238)],
				],
			];
		}

//------------------------------------------------------------------------------------------
		public function Practice_Playing_Script ():Void {
			var i:Int;
			var __planModel:PlanModelX;
			var __soundDone:Bool = false;
			
			//------------------------------------------------------------------------------------------			
			function __waitForGoal ():Array<Dynamic> { // <Dynamic>
				return [
					XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (__planModel != null && __planModel.completed);
					},
					
					XTask.BNE, "loop",
					
					function ():Void {
						trace (": ", __planModel, __planModel.index);
					},
					
					XTask.RETN,
				];
			}
			
			//------------------------------------------------------------------------------------------
			m_currPlanIndex = 0;
							
			setLastCompletedPlanIndex (m_currPlanIndex);

//------------------------------------------------------------------------------------------
			G.setGameMode (G.GAMEMODE_PLAYING);

			G.app.setMessage ("");
			
//			G.app.getProgressBar ().addStageType (FAR.STAGE_PLAN);

			m_completedSteps = 0;
			m_totalSteps = countGoalSteps ();
			G.app.getScoreAndOptions ().setScore (G.app.getCumalativeScore ());
			G.app.getProgressBar ().setProgress (0);
			G.app.getPlanTray ().removeAllGoals ();
			
			m_pointyArrowObject.point (224, 224, 335, 12);
		
//------------------------------------------------------------------------------------------
			for (i in 0 ... getPlans ().length) {
				__planModel = getPlans ()[i];
				
				__planModel.iconObject = G.app.getPlanTray ().addGoalType (__planModel.type);
			}
			
//------------------------------------------------------------------------------------------			
			for (i in 0 ... getOffPlans ().length) {
//				getOffPlans ()[i].logicObject.getCursorHighlightObject ().setExplodeAway ();
			}
			
			hideOutOfOrderGoals ();
				
//------------------------------------------------------------------------------------------			
			script.gotoTask ([			
				function ():Void {
					G.app.setMessage ("");
				},

				function ():Void {	
					var __splash:SimpleSplashX = cast xxx.getXLogicManager ().initXLogicObject (
						// parent
							self,
						// logicObject
							new SimpleSplashX () /* as XLogicObject */,
						// item, layer, depth
							null, 0, 20000,
						// x, y, z
							0, 0, 0,
						// scale, rotation
							1.0, 0,
							[
								initScript
							]
						) /* as SimpleSplashX */;
						
					addXLogicObject	(__splash);	
				},
				
				function ():Void {	
					addTask ([
						XTask.WAIT, 0x2000,
						
						function ():Void {
							getPlans ()[m_currPlanIndex].logicObject.setHighlighted (true);
						},
						
						XTask.RETN,
					]);
				},

				function ():Void {
					G.app.getBee ().freePlayMode (getBeeStartingPos (), getBeeStartingDirection ());
						
					for (i in 0 ... getPlans ().length) {
						getPlans ()[i].logicObject.oAlpha = 1.0;
					}
				},
								
				XTask.LABEL, "loop",		
					function ():Void {
						__planModel = getPlans ()[m_currPlanIndex];
					},
					
					function ():Void {
						__planModel.iconObject.FlashingMode_Script ();
					},
	
					XTask.EXEC, __waitForGoal (),
										
					function ():Void {						
						__planModel.iconObject.Finished_Script ();
							
						var __logicObject:FarXObstacle = __planModel.logicObject;							
						__logicObject.getCursorHighlightObject ().Highlighted_CompletedGoal_Script ();
							
						addCompletedStep ();
					},
			
					function ():Void {
						setLastCompletedPlanIndex (m_currPlanIndex);
						
						m_currPlanIndex++;
						
						addTask ([
							XTask.WAIT1000, 1.5*1000,
							
							function ():Void {
								m_playingStage++;
							},
							
							XTask.RETN,
						]);
					},
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (m_currPlanIndex < getPlans ().length);
					},
							
					XTask.BEQ, "loop",
					
					function ():Void {
						var s:Array<Dynamic>; // <Dynamic>

						G.setGameMode (G.GAMEMODE_FINISHED);
						
//						G.app.getScoreAndOptions ().addToScore (1);
								
						/*
						xm.replaceAllSoundTasks ([
							function ():Void {
								G.app.setSoundPlaying (true);
							},
			
							XTask.FUNC, function (__task:XSoundTask):Void {
								s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_GoodJob());
								__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
							},  XTask.EXEC, waitForSoundFinishedX (),
			
							XTask.WAIT1000, m_standardVoiceDelay,
												
							function ():Void {
								__soundDone = true;
									
								G.app.setSoundPlaying (false);
							},
							
							XTask.RETN,
						]);	
						*/
					},
					
					XTask.LABEL, "__wait",
							
					XTask.WAIT, 0x0100,
							
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (__soundDone);
					}, XTask.BNE, "__wait",
							
					function ():Void {
//						Level_Reflect_Script ();
					},
					
				XTask.RETN,
			]);
		}

//------------------------------------------------------------------------------------------
		public override function Act_SFX_GoodJob ():Void {
			var s:Array<Dynamic>; // <Dynamic>
			
			G.app.setSoundPlaying (true);
						
			xm.replaceAllSoundTasks ([
				XTask.WAIT, 0x0400,
							
				XTask.FUNC, function (__task:XSoundTask):Void {
					s = G.app.getRandomSoundFromGroup (G.app.Act_SFX_GoodJob());
					__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
				},  XTask.EXEC, waitForSoundFinishedX (),
							
				XTask.WAIT1000, m_standardVoiceDelay,
									
				function ():Void {
					G.app.setSoundPlaying (false);
				},
							
				XTask.RETN,
			]);	
		}
		
//------------------------------------------------------------------------------------------		
		public function initScript ():Void {
			xm2.replaceAllSoundTasks ([
				XTask.WAIT, 0x0100,
				
				function ():Void {
					G.app.setSoundPlaying (true);
					G.app.blockGameMouseEvents ();
				},
				
				XTask.WAIT, 0x1000,
				
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.MoveUsingTheArrowKeys () , soundFinished);
					G.app.setMessage ("Move Using the Arrow Keys");
				},
				
				XTask.WAIT1000, 2*1000,
				
				function ():Void {
					G.app.setMessage ("And Jump Using the Space Bar");
				},
				
				XTask.WAIT1000, 1*2000,
				
				function ():Void {
					G.app.setMessage ("To Act Out Your Plan");
				},
				
				XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
				
				/*
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.GetTheKey () , soundFinished);
					G.app.setMessage ("Get the Key");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
												
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.GetTheKeyOpenTheDoor () , soundFinished);
					G.app.setMessage ("And Open the Door");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
				*/
				
				function ():Void {
					m_playingStage = 0;
					
					G.app.allowGameMouseEvents ();
				},
				
				function ():Void {
					showDPadButtons ();
				},
				
				XTask.FUNC, function (__task:XSoundTask):Void {
					m_pointyArrowObject.show ();
					m_pointyArrowObject.point (256, 420, 160, 12);
					__task.replaceSound (XAssets.JumpOverThePit () , soundFinished);
					G.app.setMessage ("Jump Over The Pit");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
						
				XTask.LABEL, "loop0",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XSoundTask):Void {
						trace (": playingStage: ", m_playingStage);
						
						__task.ifTrue (m_playingStage == 0);
					}, XTask.BEQ, "loop0",
								
				XTask.FUNC, function (__task:XSoundTask):Void {
					m_pointyArrowObject.show ();
					m_pointyArrowObject.point (680, 420, 160, 12);
					__task.replaceSound (XAssets.ClimbTheLadder () , soundFinished);
					G.app.setMessage ("Climb The Ladder");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
				
				XTask.LABEL, "loop1",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XSoundTask):Void {	
						__task.ifTrue (m_playingStage == 1);
					}, XTask.BEQ, "loop1",
									
				XTask.FUNC, function (__task:XSoundTask):Void {
					m_pointyArrowObject.show ();
					m_pointyArrowObject.point (320, 224, 224, 12);
					__task.replaceSound (XAssets.GetTheKey () , soundFinished);
					G.app.setMessage ("Get the Key");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,

				XTask.LABEL, "loop2",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XSoundTask):Void {	
						__task.ifTrue (m_playingStage == 2);
					}, XTask.BEQ, "loop2",
					
				XTask.FUNC, function (__task:XSoundTask):Void {
					m_pointyArrowObject.show ();
					m_pointyArrowObject.point (160, 224, 224, 12);
					__task.replaceSound (XAssets.GetTheKeyOpenTheDoor () , soundFinished);
					G.app.setMessage ("Open the Door");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,

				XTask.LABEL, "loop3",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XSoundTask):Void {	
						__task.ifTrue (m_playingStage == 3);
					}, XTask.BEQ, "loop3",
								
				XTask.FUNC, function (__task:XSoundTask):Void {
					m_pointyArrowObject.hide ();
					__task.replaceSound (XAssets.YouWonFarOut () , soundFinished);
					G.app.setMessage ("You Won!  FAR OUT!");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
																																																					
				function ():Void {
					G.app.setSoundPlaying (false);
				},
				
				XTask.RETN,
			]);
		}
		
//------------------------------------------------------------------------------------------
		public function createPointyArrow ():Void {	
			m_pointyArrowObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					self,
				// logicObject
					new PointyArrowX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 15000,
				// x, y, z
					256, 256, 0,
				// scale, rotation
					1.0, 0
				) /* as PointyArrowX */;
				
			addXLogicObject (m_pointyArrowObject);
		}
				
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
