trigger MaintenanceRequest on Case (before update, after update) {
    if(trigger.isUpdate){
        if(trigger.isAfter){
            List<Case> toCreate=new List<Case>();
            for(Case c:Trigger.new){
                if(c.status.equals('Closed') && (c.Type.equals('Repair') || c.Type.equals('Routine Maintenance') )){
                    toCreate.add(c);
                }
            }
            if(!toCreate.isEmpty()) MaintenanceRequestHelper.createRequests(toCreate);
        }
    } 
}