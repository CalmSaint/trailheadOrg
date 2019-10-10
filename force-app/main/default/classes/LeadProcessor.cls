global class LeadProcessor implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select leadSource from Lead');
    }
    
    global void execute(Database.BatchableContext bc,List<Lead> leads){
        List<Lead> toUpdate=new List<Lead>();
        for(Lead lead:leads){
            lead.LeadSource='Dreamforce';
            toUpdate.add(lead);
        }
        update toUpdate;
    }
    
    global void finish(Database.BatchableContext bc){
        //nothing to implement
    }
}