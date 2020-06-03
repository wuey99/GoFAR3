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
	import kx.pool.*;
	import kx.sound.*;
	import kx.task.*;
	import kx.type.*;
	
	//------------------------------------------------------------------------------------------
	class XSoundTask extends XTask {
		private var m_XSoundTaskSubManager:XSoundTaskSubManager;
		
		//------------------------------------------------------------------------------------------
		public function new () {
			super ();
		}
		
		//------------------------------------------------------------------------------------------
		public override function createXTaskSubManager ():XTaskSubManager {
			m_XSoundTaskSubManager = new XSoundTaskSubManager (null, new XOldSoundManager (G.xApp));
			
			return super.createXTaskSubManager ();
		}

		//------------------------------------------------------------------------------------------
		public function setSoundManager (__soundManager:XOldSoundManager):Void {
			m_XSoundTaskSubManager.setSoundManager (__soundManager);
		}
		
		//------------------------------------------------------------------------------------------
		public override function kill ():Void {
			m_XSoundTaskSubManager.removeAllSounds ();
			
			removeAllTasks ();
		}	
		
		//------------------------------------------------------------------------------------------
		public function replaceSound (
			__sound:Sound,
			__completeListener:Dynamic /* Function */ = null
		):Int {
			
			return m_XSoundTaskSubManager.replaceSound (__sound, __completeListener);
		}
		
		//------------------------------------------------------------------------------------------
		public function playSound (
			__sound:Sound,
			__completeListener:Dynamic /* Function */ = null
		):Int {
			
			return m_XSoundTaskSubManager.playSound (__sound, __completeListener);
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
			m_XSoundTaskSubManager.stopSound (__guid);
		}
		
		//------------------------------------------------------------------------------------------
		public function removeSound (__guid:Int):Void {
			m_XSoundTaskSubManager.removeSound (__guid);
		}
		
		//------------------------------------------------------------------------------------------
		public function removeAllSounds ():Void {
			m_XSoundTaskSubManager.removeAllSounds ();
		}
		
		//------------------------------------------------------------------------------------------
	}
	
	//------------------------------------------------------------------------------------------
// }