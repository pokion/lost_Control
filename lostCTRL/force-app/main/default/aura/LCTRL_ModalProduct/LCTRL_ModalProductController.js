({

    init: function(cmp,event){
       /* let product = cmp.get('v.productExternal');
        if(product){
            cmp.set('v.productId', product.id);
            cmp.set('v.catalog', )
        }*/
    },

    handleChangeCategory: function(cmp, event){
         let category = event.getParam("category");

         cmp.set('v.category', category);
         cmp.set('v.catalog', category.Catalog.Name);
     },

    newProductModalSwitcher: function(cmp, event, helper){
        let events = $A.get('e.c:LCTRL_ToggleModal');
        events.fire();
    },

    handleUploadFinished: function (cmp, event, helper) {
        cmp.set('v.images', [...cmp.get('v.images'), ...helper.getIdsFromImages(event.getParam("files"))]);
    },

    handleClickImage: function(cmp,event,helper){
        helper.changeMainImage(cmp, event.currentTarget.dataset.imageId);
    },

    newProductModalHandler: function(cmp,event,helper){
        let toastEvent = $A.get("e.force:showToast");
        let productInfo = {
                name: cmp.find('name').get("v.value"),
                category: cmp.get('v.category'),
                quantity: Number(cmp.find('quanti').get("v.value")),
                price: cmp.find('amount').get("v.value"),
                specs: cmp.get('v.specs'),
                description: cmp.find('desc').get('v.value'),
                images: cmp.get('v.images')
            }
        let errors = helper.checkIfEmpty(productInfo)
        if(errors.length > 0){
            for(let error of errors){
                toastEvent.setParams({
                    "type": "error",
                    "title": "Something has gone wrong!",
                    "message": error
                });
                toastEvent.fire();
            }
        }else{
            let getProducts = cmp.get('c.createNewProduct');
            getProducts.setParams({productJSON: JSON.stringify(productInfo)});

            getProducts.setCallback(this, (response)=>{
                let state = response.getState();
                if(state == 'SUCCESS'){
                    let data = JSON.parse(response.getReturnValue());
                    if(data.status){
                        toastEvent.setParams({
                            "type": "success",
                            "title": "Product created",
                            "message": "Product created"
                        });
                        toastEvent.fire();
                        let events = $A.get('e.c:LCTRL_ToggleModal');
                        events.fire();
                    }
                }
            })
            $A.enqueueAction(getProducts);
        }

    },

    handleSpecChange: function(cmp,event){
        cmp.set('v.specs', event.getParam("specifications"));
    },

    newPartHandler: function(cmp,event){

    },

    removeImage: function(cmp,event,helper){
        let images = cmp.get('v.images');
        let index = event.currentTarget.dataset.idx;
        cmp.set('v.images', helper.removeImageFromArray(images, index));
    }

});