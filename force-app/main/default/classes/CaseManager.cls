@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
	
    @HttpGet
    global static Case getCaseById(){
        
        RestRequest request=RestContext.request;
        //grabbing the case Id from the end of URL
        String caseId=request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        Case result=[Select CaseNumber,Subject,Status,origin,Priority from Case where Id=:caseId];
        return result;
    }
    
    @HttpPost
    global static Id createCase(String subject,String status,String origin,String priority){
        Case thisCase=new Case(Subject=subject,Status=status,Origin=origin,Priority=priority);
        insert thisCase;
        return thisCase.Id;
    }
    
    @HttpDelete
    global Static void deleteCase(){
        Restrequest request=RestContext.request;
        String caseId=request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        Case thisCase=[Select Id from case where id=:caseId];
        delete thisCase;
    }
    
    @HttpPut
    global static Id upsertcase(String subject,String status,String origin,String priority,String id){
        Case thisCase=new case(Id=id,Subject=subject,Status=status,Origin=origin,Priority=priority);
        //matching case by Id, if present otherwise, create new Case.
        upsert thisCase;
        //return caseId
        return thisCase.id;
     }
    
    @HttpPatch
    global static id updateCaseFields(){
        RestRequest request=RestContext.request;
        String caseId=request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        Case thisCase=[Select Id from Case where Id=:caseId];
        //deserialize the JSOn String into name value pairs
        Map<String,Object> params=(Map<String,Object>)JSON.deserializeUntyped(request.requestBody.toString());
        //Iterate through each freld and parameter
        for(String fieldName:params.keySet()){
            thisCase.put(fieldName,params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }
}