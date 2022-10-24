/**
 * Created by cezary.bubieniec on 28.09.2022.
 */

({

    tableInit: function(cmp,event,helper){
        cmp.set('v.currentPage', 0)
        let page = cmp.get('v.currentPage');
        let array = cmp.get('v.data');
        console.log(array,'to jest w datatabkeek')
        let limit = Number(cmp.get('v.currentCountView'));
        let pages = helper.getCountPagesFromArray(array,limit);
        let blockNext = (page + 1) >= pages ? true : false;
        cmp.set('v.blockPreviousButtons', true);
        cmp.set('v.blockNextButtons', blockNext);

        cmp.set('v.pages', pages);

        let data = helper.nextPage(page, limit, array);

        cmp.set('v.currentPage', 1)
        cmp.set('v.dataVisible', data);
    },

    next: function(cmp,event,helper){
        let page = cmp.get('v.currentPage');
        let data = helper.nextPage(page, Number(cmp.get('v.currentCountView')), cmp.get('v.data'));
        cmp.set('v.currentPage', (page +1))
        cmp.set('v.dataVisible', data);
        cmp.set('v.blockPreviousButtons', false);

        if(page + 1 == cmp.get('v.pages')) cmp.set('v.blockNextButtons', true);
    },

    previous: function(cmp,event,helper){
        let page = cmp.get('v.currentPage');
        let data = helper.previousPage(cmp.get('v.currentPage'), Number(cmp.get('v.currentCountView')), cmp.get('v.data'));
        cmp.set('v.currentPage', (page -1))
        cmp.set('v.dataVisible', data);
        cmp.set('v.blockNextButtons', false);

        if(page - 1 == 1) cmp.set('v.blockPreviousButtons', true);
    },

    first: function(cmp,event,helper){
       let page = cmp.get('v.currentPage');
       let data = helper.firstPage(Number(cmp.get('v.currentCountView')), cmp.get('v.data'));
       cmp.set('v.currentPage', 1)
       cmp.set('v.dataVisible', data);
       cmp.set('v.blockPreviousButtons', true);
       cmp.set('v.blockNextButtons', false);
    },

    last: function(cmp,event,helper){
       let pages = cmp.get('v.pages');
       let data = helper.lastPage(Number(cmp.get('v.currentCountView')), cmp.get('v.data'));
       cmp.set('v.currentPage', pages)
       cmp.set('v.dataVisible', data);
       cmp.set('v.blockPreviousButtons', false);
       cmp.set('v.blockNextButtons', true);
    },

    handleRowAction: function(cmp,event){
        let cmpEvent = cmp.getEvent("rowaction");
        console.log(event.getParam('row'))
        cmpEvent.setParams({
                "row": event.getParam('row'),
                "action": event.getParam('action')
        });
        cmpEvent.fire();
    }

});