@isTest
public class LeadProcessorTest {
	@isTest
    public static void leadUpdateTest(){
        List<Lead> leadsToAdd=new List<Lead>();
        for(Integer i=1;i<=200;i++){
            Lead lead=new Lead();
            lead.FirstName='Lead';
            lead.LastName=i+'';
            lead.Company='Google';
            lead.Status='Open - Not Contacted';
            leadsToAdd.add(lead);
        }
        insert leadsToAdd;
        Test.startTest();
        LeadProcessor lp=new LeadProcessor();
        id batchId=Database.executeBatch(lp);
        Test.stopTest();
        System.assertEquals(200, [select count() from Lead where LeadSource='Dreamforce']);
    }
}