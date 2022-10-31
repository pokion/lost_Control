@isTest
public class LCTRL_CatalogServiceTest {
    
    @isTest static void getCatalogsPositive(){
        List<ProductCatalog> catalogs = new List<ProductCatalog>();
        for(Integer i=0;i<4;i++){
            ProductCatalog catalog = new ProductCatalog();
            catalog.Name = 'Laptop';
            catalogs.add(catalog);
        }

        insert catalogs;

        String catalogsReturned = LCTRL_CatalogService.getCatalogs();

        System.assertEquals(JSON.serialize(catalogs), catalogsReturned, 'Catalogs return are not the same.');

    }

}
