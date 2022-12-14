/**
 * Created by cezary.bubieniec on 07.10.2022.
 */

import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class ProductCard extends NavigationMixin(LightningElement) {
    @api productId;
    @api productName;
    @api productImageUrl;
    @api productPrice;

    lengthOfName = 33;

    connectedCallback(){
        this.productName = this.productName.substring(0, (this.lengthOfName + 3)) + '...';
    }

    get getImageUrl(){

        if(this.productImageUrl[0] != null){
            //https://britenet94-dev-ed.my.salesforce.com/sfc/p/7Q000006GKFr/a/7Q000000cI5j/1ps7vIHydKNPSt0GMLsGUtu9nGhQDE03liDUHRoW2dE
            return '/sfsites/c/sfc/servlet.shepherd/version/download/'+ this.productImageUrl[0].image;
        }else{
            return '/sfc/servlet.shepherd/version/download/';
        }
    }

    get getPrice(){
        return Number(this.productPrice).toLocaleString('en') + ' €';
    }

    handleClick(){
         this[NavigationMixin.Navigate]({
             type: 'comm__namedPage',
             attributes: {
                 name: 'product__c'
             },
             state: {
                'productId': this.productId,
             },
         });
    }
}