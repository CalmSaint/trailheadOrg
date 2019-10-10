/*
 * Developer: Kunal Dixit
 * Date: 22-08-2019
 * Description: Test class for IntegrationHandler class
*/
@isTest
global class IntegrationHandlerTest {
	
    @isTest
    global static void getCalloutTestPositive(){
    	Test.setMock(HttpCalloutMock.class,new IntegrationHandlerMockCallout());
        String handlerName='AnimalLocator';
        String payload='';
        String method='GET';
        Map<String,String> headers=new Map<String,String>();
        headers.put('Authorization','OAuth '+UserInfo.getSessionId());
        headers.put('Accept','application/json');
        Map<String,String> queryParams=new Map<String,String>();
        List<String> pathParams=new List<String>{String.valueOf(1)};
        Test.startTest();
        HttpResponse response=IntegrationHandler.callout(payload,method,handlerName,headers,pathParams,queryParams);
        Test.stopTest();
        system.assert(response!=null);
        system.assertEquals(200, response.getStatusCode());
        system.assertEquals('{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}', response.getBody());
    }
    
    @isTest
    global static void getHandlerRecordTestPositive(){
        String handlerName='AnimalLocator';
        Test.startTest();
        Integration_Handler__mdt handlerRecord=IntegrationHandler.getHandlerRecord(handlerName);
        Test.stopTest();
        system.assertEquals('https://th-apex-http-callout.herokuapp.com/animals',handlerRecord.API_End_Point__c);
    }
    
    @isTest
    global static void getHandlerRecordTestNegative(){
        String handlerName='TempMetadata';
        Integration_Handler__mdt handlerRecord=null;
        Test.startTest();
        try{
            handlerRecord=IntegrationHandler.getHandlerRecord(handlerName);
        }
        catch(Exception e){
            e.getStackTraceString();
        }
        Test.stopTest();
        system.assert(handlerRecord==null);
        
    }
}