package
{
	import flash.media.Video;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.World;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Anderson Antunes
	 */
	public class DefaultScenario extends World
	{
		
		[Embed(source='assets/spriteVida.png')]
		private const LIFE:Class;
		private var lifeSprite:Spritemap = new Spritemap(LIFE, 365, 94);
		
		[Embed(source = 'assets/sounds/stage1.mp3')]
		private const STAGE1:Class;
		public var stage1: Sfx = new Sfx(STAGE1);
		
		public const TILE_SIZE:uint = 50;
		private var player:Player = new Player();
		private var aim:Aim = new Aim();
		private const AIR:String = " xefb";
		private var lastPos:int = -1;
		private var matriz:Array = [];
		private var mapLenght:int = int.MAX_VALUE;
		private var mapHeight:int = 0;
		private var minLoad:int = 24;
		private var start:Boolean = true;
		protected var background:Entity = new Entity;
		
		private var vidaAnterior: int = 5;
		private var stringVida: Array = ["vida1", "vida2", "vida3", "vida4", "vida5"];
		private var lifeBar:Entity = new Entity;
		
		public function DefaultScenario(file:Class)
		{
			stage1.loop(0.1);
			lifeBar.graphic = lifeSprite;
			this.camera.x = 50;
			add(lifeBar);
			
			lifeSprite.add("vida5", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 24, false);
			lifeSprite.add("vida4", [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 24, false);
			lifeSprite.add("vida3", [20, 21, 22, 23, 24, 25, 26, 27, 28, 29], 24, false);
			lifeSprite.add("vida2", [30, 31, 32, 33, 34, 35, 36, 37, 38, 39], 24, false);
			lifeSprite.add("vida1", [40, 41, 42, 43, 44, 45, 46, 47, 48, 49], 24, false);

			
			Image(lifeSprite).scrollX = 0;
			Image(lifeSprite).scrollY = 0;
			
			var txt:ByteArray = new file() as ByteArray;
			trace("Lendo Mapa:");
			//trace(txt.toString());
			
			var i:int = -1;
			var j:int = 0;
			var w:Boolean = true;
			
			for (var k:int = 0; k < txt.length; k++)
			{
				if (j % mapLenght == 0 && w)
				{
					i++;
					mapHeight++;
					j = 0;
					// Create an array at matriz[p] if undefined.
					if (matriz[i] == undefined)
						matriz[i] = [];
					w = false;
				}
				
				matriz[i][j] = txt.readByte();
				
				if (!(matriz[i][j] == 10 || matriz[i][j] == 13))
				{
					//trace("i:" + i + " j:" + j);
					j++;
					w = true;
				}
				else if (mapLenght == int.MAX_VALUE)
				{
					mapLenght = txt.position - 1;
					//trace("Colunas:" + mapLenght);
				}
				
			}
			
			//trace("Linhas:" + mapHeight);
			
			//Adiciona o jogador e a mira
			aim.layer = -1;
			player.layer = 1;
			add(aim);
			add(player);
			player.setMyAim(aim);
		}
		
		private function ifEq(value:int, chars:String):Boolean
		{
			var tmp:String = String.fromCharCode(value);
			return chars.search(tmp) != -1;
		}
		
		override public function update():void
		{
			super.update();
			
			var currPos:int = FP.camera.x / 50 + 20;
			if (start)
			{
				loadScreen(0, minLoad);
				lastPos = minLoad;
				start = false;
			}
			else if (currPos > lastPos)
			{
				//trace("cenario carregado na posição " + currPos);
				loadScreen(currPos, minLoad);
				lastPos = currPos + minLoad;
			}
			
			var vida: int = player.getLife();
			
			if ( vida != vidaAnterior)
			{
				trace(stringVida[vida]);
				lifeSprite.play(stringVida[vida]);
				vidaAnterior = vida;
			}
		}
		
		public function mute():void
		{
			stage1.stop();
		}
		
		public function killAll():void 
		{
			var array:Array = [];
			getAll(array);
			for each (var e:Entity in array) {
				if (e){
					if (e.type == "enemy") {
						remove(e);
					}
				}
			}
		}
		
		private function getPlayer():Player {
				return player;
		}
		
		private function loadScreen(x:int, width:int):void
		{
			
			var constX:int = x * TILE_SIZE;
			var posX:int = 0;
			var posY:int = 0;
			
			var array:Array = [];
			getAll(array);
			
			for each (var e:Entity in array)
			{
				if (e)
				{
					if (4*e.x + 300 < constX)
					{
						if (e != background && e != lifeBar)
						{
							remove(e);
						}
					}
				}
			}
			
			for (var i:int = 0; i < mapHeight; i++)
			{
				posX = constX;
				for (var j:int = x - 1; j < x + width; j++)
				{
					var v:String = String.fromCharCode(matriz[i][j]);
					if (v == "c")
					{
						var t:String;
						if (i - 1 >= 0)
						{
							if (ifEq(matriz[i - 1][j], AIR))
							{
								add(new Block(posX, posY - 50, "grass"));
							}
						}
						
						if (i + 1 < mapHeight)
						{
							if (ifEq(matriz[i + 1][j], AIR))
							{
								add(new Block(posX, posY + 50, "cave"));
							}
						}
						
						add(new Block(posX, posY, "dirty"));
					}
					else if (v == "x")
					{
						add(new Delimiter(posX, posY));
					}
					else if (v == "p")
					{
						add(new Plataform(posX, posY));
					}
					else if (v == "a")
					{
						var tmp:String;
						if (i - 1 >= 0)
						{
							if (ifEq(matriz[i - 1][j], AIR))
							{
								add(new Spike(posX, posY));
							}
						}
						
						if (i + 1 < mapHeight)
						{
							if (ifEq(matriz[i + 1][j], AIR))
							{
								add(new Spike(posX, posY + 50, true));
							}
						}
					}
					else if (v == "b")
					{
						add(new Box(posX, posY));
					}
					else if (v == "e")
					{
						add(new Cockroach(posX, posY - 50));
					}
					else if (v == "s")
					{
						add(new Sheep(posX, posY - 50));
					}
					else if (v == "f")
					{
						add(new FlyingCockroach(posX, posY));
					}
					else if (v == "k")
					{
						add(new Chinelo(posX, posY));
					}
					else if (v == "B")
					{
						add(new SheepBoss(posX, posY));
					}
					posX += TILE_SIZE;
				}
				posY += TILE_SIZE;
			}
		}
	}
}