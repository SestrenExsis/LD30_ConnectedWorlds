package
{
	import org.flixel.*;
		
	public class ScreenState extends FlxState
	{
		[Embed(source="../assets/images/Background.png")] public static var imgBackground:Class;
		[Embed(source="../assets/sounds/Drone01.mp3")] public static var sfxDrone01:Class;
		[Embed(source="../assets/sounds/Drone02.mp3")] public static var sfxDrone02:Class;
		[Embed(source="../assets/sounds/Drone03.mp3")] public static var sfxDrone03:Class;
		[Embed(source="../assets/sounds/Drone04.mp3")] public static var sfxDrone04:Class;
		[Embed(source="../assets/sounds/Drone05.mp3")] public static var sfxDrone05:Class;
		[Embed(source="../assets/sounds/Drone06.mp3")] public static var sfxDrone06:Class;
		[Embed(source="../assets/sounds/Drone07.mp3")] public static var sfxDrone07:Class;
		public static var sfxDrone:Array = [sfxDrone01, sfxDrone02, sfxDrone03, sfxDrone04, sfxDrone05, sfxDrone06, sfxDrone07];
		
		public static const SFX_PLACE_PLANET:Array = [0, 1, 2, 3];
		public static const SFX_INVALID_PLACEMENT:Array = [4, 5, 6];
		public static const SFX_HARVEST_PLANET:Array = [7, 8, 9];
		public static const SFX_MENU_SELECT:Array = [10, 11];
		
		public static var instance:ScreenState;
		public static var soundBank:SoundBank;
		public static var gameWon:Boolean = false;
		public static var gameLost:Boolean = false;
		
		private var background1:FlxSprite;
		private var background2:FlxSprite;
		
		private var timer:FlxTimer;
		
		public function ScreenState()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			instance = this;
			
			background1 = new FlxSprite(0, 0);
			background1.loadGraphic(imgBackground);
			background1.velocity.x = -15;
			add(background1);
			
			background2 = new FlxSprite(FlxG.width, 0);
			background2.loadGraphic(imgBackground);
			add(background2);
			
			FlxG.flash(0xff000000, 1.0);
			
			soundBank = new SoundBank();
			
			timer = new FlxTimer();
			timer.start(2 + Math.floor(FlxG.random() * 4), 1, onTimerDrone);
		}
		
		override public function update():void
		{	
			super.update();
			
			if (background1.posX <= -FlxG.width)
				background1.posX += FlxG.width;
			background2.posX = background1.posX + FlxG.width;
		}
		
		override public function draw():void
		{
			
			super.draw();
		}
		
		public function onTimerDrone(Timer:FlxTimer):void
		{
			timer.stop();
			timer.start(16 + 4 * Math.floor(FlxG.random() * 4), 1, onTimerDrone);
			playDrone(0.25);
		}
		
		public static function playSound(Sounds:Array):void
		{
			var _seed:int = Math.floor(Sounds.length * Math.random());
			var _index:int = Sounds[_seed];
			soundBank.playSound(_index);
		}
		
		public static function playDrone(VolumeMultiplier:Number = 1.0):void
		{
			var _seed:Number = Math.floor(sfxDrone.length * Math.random());
			FlxG.play(sfxDrone[_seed], VolumeMultiplier, false, false);
		}

		
		public static function onButtonMenu():void
		{
			fadeToMenu();
		}
		
		public static function fadeToMenu(Timer:FlxTimer = null):void
		{
			FlxG.fade(0xff000000, 0.5, goToMenu);
		}
		
		public static function goToMenu():void
		{
			FlxG.switchState(new MenuScreen);
		}
		
		public static function onButtonGame():void
		{
			if (FlxG.level == 1)
				playSound(SFX_MENU_SELECT);
			fadeToGame();
		}
		
		public static function fadeToGame(Timer:FlxTimer = null):void
		{
			FlxG.fade(0xff000000, 0.5, goToGame);
		}
		
		public static function goToGame():void
		{
			FlxG.switchState(new GameScreen);
		}
		
		public static function onButtonFreePlay():void
		{
			fadeToFreePlay();
		}
		
		public static function fadeToFreePlay(Timer:FlxTimer = null):void
		{
			FlxG.fade(0xff000000, 0.5, goToFreePlay);
		}
		
		public static function goToFreePlay():void
		{
			FlxG.level = 0;
			FlxG.switchState(new GameScreen);
		}
		
		public static function onButtonWinGame():void
		{
			fadeToWinGame();
		}
		
		public static function fadeToWinGame(Timer:FlxTimer = null):void
		{
			FlxG.fade(0xff000000, 0.5, goToWinGame);
		}
		
		public static function goToWinGame():void
		{
			gameLost = false;
			gameWon = true;
			FlxG.switchState(new MenuScreen);
		}
		
		public static function onButtonLoseGame():void
		{
			fadeToLoseGame();
		}
		
		public static function fadeToLoseGame(Timer:FlxTimer = null):void
		{
			FlxG.fade(0xff000000, 0.5, goToLoseGame);
		}
		
		public static function goToLoseGame():void
		{
			gameLost = true;
			gameWon = false;
			FlxG.switchState(new MenuScreen);
		}

	}
}