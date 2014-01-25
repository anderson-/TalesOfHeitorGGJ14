package
{
	import net.flashpunk.World
	public class MyWorld extends World
	{
		public function MyWorld()
		{
			add(new Player());
			add(new Bullet);
			
			add(new Block(0, 60));
			add(new Block(32, 120));
			add(new Block(64, 120));
			add(new Block(96, 60));
			
		}
		
		override public function update():void
		{
			super.update();
		}
	}
	
}