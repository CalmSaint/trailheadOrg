public class AccountTriggerHandler {
    public static void CreateAccounts(Account[] accounts){
        
        Iterator<Account> data=accounts.iterator();
        while(data.hasNext()){
            Account acc=data.next();
            if(acc.BillingState!=acc.ShippingState){
                acc.ShippingState=acc.BillingState;
                
            }
        }
        
    }
}