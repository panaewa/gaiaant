package com.desarrolloflash.net
{
	import com.gaiaframework.debug.GaiaDebug;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.Responder;
	
	public class BaseServer implements IEventDispatcher
	{
		public static var rs:RemotingService;
		public static var gateway:String;
		public static var dispatcher:EventDispatcher;
		public static var responder:Responder;
		public static var isPending:Boolean;
		
		private static var _instance:BaseServer;
		
		public function BaseServer(url:String)
		{
			BaseServer.gateway = url;
			BaseServer.rs = new RemotingService(BaseServer.gateway);
			BaseServer.responder = new Responder(onResult, onFault);
			BaseServer.dispatcher = new EventDispatcher(this);				
		}
		
		public static function birth(url:String):void
		{
			if (_instance == null) _instance = new BaseServer(url);
		}
		public static function get instance():BaseServer
		{
			return _instance;
		}		

		public static function call(service:String, method:String, parametros:Object = null, resp:Responder = null):void
		{
			var methodCall:String = service + "." + method;
			GaiaDebug.log(methodCall);
			if ( resp == null )
				BaseServer.rs.call(methodCall, BaseServer.responder, parametros);
			else {			
				GaiaDebug.log("Object: " + parametros);
				GaiaDebug.log("Responder: " + resp);
				GaiaDebug.log("RemotingService: " + BaseServer.rs);
				BaseServer.rs.call(methodCall, resp, parametros);
			}
			BaseServer.isPending = true;
		}
		
		protected function onResult(event:Object):void
		{
			GaiaDebug.log("RESULT");
			BaseServer.isPending = false;
		}
		
		protected function onFault(event:Object):void
		{
			GaiaDebug.log("FAULT");
			BaseServer.isPending = false;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			dispatcher.addEventListener(type, listener, useCapture, priority);
		}
		public function dispatchEvent(evt:Event):Boolean {
			return dispatcher.dispatchEvent(evt);
		}
		public function hasEventListener(type:String):Boolean {
			return dispatcher.hasEventListener(type);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		public function willTrigger(type:String):Boolean {
			return dispatcher.willTrigger(type);
		}		

	}
}
