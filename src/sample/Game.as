package  sample
{

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.s3d.AssetsLibrary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author narongrit@3dsinteractive.com
	 */
	public class Game extends Sprite
	{
		private var cat1:Image;
		private var cat2:Image;
		private var cat3:Image;
		private var cat4:Image;
		private var img1:Image;
		private var big:Image;
		
		public function Game() 
		{
			
			AssetsLibrary.initLibrary("Library.xml");
			
			
			AssetsLibrary.prepareTextures( ["texture1" , "texture2" ]   ,onComplete);
			
		}
		
		private function onComplete():void 
		{
			
			// Image Texture
			var texture:Texture = AssetsLibrary.getTexture("texture2") as Texture;
			
			
			img1 = new Image(texture);
			addChild(img1);
			
			
			//AtlasTexture
			var atlas1:TextureAtlas = AssetsLibrary.getTexture("texture1") as TextureAtlas;
			
			var greenCat:Texture = atlas1.getTexture("greenCat");
			var orangeCat:Texture = atlas1.getTexture("orangeCat");
			var redCat:Texture = atlas1.getTexture("redCat");
			var yellowCat:Texture = atlas1.getTexture("yellowCat");
			
			cat1 = new Image(greenCat);
			cat2 = new Image(orangeCat);
			cat3 = new Image(redCat);
			cat4 = new Image(yellowCat);
			
			addChild(cat1);
			addChild(cat2);
			addChild(cat3);
			addChild(cat4);
			
			cat1.x = 0;
			cat2.x = 50;
			cat3.x = 100;
			cat4.x = 150;
			//============
			
			this.addEventListener(TouchEvent.TOUCH , onTouch );
			
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			
			var t:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (t) {
				this.removeEventListener(TouchEvent.TOUCH , onTouch );
				
				trace('dispose all texture');
				
				removeChild(cat1 , true);
				removeChild(cat2, true);
				removeChild(cat3, true);
				removeChild(cat4, true);
				removeChild(img1, true);
				
				removeChild(big, true);
				
				AssetsLibrary.disposeTextures(["texture1" , "texture2"]);
			}
			
		}
		
		
	}
}