package
{
	import org.flixel.*;
		
	public class World extends Entity
	{
		public function World(Width:int = 3, Height:int = 3)
		{
			super(FlxG.mouse.x, FlxG.mouse.y);
			
			randomizeColors(Width, Height);
		}
		
		override public function update():void
		{	
			super.update();
			
			posX = FlxG.mouse.x;
			posY = FlxG.mouse.y;
		}
		
		override public function draw():void
		{	
			super.draw();
		}
	}
}