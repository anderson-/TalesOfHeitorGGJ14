package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	public class Player extends Entity
	{
		[Embed(source='assets/player.png')]
		private const PLAYER:Class;
		
		private var jumpTime:uint = 0;
		//private var vel:
		
		public function Player()
		{
			
			graphic = new Image(PLAYER);
			setHitbox(42, 21);
		
		}
		
		
		private function jump():void
		{
			//jumpTime = 
		}
		
		// teste com o mouse
		override public function update():void
		{
			if (collide("bullet", x, y))
			{
				// Player is colliding with a "bullet" type.
			}
			
			
			if (!collide("block", x, y))
			{
				y += 90*FP.elapsed;
			}
			
			if (Input.check(Key.LEFT))
			{
				
				x -= 5;
			}
			if (Input.check(Key.RIGHT))
			{
				x += 5;
			}
			if (Input.check(Key.UP))
			{
				y -= 5;
			}
			if (Input.check(Key.DOWN))
			{
				y += 5;
			}
			// Assigns the Entity's position to that of the mouse (relative to the Camera).
			//x = Input.mouseX;
			//y = Input.mouseY;
			// Assigns the Entity's position to that of the mouse (relative to the World).
			//x = FP.world.mouseX;
			//y = FP.world.mouseY;
		}
	
	}

}