global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext sc){
        
        Lead[] leads=[Select LeadSource from Lead where LeadSource=null];
        List<Lead> toUpdate=new List<Lead>();
        
        Iterator<Lead> data=leads.iterator();
        while(data.hasNext()){
        	Lead lead=data.next();
            lead.LeadSource='Dreamforce';
            toUpdate.add(lead);
        }
        update toUpdate;
    }

}