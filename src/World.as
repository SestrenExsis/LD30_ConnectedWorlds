package
{
	import org.flixel.*;
		
	public class World extends Entity
	{
		public var galaxy:Galaxy;
		
		public function World(GalaxyInstance:Galaxy, Size:int = 3)
		{
			super(FlxG.mouse.x, FlxG.mouse.y);
			
			galaxy = GalaxyInstance;
			
			randomWorld(Size);
		}
		
		private function placeInGalaxy(StartX:int, StartY:int):void
		{
			var _endX:int = StartX + widthInTiles;
			var _endY:int = StartY + heightInTiles;
			if (StartX < 0 || StartY < 0 || _endX > galaxy.widthInTiles || _endY > galaxy.heightInTiles)
			{
				FlxG.log("Out of bounds");
				return;
			}
			var worldIndex:int;
			var galaxyIndex:int;
			for (var y:int = 0; y < widthInTiles; y++)
			{
				for (var x:int = 0; x < heightInTiles; x++)
				{
					worldIndex = y * widthInTiles + x;
					if (grid[worldIndex] > NONE)
					{
						galaxyIndex = (y + StartY) * galaxy.widthInTiles + (x + StartX);
						galaxy.grid[galaxyIndex] = grid[worldIndex];
					}
				}
			}
			
			randomWorld();
		}
		
		override public function update():void
		{	
			super.update();
			
			var _width:Number = tileWidth + spacerWidth;
			var _height:Number = tileHeight + spacerHeight;
			
			var _cornerX:Number = FlxG.mouse.x - 0.5 * (widthInTiles * _width);
			var _cornerY:Number = FlxG.mouse.y - 0.5 * (heightInTiles * _height);
			var _gridOffsetX:int = Math.floor((_cornerX - galaxy.posX) / _width);
			var _gridOffsetY:int = Math.floor((_cornerY - galaxy.posY) / _height);
			posX = _gridOffsetX * _width + galaxy.posX + 1;
			posY = _gridOffsetY * _height + galaxy.posY - 1;
			
			if (FlxG.mouse.justPressed())
				placeInGalaxy(_gridOffsetX, _gridOffsetY);
		}
		
		override public function draw():void
		{	
			super.draw();
		}
	}
}