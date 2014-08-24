package
{
	import org.flixel.*;
		
	public class MenuScreen extends ScreenState
	{
		[Embed(source="../assets/images/Title.png")] public var imgTitle:Class;
		[Embed(source="../assets/images/Results.png")] public var imgResults:Class;
		
		private var title:FlxSprite;
		private var results:FlxSprite;
		
		public function MenuScreen()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			FlxG.level = 1;
			
			title = new FlxSprite(0, 65);
			title.loadGraphic(imgTitle);
			add(title);
			
			results = new FlxSprite(0, 490);
			results.loadGraphic(imgResults, true, false, 640, 86);
			if (gameWon)
				results.frame = 1;
			else if (gameLost)
				results.frame = 2;
			else
				results.frame = 0;
			add(results);
			
			var _button:FlxButton = new FlxButton(0.5 * FlxG.width - 40, 0.5 * FlxG.height - 10, "Play Game", onButtonGame);
			add(_button);
			
			_button = new FlxButton(0.5 * FlxG.width - 40, 0.5 * FlxG.height + 20, "Free Play", onButtonFreePlay);
			add(_button);
		}
		
		override public function update():void
		{	
			super.update();
		}
	}
}