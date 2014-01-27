package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class Character extends Entity
	{
		
		protected var velocityY:Number = 0;
		protected var velocityX:Number = 0;
		protected var gravity:Number = 150;
		protected var offsetY: int;
		protected var noChao: Boolean;
		
		public function Character()
		{
			x = 150;
			y = 50;
		}
		
		// teste com o mouse
		override public function update():void
		{
			
			if (collideTypes(["block","plataform"], x, y + originY) && velocityY >= 0 )
			{
				if (noChao == false)
				{
					y = y - (this.originY + y)%50 +50
					//trace(y);
					noChao = true;
					velocityY = 0;
				}				
				//y += offsetY;
				//trace(noChao);
			}
			else {
				noChao = false;
			}
			
			if (noChao == false)
			{
				y += velocityY;
				velocityY += gravity*FP.elapsed;
			}
			
			//if(velocityY != 0)
			//trace(velocityY);
		}
		
		public function jump(height:int = 30):void
		{
			if (noChao == true)
			{
				velocityY = -height;
				noChao = false;
			}
		}
		
		public function setOffsetY(offset: int): void //distancia da origem y ateh o chao 
		{
			offsetY = offset;
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
	
	}
}