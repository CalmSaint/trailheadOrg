trigger AccountDeletion on Account (before delete) {
    //prevent the deletion of accounts if they have related opportunities
    
    for(Account a:[SELECT id from Account where id in (Select AccountId from opportunity) and id in :Trigger.old]){
         Trigger.oldMap.get(a.Id).addError(
            'Cannot delete account with related opportunities.');
    }
}