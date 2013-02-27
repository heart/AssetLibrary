package starling.extensions.s3d 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author narongrit@3dsinteractive.com
	 */
	public class AssetsLoader extends EventDispatcher
	{
		public var callBack:Function;
		private var textureName:Array;
		private var loadCount:int = 0;
		public var textures:Object = { };
		
		public function AssetsLoader( textureName:Array , callBack:Function):void
		{
			this.callBack = callBack;
			this.textureName = textureName;
		}
		
		public function startLoadTexture():void {
			var imageFile:File;
			var xmlFile:File;
			var fs:FileStream;
			var xmlData:ByteArray;
			var imageData:ByteArray;
			var length:int = textureName.length;
			var loader:LoaderTexture;
			var library:Library = Library.getIntance();
			for (var i:int = 0; i < length ; i++ ) {
				
				if ( !library.textureExist(textureName[i]) ) {
					if ( library.xml.image.(@name == textureName[i]) ) {
						imageData = new ByteArray();
						xmlData = new ByteArray();
						
						imageFile = File.applicationDirectory.resolvePath( library.texturePath+"/"+library.xml.image.(@name == textureName[i]).@src );
						fs = new FileStream();
						fs.open( imageFile , FileMode.READ );
						fs.readBytes(imageData);
						fs.close();
						
						loader = new  LoaderTexture();
						loader.textureName = textureName[i];
						
						if( library.xml.image.(@name == textureName[i]).@type == "atlas" ){
							xmlFile = File.applicationDirectory.resolvePath( library.texturePath+"/"+library.xml.image.(@name == textureName[i]).@xml );
							fs.open(xmlFile , FileMode.READ);
							fs.readBytes(xmlData);
							fs.close();
							loader.atlasXml = new XML(xmlData.readUTFBytes(xmlData.length));
						}
						
						loader.loadBytes(imageData,onloadimageComplete);
						
					}
				}else {
					loadCount++;
					if (loadCount == textureName.length) {
						loadFinish();
					}
				}
			}
		}
		
		private function onloadimageComplete(loader:LoaderTexture):void 
		{
			var texture:Texture = Texture.fromBitmap(loader.bitmap, true, false, Starling.contentScaleFactor);
			loadCount++;
			if (loader.atlasXml) {
				textures[loader.textureName] = new TextureAtlas(texture, loader.atlasXml );
			}else {
				textures[loader.textureName] = texture;
			}
			
			if (loadCount == textureName.length) {
				loadFinish();
			}
		}
		
		private function loadFinish():void {
			dispatchEvent(new Event(Event.COMPLETE));
			textures = null;
			callBack = null;
		}
	}
}

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.utils.ByteArray;

class LoaderTexture {
	private var callBack:Function;
	private var loader:Loader;
	public var atlasXml:XML;
	public var textureName:String;
	public var bitmap:Bitmap;
	
	public function LoaderTexture() { }
	
	public function loadBytes( byteArray:ByteArray , callBack:Function ):void {
		this.callBack = callBack;
		loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE , loaded );
		loader.loadBytes(byteArray);
	}
	
	private function loaded(e:Event):void 
	{
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE , loaded );
		
		bitmap = e.target.content as Bitmap;
		callBack(this);
		
		loader = null;
	}
}