﻿/*****************************************************************************************************
* Gaia Framework for Adobe Flash ©2007-2009
* Author: Steven Sacks
*
* blog: http://www.stevensacks.net/
* forum: http://www.gaiaflashframework.com/forum/
* wiki: http://www.gaiaflashframework.com/wiki/
* 
* By using the Gaia Framework, you agree to keep the above contact information in the source code.
* 
* Gaia Framework for Adobe Flash is released under the GPL License:
* http://www.opensource.org/licenses/gpl-2.0.php 
*****************************************************************************************************/

package pages
{
	import com.gaiaframework.templates.AbstractPreloader;
	import com.gaiaframework.api.Gaia;
	import com.gaiaframework.events.*;
	import com.greensock.TweenMax;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	public class PreloaderScaffold extends Sprite
	{
		public var TXT_Overall:TextField;
		public var TXT_Asset:TextField;
		public var TXT_Bytes:TextField;
		public var MC_Bar:Sprite;
		
		public function PreloaderScaffold()
		{
			super();
			alpha = 0;
			visible = false;
			mouseEnabled = mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		public function transitionIn():void
		{
			TweenLite.to(this, .1, {autoAlpha:1});
		}
		public function transitionOut():void
		{
			TweenLite.to(this, .1, {autoAlpha:0});
		}
		public function onProgress(event:AssetEvent):void
		{
			// if bytes, don't show if loaded = 0, if not bytes, don't show if perc = 0
			// the reason is because all the files might already be loaded so no need to show preloader
			//visible = event.bytes ? (event.loaded > 0) : (event.perc > 0);
			
			// multiply perc (0-1) by 100 and round for overall 
			//TXT_Overall.text = "Loading " + Math.round(event.perc * 100) + "%";
			
			// individual asset percentage (0-1) multiplied by 100 and round for display
			//var assetPerc:int = Math.round(event.asset.percentLoaded * 100) || 0;
			//TXT_Asset.text = (event.asset.title || event.asset.id) + " " + assetPerc + "%";
			//TXT_Asset.autoSize = TextFieldAutoSize.LEFT;
			
			// progress bar scale times percentage (0-1)
			//MC_Bar.scaleX = event.perc;
			
			// if bytes is true, show the actual bytes loaded and total
			//TXT_Bytes.text = (event.bytes) ? event.loaded + " / " + event.total : "";
			//TXT_Bytes.autoSize = TextFieldAutoSize.LEFT;
		}
		private function onResize(event:Event = null):void
		{
			x = (Gaia.api.getWidth() - width) / 2;
			y = (Gaia.api.getHeight() - height) / 2;
		}
	}
}
