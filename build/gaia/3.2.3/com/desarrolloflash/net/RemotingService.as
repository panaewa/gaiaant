package com.desarrolloflash.net
{    
	import flash.net.NetConnection;    
	import flash.net.ObjectEncoding;        
	public class RemotingService extends NetConnection    
	{                
		function RemotingService(url:String)        
		{            
			objectEncoding = ObjectEncoding.AMF3;            
			connect(url);        
		}    
	}
}
