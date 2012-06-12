package sample
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.setTimeout;
	import starling.core.Starling;	
	/**
	 * ...
	 * @author narongrit@3dsinteractive.com
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			this.addEventListener(Event.ADDED_TO_STAGE , init );
		}
		
	
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var viewport:Rectangle = new Rectangle(0, 0, stage.stageWidth , stage.stageHeight);
			
			var _starling:Starling = new Starling(Game, stage,viewport);
			_starling.stage.stageWidth = 320;
			_starling.stage.stageHeight = 480;
			_starling.start();
			_starling.showStats = true;
		}
		
		
	}
	
}