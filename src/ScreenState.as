package
{
	import org.flixel.*;
		
	public class ScreenState extends FlxState
	{
		[Embed(source="../assets/images/Background.png")] public var imgBackground:Class;
		
		public static var instance:ScreenState;
		
		private var background1:FlxSprite;
		private var background2:FlxSprite;
		
		public static var gameWon:Boolean = false;
		public static var gameLost:Boolean = false;
		
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