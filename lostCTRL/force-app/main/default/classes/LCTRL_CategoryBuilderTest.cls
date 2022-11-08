@IsTest
public class LCTRL_CategoryBuilderTest {
    
    @IsTest
    static void categorybuilderTest(){
        Test.startTest();
        LCTRL_Category cat = new LCTRL_CategoryBuilder().setId('Id').setName('name').setCatalog(new LCTRL_Catalog()).getCategory();
        Test.stopTest();
    }
}
