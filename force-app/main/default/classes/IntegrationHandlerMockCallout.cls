/*
 * Developer: Kunal Dixit
 * Date: 23-08-2019
 * Description: Test Class implementing HttpCalloutMock interface to test IntegrationHandler class
*/ 

@isTest
public class IntegrationHandlerMockCallout implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest request){
        HTTPResponse response=null;
        if(request.getMethod().equals('GET')){
            response=getDefaultResponse(200);
            response.setBody('{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}');
        }
        
        if(request.getMethod().equals('POST')){
            if(!String.isEmpty(request.getBody())){
            	response=getDefaultResponse(200);
            	response.setBody('{"status":"Success"}');    
            }
            else{
                response=getDefaultResponse(404);
            	response.setBody('{"status":"Error"}');
            }
            
        }
        return response;
    }
    
    public HTTPResponse getDefaultResponse(Integer statusCode){
        HttpResponse response=new HttpResponse();
        response.setStatusCode(statusCode);
        response.setHeader('Content-Type','application/json');
        return response;
    }
}