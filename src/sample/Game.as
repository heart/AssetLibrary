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
		
		public function Game() 
		{
			AssetsLibrary.initLibrary("Library.xml");
			
			AssetsLibrary.prepareTextures(["texture1" , "texture2"],onComplete);
		}
		
		private function onComplete():void 
		{
			
			// Image Texture
			var texture:Texture = AssetsLibrary.getTexture("texture2") as Texture;
			var img1:Image = new Image(texture);
			addChild(img1);
			
			
			//AtlasTexture
			var atlas1:TextureAtlas = AssetsLibrary.getTexture("texture1") as TextureAtlas;
			
			var greenCat:Texture = atlas1.getTexture("greenCat");
			var orangeCat:Texture = atlas1.getTexture("orangeCat");
			var redCat:Texture = atlas1.getTexture("redCat");
			var yellowCat:Texture = atlas1.getTexture("yellowCat");
			
			var cat1:Image = new Image(greenCat);
			var cat2:Image = new Image(orangeCat);
			var cat3:Image = new Image(redCat);
			var cat4:Image = new Image(yellowCat);
			
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
			if (t!=null) {
				trace('touch');
			}
		}
		
		
	}
}