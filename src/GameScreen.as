package
{
	import org.flixel.*;
		
	public class GameScreen extends ScreenState
	{
		[Embed(source="../assets/images/Interface.png")] public var imgInterface:Class;
		
		private var gameInterface:FlxSprite;
		private var galaxy:Galaxy;
		private var world:World;
		private var next:World;
		
		public function GameScreen()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			gameInterface = new FlxSprite(0, 0);
			gameInterface.loadGraphic(imgInterface);
			add(gameInterface);
			
			World.queue = 0;
			
			galaxy = new Galaxy(12, 12, 6)
			add(galaxy);
			
			next = new World(galaxy, 4, null);
			add(next);
			
			world = new World(galaxy, 4, next);
			add(world);
		}
		
		override public function update():void
		{	
			super.update();
		}
	}
}