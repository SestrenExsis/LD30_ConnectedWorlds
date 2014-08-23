package
{
	import org.flixel.*;
		
	public class Entity extends FlxGroup
	{
		//public static const PLANET_EARTH:Array = [WATER, FOLIAGE, FOLIAGE, FOLIAGE, WATER, FOLIAGE, WATER, WATER, WATER];
		
		public var posX:Number;
		public var posY:Number;
		public var widthInTiles:int;
		public var heightInTiles:int;
		
		public function Entity(PosX:Number, PosY:Number, WidthInTiles:int = 1, HeightInTiles:int = 1)
		{
			super();
			posX = PosX;
			posY = PosY;
			widthInTiles = WidthInTiles;
			heightInTiles = HeightInTiles;
			
			var i:int;
			for (var y:int = 0; y < heightInTiles; y++)
			{
				for (var x:int = 0; x < widthInTiles; x++)
				{
					i = y * widthInTiles + x;
					add(new Tile(this, x, y));
				}
			}
		}
		
		public function getTileAt(TileX:int, TileY:int):Tile
		{
			var i:int = TileY * widthInTiles + TileX;
			return members[i];
		}
		
		public function emptyGrid():void
		{
			for (var i:int = 0; i < widthInTiles * heightInTiles; i++)
			{
				members[i].type = Tile.NONE;
			}
		}
		
		public function randomWorld(Size:int = -1):void
		{
			if (Size > 0)
				widthInTiles = Size;
			else
				Size = widthInTiles;
			if (Size > 0)
				heightInTiles = Size;
			
			var _cornerClipping:int = 0;
			if (Size == 4 || Size == 5)
				_cornerClipping = 1;
			else if (Size == 6 || Size == 7 || Size == 8)
				_cornerClipping = 2;
			else
				_cornerClipping = 0;
			
			members = new Array(widthInTiles * heightInTiles);
			
			var i:int;
			for (var y:int = 0; y < heightInTiles; y++)
			{
				for (var x:int = 0; x < widthInTiles; x++)
				{
					i = y * widthInTiles + x;
					members[i] = new Tile(this, x, y);
					if (manhattanDistance(x, y, widthInTiles, heightInTiles) < _cornerClipping)
						members[i].type = Tile.NONE;
					else
						members[i].randomizeType();
				}
			}
		}
		
		public function manhattanDistance(TileX:int, TileY:int, Width:int, Height:int):int
		{
			var _cornerX:int = 0;
			var _cornerY:int = 0;
			var _smallestDistance:int = (TileX - _cornerX) + (TileY - _cornerY);
			
			_cornerX = Width - 1;
			var _distance:int = (_cornerX - TileX) + (TileY - _cornerY);
			if (_distance < _smallestDistance)
				_smallestDistance = _distance;
			
			_cornerY = Height - 1;
			_distance = (_cornerX - TileX) + (_cornerY - TileY);
			if (_distance < _smallestDistance)
				_smallestDistance = _distance;
			
			_cornerX = 0;
			_distance = (TileX - _cornerX) + (_cornerY - TileY);
			if (_distance < _smallestDistance)
				_smallestDistance = _distance;
			
			return _smallestDistance;
		}
		
		override public function update():void
		{	
			super.update();
		}
		
		override public function draw():void
		{	
			super.draw();
		}
	}
}