//------------------------------------------------------------------------------------------
// <$begin$/>
// The MIT License (MIT)
//
// The "X-Engine"
//
// Copyright (c) 2014 Jimmy Huey (wuey99@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
// <$end$/>
//------------------------------------------------------------------------------------------
package sound;

	import openfl.media.*;
	import openfl.system.*;
	import openfl.utils.*;
	
	import kx.*;
	import kx.collections.*;
	import kx.sound.*;
	import kx.task.*;
	import kx.type.*;
	import kx.world.logic.*;
	
	//------------------------------------------------------------------------------------------	
	class XSoundTaskSubManager extends XTaskSubManager {
		public var m_soundManager:XOldSoundManager;
		public var m_soundChannels:Map<Int, Int>; // <Int, Int>
		
		//------------------------------------------------------------------------------------------
		public function new (__manager:XTaskManager, __soundManager:XOldSoundManager) {
			super (__manager);
			
			m_soundManager = __soundManager;
			
			m_soundChannels = new Map<Int, Int> (); // <Int, Int>
		}
		
		//------------------------------------------------------------------------------------------
		public override function cleanup ():Void {
			super.cleanup ();
			
			removeAllSounds ();
		}
		
		//------------------------------------------------------------------------------------------
		public function setSoundManager (__soundManager:XOldSoundManager):Void {
			m_soundManager = __soundManager;
		}
		
		//------------------------------------------------------------------------------------------
		public function replaceSound (
			__sound:Sound,
			__completeListener:Dynamic /* Function */ = null
		):Int {
			
			removeAllSounds ();
			
			return playSound (__sound, __completeListener);
		}
		
		//------------------------------------------------------------------------------------------
		public function playSound (
			__sound:Sound,
			__completeListener:Dynamic /* Function */ = null
		):Int {
			
			var __guid:Int;
			
			function __complete ():Void {
				if (__completeListener != null) {
					__completeListener ();
				}
				
				m_soundChannels.remove (__guid);
			}
			
			__guid = m_soundManager.playSound (__sound, __complete);
			
			m_soundChannels.set (__guid, 0);
			
			return __guid;
		}
		
		//------------------------------------------------------------------------------------------
		public function playSoundFromClassName (
			__className:String,
			__completeListener:Dynamic /* Function */ = null
		):Int {
			
			return 0;
		}
		
		//------------------------------------------------------------------------------------------
		public function stopSound (__guid:Int):Void {
			removeSound (__guid);
		}
		
		//------------------------------------------------------------------------------------------
		public function removeSound (__guid:Int):Void {
			if (m_soundChannels.exists (__guid)) {
				m_soundChannels.remove (__guid);
			}
			
			m_soundManager.removeSound (__guid);
		}
		
		//------------------------------------------------------------------------------------------
		public function removeAllSounds ():Void {
			XType.forEach (m_soundChannels, 
				function (__guid:Dynamic /* */):Void {
					removeSound (cast __guid);
				}
			);
		}
		
		//------------------------------------------------------------------------------------------
		public override function addTask (
			__taskList:Array<Dynamic>, // <Dynamic>
			__findLabelsFlag:Bool = true
		):XTask {
			
			// var __task:XSoundTask = addXTask (new XSoundTask (__taskList, __findLabelsFlag)) as XSoundTask;
			
			// var __task:XSoundTask = m_manager.addTask (__taskList, __findLabelsFlag) as XSoundTask;
			
			var __task:XSoundTask = cast super.addTask (__taskList, __findLabelsFlag); /* as XSoundTask */
			
			__task.setSoundManager (m_soundManager);
			
			return __task;
		}
		
		//------------------------------------------------------------------------------------------
		public function replaceAllSoundTasks (
			__taskList:Array<Dynamic>, // <Dynamic>
			__findLabelsFlag:Bool = true
		):XTask {
			
			removeAllTasks ();
			
			return addSoundTask (__taskList, __findLabelsFlag);
		}
		
		//------------------------------------------------------------------------------------------
		public function addSoundTask (
			__taskList:Array<Dynamic>, /* <Dynamic> */
			__findLabelsFlag:Bool = true
		):XTask {
			
			// var __task:XSoundTask = addXTask (new XSoundTask (__taskList, __findLabelsFlag)) as XSoundTask;
			
			// var __task:XSoundTask = m_manager.addTask (__taskList, __findLabelsFlag) as XSoundTask;
			
			var __task:XSoundTask = cast addTask (__taskList, __findLabelsFlag); /* as XSoundTask */
			
			__task.setSoundManager (m_soundManager);
			
			return __task;
		}
		
		//------------------------------------------------------------------------------------------
		public override function changeTask (
			__oldTask:XTask,
			__taskList:Array<Dynamic>, // <Dynamic>
			__findLabelsFlag:Bool = true
		):XTask {
			
			// var __task:XSoundTask = changeXTask (__oldTask, new XSoundTask (__taskList, __findLabelsFlag)) as XSoundTask;
			
			// var __task:XSoundTask = m_manager.addTask (__taskList, __findLabelsFlag) as XSoundTask;
			
			var __task:XSoundTask = cast addTask (__taskList, __findLabelsFlag); /* as XSoundTask */
			
			__task.setSoundManager (m_soundManager);
			
			return __task;
		}
		
		//------------------------------------------------------------------------------------------
	}
	
	//------------------------------------------------------------------------------------------
// }