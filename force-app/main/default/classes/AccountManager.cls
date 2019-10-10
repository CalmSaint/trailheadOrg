@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    
    @HttpGet
    global static Account getAccount(){
        RestRequest request=RestContext.request;
        
        //fetching the AccountId
        String accountId=request.requestURI.substringBetween('Accounts/','/contacts');
        Account account=[select Id,Name,(Select Id,Name from Account.Contacts) from Account where Account.Id=:accountId];
        return account;
        
        
    }

}