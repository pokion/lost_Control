/**
 * Created by cezary.bubieniec on 28.09.2022.
 */

({

    nextPage: function(page, limit, array){
        let index = page * limit;
        if(array.length < limit){
            return array;
        }else{
            return [...array].splice(index, limit);
        }
    },

    previousPage: function(page, limit, array){
        let index = (page - 2) * limit;

        return [...array].splice(index, limit);
    },

    firstPage: function(limit, array){
        return [...array].splice(0, limit);
    },

    lastPage: function(limit, array){
        let index = (array.length - 1) - limit;

        if(index < 0){
            return [...array];
        }else{
            return [...array].splice(index, limit);
        }
    },

    getCountPagesFromArray: function(array, limit){
        return Math.ceil(array.length / limit);
    }

});