package
{
	import org.flixel.*;
		
	public class Galaxy extends Entity
	{
		private var planet:Vector.<Boolean>;
		private var planetSize:int;
		
		public function Galaxy(GalaxyWidth:int = 1, GalaxyHeight:int = 1, PlanetSize:int = 1)
		{
			super(12, 12);
			
			emptyColors(GalaxyWidth, GalaxyHeight);
			planetSize = PlanetSize;
			
			var _cornerClipping:int = 0;
			if (planetSize == 4 || planetSize == 5)
				_cornerClipping = 1;
			else if (planetSize == 6 || planetSize == 7 || planetSize == 8)
				_cornerClipping = 2;
			else
				_cornerClipping = 0;
			
			var _offsetX:int = Math.floor(0.5 * (GalaxyWidth - planetSize));
			var _offsetY:int = Math.floor(0.5 * (GalaxyHeight - planetSize));
			planet = new Vector.<Boolean>(widthInTiles * heightInTiles);
			/*var i:int;
			for (var y:int = 0; y < heightInTiles; y++)
			{
				for (var x:int = 0; x < widthInTiles; x++)
				{
					planet[i] = manhattanDistance(x, y) < _cornerClipping;
				}
			}*/
		}
		
		override public function update():void
		{	
			super.update();
		}
		
		override public function draw():void
		{	
			_flashRect.x = posX - 8;
			_flashRect.y = posY - 8;
			_flashRect.width = (tileWidth + spacerWidth) * widthInTiles + 14;
			_flashRect.height = (tileHeight + spacerHeight) * heightInTiles + 14;
			FlxG.camera.buffer.fillRect(_flashRect, 0xffffffff);
			
			_flashRect.x += 4;
			_flashRect.y += 4;
			_flashRect.width -= 8;
			_flashRect.height -= 8;
			FlxG.camera.buffer.fillRect(_flashRect, 0xff000000);
			
			
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
					if (grid[i] > NONE || planet[i])
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