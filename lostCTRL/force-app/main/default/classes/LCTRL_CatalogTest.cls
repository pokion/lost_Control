@IsTest
public class LCTRL_CatalogTest {
    
    @IsTest
    static void catalogTest(){
        LCTRL_Catalog catalog = new LCTRL_Catalog();
        String name = 'idReturn';
        String id = 'idReturn';
        catalog.setId(id);
        catalog.setName(name);

        Test.startTest();
        String nameReturn = catalog.getName();
        String idReturn = catalog.getId();
        catalog.setId(null);
        ProductCatalog catalogReturn = catalog.getSObject();
        Test.stopTest();

        System.assertEquals(id, nameReturn);
        System.assertEquals(name, idReturn);
    }


}
