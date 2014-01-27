package  
{
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP
	/**
	 * ...
	 * @author ...
	 */
	
	 
	public class GroundAnimation extends Entity
	{
		[Embed(source='assets/groundsprite1.png')]
		private const GROUND1:Class;
		private var groundSprite1:Spritemap = new Spritemap(GROUND1, 40, 35,destroy);
		
		[Embed(source='assets/groundsprite2.png')]
		private const GROUND2:Class;
		private var groundSprite2:Spritemap = new Spritemap(GROUND2, 60, 43, destroy);
		
		private var myPlayer: Player;
		
		public function GroundAnimation( xBegin: int,  yBegin: int, player: Player, mirror: Boolean)
		{
			this.layer = 1;
			groundSprite1.add("ground1", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 24, false);
			groundSprite2.add("ground2", [1, 2, 3, 4, 5, 6, 7, 8, 9,10,11], 24, false);
			
			x = xBegin+50;
			y = yBegin;

			if (Boolean)
			{
				groundSprite1.scaleX = -1;
				groundSprite2.scaleX = -1;
			}
			else {
				groundSprite1.scaleX = 1;
				groundSprite2.scaleX = 1;
			}
			
			
			
			var random: Number = Math.random()*1;
			if (random > 0.5) {
				graphic = groundSprite2;
				groundSprite2.play("ground2");
			}
			else {
				graphic = groundSprite1;
				groundSprite1.play("ground1");
			}
				
			
			Image(graphic).originY = 50;
			myPlayer = player;
			
			

		}
		
		public function destroy():void
		{
			myPlayer.setGroundSpriteAvailable(true);
			FP.world.remove(this);
		}
		
	}

}