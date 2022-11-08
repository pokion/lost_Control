@IsTest
public class LCTRL_ImageHandlerTest {
    
    @IsTest
    static void getMapImagesOfProductsTest(){
        Database.SaveResult productRes = Database.insert(new LCTRL_ProductBuilder().setName('testName').getProduct().getObj());
        Set<Id> productIdSet = new Set<Id>();
        productIdSet.add(productRes.getId());
        Product_images__c image = new Product_images__c();
        image.image__c = 'asd';
        image.Product__c = productRes.getId();
        insert image;

        Test.startTest();
        LCTRL_ImageHandler.getMapImagesOfProducts(productIdSet);
        LCTRL_ImageHandler.getAllImagesOfProduct(productRes.getId());
        Test.stopTest();
    }
}
