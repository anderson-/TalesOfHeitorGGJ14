package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine
	{
		public function Main()
		{
			super(800, 600, 30, false);
			FP.world = new MyWorld;
			FP.console.enable();
			
		}

		override public function init():void
		{
			trace("FlashPunk has started successfully!");
			
		}
	}
}