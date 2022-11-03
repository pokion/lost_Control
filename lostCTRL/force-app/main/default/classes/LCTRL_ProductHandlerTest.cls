@IsTest
public class LCTRL_ProductHandlerTest {

    // @IsTest
    // static void createNegative(){
    //     LCTRL_ProductWrapper wrapper = new LCTRL_ProductWrapper();
    //     wrapper.name = null;
    //     wrapper.id = null;
    //     wrapper.quantity = null;
    //     wrapper.description = null;

    //     Test.startTest();
    //     LCTRL_ProductHandler.Response stat = LCTRL_ProductHandler.create(wrapper);
    //     Test.stopTest();

    //     System.assertEquals(false, stat.status, 'status should be false');
    // }

    @IsTest
    static void appendCategoryTest(){
        ProductCatalog catalog = new ProductCatalog();
        catalog.Name = 'TestTest';
        Database.SaveResult cattRes = Database.insert(catalog);
        ProductCategory category = new ProductCategory();
        category.Name = 'test';
        category.CatalogId = cattRes.getId();
        Database.SaveResult catRes = Database.insert(category);
        category.Id = catRes.getId();
        Product2 product = new Product2();
        product.Name = 'testProd';
        Database.SaveResult prodRes = Database.insert(product);
        product.Id = prodRes.getId();


        Test.startTest();
        List<SObject> response = LCTRL_ProductHandler.appendCategory(category,product);
        Test.stopTest();

        System.assertEquals(1, response.size(), 'Id\'s hould be the same');
    }
    
    
}
