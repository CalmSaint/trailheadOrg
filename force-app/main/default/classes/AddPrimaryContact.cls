public class AddPrimaryContact implements Queueable {
    private Contact contact;
    private String state;
    
    public AddPrimaryContact(Contact contact,String state){
        this.contact=contact;
        this.state=state;
    }
    
    public void execute(QueueableContext context){
       Account[] accs=[select id from Account where BillingState=:state limit 200];
       List<Contact> toInsert=new List<Contact>();
       for(Account a:accs){
            Contact con=contact.clone(false,false,false,false);
            con.AccountId=a.id;
           toInsert.add(con);
       }
        insert toInsert;
     }
    

}