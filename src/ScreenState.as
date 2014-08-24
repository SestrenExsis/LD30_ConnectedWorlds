package
{
	import org.flixel.*;
		
	public class ScreenState extends FlxState
	{
		[Embed(source="../assets/images/Background.png")] public var imgBackground:Class;
		
		private var background1:FlxSprite;
		private var background2:FlxSprite;
		
		public function ScreenState()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			background1 = new FlxSprite(0, 0);
			background1.loadGraphic(imgBackground);
			background1.velocity.x = -50;
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
		
		public function onButtonMenu():void
		{
			fadeToMenu();
		}
		
		public function fadeToMenu(Timer:FlxTimer = null):void
		{
			FlxG.fade(0xff000000, 0.5, goToMenu);
		}
		
		public function goToMenu():void
		{
			FlxG.switchState(new MenuScreen);
		}
		
		public function onButtonGame():void
		{
			fadeToGame();
		}
		
		public function fadeToGame(Timer:FlxTimer = null):void
		{
			FlxG.fade(0xff000000, 0.5, goToGame);
		}
		
		public function goToGame():void
		{
			FlxG.switchState(new GameScreen);
		}

	}
}