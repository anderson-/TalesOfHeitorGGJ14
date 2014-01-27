package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Anderson Antunes
	 */
	public class FlyingCockroach extends Entity
	{
		
		private var dir:int = -1;
		private const amplitude:int = 90;
		private const period: Number = 60.0;
		private const xVel: Number = 2;
		private var center: int;
		private var counter: int = 0;
		[Embed(source = 'assets/flyingCockroach.png')] private const ENEMY:Class;
		private var sprite: Spritemap = new Spritemap(ENEMY, 50, 50);
		
		public function FlyingCockroach(x:int, y:int)
		{
			this.x = x;
			this.y = center = y;
			sprite.add("walk", [0, 1], 24, true);
			graphic = sprite;
			sprite.play("walk");
			setHitbox(50,50, 25, 25);
			type = "enemy";
			Image(graphic).centerOrigin();
			
		}
		
		override public function update():void
		{
			
			x += xVel * dir;
			y = center + amplitude * Math.sin(2 * Math.PI * counter / period);// * .05);
			counter++;
			
			var array:Array = [];
			
			world.getClass(Player, array);
			
			var player:Player = array[0] as Player;
			
			if (player) {
				if (player.x > x) {
					dir = 1;
					//amplitude = 10;
				} else if (player.x < x){
					dir = -1;
					//amplitude = 10;
				} else {
					//dir = 0;
					//amplitude = 0;
				}
				Image(graphic).scaleX = -dir;
			}
		}
	}

}