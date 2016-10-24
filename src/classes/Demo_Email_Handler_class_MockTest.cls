public with sharing class Demo_Email_Handler_class_MockTest implements HttpCalloutMock{
	protected Integer code;
	protected String status;
	protected String bodyAsString;
	public Demo_Email_Handler_class_MockTest(Integer code, String status, String body)
	{
		    this.code = code;
			this.status = status;
			this.bodyAsString = body;
	}
	public HTTPResponse respond(HTTPRequest req) 
    {
	   		HttpResponse resp = new HttpResponse();
			resp.setStatusCode(code);
			resp.setStatus(status);
		    resp.setBody(bodyAsString);
		    system.debug('resp in MockClass:--'+resp);
			return resp; 	
	}
    
}
//Map<String, Object> mapofjson = (Map<String, Object>)JSON.deserializeUntyped('[{"Name": "sForceTest1"}');