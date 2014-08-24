package
{
	import org.flixel.*;
		
	public class MenuScreen extends ScreenState
	{
		public function MenuScreen()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			var _button:FlxButton = new FlxButton(0.5 * FlxG.width - 40, 0.5 * FlxG.height - 10, "Play Game", onButtonGame);
			add(_button);
		}
		
		override public function update():void
		{	
			super.update();
		}
	}
}