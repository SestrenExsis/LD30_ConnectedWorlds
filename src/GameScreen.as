package
{
	import org.flixel.*;
		
	public class GameScreen extends ScreenState
	{
		[Embed(source="../assets/images/Interface.png")] public var imgInterface:Class;
		[Embed(source="../assets/images/Missions.png")] public var imgMissions:Class;
		
		private var gameInterface:FlxSprite;
		private var mission:FlxSprite;
		private var galaxy:Galaxy;
		private var world:World;
		private var next:World;
		private var score:FlxText;
		
		public function GameScreen()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			FlxG.score = 500;
			
			mission = new FlxSprite(4, 526);
			mission.loadGraphic(imgMissions, true, false, 446, 111);
			mission.frame = FlxG.level;
			add(mission);
			
			gameInterface = new FlxSprite(0, 0);
			gameInterface.loadGraphic(imgInterface);
			add(gameInterface);
			
			score = new FlxText(492, 536, 132, "");
			score.setFormat(null, 32, 0xffffff, "right");
			add(score);
			
			galaxy = new Galaxy(12, 12)
			add(galaxy);
			
			next = new World(galaxy, 4, null);
			add(next);
			
			world = new World(galaxy, 4, next);
			add(world);
		}
		
		override public function update():void
		{	
			super.update();
			
			if (FlxG.keys.justPressed("ESCAPE"))
				onButtonMenu();
			
			score.text = FlxG.score.toString();
		}
		
		public static function newLevel():void
		{
			FlxG.level++;
			if (FlxG.level > 5)
				onButtonWinGame();
			else
				onButtonGame();
		}
		
		public static function gameOver():void
		{
			onButtonLoseGame();
		}
	}
}