package
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.FP
	import net.flashpunk.Sfx;
	
	public class Player extends Character
	{
		//[Embed(source = 'assets/sounds/gameover.mp3')]
		//private const GAMEOVER:Class;
		//public var gameover: Sfx = new Sfx(GAMEOVER);
		
		[Embed(source = 'assets/sounds/choro_heitor.mp3')]
		private const CHORO:Class;
		public var choro: Sfx = new Sfx(CHORO);
		
		[Embed(source = 'assets/sounds/shoot.mp3')]
		private const SHOOT:Class;
		public var shoot: Sfx = new Sfx(SHOOT);
		
		[Embed(source = 'assets/sounds/heitorDamage1.mp3')]
		private const DMG1:Class;
		public var dmg1: Sfx = new Sfx(DMG1);
		
		[Embed(source = 'assets/sounds/heitorDamage2.mp3')]
		private const DMG2:Class;
		public var dmg2: Sfx = new Sfx(DMG2);
		

		[Embed(source = 'assets/sounds/narrador/som1.mp3')]
		private const SOM1:Class;
		public var som1: Sfx = new Sfx(SOM1,fimFala);
		
		[Embed(source = 'assets/sounds/narrador/som2.mp3')]
		private const SOM2:Class;
		public var som2: Sfx = new Sfx(SOM2,fimFala);
		
		[Embed(source = 'assets/sounds/narrador/som3.mp3')]
		private const SOM3:Class;
		public var som3: Sfx = new Sfx(SOM3,fimFala);
				
		[Embed(source = 'assets/sounds/narrador/som4.mp3')]
		private const SOM4:Class;
		public var som4: Sfx = new Sfx(SOM4,fimFala);
		
		[Embed(source = 'assets/sounds/narrador/som5.mp3')]
		private const SOM5:Class;
		public var som5: Sfx = new Sfx(SOM5,fimFala);
		
		[Embed(source = 'assets/sounds/narrador/som6.mp3')]
		private const SOM6:Class;
		public var som6: Sfx = new Sfx(SOM6,fimFala);
		
		private const v:Array = [som1, som2, som3, som4, som5,som6];
		
		
		
		[Embed(source='assets/shooting.png')]
		private const PLAYER:Class;
		private var topSprite:Spritemap = new Spritemap(PLAYER, 100, 100);
		
		[Embed(source='assets/playerlegs.png')]
		private const PLAYER2:Class;
		private var legsSprite:Spritemap = new Spritemap(PLAYER2, 100, 100);
		
		[Embed(source='assets/shell.png')]
		private const SHELL:Class;
		private var shellSprite:Spritemap = new Spritemap(SHELL, 80, 30);
		
		[Embed(source='assets/takingHit.png')]
		private const TAKINGHIT:Class;
		private var takingHitSprite:Spritemap = new Spritemap(TAKINGHIT, 155, 140,endHit);
		
		[Embed(source='assets/dying.png')]
		private const DYING:Class;
		private var dyingSprite:Spritemap = new Spritemap(DYING, 100, 100);
		
	
		private var groundSpriteAvailable: Boolean = true;
		private var cooldown: Number = 0;
		private var myAim: Aim;
		private var mirror:Boolean;
		private var invulnerable : Boolean;
		private var takingHitTime: Number;
		private var life: int = 5;
		private var falando: Boolean = false;
		private var chorando: Boolean = false;
			
		
		public function Player()
		{
			super();
			
			setHitbox(60, 100, 30 , 50);
			type = "player";
			
			addGraphic(legsSprite);
			addGraphic(topSprite);
			addGraphic(shellSprite);
			addGraphic(takingHitSprite);
			addGraphic(dyingSprite);
			
			
			legsSprite.add("run", [0, 1, 2], 12, true);
			legsSprite.add("stop", [0], 24, false);
			topSprite.add("animation", [ 1, 2,3], 24, false);
			shellSprite.add("shell", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 24, false);
			takingHitSprite.add("takingHit", [0,1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,14,15,16,17,18,19,20], 24, false);
			dyingSprite.add("dying", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 24, true);

			
			
			y += 50;
			x += 50;
			Image(Graphiclist(graphic).children[0]).originX = 50;
			Image(Graphiclist(graphic).children[0]).originY = 50;
			Image(Graphiclist(graphic).children[1]).originX = 50;
			Image(Graphiclist(graphic).children[1]).originY = 50;
			Image(Graphiclist(graphic).children[2]).originX = 50;
			Image(Graphiclist(graphic).children[2]).originY = 10;
			Image(Graphiclist(graphic).children[3]).originX = 50;
			Image(Graphiclist(graphic).children[3]).originY = 75;
			Image(Graphiclist(graphic).children[4]).originX = 50;
			Image(Graphiclist(graphic).children[4]).originY = 45;

			dyingSprite.visible = false;
			takingHitSprite.visible = false;
			
			
		}
		
		override public function update():void
		{
			super.update();
			checkKeys();
			
			var mouseX:int = FP.world.mouseX;
			var mouseY:int = FP.world.mouseY;
			var deltaX:Number = mouseX - x;
			var deltaY:Number = y - FP.world.mouseY;
			
			mirror = (deltaX < 0);
			
			var angle:Number = Math.atan(deltaY / deltaX);
			
			angle = angle * 180 / Math.PI;
			
			if (angle > 30) {
				angle = 30;	
			} else if (angle < -30) {
				angle = -30;
			}
			
			if (mirror) {
				Image(Graphiclist(graphic).children[1]).scaleX = -1;
				Image(Graphiclist(graphic).children[2]).scaleX = -1;
				legsSprite.scaleX = -1;
			} else {
				Image(Graphiclist(graphic).children[1]).scaleX = 1;
				Image(Graphiclist(graphic).children[2]).scaleX = 1;
				legsSprite.scaleX = 1;
			}
			
			Image(Graphiclist(graphic).children[1]).angle = angle;
			Image(Graphiclist(graphic).children[2]).angle = angle
			
			cooldown += FP.elapsed;
			
			if (Input.mousePressed && cooldown > 0.8 && life >0)
			{
				shoot.play(0.1);
				var i: int = Math.random() * 5.9;
				var j: Number = Math.random() * 1;
				if (falando == false && j > 0.6)
				{
					i = Math.random() * 5.99;
					falando = true;
					v[i].play();
					trace(i);
				}
				cooldown = 0;
				world.add(new Bullet(x, y, Image(Graphiclist(graphic).children[1]).height / 2, angle, mirror));
				
				topSprite.play("animation", true);
				shellSprite.play("shell", true);
				myAim.animate();
				
			}
			
			myAim.x = FP.world.mouseX;
			myAim.y = FP.world.mouseY;
			
			loadSprites();
			
			const camOffs: Number = 200;
			if (x >= FP.camera.x + camOffs)
			{
				FP.camera.x += (x - FP.camera.x - camOffs) * FP.elapsed;
			}
			
			if (life <= 0)
			{
				(FP.world as DefaultScenario).mute();
				FP.world.remove(myAim);
				//gameover.play();
				if ( chorando == false)
				{
					chorando = true;
					choro.loop();
				}
				
			}
		}
		
		public function fimFala():void
		{
			falando = false;
		}
		
		public function loadSprites():void
		{
			if (collideTypes(["enemy","spike"], x, y))
			{
				if (invulnerable == false)
				{
					
					life -= 1;
					takingHitTime = 0;
					takingHitSprite.visible = true;
					takingHitSprite.play("takingHit", true);
					invulnerable = true;
					topSprite.visible = false;
					legsSprite.visible = false;
					shellSprite.visible = false;
					
					if (Math.random() > 0.5)
					{
						dmg1.play();
					}
					else {
						dmg2.play();
					}
					
				}
			}
			
			takingHitTime += FP.elapsed;
			if (takingHitTime > 0.4 && invulnerable == true && life >0)
			{
				topSprite.visible = true;
				legsSprite.visible = true;
				shellSprite.visible = true;
			}
			
			if (life <= 0)
			{
				topSprite.visible = false;
				legsSprite.visible = false;
				takingHitSprite.visible = false;
				shellSprite.visible = false;
				dyingSprite.visible = true;
				dyingSprite.play("dying");
			}
		}
		
		public function endHit():void 
		{
			if (life > 0)
			{
				invulnerable = false;
				topSprite.visible = true;
				legsSprite.visible = true;
				takingHitSprite.visible = false;
				shellSprite.visible = true;
			}
			
		}
		
		public function setMyAim(aim: Aim):void
		{
			myAim = aim;
		}
		
		public function checkKeys():void
		{
			if (life > 0)
			{
				if (Input.check(Key.A) )
				{
					if(left > FP.camera.x)
						moveBy( -5, 0, "block");
					legsSprite.play("run");
					if (groundSpriteAvailable == true && noChao == true)
					{
						world.add(new GroundAnimation(x + Math.random() * 40, y + 60, this,mirror));
						groundSpriteAvailable = false;
					}
					legsSprite.play("run");
				}
				else if (Input.check(Key.D) )
				{
					moveBy( 5, 0, "block");
					if (groundSpriteAvailable == true && noChao == true)
					{
						world.add(new GroundAnimation(x + Math.random() * 40, y + 60, this,mirror));
						groundSpriteAvailable = false;
					}
					legsSprite.play("run");
				}
				else {
					legsSprite.play("stop");
					
				}
				
				if (Input.pressed(Key.W))
				{
					jump();
				} 
			}

		}
		
		public function getLife(): int 
		{
			return life;
		}
		
		public function setGroundSpriteAvailable(available: Boolean):void {
			groundSpriteAvailable = available;	
		}
	
	}

}