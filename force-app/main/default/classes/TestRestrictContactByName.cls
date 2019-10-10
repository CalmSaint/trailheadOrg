@isTest(SeeAllData=false)
public class TestRestrictContactByName {
	
    @isTest
    public static void validTest(){
        Contact contact=new Contact();
        contact.lastName='notInvalid';
        Database.SaveResult result=Database.insert(contact);
        system.assert(result.isSuccess(), 'Some error');
        
    }
    
    @isTest
    public static void invalidTest(){
        Contact contact=new Contact();
        contact.lastName='INVALIDNAME';
        Database.SaveResult result=Database.insert(contact,false);
        system.assert(! result.isSuccess(), 'Contact inserted some error');
    }
}