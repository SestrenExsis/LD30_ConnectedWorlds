package
{
	import org.flixel.*;
		
	public class ScreenState extends FlxState
	{
		public function ScreenState()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			FlxG.flash(0xff000000, 1.0);
			
			add(new Galaxy(12, 12));
			add(new World());
		}
		
		override public function update():void
		{	
			super.update();
		}
	}
}