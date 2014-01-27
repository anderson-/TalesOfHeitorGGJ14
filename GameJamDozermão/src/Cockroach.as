package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.Sfx;

	/**
	 * ...
	 * @author 	...
	 */
	
	public class Cockroach extends Character
	{
		
		[Embed(source = 'assets/sounds/barataDamage1.mp3')]
		private const DMG1:Class;
		public var dmg1: Sfx = new Sfx(DMG1);
		
		[Embed(source = 'assets/sounds/barataDamage2.mp3')]
		private const DMG2:Class;
		public var dmg2: Sfx = new Sfx(DMG2);
		

		//var Direita: Boolean ;  
		[Embed(source = 'assets/cockroach.png')] private const ENEMY:Class;
		protected var sprite: Spritemap = new Spritemap(ENEMY, 50, 50);
		
		[Embed(source = 'assets/skull.png')] private const SKULL:Class;
		protected var spriteSkull: Spritemap = new Spritemap(SKULL, 110, 150);
		
		private const VEL: int = 3;
		protected var vivo:Boolean = true;
		protected var v:Array = [];
		
		public function Cockroach(x:int = -1 ,y:int = -1)
		{
			if (x == -1 && y == -1) {
				return;
			}
			this.x = x;
			this.y = y+25;
			sprite.add("walk", [0, 1], 24, true);
			sprite.add("dead", [2], 24, false);
			
			var i:int = 0;
			while (i < 32)
			{
				v[i] = i;
				i++;
			}
			spriteSkull.add("skull", v, 24, false);
			spriteSkull.visible = false;

			sprite.play("walk");
			
			velocityX = -VEL;
			
			setHitbox(50, 50, 25, 25);
			type = "enemy";
			
			addGraphic(sprite);
			addGraphic(spriteSkull);

			Image(Graphiclist(graphic).children[0]).centerOrigin();
			Image(Graphiclist(graphic).children[1]).centerOrigin();
			Image(Graphiclist(graphic).children[1]).originY += 50;
		}
		
		override public function update():void
		{
			super.update();
			
			var enemyLimitBlock: Entity = collideTypes(["block","plataform", "delimiter"], x, y) as Entity;
			
			if (enemyLimitBlock && vivo == true)
			{
				if (enemyLimitBlock.x >= this.x)
				{
					// Block is at right of enemy, go to left
					velocityX = -VEL;
				}
				else if (enemyLimitBlock.x <= this.x)
				{
					// Block is at left of enemy, go to right
					velocityX = VEL;
				}
				Image(Graphiclist(graphic).children[0]).scaleX = -Image(Graphiclist(graphic).children[0]).scaleX;
			}
			if (vivo)
			{
				x += velocityX;
		
			}
		}
		
		public function dead():void
		{
			if (Math.random() > 0.5)
			{
				dmg1.play();
			}
			else {
				dmg2.play();
			}
			type = "dead";
			sprite.play("dead");
			spriteSkull.visible = true;
			spriteSkull.play("skull");
			vivo = false;
		}
		
	}

}