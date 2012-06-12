package starling.extensions.s3d 
{
	import starling.textures.Texture;
	/**
	 * ...
	 * @author narongrit@3dsinteractive.com
	 */
	public class AssetsLibrary 
	{
		
		public static function initLibrary( xmlLibrary:String):void {
			Library.getIntance().initLibrary( xmlLibrary );
		}
		
		public static function prepareTextures( textureList:Array , onComplete:Function  ):void {
			Library.getIntance().prepareTextures( textureList , onComplete );
		}
		public static function getTexture( textureName:String ):* {
			return Library.getIntance().getTexture(textureName);
		}
		public static function disposeTextures( textureList:Array ):void {
			Library.getIntance().disposeTextures(textureList);
		}
			
		
	}

}