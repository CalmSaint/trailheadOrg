@isTest(SeeAllData=false)
public class TestVerifyDate {
	
    @istest
    public static void dateWithin(){
        Date date1=Date.newInstance(2019,3,5);
        Date date2=Date.newInstance(2019,3,15);
        Date rDate=VerifyDate.CheckDates(date1, date2);
        system.assert(rDate==date2,'Some error occurred');
        
    }
    
    @isTest
    public static void dateNotWithin(){
        Date date1=Date.newInstance(2019,3,5);
        Date date2=Date.newInstance(2019,5,15);
        Date rDate=VerifyDate.CheckDates(date1, date2);
        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
        system.assertEquals(rDate,lastDay, 'Date is not equal to last month ,check error');
    }
}