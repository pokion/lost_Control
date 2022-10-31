/**
 * Created by cezary.bubieniec on 13.10.2022.
 */

import { LightningElement, wire } from 'lwc';
import saveOrder from '@salesforce/apex/LCTRL_OrderProductService.saveOrder';
import { NavigationMixin } from 'lightning/navigation';

export default class DeliveryPage extends NavigationMixin(LightningElement) {
    isOrder = true;
    products;
    totalPrice = 0;
    address = {
        country: null,
        firstName: null,
        lastName: null,
        streetAddress: null,
        city: null,
        state: null,
        zipCode: null,
        email: null,
        phoneNumber: null,
        payment: null,
        products: null
    };

    connectedCallback(){
        this.products = JSON.parse(localStorage.getItem('cart'));

        for(let item of this.products.products){
            this.totalPrice+= item.price * item.amount;
            for(let image of item.images){
                if(image.isMain){
                    item['imageURL'] = '/sfsites/c/sfc/servlet.shepherd/version/download/' + image.image;
                }
            }

            item['price'] = Number(item.price).toLocaleString('en') + ' €';
        }
    }

    handleNavigateToHome(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            },
        });
    }

    get getTotalPrice(){
        return Number(this.totalPrice).toLocaleString('en') + ' €';
    }

    handleClickBuy(){
        this.address.products = this.products;
        let isEmpty = false;
        for(let property in this.address){
            let id = `.${property}`;
            if(this.address[property] == null){
                isEmpty = true;
                this.template.querySelector(id).classList.remove('hide');
            }else{
                this.template.querySelector(id).classList.add('hide');
            }
        }

        if(!isEmpty){
            saveOrder({ JSONorder: JSON.stringify(this.address) })
                            .then( result =>{
                                console.table(result)
                                this.isOrder = false;
                                localStorage.clear();
                            }).catch( error => {
                                console.table(error)
                            })
        }

    }

    handleOnChane(event){
        this.address[event.target.dataset.id] = event.currentTarget.value;
    }

    handleOnChange(event){
        this.address[event.target.dataset.id] = event.target.dataset.by;
    }

}