/**
 * Created by cezary.bubieniec on 23.09.2022.
 */

({

    doInit: function(cmp,event,helper){
        helper.getAllParts(cmp);
    },

    handleSelectedItem: function(cmp,event,helper){
        helper.specSelected(cmp,event);
    },

    detectChangeCatalog: function(cmp){
        let catalog = cmp.get('c.getAllSpecsByCatalog');
        if(catalog){
            let getAllSpecs = catalog;
            getAllSpecs.setParam('catalog', cmp.get('v.catalog'));

            getAllSpecs.setCallback(this, (response)=>{
                let state = response.getState();
                if(state == 'SUCCESS'){
                    let specs = JSON.parse(response.getReturnValue());
                    let parts = [];

                    for(const spec of specs){
                        parts.push({
                            label: spec.Name__c,
                            value: spec.Id
                        })
                    }

                    cmp.set('v.isBlocked', false);
                    cmp.set('v.parts', parts);
                    cmp.set('v.specs', []);
                }else{
                    console.log('response else', response);
                }
            })
            $A.enqueueAction(getAllSpecs);
        }else{
            cmp.set('v.isBlocked', true);
            cmp.set('v.specs', []);
        }
    },

    addSpecHandler: function(cmp,event,helper){
        helper.setSpecs(cmp, cmp.get('v.specSelected'));
    },

    handleDelete: function(cmp,event,helper){
        helper.removeSpec(cmp,event.currentTarget.dataset.idx);
    },

    changeParts: function(cmp,event,helper){
       cmp.set('v.dataParts', helper.getDataFromArray(cmp.get('v.data'), event.getParam('value')))
    }

});