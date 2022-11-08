@IsTest
public class LCTRL_CategoryHandlerTest {
    
    @IsTest
    static void getMapOfCategoryByProductIdsTest(){
        Database.SaveResult CatalogRes = Database.insert(new LCTRL_CatalogBuilder().setName('nametest').getCatalog().getSObject());
        Database.SaveResult categoryRes = Database.insert(new LCTRL_CategoryBuilder()
            .setCatalog(new LCTRL_CatalogBuilder().setId(CatalogRes.getId()).getCatalog())
            .setName('testCategory').getCategory().getObj()
            );


        Integer numberOfProduct = 4;
        List<Product2> products = new List<Product2>();
        Set<Id> setId = new Set<Id>();

        for(Integer i = 0; i < numberOfProduct; i++){
            products.add(new LCTRL_ProductBuilder().setName('test'+i).getProduct().getObj());
        }

        Database.SaveResult[] productSaveResult = Database.insert(products);

        for(Database.SaveResult id : productSaveResult){
            ProductCategoryProduct junction = new ProductCategoryProduct();
            junction.ProductCategoryId = categoryRes.getId();
            junction.ProductId = id.getId();
            insert junction;

            setId.add(id.getId());
        }

        Test.startTest();
        Map<Id, ProductCategory> cat = LCTRL_CategoryHandler.getMapOfCategoryByProductIds(setId);
        Test.stopTest();
    }

    @IsTest
    static void getCatNameTest(){
        Test.startTest();
        List<ProductCategory> res =LCTRL_CategoryHandler.getCategoryByName('as');
        Test.stopTest();
    }
}
