trigger ExampleTrigger on Contact (after insert,after delete) {
    if(Trigger.isInsert){
        Integer recordCount=Trigger.new.size();
        //calling the utility method
        EmailManager.sendMail('kunal.dixit@infosys.com','Trigger Test',recordCount+' records are inserted in database.');
    }
    else if(Trigger.isDelete){
        Integer recordCount=Trigger.old.size();
        //calling the utility method
        EmailManager.sendMail('kunal.dixit@infosys.com','Trigger Test',recordCount+' records are deleted from the database.');
    }
}