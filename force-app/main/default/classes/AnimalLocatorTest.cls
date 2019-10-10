@isTest(SeeAllData=false)
public class AnimalLocatorTest {
    @isTest
    public static void testGetCallout(){
        Test.setMock(HttpCalloutMock.class,new AnimalLocatorMock());
        String response=AnimalLocator.getAnimalNameById(1);
        
        system.debug(response);
        system.assert(response.equals('chicken'));
        
    }
	
}