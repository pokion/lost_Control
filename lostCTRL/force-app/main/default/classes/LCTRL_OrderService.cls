public with sharing class LCTRL_OrderService {
    
    @AuraEnabled
    public static string getAllOrders(){
        try {
            List<OrderProduct__c> orders = [SELECT Adress__r.City__c, Adress__c, Adress__r.Country__c, Adress__r.Email__c, Adress__r.FirstName__c, Adress__r.LastName__c, Adress__r.PaymentMethod__c, Adress__r.PhoneNumber__c, Adress__r.State__c, Adress__r.Street__c, Adress__r.ZipCode__c, Product__r.Name, Quantity__c, Status__c, Name FROM OrderProduct__c ];
            return JSON.serialize(orders);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
