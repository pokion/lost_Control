/**
 * Created by cezary.bubieniec on 04.10.2022.
 */

public with sharing class LCTRL_PriceBookHandler {

    public static Map<Id, PricebookEntry> getMapOfPriceBooksByProductsIds(Set<Id> productsIds){
        List<PricebookEntry> prices = [SELECT UnitPrice, Product2Id FROM PricebookEntry WHERE Product2.Id =:productsIds];
        Map<Id, PricebookEntry> pricesMap = new Map<Id, PricebookEntry>();

        for(PricebookEntry price : prices){
            pricesMap.put(price.Product2Id, price);
        }

        return pricesMap;
    }
}