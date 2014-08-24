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
		
		public static const values:Array = [0, 10, 0, 60, 40, 20];
		public static const FREE_PLAY:Array = [MAGMA, WATER, WATER, WATER, WATER, WATER, ROCK, ROCK, EARTH, FOLIAGE];
		public static const STAGE_1:Array =   [WATER, WATER, WATER, WATER, EARTH, EARTH, EARTH, EARTH, FOLIAGE, FOLIAGE];
		public static const STAGE_2:Array =   [WATER, WATER, WATER, WATER, WATER, ROCK, ROCK, ROCK, EARTH, FOLIAGE];
		public static const STAGE_3:Array =   [MAGMA, WATER, WATER, WATER, WATER, WATER, ROCK, ROCK, EARTH, FOLIAGE];
		public static const STAGE_4:Array =   [MAGMA, WATER, WATER, WATER, WATER, WATER, ROCK, ROCK, EARTH, EARTH];
		public static const STAGE_5:Array =   [MAGMA, WATER, WATER, WATER, WATER, WATER, ROCK, ROCK, ROCK, ROCK];
		
		public static const tileBags:Array = [FREE_PLAY, STAGE_1, STAGE_2, STAGE_3, STAGE_4, STAGE_5];
		//Averages:  M + W + R +  E +  F = avg * tiles = avg value per world
		//
		//STAGE_1:   0 + 4 + 0 + 16 + 12 = 32 * 12 = 384 per world
		//STAGE_2:   0 + 5 + 6 +  4 +  6 = 21 * 12 = 252 per world
		//STAGE_3:   0 + 5 + 4 +  4 +  6 = 19 * 12 = 228 per world
		//STAGE_4:   0 + 5 + 4 +  8 +  0 = 17 * 12 = 204 per world
		//STAGE_5:   0 + 5 + 8 +  0 +  0 = 13 * 12 = 156 per world
		
		public static const TILE_WIDTH:int = 32;
		public static const TILE_HEIGHT:int = 32;
		public static const TILE_BORDER:int = 4;
		public static const SPACER_WIDTH:int = 2;
		public static const SPACER_HEIGHT:int = 2;
		
		private var entity:Entity;
		private var tileX:int;
		private var tileY:int;
		private var targetPos:FlxPoint;
		private var posVelocity:FlxPoint;
		private var elevationVelocity:Number;
		private var elevation:Number;
		
		protected var _type:int;
		protected var _newType:int;
		
		public var targetElevation:Number;
		public var score:int;
		public var newScore:int;
		
		public function Tile(EntityInstance:Entity, TileX:Number, TileY:Number, Type:int = NONE)
		{
			super(FlxG.width, 0);
			entity = EntityInstance;
			tileX = TileX;
			tileY = TileY;
			elevation = 0;
			targetElevation = 0;
			elevationVelocity = 0;
			targetPos = new FlxPoint(posX, posY);
			posVelocity = new FlxPoint(0, 0);
			
			score = 0;
			type = Type;
			newType = type;
			loadGraphic(imgTile, true, false, TILE_WIDTH, TILE_HEIGHT + TILE_BORDER);
			dirty = true;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function set type(Value:int):void
		{
			var _oldValue:int = _type;
			if (_oldValue != Value)
			{
				_type = Value;
				entity.tileCounts[_oldValue]--;
				entity.tileCounts[_type]++;
				dirty = true;
			}
			score = values[_type];
		}
		
		public function get newType():int
		{
			return _newType;
		}
		
		public function set newType(Value:int):void
		{
			var _oldValue:int = _newType;
			if (_oldValue != Value)
			{
				_newType = Value;
				dirty = true;
			}
			newScore = values[_newType];
		}
		
		public function randomizeType():void
		{
			var _tileBag:Array = tileBags[FlxG.level];
			var _seed:int = Math.floor(FlxG.random() * _tileBag.length);
			type = _tileBag[_seed];
			newType = type;
			visible = true;
		}
		
		public function combineTiles(TileToCombineWith:Tile = null, CommitChange:Boolean = false):int
		{
			var _combinedTile:int = type;
			if (TileToCombineWith == null)
			{
				newType = _combinedTile;
				return type;
			}
			
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
				TileToCombineWith.newType = _combinedTile;
			}
			newType = _combinedTile;
			return _combinedTile;
		}
		
		override public function update():void
		{	
			updateTargets(4.0, 0.6, 0.6);
			
			super.update();
			
		}
		
		override protected function calcFrame():void
		{
			_flashRect.setTo(0, 0, TILE_WIDTH, TILE_HEIGHT + TILE_BORDER);
			framePixels.fillRect(_flashRect, 0x00000000);
			
			if (type == NONE)
			{
				dirty = false;
				return;
			}
			
			//Update display bitmap
			_flashRect.setTo(0, TILE_HEIGHT * newType, TILE_WIDTH, TILE_HEIGHT);
			framePixels.copyPixels(_pixels, _flashRect, _flashPointZero);
			
			_flashRect.setTo(TILE_WIDTH, TILE_BORDER * type, TILE_WIDTH, TILE_BORDER);
			_flashPoint.setTo(0, TILE_HEIGHT);
			framePixels.copyPixels(_pixels, _flashRect, _flashPoint);
			
			_flashRect.setTo(0, 0, frameWidth, frameHeight);
			if(_colorTransform != null)
				framePixels.colorTransform(_flashRect,_colorTransform);
			if(_callback != null)
				_callback(((_curAnim != null)?(_curAnim.name):null),_curFrame,_curIndex);
			dirty = false;
		}
		
		override public function draw():void
		{	
			if (entity.harvest)
			{
				_flashRect.setTo(posX + 8, posY + 8, frameWidth - 16, frameHeight - 20);
				FlxG.camera.buffer.fillRect(_flashRect, 0xffffffff);
				_flashRect.setTo(0, 0, frameWidth, frameHeight);
			}
			else
			{
				var y:Number = posY;
				posY = posY - elevation;
				super.draw();
				posY = y;
			}
		}
		
		private function updateTargets(Mass:Number, Stiffness:Number, Damping:Number):void
		{
			// Update positions
			targetPos.x = entity.posX + tileX * (TILE_WIDTH + 2 * SPACER_WIDTH);
			targetPos.y = entity.posY + tileY * (TILE_HEIGHT + 2 * SPACER_HEIGHT + TILE_BORDER);
			
			if (entity.repositionTiles)
			{
				posX = targetPos.x;
				posY = targetPos.y;
			}
			
			var _diffX:Number = Math.abs(posX - targetPos.x);
			var _diffY:Number = Math.abs(posY - targetPos.y);
			if ((_diffX < 0.5 && _diffY < 0.5))
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
			
			// Update elevation
			_diffX = Math.abs(elevation - targetElevation);
			if (_diffX < 0.5)
				targetElevation = elevation;
			
			_force = (targetElevation - elevation) * Stiffness;
			_factor = _force / Mass;
			elevationVelocity = Damping * (elevationVelocity + _factor);
			elevation += elevationVelocity;
		}
	}
}