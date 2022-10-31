/**
 * Created by cezary.bubieniec on 19.10.2022.
 */

public without sharing class LCTRL_CatalogService {

    @AuraEnabled(cacheable=true)
    public static String getCatalogs(){
        List<ProductCatalog> catalgos = [SELECT Name FROM ProductCatalog WHERE Id NOT IN('0ZS7Q00000098KqWAI')];
        System.debug(catalgos + '  CATALOG');
        return JSON.serialize(catalgos);
    }

}