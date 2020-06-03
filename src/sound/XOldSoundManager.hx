//------------------------------------------------------------------------------------------
package sound;
	
	import openfl.events.Event;
	import openfl.media.*;
	import openfl.utils.*;
	
	import kx.XApp;
	import kx.collections.*;
	import kx.task.*;
	import kx.type.*;
	
	//------------------------------------------------------------------------------------------	
	class XOldSoundManager {
		public var m_XApp:XApp;
		public var m_soundChannels:Map<Int, SoundChannel>;  // <Int, SoundChannel>
		private static var g_GUID:Int = 0;
		
		//------------------------------------------------------------------------------------------
		public function new (__XApp:XApp) {
			m_XApp = __XApp;
			
			m_soundChannels = new Map<Int, SoundChannel> (); // <Int, SoundChannel>
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
			
			var __soundChannel:SoundChannel = __sound.play ();
			var __guid:Int = g_GUID++;
			m_soundChannels.set (__guid, __soundChannel);
			
			__soundChannel.addEventListener (
				Event.SOUND_COMPLETE,
				
				function (e:Event):Void {
					if (__completeListener != null) {
						__completeListener ();
					}
					
					if (m_soundChannels.exists (__guid)) {
						m_soundChannels.remove (__guid);
					}
				}
			);
			
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
				var __soundChannel:SoundChannel = m_soundChannels.get (__guid);
				__soundChannel.stop ();
				
				m_soundChannels.remove (__guid);
			}
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
		public function getSoundChannel (__guid:Int):SoundChannel {
			if (m_soundChannels.exists (__guid)) {
				return m_soundChannels.get (__guid);
			}
			else
			{
				return null;
			}
		}	
		
		//------------------------------------------------------------------------------------------
	}
	
	//------------------------------------------------------------------------------------------
// }
