package starling.extensions.s3d 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import starling.core.Starling;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author narongrit@3dsinteractive.com
	 */
	public class Library 
	{
		private static var instance:Library = new Library();
		public var xml:XML;
		
		private var textureDic:Object = { };
		public var texturePath:String;
		
		public function Library() 
		{
			if ( instance ) throw Error("Library Class is Singleton.");
		}
		public static function getIntance():Library {
			return instance;
		}
		
		public function initLibrary( xmlFile:String ):void {
			var file:File = File.applicationDirectory.resolvePath(xmlFile);
			if (file.exists) {
				var data:ByteArray = new ByteArray();
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				fs.readBytes(data);
				fs.close();
				data.position = 0;
				xml = new XML(data.readUTFBytes(data.bytesAvailable));
				
				try {
					xml.directory.(@scale == Starling.contentScaleFactor).name();
					texturePath = xml.directory.(@scale == Starling.contentScaleFactor).@path;
				}catch (e:Error) {
					texturePath = xml.directory[0].@path;
				}
				
			}else {
				throw Error(xmlFile+" not Found.");
			}
		}
		public function getTexture( textureName:String ):* {
			if ( textureExist(textureName) ) {
				return textureDic[textureName];
			}else {
				return null;
			}
		}
		public function textureExist( textureName:String ):Boolean {
			return textureDic.hasOwnProperty(textureName);
		}
		public function prepareTextures( textureName:Array, onComplete:Function ):void {
			var loader:AssetsLoader = new AssetsLoader( textureName , onComplete);
			loader.addEventListener(Event.COMPLETE , loadTextureComplete );
			loader.startLoadTexture();
		}
		private function loadTextureComplete(e:Event):void {
			var loader:AssetsLoader = e.target as AssetsLoader;
			for (var i:String in loader.textures ) {
				textureDic[i] = loader.textures[i]; 
			}
			loader.callBack();
		}
		public function disposeTextures(textureName:Array):void {
			var length:int = textureName.length;
			for (var i:int = 0; i < length ; i++ ) {
				if ( textureExist(textureName[i])  ) {
					textureDic[textureName[i]].dispose();
					delete textureDic[textureName[i]];
				}
			}
		}
		
		
		
		
		
		
	}

}
