@isTest
private class AccountProcessorTest {
	
    @isTest
    private static void testCountContacts(){
        Account a=new Account();
        a.Name='Kunal Dixit';
        insert a;
        Contact c=new Contact();
        c.AccountId=a.id;
        c.FirstName='Kunal';
        c.LastName='Dixit';
        insert c;
        Account aa=new Account();
        aa.Name='Kunal Dixit';
        insert aa;
        List<id> mockList=new List<id>();
        mockList.add(a.Id);
        Test.startTest();
        AccountProcessor.countContacts(mockList);
        
        Test.stopTest();
        
    }
   
}