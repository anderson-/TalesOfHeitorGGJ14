package  
{
	
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Graphiclist;
	/**
	 * ...
	 * @author Anderson Antunes
	 */
	public class WorldCockroach extends DefaultScenario
	{
		[Embed(source="fase1.txt",mimeType="application/octet-stream")]
		private var myText:Class;
		[Embed(source="assets/cockroachbg.png")]
		private const BG0:Class;
		[Embed(source="assets/cockroachbg2.png")]
		private const BG1:Class;
		
		public function WorldCockroach() 
		{
			super(myText);
						
			var b:Backdrop = new Backdrop(BG0, true, true);
			b.scrollX = 0.2;
			b.scrollY = 0.2;
			
			var b2:Backdrop = new Backdrop(BG1, true, true);
			b2.scrollX = 0.55;
			b2.scrollY = 0.55;
			
			//var b3:Backdrop = new Backdrop(Assets.GRAPHIC_STARS3, true, true);
			//b3.scrollX = 0.8;
			//b3.scrollY = 0.8;
			
			background.graphic = new Graphiclist(b, b2);
			background.layer = 3;
			add(background);
			
		}
		
	}

}