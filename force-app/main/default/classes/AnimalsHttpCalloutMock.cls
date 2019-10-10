@isTest
global class AnimalsHttpCalloutMock implements HttpCalloutMock{
	//implementing the interface method
	
    global HTTPResponse respond(HTTPRequest request){
        //creating a fake response
        
        HTTPResponse response=new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
        response.setStatusCode(201);
        return response;
    }
    
    
    
}