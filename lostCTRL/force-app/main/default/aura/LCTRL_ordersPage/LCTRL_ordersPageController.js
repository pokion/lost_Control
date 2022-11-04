({
    doInit : function(cmp, event, helper) {
        let getOrders = cmp.get('c.getAllOrders');
        let ordersData;
        getOrders.setCallback(this, (response)=>{
            let state = response.getState();
            if(state == 'SUCCESS'){
                cmp.set('v.data', JSON.parse(response.getReturnValue()));
                console.table(ordersData);
            }else{
                console.log('response else', response);
            }
        })
        $A.enqueueAction(getOrders); 

        

        cmp.set('v.columns', [
            {label: 'Order Number', fieldName: 'Name', type: 'text'},
            {label: 'Quantity', fieldName: 'Quantity__c', type: 'text'},
            {type: 'action', typeAttributes: {rowActions: [
                {label: 'View', name: 'view'}
            ]}}
        ]);
    },

    handleRowAction: function(cmp,event,helper){
        let action = event.getParam('action');
        let row = event.getParam('row');

        switch (action.name){
            case 'view':
                cmp.set('v.selectedOrder', row);
                cmp.set('v.isview', true);
                break;

            case 'edit':
            
                break;
        }
    },

    modalSwitch: function(cmp,event,helper){
        cmp.set('v.isview', true);
    },
    modalExit: function(cmp){
        cmp.set('v.isview', false);
    }
})