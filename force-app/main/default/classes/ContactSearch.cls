public class ContactSearch {
    public static Contact[] searchForContacts(String lastName,String postalCode){
        Contact[] contact=[SELECT Name FROM Contact WHERE (LastName=:lastName AND MailingPostalCode=:postalCode)];
        return contact;
    }
}