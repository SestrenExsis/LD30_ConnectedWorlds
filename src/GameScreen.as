package
{
	import org.flixel.*;
		
	public class GameScreen extends ScreenState
	{
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