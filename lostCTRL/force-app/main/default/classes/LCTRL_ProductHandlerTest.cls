@IsTest
public class LCTRL_ProductHandlerTest {

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

        LCTRL_ProductWrapper wrapper = new LCTRL_ProductWrapper();
        wrapper.name = 'asd';
        wrapper.quantity = 1;
        wrapper.description = 'asd';

        Test.startTest();
        List<SObject> response = LCTRL_ProductHandler.appendCategory(category,product);
        LCTRL_ProductHandler.create();
        LCTRL_ProductHandler.appendSpecs();
        LCTRL_ProductHandler.createProduct(wrapper);
        LCTRL_ProductHandler.setPrice();
        LCTRL_ProductHandler.setImages();
        Test.stopTest();

        System.assertEquals(1, response.size(), 'Id\'s hould be the same');
    }
    
    
}