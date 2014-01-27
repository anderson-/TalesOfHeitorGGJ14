package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Wallace Guarnieri
	 */
	public class Plataform extends Entity
	{
		[Embed(source = "assets/dirty.png")] private const PLATAFORM:Class;
		public var changePos : int = -1; 
		
		public function Plataform(x:int, y:int) 
		{
			super();
			
			this.x = x;
			this.y = y;
			
			
			setHitbox(300, 50);
			type = "plataform";
			
			graphic = new Image(PLATAFORM);
			
		}
		
		private var tx:Number = 0;
		
		public function getDx(): Number {
			return tx;
		}
		
		override public function update() : void 
		{
			tx = 50 * changePos * FP.elapsed;
			x += tx;
			if (collide("delimiter", x, y)) {
				changePos = changePos * -1;
			}

		}
		
	}

}