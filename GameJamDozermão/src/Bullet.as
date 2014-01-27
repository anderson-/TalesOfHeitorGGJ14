package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP

	public class Bullet extends Entity 
	{
		[Embed(source = "assets/shotgunShot.png")] private const BULLET:Class;
		
		private var lifeTime: Number = 0;
		private var sprite: Spritemap = new Spritemap(BULLET, 250, 100);
		private var velocity: int = 10;
		private var hitboxOriginX:Number = 40;
		private var hitboxOriginY:Number = 40;
		private var myAngle: int;
		private var isMirrored: Boolean;
		
		public function Bullet( xBegin: int,  yBegin: int, originY: int, angle: Number, mirror:Boolean)
		{
			
			layer = 0;
			
			setHitbox(80, 80,40,40);
			type = "bullet";
			x = xBegin;
			y = yBegin;
			
			sprite.scaleX = (mirror)? -1 : 1;
			graphic = sprite;
			sprite.add("animation", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,16], 24);
			sprite.play("animation");
			
			Image(graphic).originY = 50;
			Image(graphic).angle = angle;
			myAngle = angle;
			isMirrored = mirror;
			

		}
		
		override public function update() : void
		{
			var constanteHipotenusa:int = 1000;
			if (isMirrored)
			{

				hitboxOriginX += Math.cos(myAngle * Math.PI / 180) * FP.elapsed * constanteHipotenusa;
				hitboxOriginY += -Math.sin(myAngle * Math.PI / 180) *  FP.elapsed * constanteHipotenusa;
				setHitbox(80, 80,hitboxOriginX,hitboxOriginY); 

			}
			else
			{
				hitboxOriginX -= Math.cos(myAngle * Math.PI / 180) *  FP.elapsed * constanteHipotenusa;
				hitboxOriginY -= -Math.sin(myAngle * Math.PI / 180) *  FP.elapsed * constanteHipotenusa;
				setHitbox(80, 80,hitboxOriginX,hitboxOriginY); 

			}

			
			lifeTime += FP.elapsed;
			if (lifeTime > 0.23) // tempo de vida da hitbox
			{
				setHitbox(0, 0, 40, 40);
			}
			if (lifeTime > 0.6) //tempo de vida da bullet
			{
				this.destroy();
			}
			
			var enemy:Entity = collide("enemy", x, y) as Entity;
			
			if (enemy is Cockroach) {
				
				(enemy as Cockroach).dead();
			}
			else if (enemy is FlyingCockroach)
			{
				
				var c : Cockroach = new Cockroach(enemy.x, enemy.y);
				FP.world.add(c);
				c.dead();
				FP.world.remove(enemy);
			}
			else if (enemy is SheepBoss)
			{
				(enemy as SheepBoss).hit();
			}
		}
		
		public function destroy():void
		{
			// Here we could place specific destroy-behavior for the Bullet.
			FP.world.remove(this);
		}
	}
}