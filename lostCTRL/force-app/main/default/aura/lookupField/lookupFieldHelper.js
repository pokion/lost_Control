({
    processResults : function(results, returnFields, searchText) {
        let fetchFromObject = function(obj, prop) {
            if(typeof obj === 'undefined') {
                return false;
            }

            var _index = prop.indexOf('.')
            if(_index > -1) {
                return fetchFromObject(obj[prop.substring(0, _index)], prop.substr(_index + 1));
            }

            return obj[prop];
        }

        var regEx = null;
        if (searchText != null && searchText.length> 0) {
            regEx = new RegExp(searchText, 'gi');
        }
        
        for (var i = 0; i < results.length; i++) {
            
            results[i]['Field0'] = results[i][returnFields[0]].replace(regEx,'<mark>$&</mark>');
            
            for(var j = 1; j < returnFields.length; j++){
                var fieldValue = fetchFromObject(results[i],returnFields[j]);
                console.table(fieldValue);
                if (fieldValue) {
                    results[i]['Field1'] = (results[i]['Field1'] || '') + ' • ' + fieldValue;
                }
            }
            if (results[i]['Field1']) {
                results[i]['Field1'] = results[i]['Field1'].substring(3).replace(regEx,'<mark>$&</mark>');
            }
        }
        return results;
    }
})