/**
 * Created by cezary.bubieniec on 10.10.2022.
 */

import { LightningElement, wire, api, track } from 'lwc';
import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';
import getRecord from '@salesforce/apex/LCTRL_ProductService.getProductById';
import saveComment from '@salesforce/apex/LCTRL_SaveComment.saveComment';
import getComments from '@salesforce/apex/LCTRL_SaveComment.getComments';

export default class ProductPage extends NavigationMixin(LightningElement) {
    commentsCount = 0;
    productId;
    record;
    average = 0;
    amount = 1;
    commentStar;
    isModalCommentOpen = false;
    isModalOpen = false;
    comments;
    @track isLoaded = false;

    @wire(CurrentPageReference)
    async getPageRef(pageRef) {
        this.productId = pageRef.state.productId;
    }

    @wire(getRecord, {productId: '$productId'})
        async wireRecords(data,error){
            if(data.data != undefined){
                this.record = JSON.parse(data.data)[0];
                this.isLoaded = true;
            }else{
            }
        }

    @wire(getComments, {productId: '$productId'})
        async wireComments(data,error){
            if(data.data != undefined){
                this.comments = JSON.parse(data.data);
                if(this.comments.length > 0){
                    let totalCount = 0, average = 0;


                                    for(let item of this.comments){
                                        totalCount++;
                                        average += Number(item.Star__c);
                                    }


                                    this.commentsCount = totalCount;
                                    this.average = Math.round(((average / totalCount) + Number.EPSILON) * 100) / 100;
                }
            }

        }

    get getPrice(){
        return Number(this.record?.price).toLocaleString('en') + ' €';
    }

    handleFormInputChange(event){
        this.amount = event.target.value;
    }

    /*
        cart: {
            totalValue: 2,
            products: new Array()
        }

    */

    get getBodyModal(){
        let data = JSON.parse(localStorage.getItem('cart'));
        let body = `
            <div class="slds-grid slds-wrap">
        `

        for(let product of data.products){
            let mainImg;
            for(let image of product.images){
                if(image.isMain){
                    mainImg = '/sfsites/c/sfc/servlet.shepherd/version/download/' + image.image;
                }
            }

            body += `
                <div class="slds-col slds-size_1-of-1" style="padding:10px;">
                    <img src='${mainImg}' style="width: 30%">

                    <div class="item-info" style="width:65%; float: right">
                        <p style="padding-bottom: 10px">${product.name}</p>

                        <div class="slds-clearfix">
                            <div class="slds-float_left">
                                <span>${product.amount} pcs.</span>
                            </div>
                            <div class="slds-float_right">
                                <span>${Number(product.price).toLocaleString('en') + ' €'}</span>
                            </div>
                        </div>
                    </div>
                </div>
            `
        }
        body += '</div>';
        return body;
    }

    handleBuyClick(){
        let localStor = localStorage.getItem('cart');
        if(localStor){
            let products = JSON.parse(localStor);
            let product;

            for(let value of products.products){
                if(value.id == this.record.id){
                    value['amount']+= Number(this.amount);
                    product = Number(this.amount);
                    products.totalValue+= Number(this.amount);
                }
            }

            if(!product){
                this.record['amount'] = Number(this.amount);
                products.products.push(this.record);
                products.totalValue+= Number(this.amount);
            }

            localStorage.setItem('cart', JSON.stringify(products));
        }else{
            let productToAppend = this.record;
            productToAppend['amount'] = Number(this.amount);
            localStorage.setItem('cart', JSON.stringify({
                products: [productToAppend],
                totalValue: Number(this.amount)
            }))
        }
        this.isModalOpen = true;
    }

    handleExitModal(){
        this.isModalOpen = false;
    }

    handleAddComment(){

    }

    handleAddComment(){
        this.isModalCommentOpen = true;
    }

    get getMainImage(){
        let main;

        for(let image of this.record.images){
            if(image.isMain == true){
                main = image.image;
            }
        }

        return '/sfsites/c/sfc/servlet.shepherd/version/download/' + main;
    }

    handleClickStar(event){
        this.commentStar = event.currentTarget.dataset.count;
        let stars = this.template.querySelectorAll('.star');

        for(let [index, value] of stars.entries()){
            if(index < event.currentTarget.dataset.count){
                value.classList.add('gold');
            }else{
                value.classList.remove('gold');
            }
        }
    }

    exit(){
        this.isModalCommentOpen = false;
    }

    buttonClick(){
        let jsonComment = JSON.stringify({
                              name: this.template.querySelector('.nameComment').value,
                              email: this.template.querySelector('.email').value,
                              comment: this.template.querySelector('.comment').value,
                              stars: this.commentStar,
                              productId: this.productId
                          })
        saveComment({JSON: jsonComment})
            .then( result =>{

                this.isModalCommentOpen = false;
            }).catch( error => {
            })
    }

    handleModalButtonClick(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'cart__c'
            },
        });
    }

}