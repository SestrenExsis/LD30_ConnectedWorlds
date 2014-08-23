package
{
	import org.flixel.*;
		
	public class Tile extends FlxSprite
	{
		[Embed(source="../assets/images/Tiles.png")] public var imgTile:Class;
		
		public static const NUM_OF_TYPES:int = 5;
		
		public static const ILLEGAL:int = -1;
		public static const NONE:int = 0;
		public static const WATER:int = 1;
		public static const MAGMA:int = 2;
		public static const FOLIAGE:int = 3;
		public static const EARTH:int = 4;
		public static const ROCK:int = 5;
		
		public static const colors:Array = [0x00000000, 0xff00ffff, 0xffff0000, 0xff00a651, 0xffffd800, 0xff7d4900];
		public static const PLANET_EARTH:Array = [WATER, FOLIAGE, FOLIAGE, FOLIAGE, WATER, FOLIAGE, WATER, WATER, WATER];
		
		public static const TILE_WIDTH:int = 32;
		public static const TILE_HEIGHT:int = 32;
		public static const SPACER_WIDTH:int = 4;
		public static const SPACER_HEIGHT:int = 4;
		
		private var entity:Entity;
		private var tileX:int;
		private var tileY:int;
		private var targetPos:FlxPoint;
		private var posVelocity:FlxPoint;
		private var elevationVelocity:Number;
		private var elevation:Number;
		
		public var type:int;
		public var targetElevation:Number;
		public var combinedType:int;
		
		public function Tile(EntityInstance:Entity, TileX:Number, TileY:Number, Type:int = NONE)
		{
			super(FlxG.width, FlxG.height);
			entity = EntityInstance;
			type = Type;
			combinedType = type;
			tileX = TileX;
			tileY = TileY;
			elevation = 0;
			targetElevation = 0;
			elevationVelocity = 0;
			targetPos = new FlxPoint(posX, posY);
			posVelocity = new FlxPoint(0, 0);
			
			loadGraphic(imgTile);
		}
		
		public function randomizeType():void
		{
			type = Math.ceil(FlxG.random() * NUM_OF_TYPES);
			combinedType = type;
		}
		
		public function combineTiles(TileToCombineWith:Tile = null, CommitChange:Boolean = false):int
		{
			if (TileToCombineWith == null)
				return type;
			
			var _combinedTile:int;
			
			var _bottomType:int = TileToCombineWith.type;
			if (type == MAGMA || _bottomType == MAGMA)
			{
				if (type == WATER || _bottomType == WATER)
					_combinedTile = ROCK;
				else
					_combinedTile = MAGMA;
			}
			else if (type == WATER || _bottomType == WATER)
			{
				if (type == ROCK || _bottomType == ROCK)
					_combinedTile = EARTH;
				else if (type == EARTH || _bottomType == EARTH)
					_combinedTile = FOLIAGE;
				else
					_combinedTile = WATER;
			}
			else if (type == ROCK || _bottomType == ROCK)
				_combinedTile = ROCK;
			else
				_combinedTile = Math.max(type, _bottomType);
			
			if (CommitChange)
			{
				TileToCombineWith.type = _combinedTile;
				TileToCombineWith.combinedType = type;
			}
			combinedType = _combinedTile;
			return _combinedTile;
		}
		
		override public function update():void
		{	
			updatePosition(3.0, 0.6, 0.6);
			updateElevation(3.0, 0.6, 0.6);
			
			super.update();
			
		}
		
		override public function draw():void
		{	
			if (FlxG.debug)
				drawDebug();
			
			if (type == ILLEGAL || type == NONE)
				return;
			
			_flashRect.width = TILE_WIDTH;
			_flashRect.height = TILE_HEIGHT;
			_flashRect.x = 0;
			_flashRect.y = TILE_HEIGHT * combinedType;
			_flashPoint.x = posX;
			_flashPoint.y = posY - elevation;
			FlxG.camera.buffer.copyPixels(pixels, _flashRect, _flashPoint);
			
			_flashRect.x = TILE_WIDTH;
			_flashRect.y = SPACER_HEIGHT * type;
			_flashRect.height = SPACER_HEIGHT;
			_flashPoint.y += TILE_HEIGHT;
			FlxG.camera.buffer.copyPixels(pixels, _flashRect, _flashPoint);
		}
		
		private function updatePosition(Mass:Number, Stiffness:Number, Damping:Number):void
		{
			targetPos.x = entity.posX + tileX * (TILE_WIDTH + 2 * SPACER_WIDTH);
			targetPos.y = entity.posY + tileY * (TILE_HEIGHT + 2 * SPACER_HEIGHT);
			
			var _diffX:Number = Math.abs(posX - targetPos.x);
			var _diffY:Number = Math.abs(posY - targetPos.y);
			if ((_diffX < 0.01 && _diffY < 0.01))
			{
				targetPos.x = posX;
				targetPos.y = posY;
			}
			
			var _force:Number = (targetPos.x - posX) * Stiffness;
			var _factor:Number = _force / Mass;
			posVelocity.x = Damping * (posVelocity.x + _factor);
			posX += posVelocity.x;
			
			_force = (targetPos.y - posY) * Stiffness;
			_factor = _force / Mass;
			posVelocity.y = Damping * (posVelocity.y + _factor);
			posY += posVelocity.y;
		}
		
		private function updateElevation(Mass:Number, Stiffness:Number, Damping:Number):void
		{
			var _diff:Number = Math.abs(elevation - targetElevation);
			if (_diff < 0.01)
				targetElevation = elevation;
			
			var _force:Number = (targetElevation - elevation) * Stiffness;
			var _factor:Number = _force / Mass;
			elevationVelocity = Damping * (elevationVelocity + _factor);
			elevation += elevationVelocity;
		}
	}
}