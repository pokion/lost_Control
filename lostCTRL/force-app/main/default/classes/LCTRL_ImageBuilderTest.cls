@IsTest
public class LCTRL_ImageBuilderTest {
    
    @IsTest
    static void builderTest(){
        Test.startTest();
        LCTRL_Image image = new LCTRL_ImageBuilder().setImage('test').setMain(true).getImage();
        Test.stopTest();

        System.assertEquals('test', image.getImage(), 'should equal test');
        System.assertEquals(true, image.getMain(), 'should equal true');
    }
}
