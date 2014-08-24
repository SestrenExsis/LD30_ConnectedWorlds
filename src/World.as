package
{
	import flash.utils.ByteArray;
	import org.flixel.*;
	
	public class World extends Entity
	{
		public var galaxy:Galaxy;
		public var next:World;
		public var score:int;
		public var allGreen:Boolean;
		
		public function World(GalaxyInstance:Galaxy, Size:int = 3, Preview:World = null)
		{
			super(FlxG.mouse.x, FlxG.mouse.y, Size, Size);
			
			galaxy = GalaxyInstance;
			next = Preview;
			harvest = false;
			allGreen = false;
			randomWorld(Size);
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
					{
						members[i].type = Tile.NONE;
						members[i].visible = false;
					}
					else
						members[i].randomizeType();
				}
			}
		}
		
		private function placeWorld(StartX:int, StartY:int):void
		{
			var _endX:int = StartX + widthInTiles;
			var _endY:int = StartY + heightInTiles;
			if (StartX < 0 || StartY < 0 || _endX > galaxy.widthInTiles || _endY > galaxy.heightInTiles)
			{
				ScreenState.playSound(ScreenState.SFX_INVALID_PLACEMENT);
				return;
			}
			
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
							worldTile.targetElevation = Tile.TILE_BORDER;
						else
							worldTile.targetElevation = 0;
						worldTile.combineTiles(galaxyTile, true);
					}
				}
			}
			
			FlxG.score -= 5;
			FlxG.shake(0.005, 0.125);
			clone(next);
			posX = next.posX;
			posY = next.posY;
			repositionTiles = true;
			
			next.randomWorld();
			next.posX = FlxG.width;
			next.posY = Tile.SPACER_WIDTH;
			next.repositionTiles = true;
			
			ScreenState.playSound(ScreenState.SFX_PLACE_PLANET);
			
			if (FlxG.score <= 0)
				GameScreen.gameOver();
		}
		
		private function isLegalHarvest(StartX:int, StartY:int):Boolean
		{
			var _endX:int = StartX + widthInTiles;
			var _endY:int = StartY + heightInTiles;
			
			var worldTile:Tile;
			var galaxyTile:Tile;
			var legalMove:Boolean = true;
			for (var y:int = 0; y < widthInTiles; y++)
			{
				for (var x:int = 0; x < heightInTiles; x++)
				{
					worldTile = getTileAt(x, y);
					galaxyTile = galaxy.getTileAt(x + StartX, y + StartY);
					
					if (galaxyTile)
					{
						if (worldTile.type > Tile.NONE)
						{
							if (galaxyTile.type > Tile.NONE)
								worldTile.targetElevation = Tile.TILE_BORDER;
							else
								worldTile.targetElevation = 0;
							worldTile.combineTiles(galaxyTile, false);
						}
						
						if (worldTile.visible)
						{
							if (galaxyTile.type == Tile.NONE)
								legalMove = false;
						}
					}
					else
					{
						worldTile.targetElevation = 0;
						worldTile.combineTiles(null, false);
						legalMove = false;
					}
				}
			}
			return legalMove;
		}
		
		private function commitHarvest(StartX:int, StartY:int):void
		{
			score = 0;
			var worldTile:Tile;
			var galaxyTile:Tile;
			allGreen = true;
			for (var y:int = 0; y < widthInTiles; y++)
			{
				for (var x:int = 0; x < heightInTiles; x++)
				{
					worldTile = getTileAt(x, y);
					if (worldTile.visible)
					{
						galaxyTile = galaxy.getTileAt(x + StartX, y + StartY);
						FlxG.score += galaxyTile.score;
						if (galaxyTile.type != Tile.FOLIAGE)
							allGreen = false;
						galaxyTile.type = Tile.NONE;
					}
				}
			}
			
			FlxG.score -= 250;
			FlxG.shake(0.015, 0.25);
			ScreenState.playSound(ScreenState.SFX_HARVEST_PLANET);
			if (FlxG.level == 1 && allGreen)
			{
				GameScreen.newLevel();
			}
			else if (FlxG.level > 1 && FlxG.score >= 1000)
			{
				GameScreen.newLevel();
			}
			else if (FlxG.score <= 0)
				GameScreen.gameOver();
		}
		
		public function clone(TargetWorld:World):void
		{	
			var i:int;
			for (var y:int = 0; y < heightInTiles; y++)
			{
				for (var x:int = 0; x < widthInTiles; x++)
				{
					i = y * widthInTiles + x;
					(members[i] as Tile).type = (TargetWorld.members[i] as Tile).type;
				}
			}
			harvest = TargetWorld.harvest;
		}
		
		override public function update():void
		{	
			repositionTiles = false;
			var _gridOffsetX:int;
			var _gridOffsetY:int;
			if (next)
			{
				var _width:Number = Tile.TILE_WIDTH + 2 * Tile.SPACER_WIDTH;
				var _height:Number = Tile.TILE_HEIGHT + 2 * Tile.SPACER_HEIGHT + Tile.TILE_BORDER;
				
				var _cornerX:Number = FlxG.mouse.x - 0.5 * (widthInTiles * _width);
				var _cornerY:Number = FlxG.mouse.y - 0.5 * (heightInTiles * _height);
				_gridOffsetX = Math.floor((_cornerX - galaxy.posX) / _width);
				_gridOffsetY = Math.floor((_cornerY - galaxy.posY) / _height);
				posX = _gridOffsetX * _width + galaxy.posX;
				posY = _gridOffsetY * _height + galaxy.posY;
			}
			else
			{
				posX = FlxG.width - Tile.SPACER_WIDTH * 3.5 - widthInTiles * (Tile.TILE_WIDTH + 2 * Tile.SPACER_WIDTH);
				posY = 5 * Tile.SPACER_HEIGHT;
			}
			
			if (next)
			{
				harvest = isLegalHarvest(_gridOffsetX, _gridOffsetY);
				if (FlxG.mouse.justPressed())
				{
					if (harvest)
						commitHarvest(_gridOffsetX, _gridOffsetY);
					else
						placeWorld(_gridOffsetX, _gridOffsetY);
				}
			}
			
			super.update();
		}
		
		override public function draw():void
		{	
			super.draw();
		}
	}
}