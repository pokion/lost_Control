/**
 * Created by cezary.bubieniec on 19.10.2022.
 */

import { LightningElement,wire, track } from 'lwc';
import getOrders from '@salesforce/apex/LCTRL_OrderProductService.getOrders';
import createComplaint from '@salesforce/apex/LCTRL_Complaint.createComplaint';

import {getRecord} from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name';

export default class ProfilPage extends LightningElement {
    month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    orders = new Map();
    isOrder = true;
    isSpinner = false;
    isLoaded = false;
    isComplaint = false;
    currentComplatintId;

    @wire(getOrders)
    async wireRecords(data,error){
        if(data.data != undefined){
            let ordersJSON = JSON.parse(data.data);
            for(let item of ordersJSON){
                if(this.orders.get(item.Adress__c) != undefined){
                    this.orders.set(this.orders.get(item.Adress__c).push(item))
                }else{
                    this.orders.set(item.Adress__c, new Array(item));
                }
            }

            this.isLoaded = true;
        }else{
        }
    }

    @track name;
    @wire(getRecord, {
        recordId: USER_ID,
        fields: [NAME_FIELD]
    }) wireuser({
        error,
        data
    }) {
        if (data) {
            this.name = data.fields.Name.value;
        }
    }


    get getOrders(){
        let retu = [];
        for(let item of this.orders){
            if(item[1]){
                let date = item[1][0].CreatedDate.split('T');

                retu.push({
                    id: item[0],
                    oderDate: date[0],
                    length: item[1].length +1,
                    value: item[1]
                })
            }
        }

        let sortArray = retu.sort().reverse();
        return sortArray;
    }

    exit(){
        this.isComplaint = false;
    }

    open(event){
        this.isComplaint = true;
        this.currentComplatintId = event.currentTarget.id;
        console.table(this.currentComplatintId);
    }

    buttonClick(){
        this.isSpinner = true;
        let inputs = this.template.querySelectorAll('.dat');
        let complaint = {};
        for(let input of inputs){
            complaint[input.dataset.id] = input.value;
        }
        complaint['status'] = 'New';
        complaint['caseOrigin'] = 'Web';

        createComplaint(complaint).then(data => {
            console.table(data);
            this.isSpinner = true;
            this.isComplaint = false;
        })

    }


}