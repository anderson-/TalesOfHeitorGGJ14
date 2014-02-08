package  
{
	
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Graphiclist;
	/**
	 * ...
	 * @author Anderson Antunes
	 */
	public class WorldSheep extends DefaultScenario
	{
		[Embed(source="fase6.txt",mimeType="application/octet-stream")]
		private var myText:Class;
		[Embed(source='assets/sheepbg.png')]
		private const BG0:Class;
		[Embed(source='assets/fence.png')]
		private const BG1:Class;
		
		public function WorldSheep() 
		{
			super(myText);
			
			var b:Backdrop = new Backdrop(BG0, true, true);
			b.scrollX = 0.2;
			b.scrollY = 0.2;
			b.y = -300;
			
			var b2:Backdrop = new Backdrop(BG1, true, false);
			b2.scrollX = 0.55;
			b2.scrollY = 0.55;
			b2.y = 435;
			
			//var b3:Backdrop = new Backdrop(Assets.GRAPHIC_STARS3, true, true);
			//b3.scrollX = 0.8;
			//b3.scrollY = 0.8;
			
			background.graphic = new Graphiclist(b, b2);
			background.layer = 3;
			add(background);
			
		}
		
		override public function update():void {
			super.update();
			
			if (Math.random() < 0.01) {
				add(new Sheep(this.camera.x + 1124, 100));
				add(new Sheep(this.camera.x + 50, 100));
			}
		}
		
	}

}