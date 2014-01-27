package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Spike extends Entity
	{
		[Embed(source = "assets/spike.png")] private const SPIKE : Class;
		
		public function Spike(x:int, y:int, down:Boolean = false)
		{
			type = "spike";
			
			var g:Image = new Image (SPIKE);
			graphic = g;
			
			if (down) {
				g.scaleY = -1;
			}
			
			this.x = x;
			this.y = y;
			type = "spike";
			setHitbox (50, 50 );
			
		}
		
		override public function update() : void 
		{
		
			
		}
		
		
		
	}
	
	
}