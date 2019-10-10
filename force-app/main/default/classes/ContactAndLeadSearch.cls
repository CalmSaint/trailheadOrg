public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String parameter){
        List<List<sObject>> lists=[FIND :parameter IN ALL FIELDS RETURNING Contact,Lead];
        return lists;
    }
}