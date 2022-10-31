/**
 * Created by cezary.bubieniec on 17.10.2022.
 */

import { LightningElement, api } from 'lwc';

export default class Comment extends LightningElement {
    @api starts;
    @api name;
    @api body;
    @api createDate;
    month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    connectedCallback(){

    }

    get getStars(){
        let starString ='';

        for(let i=0; i<5;i++){
            if(i<this.starts){
                starString+= '<span style="color: gold">★</span>'
            }else{
                starString+= '<span>★</span>'
            }
        }
        return starString;
    }

    get getCreateDate(){
        let date = new Date(this.createDate);
        return this.month[date.getMonth()] + ' ' + date.getFullYear();
    }
}