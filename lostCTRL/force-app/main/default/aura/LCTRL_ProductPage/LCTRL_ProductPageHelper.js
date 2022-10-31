({

    getProducts: function(cmp, string){
        let getProducts = cmp.get('c.getProductsFromString');
        getProducts.setParam('searchString', string);

        getProducts.setCallback(this, (response)=>{
            let state = response.getState();
            console.table(response);
            if(state == 'SUCCESS'){
                let data = JSON.parse(response.getReturnValue());
                data.forEach(item =>{
                    item['URL'] = '/lightning/r/Product2/'+ item['id'] +'/view';
                    item['categoryName'] = item.category.Name;
                });
                console.table(data);
                cmp.set('v.data', data);
            }else{
                console.table( response);
            }
        })
        $A.enqueueAction(getProducts);
    },

    deleteProduct: function(cmp, id){
        let deleteProd = cmp.get('c.deleteProduct');
        deleteProd.setParam('id', id);
        deleteProd.setCallback(this, (response)=>{
            let state = response.getState();
            if(state == 'SUCCESS'){
                console.log(state,'no state jest');

            }else{
                console.log('response else', response);
            }
        })
        $A.enqueueAction(deleteProd);
    }

});