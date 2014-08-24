package
{
	import org.flixel.*;
		
	public class Entity extends FlxGroup
	{
		//public static const PLANET_EARTH:Array = [WATER, FOLIAGE, FOLIAGE, FOLIAGE, WATER, FOLIAGE, WATER, WATER, WATER];
		
		public var posX:Number;
		public var posY:Number;
		public var repositionTiles:Boolean;
		public var widthInTiles:int;
		public var heightInTiles:int;
		public var harvest:Boolean;
		public var tileCounts:Array;
		
		public function Entity(PosX:Number, PosY:Number, WidthInTiles:int = 1, HeightInTiles:int = 1)
		{
			super();
			posX = PosX;
			posY = PosY;
			widthInTiles = WidthInTiles;
			heightInTiles = HeightInTiles;
			repositionTiles = false;
			tileCounts = new Array(Tile.NUM_OF_TYPES);
			
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
			if (TileX < 0 || TileY < 0 || TileX >= widthInTiles || TileY >= heightInTiles)
				return null;
			
			var i:int = TileY * widthInTiles + TileX;
			return members[i];
		}
		
		public function emptyGrid():void
		{
			var _cornerClipping:int = 0;
			if (widthInTiles == 4 || widthInTiles == 5)
				_cornerClipping = 1;
			else if (widthInTiles == 6 || widthInTiles == 7 || widthInTiles == 8)
				_cornerClipping = 2;
			else
				_cornerClipping = 0;
			
			var i:int;
			for (var y:int = 0; y < heightInTiles; y++)
			{
				for (var x:int = 0; x < widthInTiles; x++)
				{
					i = y * widthInTiles + x;
					members[i].type = Tile.NONE;
					if (manhattanDistance(x, y, widthInTiles, heightInTiles) < _cornerClipping)
						members[i].visible = false;
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