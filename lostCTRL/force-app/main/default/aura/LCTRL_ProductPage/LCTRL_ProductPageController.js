({
    init: function (cmp, event, helper){
        cmp.set('v.columns', [
            {label: 'Product name', fieldName: 'URL', type: 'url', typeAttributes: {
                label:{
                    fieldName: 'name'
                },
                target: '_self'
            }},
            {label: 'Category', fieldName: 'categoryName', type: 'text'},
            {label: 'Quantity', fieldName: 'quantity', type: 'number'},
            {label: 'Price', fieldName: 'price', type: 'currency'},
            {type: 'action', typeAttributes: {rowActions: [
                {label: 'View', name: 'view'},
                {label: 'Edit', name: 'edit'},
                {label: 'Delete', name: 'delete'}
            ]}}
        ]);

        helper.getProducts(cmp, '');
    },

    newProductModalSwitcher: function(cmp, event, helper){
        let state = !cmp.get('v.newProduct');
        cmp.set('v.newProduct', state);
        console.log('no jest', cmp.get('v.newProduct'))
    },

    handleRowAction: function(cmp, event, helper){
        let action = event.getParam('action');
        let row = event.getParam('row');
        let navEvt = $A.get("e.force:navigateToSObject");

        switch (action.name){
            case 'view':
                let navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                      "recordId": row.id
                    });
                navEvt.fire();
                break;
            case 'edit':

                break;
            case 'delete':
                helper.deleteProduct(cmp,row.id);
                break;
        }
    },

    searchProduct: function(cmp,event,helper){
        let search = (cmp.get('v.inputSearch') == undefined) ? '' : cmp.get('v.inputSearch');
        helper.getProducts(cmp, search);
    }

});