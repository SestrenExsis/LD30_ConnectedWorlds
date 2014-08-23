package
{
	import org.flixel.FlxGame;
	[SWF(width="640", height="640", backgroundColor="#888888")]
	
	public class LD30_ConnectedWorlds extends FlxGame
	{
		public function LD30_ConnectedWorlds()
		{
			super(320, 320, GameScreen, 2.0, 60, 60, true);
			forceDebugger = true;
		}
	}

}