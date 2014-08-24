package
{
	import com.increpare.bfxr.*;
	
	public class SoundBank
	{
		private var _bfxr:Bfxr;
		private var bfxrSoundBank:Array;
		private var sounds:Array = [
			"2,0.5,,0.2816,0.0001,0.2097,0.3,0.4823,0.075,-0.5666,,,,,,,,,,,0.8114,-0.1627,,0.1125,-0.1753,1,,,0.2967,,,,masterVolume",
			"2.0016,0.5,0.04,0.3151,0.0001,0.1743,0.3,0.535,0.0524,-0.5313,0.0224,,,0.0337,0.0065,0.0255,,,0.0079,0.0246,0.8114,-0.1584,,0.1173,-0.1934,1,0.0397,0.0486,0.2967,0.0296,0.0103,0.0241,masterVolume",
			"2,0.5,0.04,0.3027,0.0001,0.2097,0.3,0.4934,0.0656,-0.5313,0.0224,,,0.0337,,,,,0.0222,,0.8114,-0.1627,,0.1062,-0.1753,1,0.0397,,0.2967,,,,masterVolume",
			"1.9676,0.5,0.0525,0.3027,0.0001,0.2298,0.309,0.5169,0.1144,-0.5313,0.0523,,,0.0337,,,,,0.0226,,0.8231,-0.1273,,0.1062,-0.1753,1,0.0896,,0.2467,0.0138,0.0132,0.0471,masterVolume",
			",0.5,,0.1278,,0.0614,0.3,0.2582,,,,,,,,,,,,,0.552,,,,,1,,,0.1,,,,masterVolume",
			",0.5,,0.1188,,0.1093,0.3167,0.2582,,0.0219,,,,,,,,,0.0167,,0.552,0.0399,,,,1,0.047,,0.1,0.0255,,,masterVolume",
			",0.5,0.0002,0.1385,,0.0579,0.3136,0.2754,0.0246,0.0279,-0.0277,,,0.015,0.072,,0.0488,,-0.0283,0.0693,0.5225,0.0338,0.039,-0.0289,-0.0007,1,0.0322,0.0408,0.1,0.0397,0.0061,0.0116,masterVolume",
			"3,0.5,,0.154,0.4909,0.4118,0.3,0.014,,,,,,,,,,,,,,,,0.401,-0.217,1,,,,,,,masterVolume",
			"3,0.5,,0.2793,0.3777,0.0797,0.3,0.0406,,0.1564,,,,,,,,,,,,,,0.1323,-0.0488,1,,,,,,,masterVolume",
			"3.0057,0.5,0.0362,0.2793,0.3777,0.1025,0.3,0.0406,,0.1564,,,0.0363,,,,,,,0.0055,,,0.0497,0.1323,-0.0488,0.9965,,,0.0183,-0.0456,0.0466,0.0088,masterVolume",
			",0.5,,0.0476,,0.2549,0.3,0.378,,-0.3393,,,,,,,,,,,0.2282,,,,,1,,,,,,,masterVolume",
			",0.5,,0.0316,,0.2549,0.3452,0.378,,-0.3393,0.0262,,,,0.0457,0.0196,-0.0346,,,0.0065,0.2114,,0.0468,,0.0179,0.9503,,,,,,,masterVolume"];
		
		public function SoundBank()
		{
			create();
		}
		
		public function create():void
		{
			bfxrSoundBank = new Array();
			for (var i:int = 0; i < sounds.length; i++)
			{
				_bfxr = new Bfxr();
				_bfxr.Load(sounds[i]);
				_bfxr.Cache();
				bfxrSoundBank.push(_bfxr);
			}
		}
		
		public function playSound(SoundIndex:int):void
		{
			bfxrSoundBank[SoundIndex].Play(0.5);
		}
	}
}