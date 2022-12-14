/**
 * Created by cezary.bubieniec on 07.10.2022.
 */

import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { loadScript } from 'lightning/platformResourceLoader';
import getCatalogs from '@salesforce/apex/LCTRL_CatalogService.getCatalogs';


export default class NavBar extends NavigationMixin(LightningElement) {
    searchString = '';
    totalCount;
    isCartEmpty = true;
    category;

    @wire(getCatalogs)
    async wireRecords(data,error){
        if(data.data != undefined){
            console.table(data)
            this.category = JSON.parse(data.data);
        }else{
            console.table(error);
        }
    }


    renderedCallback(){

    }

    connectedCallback(){
        let localStor = JSON.parse(localStorage.getItem('cart'));
        if(localStor && localStor.totalValue > 0){
            this.totalCount = localStor.totalValue;
            this.isCartEmpty = false;
        }


    }

    handleCatalogClick(event){
        let name = event.currentTarget.dataset.name;
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Product_search__c'
            },
            state: {
               'catalog': name,
            },
        });
    }

    handleLogoClick(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            }
        });
    }

    loginClick(event){
        let name = event.currentTarget.dataset.name;
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'AccountPage__c'
            },
        });
    }

    handleClick(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Product_search__c'
            },
            state: {
               'searchString': this.searchString,
            },
        });
    }

    handleClickCart(){
        this[NavigationMixin.Navigate]({
             type: 'comm__namedPage',
             attributes: {
                 name: 'cart__c'
             },

         });
    }
    handleFormInputChange(event){
        this.searchString = event.target.value;
    }
}