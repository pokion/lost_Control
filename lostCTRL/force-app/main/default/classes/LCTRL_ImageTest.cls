@IsTest
public class LCTRL_ImageTest {
    
    @IsTest
    static void imageTest(){
       
        String type = 'typeTest';
        String imageName = 'nameTest';
        Boolean isMain = true;
        Blob bl = Blob.valueOf('adsasd');
        

        Test.startTest();
        LCTRL_Image image = new LCTRL_Image();
        image.setImage(imageName);
        image.setMain(isMain);
        image.setType(type);
        image.setBase(bl);
        String typeReturn = image.getImage();
        Boolean main = image.getMain();
        Test.stopTest();
    }
}
