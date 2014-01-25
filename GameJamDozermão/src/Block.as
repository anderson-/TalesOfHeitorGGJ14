package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image
	/**
	 * ...
	 * @author Anderson Antunes
	 */
	public class Block extends Entity
	{
		
		[Embed(source = 'assets/stone_tile.gif')] private const PLAYER:Class;
		
		public function Block(x:uint,y:uint)
		{
			graphic = new Image(PLAYER);
			setHitbox(32, 32);
			type = "block";
			this.x = x;
			this.y = y;
		}
		/*
		public function Block(x:uint, y:uint)
		{
			this();
			this.x = x;
			this.y = y;
		}*/
		
	}

}