/**
 * Created by cezary.bubieniec on 22.09.2022.
 */

({
    doInit: function(cmp){
        let getCategory = cmp.get('c.getAllCategory');

        getCategory.setCallback(this, (response)=>{
            let state = response.getState();
            if(state == 'SUCCESS'){
                console.log(JSON.parse(response.getReturnValue()));
                cmp.set('v.categoryList', JSON.parse(response.getReturnValue()));
            }else{
                console.log('response else', response);
            }
        })
        $A.enqueueAction(getCategory);
    },

    comboboxShow: function(cmp,event,helper){
        helper.sleep(cmp,true);
    },

    comboboxHide: function(cmp,event,helper){
        helper.sleep(cmp,false);
    },

    selectCategory: function(cmp,event){
        let id = event.currentTarget.dataset.categoryId;
        let categories = cmp.get('v.categoryList');

        for(const element of categories.Categories){
            if(element.Id == id){
                cmp.set('v.searchValue', element.Name);

                let appEvent = $A.get("e.c:newCategory");
                appEvent.setParams({"category" : element});
                appEvent.fire();
                break;
            }
        }
    },

    newCategorySwitcher: function(cmp){
        cmp.set('v.newCategory', !cmp.get('v.newCategory'));
    },

    categorySuccessHandler: function(cmp,event){
        let toastEvent = $A.get("e.force:showToast");

       let getCategory = cmp.get('c.getCategoryById');
       getCategory.setParam('id', event.getParam("id"));

       getCategory.setCallback(this, (response)=>{
           let state = response.getState();
           if(state == 'SUCCESS'){
               cmp.set('v.searchValue', JSON.parse(response.getReturnValue()))
           }else{
               console.log('response else', response);
           }
       })
       $A.enqueueAction(getCategory);

        toastEvent.setParams({
            "type": "success",
            "title": "Category Created",
            "message": "Record ID: " + event.getParam("id")
        });
        toastEvent.fire();
        cmp.set('v.newCategory', !cmp.get('v.newCategory'));
    },

    handleChange: function(cmp,event,helper){

    }


});