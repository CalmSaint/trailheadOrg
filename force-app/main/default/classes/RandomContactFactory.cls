public class RandomContactFactory {
	
    
    public static List<Contact> generateRandomContacts(Integer num,String lastName){
        List<Contact> cList=new List<Contact>();
        for(Integer i=1;i<=num;i++){
            Contact contact=new Contact();
            contact.FirstName='Test'+i;
            contact.LastName=lastName;
            cList.add(contact);
        }
        return cList;
    }
}