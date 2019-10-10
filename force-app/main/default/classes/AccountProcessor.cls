public class AccountProcessor {
    
    @future
    public static void countContacts(List<String> accountIds){
        List<Account> toUpdate=new List<Account>();
        for(String i:accountIds){
            
            Contact[] countt=[select id from contact where AccountId = :i];
            
            List<Account> a=new List<Account>();
            
            
            a=[select id,Number_of_Contacts__c from Account where id=:i];
            
            if(!a.isEmpty()) {
               
                	(a.get(0)).Number_of_Contacts__c=countt.size();
            		toUpdate.add(a.get(0));    
                
                
            }}	
        
     }
    
            
        
    }