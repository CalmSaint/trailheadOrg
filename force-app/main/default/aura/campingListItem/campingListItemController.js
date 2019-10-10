({
	packItem : function(component, event, helper) {
		var buttonClicked=event.getSource();
        alert(buttonClicked);
        component.set("v.item.packed__c",true);
        buttonClicked.set("v.disabled",true);
        
	}
})