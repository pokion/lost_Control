/**
 * Created by cezary.bubieniec on 05.10.2022.
 */

({

    doInit: function(cmp,event,helper){
       helper.getAllParts(cmp, 'c.getAllParts', {value: ''}, function(data){
           data.forEach(item =>{
               item['URLpart'] = '/lightning/r/PartsToProducts/'+ item['part'].id +'/view';
               item['partName'] = item['part'].name;

               item['URLvalue'] = '/lightning/r/PartsToProducts/'+ item['value'].id +'/view';
               item['valueName'] = item['value'].name;
           })

           //console.table(data);
           cmp.set('v.data', data);
           cmp.set('v.columns', helper.getColumns());
       });
    },

    newProductModalSwitcher: function(cmp,event,helper){
        cmp.set('v.newPart', !cmp.get('v.newPart'));
        cmp.set('v.selectedId', '');
    },

    saveNewPart: function(cmp,event,helper){
        try{
            let toastEvent = $A.get("e.force:showToast");
            let savePart = cmp.get('c.savePart');

            savePart.setParam("partId", cmp.get('v.selectedId'));
            savePart.setParam("value", cmp.find('name').get('v.value'));

            savePart.setCallback(this, (response)=>{
                let state = response.getState();
                if(state == 'SUCCESS'){
                    let data = JSON.parse(response.getReturnValue());
                    if(data.success){
                        toastEvent.setParams({
                            "type": "success",
                            "title": "Specification was created",
                            "message": "Specification was created"
                        });
                        toastEvent.fire();
                        cmp.set('v.newPart', !cmp.get('v.newPart'));
                        cmp.set('v.selectedId', '');

                        helper.getAllParts(cmp, 'c.getAllParts', null, function(data, cmp){
                            data.forEach(item =>{
                                item['URLpart'] = '/lightning/r/PartsToProducts/'+ item['part'].id +'/view';
                                item['partName'] = item['part'].name;

                                item['URLvalue'] = '/lightning/r/PartsToProducts/'+ item['value'].id +'/view';
                                item['valueName'] = item['value'].name;
                            })

                            cmp.set('v.data', data);

                        });

                    }
                }else{
                    console.log('response else', JSON.parse(JSON.stringify(response)));
                }
            })
            $A.enqueueAction(savePart);
        }catch (error){
            console.log(JSON.parse(JSON.stringify(error)), 'es')
        }
    },

    handleRowAction: function(cmp, event, helper){
        let action = event.getParam('action');
        let row = event.getParam('row');

        switch (action.name){
            case 'edit':
                var createRecordEvent = $A.get("e.force:editRecord");

                createRecordEvent.setParams({
                    "recordId": row.value.id,
                    "panelOnDestroyCallback": function(event) {
                        helper.getAllParts(cmp, 'c.getAllParts', {value: ''}, function(data, cmp){
                            data.forEach(item =>{
                                item['URLpart'] = '/lightning/r/PartsToProducts/'+ item['part'].id +'/view';
                                item['partName'] = item['part'].name;

                                item['URLvalue'] = '/lightning/r/PartsToProducts/'+ item['value'].id +'/view';
                                item['valueName'] = item['value'].name;
                            })

                            //console.table(data);
                            cmp.set('v.data', data);
                        });
                    }
                });
                createRecordEvent.fire();
                break;
            case 'delete':
                helper.getAllParts(cmp, 'c.deletePart', {id: row.value.id}, function(){
                    helper.getAllParts(cmp, 'c.getAllParts', {value: ''}, function(data){
                        data.forEach(item =>{
                            item['URLpart'] = '/lightning/r/PartsToProducts/'+ item['part'].id +'/view';
                            item['partName'] = item['part'].name;

                            item['URLvalue'] = '/lightning/r/PartsToProducts/'+ item['value'].id +'/view';
                            item['valueName'] = item['value'].name;
                        })

                        //console.table(data);
                        cmp.set('v.data', data);
                        cmp.set('v.columns', helper.getColumns());
                    });
                });
                break;
        }
    },

    searchProduct: function(cmp,event,helper){
        console.log(cmp.get('v.inputSearch'))
        helper.getAllParts(cmp, 'c.getAllParts', {value: cmp.get('v.inputSearch')}, function(data){
            data.forEach(item =>{
                item['URLpart'] = '/lightning/r/PartsToProducts/'+ item['part'].id +'/view';
                item['partName'] = item['part'].name;

                item['URLvalue'] = '/lightning/r/PartsToProducts/'+ item['value'].id +'/view';
                item['valueName'] = item['value'].name;
            })

             console.table(data);
            cmp.set('v.data', data);
            cmp.set('v.columns', helper.getColumns());
        });
    }
});