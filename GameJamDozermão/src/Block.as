package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Anderson Antunes
	 */
	public class Block extends Entity
	{
		[Embed(source='assets/dirty.png')]
		private const DIRTY_IMG:Class;
		[Embed(source='assets/grass.png')]
		private const GRASS_IMG:Class;
		[Embed(source='assets/cave.png')]
		private const CAVE_IMG:Class;
		[Embed(source='assets/gramasolid.png')]
		private const SOLID_GRASS_IMG:Class;
		[Embed(source='assets/grama.png')]
		private const GRAMA_IMG:Class;
		
		public function Block(x:int, y:int, type:String)
		{
			this.x = x;
			this.y = y;
			
			layer = 3;
			
			var sprites:Spritemap;
			
			if (type == "dirty")
			{
				sprites = new Spritemap(DIRTY_IMG, 50, 50);
				sprites.randFrame();
				this.type = "block";
			}
			else if (type == "grass")
			{
				sprites = new Spritemap(GRASS_IMG, 50, 50);
				sprites.add("grass", [0, 1], 1, true);
				sprites.play("grass",false,Math.random()*10);
				this.type = "air";
			}
			else if (type == "grama")
			{
				sprites = new Spritemap(GRAMA_IMG, 50, 50);
				sprites.add("grama", [0, 1], 1, true);
				sprites.play("grama",false,Math.random()*10);
				this.type = "air";
			}
			else if (type == "cave")
			{
				sprites = new Spritemap(CAVE_IMG, 50, 50);
				sprites.randFrame();
				this.type = "air";
			}
			else if (type == "solidGrass")
			{
				sprites = new Spritemap(SOLID_GRASS_IMG, 50, 50);
				sprites.randFrame();
				this.type = "block";
			}
			
			graphic = sprites;
			setHitbox(50, 50);
		}
	
	}

}