package
{
	import org.flixel.*;
		
	public class Entity extends FlxSprite
	{
		public static const NONE:int = 0;
		public static const WATER:int = 1;
		public static const MAGMA:int = 2;
		public static const FOLIAGE:int = 3;
		public static const EARTH:int = 4;
		
		public static const colors:Array = [0x00000000, 0xff00ffff, 0xffff0000, 0xff00a651, 0xffffd800];
		public static const PLANET_EARTH:Array = [WATER, FOLIAGE, FOLIAGE, FOLIAGE, WATER, FOLIAGE, WATER, WATER, WATER];
		
		public var tileWidth:int = 16;
		public var tileHeight:int = 16;
		public var spacerWidth:int = 2;
		public var spacerHeight:int = 2;
		
		public var grid:Vector.<int>;
		public var widthInTiles:int;
		public var heightInTiles:int;
		
		public function Entity(X:Number, Y:Number, Width:int = 1, Height:int = 1)
		{
			super(X, Y);
		}
		
		public function emptyColors(Width:int = -1, Height:int = -1):void
		{
			if (Width > 0)
				widthInTiles = Width;
			else
				widthInTiles = 8;
			if (Height > 0)
				heightInTiles = Height;
			else
				heightInTiles = 8;
			
			grid = new Vector.<int>(widthInTiles * heightInTiles);
			for (var i:int = 0; i < grid.length; i++)
			{
				grid[i] = NONE;
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
			
			grid = new Vector.<int>(widthInTiles * heightInTiles);
			
			var i:int;
			for (var y:int = 0; y < heightInTiles; y++)
			{
				for (var x:int = 0; x < widthInTiles; x++)
				{
					i = y * widthInTiles + x;
					if (manhattanDistance(x, y) < _cornerClipping)// > 0)
						grid[i] = NONE;
					else
						grid[i] = Math.ceil(FlxG.random() * (colors.length - 1)); //to avoid index 0, which is reserved for NONE
				}
			}
		}
		
		public function manhattanDistance(TileX:int, TileY:int):int
		{
			var _cornerX:int = 0;
			var _cornerY:int = 0;
			var _smallestDistance:int = (TileX - _cornerX) + (TileY - _cornerY);
			
			_cornerX = widthInTiles - 1;
			var _distance:int = (_cornerX - TileX) + (TileY - _cornerY);
			if (_distance < _smallestDistance)
				_smallestDistance = _distance;
			
			_cornerY = heightInTiles - 1;
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
			if (FlxG.debug)
				drawDebug();
			
			var i:int;
			var _gridColor:uint;
			_flashRect.width = tileWidth;
			_flashRect.height = tileHeight;
			
			var _width:int = tileWidth + spacerWidth;
			var _height:int = tileHeight + spacerHeight;
			for (var y:int = 0; y < heightInTiles; y++)
			{
				for (var x:int = 0; x < widthInTiles; x++)
				{
					i = y * widthInTiles + x;
					if (grid[i] > NONE)
					{
						_gridColor = colors[grid[i]];
						_flashRect.x = posX + _width * x;
						_flashRect.y = posY + _height * y;
						FlxG.camera.buffer.fillRect(_flashRect, _gridColor);
					}
				}
			}
		}
	}
}