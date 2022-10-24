/**
 * Created by cezary.bubieniec on 26.09.2022.
 */

({
    toggleResult: function(cmp,showOrNot){
        window.setTimeout(
            $A.getCallback(function() {
                cmp.set('v.lookupResult', showOrNot);
            }), 200
        );
    },

    sendEvent: function(eventName, params){
        let event = $A.get(eventName);
        if(params) event.setParams(params);
        event.fire();
    },

    getData: function(index, data){
        for(const [indexItem, item] of data.entries()){
            if(indexItem == index){
                return item;
            }
        }
    }

});