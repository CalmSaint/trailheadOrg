trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
	List<Task> taskList=new List<Task>();
    for(opportunity o:[select id from opportunity where id in :Trigger.new and StageName='Closed Won']){
        Task t=new Task(WhatId=o.Id,Subject='Follow Up Test Task');
        taskList.add(t);
    }
    insert taskList;
}