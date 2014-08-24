package
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flixel.*;
		
	public class Galaxy extends Entity
	{
		private var _flashRect:Rectangle;
		private var _flashPoint:Point;
		
		public function Galaxy(GalaxyWidth:int = 1, GalaxyHeight:int = 1)
		{
			super(12, 12, GalaxyWidth, GalaxyHeight);
			
			_flashRect = new Rectangle();
			_flashPoint = new Point();
			emptyGrid();
		}
		
		override public function update():void
		{	
			super.update();
		}
		
		override public function draw():void
		{	
			super.draw();
		}
	}
}