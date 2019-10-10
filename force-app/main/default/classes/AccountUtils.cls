public class AccountUtils {
    
    private String state;
    public AccountUtils(String state){
        this.state=state;
    }
    public static Account[] accountsByState (String state){
        Account[] accounts=[select id,name from Account where BillingState=:state];
        return accounts;
    }

}