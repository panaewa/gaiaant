package com.desarrolloflash.gaia
{
	import com.gaiaframework.core.GaiaMain;
	import com.gaiaframework.debug.GaiaDebug;
	import com.desarrolloflash.net.BaseServer;
	
	import flash.events.Event;
	
	public class GaiaAMFMain extends GaiaMain
	{
		
		public function GaiaAMFMain()
		{
			super();
		}
			
		override protected function init():void
		{
			BaseServer.birth(stage.loaderInfo.parameters.amf_gateway )
			super.init();
		}	
	}
}
