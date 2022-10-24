/**
 * Created by cezary.bubieniec on 17.10.2022.
 */

public with sharing class LCTRL_OrderProductService {

    @AuraEnabled
    public static String saveOrder(String JSONorder){
        return LCTRL_OrderProductHandler.saveOrder(JSONorder);
    }

    @AuraEnabled(cacheable=true)
    public static String getOrders(){
        List<OrderProduct__c> orders = [SELECT Product__r.Name, Quantity__c, CreatedDate, Adress__c  FROM OrderProduct__c];

        return JSON.serialize(orders);
    }
}