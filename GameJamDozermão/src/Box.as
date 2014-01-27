package
{
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Box extends Entity
	{
		[Embed(source="assets/boxes.png")]
		private const BOXES:Class;
		
		public function Box(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			var boxType:Spritemap = new Spritemap(BOXES, 50, 50);
			boxType.randFrame();
			
			type = "block";
			
			graphic = boxType;
			setHitbox(50, 50);
		}
	}
}