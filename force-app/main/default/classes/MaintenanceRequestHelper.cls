public class MaintenanceRequestHelper {
    
    //to create new cases
    public static void createRequests(List<Case> cases){
        List<Case> toCreate=new List<Case>();
        for(Case oldCase:cases){
        	Case newCase=new Case();
        	newCase.Equipment__c=oldCase.Equipment__c;
            newCase.Product__c=oldCase.Product__c;
            newCase.Vehicle__c=oldCase.Vehicle__c;
            
            newCase.Type='Routine Maintenance';
            newCase.Date_Reported__c=System.today();
            newCase.Subject='Routine check up Request';
            newCase.Origin=oldCase.Origin;
            toCreate.add(newCase);
        }
        if(!toCreate.isEmpty())
        	insert toCreate;
        
        
        
    }
    
    public static void updateWorkOrders(){
        // update workorders
    }        
    
}