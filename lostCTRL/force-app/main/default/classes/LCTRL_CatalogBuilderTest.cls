@IsTest
public class LCTRL_CatalogBuilderTest {
    
    @IsTest
    static void builderTest(){
        Test.startTest();
        LCTRL_Catalog catalog = new LCTRL_CatalogBuilder().setId('asd').setName('name').getCatalog();
        catalog.getId();
        catalog.getName();
        Test.stopTest();
    }
}
