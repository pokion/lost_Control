@IsTest
public class commentWrapperTest {
   
    @IsTest
    static void parsetest(){
        commentWrapper wrapper = new commentWrapper();
        wrapper.comment = 'asd';
        wrapper.email = 'asd@asd.com';
        wrapper.name = 'asd';
        wrapper.productId = 'idtest';
        wrapper.stars = 3;

        String wrapperJSON = JSON.serialize(wrapper);

        Test.startTest();
        commentWrapper result = commentWrapper.parse(wrapperJSON);
        Test.stopTest();

        System.assertEquals(wrapper.name, result.name, 'result should be the same');
    }
}
