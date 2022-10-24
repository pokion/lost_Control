/**
 * Created by cezary.bubieniec on 26.09.2022.
 */

({

    getAllParts: function(cmp){
        let getAllPartsService = cmp.get('c.getAllParts');

        getAllPartsService.setCallback(this, (response)=>{
            let state = response.getState();
            if(state == 'SUCCESS'){

                let parts = JSON.parse(response.getReturnValue());

                cmp.set('v.data',parts);
                console.log(parts)

            }else{
                console.log('response else', response);
            }
        })
        $A.enqueueAction(getAllPartsService);
    },

    setSpecs: function(cmp, object){
        let specs = cmp.get('v.specs');
        let partMessage = object;

        specs.push({
            part: {
                Id: partMessage.Id,
                Name: partMessage.Name
            },
            value: {
                Id: partMessage.Part__r.Id,
                Name: partMessage.Part__r.Name__c
            }
        })

        cmp.set('v.specs', specs);
        cmp.set('v.specSelected', '');
        cmp.set('v.partValue', '');

        let appEvent = $A.get("e.c:specs");
        appEvent.setParams({
            "specifications" : specs});
        appEvent.fire();
    },

    specSelected: function(cmp,event){
        let partMessage = event.getParam("partSelected");
        cmp.set('v.specSelected', partMessage);
    },

    removeSpec: function(cmp, index){
        let specs = cmp.get('v.specs');
        specs.splice(index, 1);
        cmp.set('v.specs',JSON.parse(JSON.stringify(specs)));

        let appEvent = $A.get("e.c:specs");
        appEvent.setParams({
            "specifications" : specs});
        appEvent.fire();
    },

    getDataFromArray: function(array, value){
        let filteredArray = [];

        for(let item of array){
            if(value == item.Part__c) filteredArray.push(item);
        }

        console.log(filteredArray, array, value)

        return filteredArray;

    }

});