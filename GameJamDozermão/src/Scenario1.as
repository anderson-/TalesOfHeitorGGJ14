package
{
	import net.flashpunk.World
	public class Scenario1 extends World
	{
		public function Scenario1()
		{
			add(new PlayerLegs());
			add(new Player());
			
			//add(new Bullet);
		}
		
	}
	
}