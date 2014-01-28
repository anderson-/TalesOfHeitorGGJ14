package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Screen;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.Graphic;
	
	/**
	 * ...
	 * @author 
	 */
	public class Menu extends World 
	{
		[Embed(source = "assets/menu.png")] private const MENU_BACK:Class;
		[Embed(source = "assets/creditos.png")] private const CREDITS:Class;
		[Embed(source = "assets/btns0001.png")] private const BUTTON_PLAY:Class;
		[Embed(source = "assets/btns0002.png")] private const BUTTON_CREDITS:Class;
		
		private var buttonPlay: Entity;
		private var buttonCredits: Entity;
		private var back: Entity;
		private var mainMenuBack: Image = new Image(MENU_BACK);
		private var creditsBack: Image = new Image(CREDITS);
		
		public function Menu() 
		{
			super();
			
			buttonPlay = new Entity(150, 323, new Image(BUTTON_PLAY));
			buttonPlay.setHitbox(69, 68);
			buttonPlay.layer = 0;
			buttonCredits = new Entity(550, 323, new Image(BUTTON_CREDITS));
			buttonCredits.setHitbox(69, 68);
			buttonCredits.layer = 0;
			
			mainMenuBack.scale = 0.46;
			creditsBack.scale = 0.46;
			
			back = addGraphic(mainMenuBack, 1);
			
			buttonPlay = add(buttonPlay);
			buttonCredits = add(buttonCredits);
		}
		
		public function init(): void
		{
			back.graphic = mainMenuBack;
			buttonPlay.visible = true;
			buttonCredits.visible = true;
		}
		
		override public function update():void 
		{
			super.update();
			
			var mouseX: int = Input.mouseX;
			var mouseY: int = Input.mouseY;
			
			if (Input.mousePressed)
			{
				if (buttonPlay.collidePoint(buttonPlay.x, buttonPlay.y, mouseX, mouseY))
				{
					[Embed(source="fase1.txt",mimeType="application/octet-stream")] var myText:Class;
					FP.world = new WorldCockroach();
					
					//Comente 2 linhas acima e descomente abaixo para jogar faze boss direto
					//[Embed(source="fase6.txt",mimeType="application/octet-stream")] var myText:Class;
					//FP.world = new WorldSheep();
					
				}
				else if (buttonCredits.collidePoint(buttonCredits.x, buttonCredits.y, mouseX, mouseY))
				{
					back.graphic = creditsBack;
					buttonPlay.visible = false;
					buttonCredits.visible = false;
				}
			}
			
			if (Input.pressed(Key.ESCAPE))
			{
				init();
			}
			
		}
		
	}

}