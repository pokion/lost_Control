/**
 * Created by cezary.bubieniec on 11.10.2022.
 */

import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class CartPage extends NavigationMixin(LightningElement) {
    products;
    total;
    totalAmount = 0;
    modal = false;
    isCartEmpty = false;

    connectedCallback(){
        if(localStorage.getItem('cart') != null && JSON.parse(localStorage.getItem('cart')).totalValue > 0){
            let cart = JSON.parse(localStorage.getItem('cart'));
            this.products = cart.products;
            this.total = cart.totalValue;

            for(let item of cart.products){
                this.totalAmount+= item.price * item.amount;
                item.price = Number(item.price).toLocaleString('en') + ' €';
                for(let image of item.images){
                    if(image.isMain){
                        item['imageUrl'] = '/sfsites/c/sfc/servlet.shepherd/version/download/' + image.image;
                    }
                }
            }
        }else{
            this.isCartEmpty = true;
        }
    }

    get getTotalAmount(){
        return Number(this.totalAmount).toLocaleString('en') + ' €';
    }

    handleExitModal(){
        this.modal = false;
    }

    handleOpenModal(){
        this.modal = true;
    }

    handleModalButtonClick(){
        localStorage.clear();
        this.products = null;
        this.totalAmount = 0;
        this.modal = false;
        this.total = 0;
        this.isCartEmpty = true;
    }

    handleNavigateToHome(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            },
        });
    }

    goToDelivery(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'delivery__c'
            },
        });
    }

    handleInputChange(event){
        //let value = event.currentTarget.value;
        //TODO: zrobić żeby działało jak się zwiekszy to się zwiększy

    }

    deleteHandler(event){
        let id = event.currentTarget.dataset.id;
        let product;

        for(let [index, value] of this.products.entries()){
            if(value.id == id){
                product = value;
                this.products.splice(index, 1);
            }
        }

        this.total-= product.amount;
        console.log(Number(product.price.replace(/\D/g,'')))
        this.totalAmount = Number(this.totalAmount) - (product.amount * Number(product.price.replace(/\D/g,'')));
        console.log(product.amount,product.price,this.totalAmount)

        let newProductList = JSON.parse(JSON.stringify(this.products));

        for(let item of newProductList){
            item.price = Number(item.price.replace(/\D/g,''));
        }

        localStorage.setItem('cart', JSON.stringify({
            totalValue: this.total,
            products: newProductList
        }))


        if(this.total <= 0){
            this.isCartEmpty = true;
            this.products = null;
        }
    }
}