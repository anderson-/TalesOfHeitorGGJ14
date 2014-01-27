package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Anderson Antunes
	 */
	public class Chinelo extends Entity
	{
		[Embed(source='assets/chinela.png')]
		private const DIRTY_IMG:Class;
		
		[Embed(source='assets/end1.png')]
		private const DIRTY_IMG2:Class;
		
		private var endthis:Boolean = true;
		
		public function Chinelo(x:int,y:int) 
		{
			this.x = x;
			this.y = y;
			graphic = new Image(DIRTY_IMG);
			setHitbox(50, 80);
		}
		
		override public function update():void {
			if (collide("player", x, y) && endthis) {
				
				(FP.world as DefaultScenario).mute();
				(FP.world as DefaultScenario).killAll()
				
				var img:Image = new Image(DIRTY_IMG2);
				img.scrollX = 0;
				img.scrollY = 0;
				
				FP.world.addGraphic(img, 0 , 362, 150);
				
				endthis = false;
			}
			
			if (!endthis && Input.check(Key.ENTER)) {
				FP.world = new WorldSheep;
			}
		}
	}

}