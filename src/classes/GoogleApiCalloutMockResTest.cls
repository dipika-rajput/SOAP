@isTest
global class GoogleApiCalloutMockResTest implements HttpCalloutMock{
		protected Integer code;
		protected String status;
		protected String bodyAsString;
		

		public GoogleApiCalloutMockResTest(Integer code, String status, String body)
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
			return resp;
	    }
    
}