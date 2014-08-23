package
{
	import org.flixel.*;
		
	public class GameScreen extends ScreenState
	{
		public function GameScreen()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			var _galaxy:Galaxy = new Galaxy(12, 12, 6)
			add(_galaxy);
			add(new World(_galaxy, 4));
		}
		
		override public function update():void
		{	
			super.update();
		}
	}
}