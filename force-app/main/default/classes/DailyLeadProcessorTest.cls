@IsTest
public class DailyLeadProcessorTest {
	@IsTest
    public static void leadProcessorTest(){
        List<Lead> toInsert=new List<Lead>();
        for(Integer i=0;i<200;i++){
            Lead lead=new Lead();
            
            lead.LastName='Test'+i;
            lead.Company='Infosys';
            lead.Status='Open - Not Contacted';
            toInsert.add(lead);
        }
        insert toInsert;
        Test.startTest();
        String jobId=system.schedule('Testing job Scheduler','0 0 13 ? * * *', new DailyLeadProcessor());
        Test.stopTest();
        
    }
}