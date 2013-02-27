package  example
{

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
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
		private var images:Vector.<Image>;
		
		public function Game() 
		{
			
			AssetsLibrary.initLibrary("lib.xml");
			
			
			AssetsLibrary.prepareTextures( ["texture1"  ]   ,onComplete);
			
		}
		
		private function onComplete():void 
		{
			
			// Image Texture
			var texture:Texture = AssetsLibrary.getTexture("texture1") as Texture;
			images = new Vector.<Image>();
			var img:Image;
			
			for (var i:int = 0 ; i <= 100 ; i++ ) {
				img = new Image(texture);
				
				img.x = Math.random() * Starling.current.stage.stageWidth;
				img.y = Math.random() * Starling.current.stage.stageHeight;
				img.scaleX = img.scaleY = Math.random();
				
				addChild(img);
				
				images.push(img);
			}
			
			this.addEventListener( EnterFrameEvent.ENTER_FRAME , loop );
		}
		
		private function loop(e:EnterFrameEvent):void 
		{
			for (var i:String in images) {
				images[i].x += 10*(1-images[i].scaleX);
				if ( images[i].x > Starling.current.stage.stageWidth + images[i].width ) {
					images[i].y = Math.random() * Starling.current.stage.stageHeight;
					images[i].scaleX = images[i].scaleY = Math.random();
					images[i].x = -images[i].width;
				}
			}
		}
		
		
		
	}
}