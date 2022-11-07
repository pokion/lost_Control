/**
 * Created by cezary.bubieniec on 12.10.2022.
 */

import { LightningElement, api } from 'lwc';

export default class Modal extends LightningElement {
    @api title;
    @api body;
    @api buttonText;
    @api buttonVariant = 'danger';

    get getButtonClass(){
        return 'button '+this.buttonVariant;
    }

    exit(){
        this.dispatchEvent(new CustomEvent('exit'));
    }

    buttonClick(){
        this.dispatchEvent(new CustomEvent('buttonclick'));
    }
}