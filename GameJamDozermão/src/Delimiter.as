package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Wallace Guarnieri
	 */
	public class Delimiter extends Entity
	{
		
		public function Delimiter(x:int, y:int) 
		{
			super();
			
			this.x = x;
			this.y = y;
			
			setHitbox(50, 50);
			type = "delimiter";
		
		}
		
	}

}