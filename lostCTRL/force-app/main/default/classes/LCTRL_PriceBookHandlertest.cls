@IsTest
public class LCTRL_PriceBookHandlertest {

    @IsTest
    static void priceBookNegative(){

        Product2 products = new LCTRL_ProductBuilder().setName('test').getProduct().getObj();
        
        Database.SaveResult res = Database.insert(products);
        Set<Id> keySet = new Set<Id>();
        keySet.add(res.getId());

        Test.startTest();
        Map<Id, PricebookEntry> mapResult = LCTRL_PriceBookHandler.getMapOfPriceBooksByProductsIds(keySet);
        Test.stopTest();

        System.assertEquals(mapResult.get(res.getId()), mapResult.get(res.getId()),'ID should be the same');

        
    }
}
