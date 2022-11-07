/**
 * Created by cezary.bubieniec on 11.10.2022.
 */

import { LightningElement, api } from 'lwc';

export default class ImageVewer extends LightningElement {
    @api allImages;
    images = [];
    mainImage;
    isLoaded = false;

    connectedCallback(){
        for(let image of this.allImages){
            this.images.push('/sfsites/c/sfc/servlet.shepherd/version/download/' + image.image);
            if(image.isMain) this.mainImage = '/sfsites/c/sfc/servlet.shepherd/version/download/' + image.image;
        }

        if(!this.mainImage) this.mainImage = this.images[0];

        this.isLoaded = true;
    }

    handleMouseHover(event){
        let image = event.target.dataset.image;
        if(image != undefined){
            let smallImg = this.template.querySelectorAll('.small-image');
            for(let item of smallImg){
                item.classList.remove('selected');
            }
            event.currentTarget.classList.add('selected');
            this.mainImage = image;
        }
    }

}