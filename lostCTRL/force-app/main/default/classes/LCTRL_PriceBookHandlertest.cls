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

    @IsTest(SeeAllData=true)
    static void priceBookPositive(){
        Integer numberOfAccount = 4;
        List<Product2> omeProduct = [SELECT Id FROM Product2 LIMIT :numberOfAccount];
        Set<Id> ids = new Set<Id>();
        for(Product2 prod : omeProduct){
            ids.add(prod.Id);
        }

        Test.startTest();
        Map<Id, PricebookEntry> mapPriceBook = LCTRL_PriceBookHandler.getMapOfPriceBooksByProductsIds(ids);
        Test.stopTest();
        
        System.assertEquals(numberOfAccount, mapPriceBook.size(), 'Should be equal to numberOfAccount variable.');
    }
}