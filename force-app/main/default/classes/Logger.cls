/*
* Developer: Kunal Dixit
* Date: 27-08-2019
* Description: Logger class to insert error logging records in database
*/ 

global with sharing class Logger {
    String loggerName;
    List<Application_Log__c> logList=new List<Application_Log__c>();
    
    //inner class for javascript logger
    global class LogDTO{
        public string apexClass{get;set;}
        public string message{get;set;}
        public string request{get;set;}
        public string response{get;set;}
        public string stackTrace{get;set;}
        public string statusCode{get;set;}
        public string typeName{get;set;}
        
    }
    
    private Logger(String loggerName){
        this.loggerName=loggerName;
    }
    
    //static method to get the logger with loggerName as String
    global static Logger getLogger(String loggerName){
        return new Logger(loggerName);
    }
    
    //static method to get the logger with loggerName as Type
    global static Logger getLogger(Type loggerName){
        return new Logger(loggerName.getName());
    }
    
    //this method will be called to insert the logs from server side
    global void logMessages(String typeName,String request,String response,String stackTrace,String statusCode,String message){
        String truncatedRequest=request;
        String truncatedResponse=response;
        String truncatedStackTrace=stackTrace;
        
        if(request.length()>131070) truncatedRequest=truncatedRequest.substring(0,131070);
        if(response.length()>131070) truncatedResponse=truncatedResponse.substring(0,131070);
        if(stackTrace.length()>32368) truncatedStackTrace=truncatedStackTrace.substring(0,32368);
        
        insertLog(typeName,truncatedRequest,truncatedResponse,truncatedStackTrace,statusCode,message);
    }
    
    
    
    
    //this method will be called to log from client side javascript
    //this method expects a json with peredefined inner class fields
    global void logMessages(String json){
        try{
            LogDTO dto=(LogDTO)System.JSON.deserialize(json,LogDTO.class);
            String truncatedRequest=dto.request;
            String truncatedResponse=dto.response;
            String truncatedStackTrace=dto.stackTrace;
            
            if(truncatedRequest.length()>131070) truncatedRequest=truncatedRequest.substring(0,131070);
            if(truncatedResponse.length()>131070) truncatedResponse=truncatedResponse.substring(0,131070);
            if(truncatedStackTrace.length()>32368) truncatedStackTrace=truncatedStackTrace.substring(0,32368);
            insertLog(dto.typeName,truncatedRequest,truncatedResponse,truncatedStackTrace,dto.statusCode,dto.message);
        }
        catch(Exception e){
            system.debug('Exception: '+e.getStackTraceString());
        }
        
    }
    
    
    
    
    //this method wil actually insert the log
    //in this method we are well withihn governer limits to insert the logs
    private void insertLog(String type,String request,String response,String stackTrace,String statusCode,String message){
        try{
            //checking the governer limits
            if((Limits.getDMLRows() < Limits.getLimitDMLRows()) && 
               (Limits.getDMLStatements() < Limits.getLimitDMLStatements())){
                   
                   Application_Log__c logObject=new Application_Log__c();
                   logObject.Apex_Class__c=this.loggerName;
                   logObject.Message__c=message;
                   logObject.Type__c=type;
                   logObject.Request__c=request;
                   logObject.Response__c=response;
                   logObject.Stack_Trace__c=stackTrace;
                   logObject.Status_Code__c=statusCode;
                   
                   logList.add(logObject);
               }
            else{
                System.debug('The Governor Limits have already been exhausted and hence failed to create a Log!');
            }
        }
        catch(DMLException ex){
            System.debug('Something fatal has occurred and hence failed to create a Log! Error:' + ex.getMessage());
            system.debug('StackTrace: '+ex.getStackTraceString());
        }
        catch(Exception e){
            System.debug('Something fatal has occurred and hence failed to create a Log! Error:' + e.getMessage());
            system.debug('StackTrace: '+e.getStackTraceString());
        }
    }
    
    
    
    global void exitLogger(){
        if(!logList.isEmpty()){
            insert logList;
        }
        logList.clear();
    }
    
}