package
{
	import org.flixel.*;
		
	public class Galaxy extends Entity
	{
		public function Galaxy(X:Number, Y:Number, Width:int = 1, Height:int = 1)
		{
			super(X, Y);
			
			emptyBoard();
		}
		
		override public function update():void
		{	
			super.update();
		}
		
		override public function draw():void
		{	
			_flashRect.x = posX - 8;
			_flashRect.y = posY - 8;
			_flashRect.width = (blockWidth + spacerWidth) * gridWidth + 12;
			_flashRect.height = (blockHeight + spacerHeight) * gridHeight + 12;
			FlxG.camera.buffer.fillRect(_flashRect, 0xffffffff);
			
			_flashRect.x += 4;
			_flashRect.y += 4;
			_flashRect.width -= 8;
			_flashRect.height -= 8;
			FlxG.camera.buffer.fillRect(_flashRect, 0xff000000);
			super.draw();
		}
	}
}