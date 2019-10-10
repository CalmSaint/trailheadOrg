/*
 * Developer: Kunal Dixit
 * Date: 27-08-2019
 * Description: Test class for Logger framework
*/ 

@IsTest
global class LoggerTest {

    global static testmethod void getLoggerTest(){
        String loggerName='DelhiveryManager';
        Test.startTest();
        Logger logger=Logger.getLogger(loggerName);
        Test.stopTest();
        system.assert(logger!=null);
        
    }
    
    global static testmethod void getLoggerTypeTest(){
        String loggerName='DelhiveryManager';
        Test.startTest();
        Type t=Type.forName('Logger');
        Logger logger=Logger.getLogger(t);
        Test.stopTest();
        system.assert(logger!=null);
        
    }
    
    global static testmethod void logMessagesTest(){
        String typeName='Error';
        String request='Test Request';
        String response='Test Response';
        String stackTrace='Test StackTrace';
        String statusCode='202';
        String message='Test message';
        
        Test.startTest();
        Logger logger=Logger.getLogger('testName');
        logger.logMessages(typeName, request, response, stackTrace, statusCode, message);
        logger.exitLogger();
        Test.stopTest();
        List<Application_Log__c> logs=[select Apex_Class__c,Message__c,Request__c,Response__c,Stack_Trace__c,Status_Code__c,Type__c from Application_Log__c where Apex_Class__c='testName'];
        system.assert(logs.size()>0,'Error: No logs inserted');
        if(logs.size()>0){
            system.assertEquals('Test Request',logs[0].request__c);
            system.assertEquals('Test Response',logs[0].response__c);
            system.assertEquals('Test StackTrace',logs[0].stack_Trace__c);
            system.assertEquals('202',logs[0].status_code__c);
            system.assertEquals('Test message',logs[0].message__c );
        }
    }
    
    global static testmethod void logMessagesControllerTest(){
        String json='{"apexClass":"testName","message":"custom error message","request":"Sample_request","response":"Sample Response","stackTrace":"Sample_StackTrace","statusCode":"200","typeName":"Error"}';
        Test.startTest();
        Logger logger=Logger.getLogger('testName');
        logger.logMessages(json);
        logger.exitLogger();
        Test.stopTest();
        List<Application_Log__c> logs=[select Apex_Class__c,Message__c,Request__c,Response__c,Stack_Trace__c,Status_Code__c,Type__c from Application_Log__c where Apex_Class__c='testName'];
        system.assert(logs.size()>0,'Error: No logs inserted');
        if(logs.size()>0){
            system.assertEquals('testName',logs[0].Apex_Class__c);
            system.assertEquals('Sample_request',logs[0].request__c);
            system.assertEquals('Sample Response',logs[0].response__c);
            system.assertEquals('Sample_StackTrace',logs[0].stack_Trace__c);
            system.assertEquals('200',logs[0].status_code__c);
            system.assertEquals('custom error message',logs[0].message__c );
        }
    }
}