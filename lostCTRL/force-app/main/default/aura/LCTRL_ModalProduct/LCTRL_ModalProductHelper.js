/**
 * Created by cezary.bubieniec on 28.09.2022.
 */

({

    getIdsFromImages: function(files){
        let images = [];

        for(const file of files){
            images.push({
                Id: file.contentVersionId,
                IsMainImage: false
            });
        }

        return images;
    },

    checkIfEmpty: function(object){
        let issues = [];
        if(object.name === "") issues.push('Name can\'t be empty');
        if(object.category === null) issues.push('Category can\'t be empty');
        if(object.quantity === null) issues.push('In Stock can\'t be empty');
        if(object.specs.length === 0) issues.push('Specification can\'t be empty');
        if(object.images.length === 0) issues.push('Images can\'t be empty');
        return issues;
    },

    changeMainImage: function(cmp, id){
        let images = cmp.get('v.images');

        for(let image of images){

            if(image.Id == id){
                image.IsMainImage = true;
            }else{
                image.IsMainImage = false;
            }
        }

        cmp.set('v.images', JSON.parse(JSON.stringify(images)));
    },

    removeImageFromArray: function(array, index){
        let newArray = [...array].splice(index,1);
        return newArray;
    }


});