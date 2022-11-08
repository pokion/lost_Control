@IsTest
public class LCTRL_SpecPartsTest {
    
    @IsTest
    static void specTest(){
        Test.startTest();
        LCTRL_SpecParts.getAllSpecsByCatalog('asd');
        LCTRL_SpecParts.getAllParts();
        Test.stopTest();
    }
}
