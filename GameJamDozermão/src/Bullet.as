package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Bullet extends Entity
	{
		
		[Embed(source = "assets/bullet.png")] private const BULLET:Class;
		
		public function Bullet()
		{
			graphic = new Image (BULLET);
			setHitbox(10, 10);
			type = "bullet";
			
			x = 100;
			y = 100;
		}
		
		override public function update() : void
		{
			if (Input.check(Key.A)) { x -= 5; }
			if (Input.check(Key.D)) { x += 5; }
			if (Input.check(Key.W)) { y -= 5; }
			if (Input.check(Key.S)) { y += 5; }
			
			x += 10;
			y += 10;
			
		}
	}
}