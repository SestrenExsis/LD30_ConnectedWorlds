package
{
	import org.flixel.*;
		
	public class Entity extends FlxSprite
	{
		public static const NONE:int = 0;
		public static const BLUE:int = 1;
		public static const RED:int = 2;
		public static const GREEN:int = 3;
		public static const YELLOW:int = 4;
		
		public static const colors:Array = [0x00000000, 0xff00ffff, 0xffff0000, 0xff00a651, 0xffffd800];
		public static const EARTH:Array = [BLUE, GREEN, GREEN, GREEN, BLUE, GREEN, BLUE, BLUE, BLUE];
		
		public var blockWidth:int = 16;
		public var blockHeight:int = 16;
		public var spacerWidth:int = 2;
		public var spacerHeight:int = 2;
		
		public var grid:Vector.<int>;
		public var gridWidth:int;
		public var gridHeight:int;
		
		public function Entity(X:Number, Y:Number, Width:int = 1, Height:int = 1)
		{
			super(X, Y);
			
			randomizeColors(Width, Height);
		}
		
		public function emptyBoard(Width:int = -1, Height:int = -1):void
		{
			if (Width > 0)
				gridWidth = Width;
			else
				gridWidth = 8;
			if (Height > 0)
				gridHeight = Height;
			else
				gridHeight = 8;
			
			grid = new Vector.<int>(gridWidth * gridHeight);
			for (var i:int = 0; i < grid.length; i++)
			{
				grid[i] = NONE;
			}
		}
		
		public function randomizeColors(Width:int = -1, Height:int = -1):void
		{
			if (Width > 0)
				gridWidth = Width;
			if (Height > 0)
				gridHeight = Height;
			
			grid = new Vector.<int>(gridWidth * gridHeight);
			for (var i:int = 0; i < grid.length; i++)
			{
				grid[i] = Math.ceil(FlxG.random() * (colors.length - 1)); //to avoid index 0, which is reserved for NONE
			}
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
			_flashRect.width = blockWidth;
			_flashRect.height = blockHeight;
			
			var _width:int = blockWidth + spacerWidth;
			var _height:int = blockHeight + spacerHeight;
			for (var y:int = 0; y < gridHeight; y++)
			{
				for (var x:int = 0; x < gridWidth; x++)
				{
					i = y * gridWidth + x;
					_gridColor = colors[grid[i]];
					_flashRect.x = posX + _width * x;
					_flashRect.y = posY + _height * y;
					FlxG.camera.buffer.fillRect(_flashRect, _gridColor);
				}
			}
		}
	}
}