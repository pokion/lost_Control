@IsTest
public class LCTRL_CatalogServiceTest {

    @IsTest
    static void getCatalogsPositive(){
        List<ProductCatalog> catalogs = new List<ProductCatalog>();
        for(Integer i=0;i<4;i++){
            ProductCatalog catalog = new ProductCatalog();
            catalog.Name = 'Laptop';
            catalogs.add(catalog);
        }
        insert catalogs;
        Test.startTest();
        String catalogsReturned = LCTRL_CatalogService.getCatalogs();
        Test.stopTest();
        System.assertEquals(JSON.serialize(catalogs), catalogsReturned, 'Catalogs return are not the same.');
    }
    

    @IsTest
    static void getCatalogsNegative(){
        List<ProductCatalog> catalogs = new List<ProductCatalog>();

        insert catalogs;
        Test.startTest();
        String catalogsReturned = LCTRL_CatalogService.getCatalogs();
        Test.stopTest();
        System.assertEquals(JSON.serialize(catalogs), catalogsReturned, 'Catalogs return are not the same.');
    }

}
