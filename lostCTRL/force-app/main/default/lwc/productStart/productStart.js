/**
 * Created by cezary.bubieniec on 10.10.2022.
 */

import { LightningElement, wire } from 'lwc';
import getRecords from '@salesforce/apex/LCTRL_ProductService.getProductsFromString';

export default class ProductStart extends LightningElement {
    records;

    @wire(getRecords, {searchString: ''})
    wirerecords(data,error){
        if(data.data){
            this.records = JSON.parse(data.data);
            console.table(this.records);
        }else{
            console.log(error)
        }
    }

}