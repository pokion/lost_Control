@IsTest
public class LCTRL_SpecBuilderTest {
    
    @IsTest
    static void builderTest(){
        Test.startTest();
        LCTRL_Spec spec = new LCTRL_SpecBuilder().setCatalog(new ProductCatalog()).setPart('asd','asd').setValue('asd','asd').getSpec();
        spec.getPart();
        spec.getValue();
        spec.getPartC();
        Test.stopTest();
    }
}
