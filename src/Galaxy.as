package
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
		
	public class Galaxy extends Entity
	{
		private var _flashRect:Rectangle;
		private var _flashPoint:Point;
		
		public function Galaxy(GalaxyWidth:int = 1, GalaxyHeight:int = 1, PlanetSize:int = 1)
		{
			super(12, 12, GalaxyWidth, GalaxyHeight);
			
			_flashRect = new Rectangle();
			_flashPoint = new Point();
			emptyGrid();
		}
		
		override public function update():void
		{	
			super.update();
		}
		
		override public function draw():void
		{	
			_flashRect.x = posX - 8;
			_flashRect.y = posY - 8;
			_flashRect.width = (Tile.TILE_WIDTH + 2 * Tile.SPACER_WIDTH) * widthInTiles + 14;
			_flashRect.height = (Tile.TILE_HEIGHT + 2 * Tile.SPACER_HEIGHT) * heightInTiles + 14;
			FlxG.camera.buffer.fillRect(_flashRect, 0xffffffff);
			
			_flashRect.x += 4;
			_flashRect.y += 4;
			_flashRect.width -= 8;
			_flashRect.height -= 8;
			FlxG.camera.buffer.fillRect(_flashRect, 0xff000000);
			
			super.draw();
		}
	}
}