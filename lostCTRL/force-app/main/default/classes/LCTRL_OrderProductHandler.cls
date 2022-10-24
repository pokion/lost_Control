/**
 */

public with sharing class LCTRL_OrderProductHandler {

    public static String saveOrder(String JSONorder){
        Order order = Order.parse(JSONorder);
        Order__c address = new Order__c();
        List<OrderProduct__c> products = new List<OrderProduct__c>();
        List<Product2> product2s = new List<Product2>();
        List<SObject> sobject2 = new List<SObject>();
        Set<Id> idSetProduct = new Set<Id>();
        Map<Id,OrderProduct__c> orderProduct = new Map<Id, OrderProduct__c>();

        address.PaymentMethod__c = order.payment;
        address.PhoneNumber__c = order.phoneNumber;
        address.Email__c = order.email;
        address.ZipCode__c = order.zipCode;
        address.State__c = order.state;
        address.City__c = order.city;
        address.State__c = order.streetAddress;
        address.LastName__c = order.lastName;
        address.FirstName__c = order.firstName;
        address.Country__c = order.country;

        Database.SaveResult orderResult = Database.insert(address);

        if(orderResult.isSuccess()){
            for(Order.cls_products product : order.products.products){
                OrderProduct__c newOrderItem = new OrderProduct__c();

                newOrderItem.Adress__c = orderResult.getId();
                newOrderItem.Product__c = product.id;
                idSetProduct.add(product.id);
                newOrderItem.Quantity__c = product.amount;
                products.add(newOrderItem);
                orderProduct.put(product.id, newOrderItem);
            }

            List<Product2> productsReturn = [SELECT Id,Quantity__c FROM Product2 WHERE Id =: idSetProduct];
            for(Product2 prod : productsReturn){
                prod.Quantity__c -= orderProduct.get(prod.Id).Quantity__c;
            }
            sobject2.addAll(products);
            sobject2.addAll(productsReturn);
            String retur;

            List<Database.UpsertResult> prodSaveItem = Database.upsert(sobject2,false);

            for(Database.UpsertResult result : prodSaveItem){
                if(!result.isSuccess()){
                    System.debug(prodSaveItem);
                    retur = JSON.serialize(result.getErrors());
                }
            }

            return retur;
        }

        return 'false';
    }



}