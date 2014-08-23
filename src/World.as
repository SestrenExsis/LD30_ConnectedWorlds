package
{
	import org.flixel.*;
		
	public class World extends Entity
	{
		public var galaxy:Galaxy;
		public var queue:int;
		
		public function World(GalaxyInstance:Galaxy, Size:int = 3, Queue:int = 0)
		{
			super(FlxG.mouse.x, FlxG.mouse.y, Size, Size);
			
			galaxy = GalaxyInstance;
			queue = Queue;
			randomWorld(Size);
		}
		
		private function placeInGalaxy(StartX:int, StartY:int, CommitChange:Boolean = false):void
		{
			var _endX:int = StartX + widthInTiles;
			var _endY:int = StartY + heightInTiles;
			if (StartX < 0 || StartY < 0 || _endX > galaxy.widthInTiles || _endY > galaxy.heightInTiles)
				return;
			
			var worldTile:Tile;
			var galaxyTile:Tile;
			var x:int;
			var y:int;
			for (y = 0; y < widthInTiles; y++)
			{
				for (x = 0; x < heightInTiles; x++)
				{
					worldTile = getTileAt(x, y);
					if (worldTile.type > Tile.NONE)
					{
						galaxyTile = galaxy.getTileAt(x + StartX, y + StartY);
						if (galaxyTile.type > Tile.NONE)
							worldTile.targetElevation = Tile.SPACER_HEIGHT;
						else
							worldTile.targetElevation = 0;
						worldTile.combineTiles(galaxyTile, CommitChange);
					}
				}
			}
			if (CommitChange)
			{
				FlxG.shake(0.005, 0.125);
				randomWorld();
			}
		}
		
		override public function update():void
		{	
			var _width:Number = Tile.TILE_WIDTH + 2 * Tile.SPACER_WIDTH;
			var _height:Number = Tile.TILE_HEIGHT + 2 * Tile.SPACER_WIDTH;
			
			var _cornerX:Number = FlxG.mouse.x - 0.5 * (widthInTiles * _width);
			var _cornerY:Number = FlxG.mouse.y - 0.5 * (heightInTiles * _height);
			var _gridOffsetX:int = Math.floor((_cornerX - galaxy.posX) / _width);
			var _gridOffsetY:int = Math.floor((_cornerY - galaxy.posY) / _height);
			posX = _gridOffsetX * _width + galaxy.posX + 1;
			posY = _gridOffsetY * _height + galaxy.posY - 1;
			
			super.update();
			
			placeInGalaxy(_gridOffsetX, _gridOffsetY, FlxG.mouse.justPressed());
		}
		
		override public function draw():void
		{	
			super.draw();
		}
	}
}