/*
* Developer: Kunal Dixit
* Date: 22-August-2019
* Description: this class will make all HTTP callouts using REST synchronously
*/

global with sharing class IntegrationHandler {
    global static HTTPResponse callout(String payload,String method,String handlerName,Map<String,String> headers,List<String> pathParams,Map<String,String> queryParams){
        HTTPResponse response=null;
        try{
            Integration_Handler__mdt handlerRecord=getHandlerRecord(handlerName);
            if(handlerRecord!=null){
                String endpoint=handlerRecord.API_End_Point__c;
                Integer timeout=Integer.valueOf(handlerRecord.timeout__c);
                
                //concatenating path parameters
                for(String path:pathParams){
                    endpoint+='/'+path;
                }
                
                //concatenating query parameters
                for(String queryParam:queryParams.keySet()){
                    if(endpoint.contains('?')){
                        endpoint+='&'+queryParam+'='+queryParams.get(queryParam);
                    }
                    else{
                        endpoint+='?'+queryParam+'='+queryParams.get(queryParam);
                    }
                }
                system.debug(endpoint);
                system.debug(method);
                HTTPRequest request=new HTTPRequest();
                request.setEndpoint(endpoint);
                request.setBody(payload);
                request.setTimeout(timeout);
                request.setMethod(method);
                
                for(String header:headers.keySet()){
                    request.setHeader(header,headers.get(header));
                }
                
                HTTP http=new HTTP();
                response=http.send(request);
                system.debug('response--->'+response);
            }
        }
        catch(Exception e){
            system.debug('Error Occurred: '+e.getMessage());
            system.debug('Error Occurred on Line Number: '+e.getLineNumber());
            system.debug(e.getStackTraceString());
        }
        return response;
    }
    
    //method to fetch the Integration Handler record
    public static Integration_Handler__mdt getHandlerRecord(String handlerName){
        Integration_Handler__mdt metaRecord=null;
        try{
            String query='select Handler_Name__c,API_End_Point__c,timeout__c from Integration_Handler__mdt where Handler_Name__c=:handlerName';
            Integration_Handler__mdt handlerRecord=Database.query(query);
            if(handlerRecord!=null)
                metaRecord=handlerRecord;
        }
        catch(Exception e){
            system.debug('Exception Occurred: '+e.getStackTraceString());
            throw e;
        }
        return metaRecord;
    }
    
}