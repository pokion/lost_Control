@IsTest
public class LCTRL_ProductTest {
    
    @IsTest
    static void productTest(){
        Test.startTest();
        LCTRL_Product product = new LCTRL_Product();
        product.setId('id');
        product.setName('name');
        product.setDescription('description');
        product.setPrice(2.99);
        product.setQuantity(12);
        product.setCategory(new ProductCategory());
        product.setImages(new List<LCTRL_Image>());
        product.setSpecs(new List<LCTRL_Spec>());
        String te = product.getId();
        String te1 = product.getName();
        String te2 = product.getDescription();
        Decimal te4 = product.getPrice();
        Integer te5 = product.getQuantity();
        List<LCTRL_Image> te6 = product.getImages();
        List<LCTRL_Spec> te7 = product.getSpecs();
        Product2 te8 = product.getObj();
        ProductCategory te9 = product.getCategory();
        Test.stopTest();
    }

    @IsTest
    static void productBuilderTest(){
        Test.startTest();
        LCTRL_Product product = new LCTRL_ProductBuilder().setCategory(new ProductCategory()).setDescription('asd')
        .setId('asd').setImages(new List<LCTRL_Image>()).setName('asd').setPrice(2.99).setQuantity(12).setSpecs(new List<LCTRL_Spec>()).getProduct();

        Test.stopTest();
    }
}
