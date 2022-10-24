/**
 * Created by cezary.bubieniec on 11.10.2022.
 */

import { LightningElement, track, wire } from 'lwc';
import getRecords from '@salesforce/apex/LCTRL_ProductService.getProductsFromString';
import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';

export default class ProductSearch extends NavigationMixin(LightningElement) {
    allRecords;
    @track isLoaded = false;
    string = '';
    catalog = null;
    records;

    @wire(CurrentPageReference)
    async getPageRef(pageRef) {
        if(pageRef.state.searchString){
            this.string = pageRef.state.searchString;
        }

        if(pageRef.state.catalog){
            this.catalog = pageRef.state.catalog;
            
            if(this.allRecords){
                let newProductsList = [];
                for(let item of this.allRecords){
                    if(item.category.Catalog.Name == this.catalog){
                        newProductsList.push(item);
                    }
                    
                }
                this.records = [...newProductsList]
            }
        }
    }

    @wire(getRecords, {searchString: '$string'})
    async wirerecords(data,error){
        if(data.data != undefined){
            if(this.catalog != null){
                let array = [];
                for(let item of JSON.parse(data.data)){
                    if(item.category.Catalog.Name == this.catalog){
                        array.push(item);
                    }
                    
                }
                this.records = array;
            }else{
                this.records = JSON.parse(data.data);
            }
            
            this.allRecords = JSON.parse(data.data);
        }else{
            console.log(error)
        }
    }

    



}