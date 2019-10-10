@IsTest
public class AccountTriggerTest {
    @IsTest
    public static void TriggerTest(){
        List<Account> toInsert=new List<Account>();
    for(Integer i=0;i<200;i++){
        Account account=new Account();
        account.Name='Test'+i;
        account.BillingState='CA';
        account.ShippingState='AB';
        toInsert.add(account);
    }
    Test.startTest();
    insert toInsert;
    
    Iterator<Account> data=toInsert.iterator();
        while(data.hasNext()){
            Account acc=data.next();
            system.assertEquals('CA', acc.ShippingState);
        }
        Test.stopTest();
    }
    
    
}