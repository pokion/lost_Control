/**
 * Created by cezary.bubieniec on 24.09.2022.
 */

({

    doInit: function(cmp){
        cmp.set('v.dataVisible', cmp.get('v.dataVisible'));
    },

    lookupResultShow: function(cmp,event,helper){
        helper.toggleResult(cmp, true);
    },

    lookupResultHide: function(cmp, event, helper){
        helper.toggleResult(cmp, false);
    },

    selectedItem: function(cmp,event,helper){
        let data = helper.getData(event.currentTarget.dataset.itemIndex, cmp.get('v.data'));

        helper.sendEvent('e.c:selectedItem', {"partSelected": data});

    },

    newSelect: function(cmp,event,helper){

    },

    changeValue: function(cmp,event,helper){

    }

});