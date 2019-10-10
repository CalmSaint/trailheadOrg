@isTest
public class AccountManagerTest {
    @isTest public static void testGetAccount(){
        Account acc=new Account();
        acc.Name='test Account';
        insert acc;
        Contact con=new Contact();
        con.LastName='ValidName';
        con.AccountId=acc.Id;
        insert con;
        
        RestRequest request=new RestRequest();
        request.requestURI='https://curious-fox-7etyuh-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+acc.Id+'/contacts';
        request.httpMethod='GET';
        
        RestContext.request=request;
        Account account=AccountManager.getAccount();
        System.assert(account!=null);
        System.assertEquals(acc.Id, account.Id);
        
    }
}