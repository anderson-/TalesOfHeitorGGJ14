package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author ...
	 */
	public class Aim extends Entity
	{
		[Embed(source = "assets/aim.png")] private const AIM:Class;
		
		private var sprite: Spritemap = new Spritemap(AIM, 35, 35);
		
		public function Aim() 
		{
			graphic = sprite;
			sprite.add("aimAnimation", [1, 2, 3, 4, 5, 6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23], 24,false);		
			
			Image(graphic).originX = Image(graphic).width / 2;
			Image(graphic).originY = Image(graphic).height / 2;
			Input.mouseCursor = "hide";
		}
		
		public function animate():void
		{
			sprite.play("aimAnimation",true);
		}
		
		
	}

}