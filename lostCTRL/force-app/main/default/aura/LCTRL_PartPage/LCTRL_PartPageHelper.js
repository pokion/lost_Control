/**
 * Created by cezary.bubieniec on 05.10.2022.
 */

({

    getAllParts: function(cmp, nameOfClass, params, callback){
        let event = cmp.get(nameOfClass);

        if(params != null){
            event.setParams(params);
        }

        event.setCallback(this, (response)=>{
            let state = response.getState();
            if(state == 'SUCCESS'){
                let data = JSON.parse(response.getReturnValue());
                callback(data);
            }else{
                console.log('response else', response);
            }
        })
        $A.enqueueAction(event);
    },

    getColumns: function(){
        return [
            {label: 'Part name', fieldName: 'URLpart', type: 'url', typeAttributes: {
                label:{
                    fieldName: 'partName'
                },
                target: '_self'
            }},
            {label: 'Value name', fieldName: 'URLvalue', type: 'url', typeAttributes: {
                label:{
                    fieldName: 'valueName'
                },
                target: '_self'
            }},
            {type: 'action', typeAttributes: {rowActions: [
                {label: 'Edit', name: 'edit'},
                {label: 'Delete', name: 'delete'}
            ]}}
        ]
    }

});