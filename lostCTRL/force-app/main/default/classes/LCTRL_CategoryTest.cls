@IsTest
public class LCTRL_CategoryTest {
    
    @IsTest
    static void categoryTest(){
        String name = 'testName';
        String id = 'testId';
        LCTRL_Category category = new LCTRL_Category();
        category.setId(id);
        category.setName(name);

        Test.startTest();
        String nameReturn = category.getName();
        String idReturn = category.getId();
        Test.stopTest();

        System.assertEquals(name, nameReturn);
        System.assertEquals(id, idReturn);
    }
}
