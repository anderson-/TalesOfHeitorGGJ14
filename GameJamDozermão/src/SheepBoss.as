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
	
	public class SheepBoss extends Cockroach
	{
		 
		private var vida:int = 1;
		
		[Embed(source='assets/bossSheep.png')]
		private const BOSS:Class;
		private var boss:Spritemap = new Spritemap(BOSS, 200, 200);
		
		[Embed(source='assets/meteoro.png')]
		private const METEOR:Class;
		private var meteor:Spritemap = new Spritemap(METEOR, 287, 224);
		
		private const VEL: int = 3;
		
		public function SheepBoss(x:int,y:int)
		{
			super();
			
			addGraphic(boss);
			addGraphic(meteor);
			
			
			var i: int = 0;
			var l: Array = [];
			while ( i < 84)
			{
				l[i] = i;
				i++;
			}

			meteor.add("meteor", l, 24, true);
			boss.add("boss", [0, 1], 12, true);
			meteor.scale = 3;
			

			
			
			this.x = x;
			this.y = y+25;
			boss.play("boss");
			
			velocityX = -VEL;
			meteor.play("meteor");
			meteor.centerOrigin();
			
			setHitbox(200, 200, 100, 100);
			type = "boss";
			
			addGraphic(sprite);
			addGraphic(spriteSkull);
			var j:int = 0;
			while (j < 32)
			{
				v[j] = j;
				j++;
			}
			spriteSkull.add("skull", v, 24, false);
			spriteSkull.visible = false;

			Image(Graphiclist(graphic).children[0]).centerOrigin();
			Image(Graphiclist(graphic).children[1]).centerOrigin();
			Image(Graphiclist(graphic).children[1]).originY += 50;
		}
		
		override public function update():void
		{
			super.update();
			if (vivo) {
				var jumpHeight: Number ;
				jumpHeight = Math.random() * 15 + 15;
				jump(jumpHeight);
			}
		}
		
		public function hit():void
		{
			vida --;
			if ( vida<= 0)
			{
				dead();
			}
		}
		
		override public function dead():void
		{
			type = "dead";
			sprite.play("dead");
			spriteSkull.visible = true;
			spriteSkull.play("skull");
			vivo = false;
		}
	}

}