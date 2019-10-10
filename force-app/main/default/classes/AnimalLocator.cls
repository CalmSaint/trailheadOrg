public class AnimalLocator {
    
    public static String getAnimalNameById(Integer id){
        
        String handlerName='AnimalLocator';
        String payload='';
        String method='GET';
        Map<String,String> headers=new Map<String,String>();
        headers.put('Authorization','OAuth '+UserInfo.getSessionId());
        headers.put('Accept','application/json');
        Map<String,String> queryParams=new Map<String,String>();
        List<String> pathParams=new List<String>{String.valueOf(id)};
        HttpResponse response=IntegrationHandler.callout(payload,method,handlerName,headers,pathParams,queryParams);
        String name=null;
        if(response.getStatusCode()==200){
            Map<String,Object> resp=(Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            Map<String,Object> animal=(Map<String,Object>)resp.get('animal');
            name=String.valueOf(animal.get('name'));
        }
        
        return name;
    }

}