package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.Sfx;

	/**
	 * ...
	 * @author ...
	 */
	
	public class Sheep extends Cockroach
	{
		[Embed(source = 'assets/whiteSheep.png')] private const ENEMY:Class;
		
		
		private const VEL: int = 3;
		private var hJump:int = 15;
		public function Sheep(x:int,y:int)
		{
			super();
			
			sprite = new Spritemap(ENEMY, 50, 50);
			
			this.x = x;
			this.y = y+25;
			sprite.add("walk", [0, 1], 24, true);
			sprite.add("dead", [2], 24, false);
			sprite.play("walk");
			
			velocityX = -VEL;
			
			setHitbox(50, 50, 25, 25);
			type = "enemy";
			
			addGraphic(sprite);
			addGraphic(spriteSkull);
			var i:int = 0;
			while (i < 32)
			{
				v[i] = i;
				i++;
			}
			spriteSkull.add("skull", v, 24, false);
			spriteSkull.visible = false;

			Image(Graphiclist(graphic).children[0]).centerOrigin();
			Image(Graphiclist(graphic).children[1]).centerOrigin();
			Image(Graphiclist(graphic).children[1]).originY += 50;
			
			hJump = Math.random() * 60 + 10;
		}
		
		override public function update():void
		{
			super.update();
			if (vivo){
				jump(hJump);
			}
		}
	}

}