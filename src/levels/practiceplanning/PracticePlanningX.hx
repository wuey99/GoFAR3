//------------------------------------------------------------------------------------------
package levels.practiceplanning;
	
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
	class PracticePlanningX extends LevelX {
		private var m_pointyArrowObject:PointyArrowX;
		private var m_samplePlanObject:SamplePlanX;
		private var m_planningStage:Float;
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
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
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
			
			m_planningStage = 1;
		}

//------------------------------------------------------------------------------------------				
		public override function createPlanningLevel ():Void {
			createBGController (m_setting, getDepth ());
			
			createLevel ();

			Practice_Planning_Script ();
			
			m_beeObject.planningMode ();
		}
		
//------------------------------------------------------------------------------------------
// create sprites
//------------------------------------------------------------------------------------------
		public override function createSprites ():Void {
			var sprite:XMovieClip;

			sprite = createXMovieClip(getBgClass ());
			x_sprite = addSpriteAt (sprite, 0, 0);
			x_sprite.setDepth (getDepth () + 0);
			
			sprite = createXMovieClip("Assets:Level001_" + getLevelClass ());
			x_sprite = addSpriteAt (sprite, 0, 0);
			x_sprite.setDepth (getDepth () + 4);
									
			createPointyArrow ();
			createSamplePlan ();
			
			show ();
		}

//------------------------------------------------------------------------------------------
		public override function getLevelData ():Array<Dynamic> /* <Dynamic> */ {
			var dx:Float = 48;
			var dy:Float = 0;
			
			return [
			
			// bee
				[Game.OBJECT_BEE, new XPoint (184+dx, 525+dy), 1.0],
				
			// off-plan objects
				[
				],
				
			// goal/plan objects
				[
					[
// type, assetClassName, position
						Game.GOAL_GETKEY, "", new XPoint (478+dx, 525+dy),
// [sensorPosList]
						[new XPoint (478+dx, 525+dy)],
// beePos, beeDirection 1
						new XPoint (184+dx, 525+dy), 1.0,
// beePos, beeDirection 2
						new XPoint (829, 525), -1.0,
					],
					[
// type, assetClassName, position
						Game.GOAL_OPENDOOR, "", new XPoint (738-64+dx, 525+dy),
// [sensorPosList]
						[new XPoint (738-64+dx, 525+dy)],
// beePos, beeDirection 1
						new XPoint (184+dx, 525+dy), 1.0,
// beePos, beeDirection 2
						new XPoint (829, 525), -1.0,
					],
				],
				
			// proximity sensors
				[
				],
			];
		}
		
//------------------------------------------------------------------------------------------
		public function Practice_Planning_Script ():Void {
			var __planModel:PlanModelX;
			var __nextPlanModel:PlanModelX;
			var __currIndex:Int;
			var i:Int;
			var s:Array<Dynamic>; // <Dynamic>

			//------------------------------------------------------------------------------------------			
			function __waitForSelect ():Array<Dynamic> { // <Dynamic>
				return [
					function ():Void {
						__planModel = null;
					},
					
					XTask.LABEL, "loop",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XTask):Void {
						__task.ifTrue (__planModel != null);
					},
					
					XTask.BNE, "loop",
					
					XTask.RETN,
				];
			}
			
			//------------------------------------------------------------------------------------------			
			function __selected (args:Dynamic /* */ /* Dynamic */):Void {
				__planModel = cast args; /* as PlanModelX */
				
				trace (": selected: ", __planModel, __planModel.type);
			}
			
			//------------------------------------------------------------------------------------------			
			function __selectedPlan (args:Dynamic /* */ /* Dynamic */):Void {
				__planModel = cast args; /* as PlanModelX */
				
				var i:Int;
				
				for (i in __planModel.index+1 ... m_plans.length) {
					var __planModel2:PlanModelX = m_plans[i];
					
					if (__planModel.type == __planModel2.type &&
						__planModel.logicObject.oX == __planModel2.logicObject.oX &&
						__planModel.logicObject.oY == __planModel2.logicObject.oY
					) {
						trace (": ***: ");
						
						var __logicObject:XLogicObject = __planModel.logicObject;
						
						addTask ([
							XTask.WAIT, 0x0800,
							
							function ():Void {
								__logicObject.setVisible (false);		
							},
							
							XTask.RETN,
						]);
						
						addTask ([
							XTask.WAIT, 0x1800,
							
							function ():Void {							
								__planModel2.logicObject.setVisible (true);
							},
							
							XTask.RETN,
						]);
						
						return;
					}
				}
				
				trace (": selectedPlan: ", __planModel, __planModel.type);
			}
			
			//------------------------------------------------------------------------------------------			
			function __planningCorrect ():Void {
				var s:Array<Dynamic>; // <Dynamic>
				var __type:Int = __planModel.type;
				var __soundDone:Bool = false;
				
				function __whatsNextX (__last:Bool = false):Array<Dynamic> { // <Dynamic>
					if (!__last) {
						return [
							function ():Void {
								xm.replaceAllSoundTasks ([
									XTask.FUNC, function (__task:XSoundTask):Void {
										var s:Array<Dynamic> /* <Dynamic> */ = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_WhatsNext());
										__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
									},  XTask.EXEC, waitForSoundFinishedX (),
									
									XTask.WAIT1000, m_standardVoiceDelay,
									
									function ():Void {
										G.app.setSoundPlaying (false);
									},
									
									XTask.RETN,
									]);
							},
							
							XTask.RETN,
						];
					}
					else
					{
						return [
							function ():Void {
								G.app.setSoundPlaying (false);
							},
									
							XTask.RETN,
						];
					}
				}
					
				G.app.setSoundPlaying (true);
				
				xm.replaceAllSoundTasks ([
					XTask.FUNC, function (__task:XSoundTask):Void {
						s = G.app.getSoundFromGroup (__type, G.app.Plan_SFX_PickedRightStep());
						__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
					},  XTask.EXEC, waitForSoundFinishedX (),
					
					XTask.WAIT1000, m_standardVoiceDelay,
					
					XTask.FUNC, function (__task:XSoundTask):Void {
						s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_GoodJob());
						__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
					},  XTask.EXEC, waitForSoundFinishedX (),
					
					XTask.WAIT1000, m_standardVoiceDelay,
					
					function ():Void {
						m_planningStage += 1;
					},
					
					XTask.FLAGS, function (__task:XSoundTask):Void {
						__task.ifTrue (__currIndex == getPlans ().length);
					},
					
					XTask.BEQ, "last",
					
					//					XTask.EXEC, __whatsNextX (false), XTask.GOTO, "cont",
					
					XTask.LABEL, "last", XTask.EXEC, __whatsNextX (true),
					
					XTask.LABEL, "cont",
					
					function ():Void {
						__soundDone = true;
					},
					
					XTask.RETN,
				]);		
				
				__planModel.iconObject = G.app.getPlanTray ().addGoalType (__planModel.type);
				
				var __logicObject:FarXObstacle = __planModel.logicObject;							
				__logicObject.getCursorHighlightObject ().setExplodeAway ();
				
				addCompletedStep ();
				
				addTask ([
					XTask.WAIT, 0x0800,
					
					function ():Void {
						__logicObject.oAlpha = 0.25;
					},
					
					XTask.RETN,
				]);
				
				trace (": ", __currIndex, getPlans ().length);
				
				__currIndex++;
				
				if (__currIndex < getPlans ().length) {								
					__nextPlanModel = getPlans ()[__currIndex];
					
					G.app.getBee ().setPos (__nextPlanModel.beePos);
					G.app.getBee ().oScaleX = __nextPlanModel.beeDirection;
				}
				else
				{
					for (i in 0 ... getPlans ().length) {
						//						getPlans ()[i].logicObject.removeSelectedListener (__selected);
						getPlans ()[i].logicObject.removeSelectedListener (__selectedPlan);
					}
					
					//					G.app.getScoreAndOptions ().addToScore (1);
					
					addTask ([
						XTask.LABEL, "__wait",
						
						XTask.WAIT, 0x0100,
						
						XTask.FLAGS, function (__task:XTask):Void {
							__task.ifTrue (__soundDone);
						}, XTask.BNE, "__wait",
						
						function ():Void {
							m_planningStage++;
							
							//							Level_Playing_Script ();
						},
						
						XTask.RETN,
					]);
				}
			}		
				
			//------------------------------------------------------------------------------------------
			function __planningIncorrect ():Void {
						var s:Array<Dynamic>; // <Dynamic>
						var __rightModel:PlanModelX = getPlans()[__currIndex];	
						__rightModel.incorrectGuesses++;
						
						__planModel.logicObject.buzzWrong ();
						
						if (__rightModel.incorrectGuesses == 3) {
							xm.replaceAllSoundTasks ([
								XTask.WAIT, 0x1000,
								
								XTask.FUNC, function (__task:XSoundTask):Void {
									s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_3Errors());
									__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
									
									__rightModel.logicObject.setHint (true);
									
									G.app.setSoundPlaying (true);
								},  XTask.EXEC, waitForSoundFinishedX (),
								
								XTask.WAIT1000, m_standardVoiceDelay,
								
								function ():Void {
									G.app.setSoundPlaying (false);
								},
								
								XTask.RETN,
							]);
						}							
						else if (__rightModel.incorrectGuesses > 3) {
							xm.replaceAllSoundTasks ([
								XTask.WAIT, 0x1000,
								
								XTask.FUNC, function (__task:XSoundTask):Void {
									s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_StillWrong());
									__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
									
									__rightModel.logicObject.setHint (true);
									
									G.app.setSoundPlaying (true);
								},  XTask.EXEC, waitForSoundFinishedX (),
								
								XTask.WAIT1000, m_standardVoiceDelay,
								
								function ():Void {
									G.app.setSoundPlaying (false);
								},
								
								XTask.RETN,
							]);
						}
						else
						{
							xm.replaceAllSoundTasks ([
								XTask.WAIT, 0x1000,
								
								XTask.FUNC, function (__task:XSoundTask):Void {
									s = G.app.getRandomSoundFromGroup (G.app.Plan_SFX_1Error());
									__task.replaceSound (s[0], soundFinished); G.app.setMessage (s[1]);
									
									G.app.setSoundPlaying (true);
								},  XTask.EXEC, waitForSoundFinishedX (),
								
								XTask.WAIT1000, m_standardVoiceDelay,
								
								function ():Void {
									G.app.setSoundPlaying (false);
								},
								
								XTask.RETN,
							]);		
						}
			}
					
//------------------------------------------------------------------------------------------
			G.setGameMode (G.GAMEMODE_PLANNING);
			
			G.app.setMessage ("");
			
//			G.app.getProgressBar ().addStageType (FAR.STAGE_PLAN);

			m_completedSteps = 0;
			m_totalSteps = countGoalSteps ();
			G.app.getScoreAndOptions ().setScore (G.app.getCumalativeScore ());
			G.app.getProgressBar ().setProgress (0);
			G.app.getPlanTray ().removeAllGoals ();
			
			m_pointyArrowObject.point (224, 224, 335, 12);
			
//			doLevelPlanningSFX ();
				
//------------------------------------------------------------------------------------------			
			for (i in 0 ... getPlans ().length) {
//				getPlans ()[i].logicObject.addSelectedListener (__selected);
				getPlans ()[i].logicObject.addSelectedListener (__selectedPlan);
			}

//------------------------------------------------------------------------------------------
			trace (": m_offPlans: ", m_offPlans.length);
						
			for (i in 0 ... getOffPlans ().length) {
				getOffPlans ()[i].logicObject.addSelectedListener (__selected);
			}
			
//------------------------------------------------------------------------------------------				
			script.gotoTask ([
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
					__currIndex = 0;
					
					addTask ([
						XTask.WAIT, 0x2000,
						
						function ():Void {
							getPlans ()[__currIndex].logicObject.setHighlighted (true);
						},
						
						XTask.RETN,
					]);
				},
					
				XTask.LABEL, "loop",
					XTask.EXEC, __waitForSelect (),
				
					function ():Void {
						trace (": selected >>>: ", __currIndex, __planModel.type, __planModel.index);
					},
									
					XTask.FLAGS, function (__task:XTask):Void {
						if (__currIndex == __planModel.index) {		
							__planningCorrect ();
						}
						else
						{
							__planningIncorrect ();
						}
					},
					
					XTask.GOTO, "loop",
					
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
					m_samplePlanObject.flashPlan ();
					m_pointyArrowObject.show ();
					m_pointyArrowObject.point (256, 256, 335, 12);
					__task.replaceSound (XAssets.LetsFocusAndPlan () , soundFinished);
					G.app.setMessage ("Let's Focus And Plan");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
				
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.GetTheKeyOpenTheDoor () , soundFinished);
					G.app.setMessage ("Get The Key and Open the Door");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
				
				XTask.FUNC, function (__task:XSoundTask):Void {
					__task.replaceSound (XAssets.EachStepInThePlanHasAStar () , soundFinished);
					G.app.setMessage ("Each Step in the Plan has a Star");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,

				XTask.FUNC, function (__task:XSoundTask):Void {
					m_samplePlanObject.hidePlan ();
					m_pointyArrowObject.show ();
					m_pointyArrowObject.point (512, 420, 160, 12);
					__task.replaceSound (XAssets.AddThisStepToThePlan () , soundFinished);
					G.app.setMessage ("Add this Step to the Plan");
				}, XTask.EXEC, waitForSoundFinishedX (),

				function ():Void {
					G.app.allowGameMouseEvents ();	
				},
				
				XTask.LABEL, "loop1",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XSoundTask):Void {	
						__task.ifTrue (m_planningStage == 1);
					}, XTask.BEQ, "loop1",
					
				XTask.FUNC, function (__task:XSoundTask):Void {
					m_pointyArrowObject.show ();
					m_pointyArrowObject.point (712, 420, 160, 12);
					__task.replaceSound (XAssets.AddTheNextStepToThePlan () , soundFinished);
					G.app.setMessage ("Add the Next Step to the Plan");
				}, XTask.EXEC, waitForSoundFinishedX (),

				XTask.WAIT1000, m_standardVoiceDelay,
								
				XTask.LABEL, "loop2",
					XTask.WAIT, 0x0100,
					
					XTask.FLAGS, function (__task:XSoundTask):Void {	
						__task.ifTrue (m_planningStage == 2);
					}, XTask.BEQ, "loop2",
					
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
		public function createSamplePlan ():Void {	
			m_samplePlanObject = cast xxx.getXLogicManager ().initXLogicObject (
				// parent
					self,
				// logicObject
					new SamplePlanX () /* as XLogicObject */,
				// item, layer, depth
					null, 0, 12500,
				// x, y, z
					104, 120, 0,
				// scale, rotation
					1.0, 0
				) /* as SamplePlanX */;
				
			addXLogicObject (m_samplePlanObject);					
		}
								
//------------------------------------------------------------------------------------------
	}

//------------------------------------------------------------------------------------------
// }
