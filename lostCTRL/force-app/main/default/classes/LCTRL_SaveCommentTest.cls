@IsTest
public class LCTRL_SaveCommentTest {
    
    @IsTest
    static void commenttest(){
        Product2 prod = new Product2();
        prod.Name = 'asd';
        Database.SaveResult prodRes = Database.insert(prod);
        commentWrapper wrapper = new commentWrapper();
        wrapper.comment = 'asd';
        wrapper.email = 'asd@asd.pl';
        wrapper.name = 'asd';
        wrapper.productId = prodRes.getId();
        wrapper.stars = 2;

        Test.startTest();
        LCTRL_SaveComment.saveComment(JSON.serialize(wrapper));
        LCTRL_SaveComment.getComments(prodRes.getId());
        Test.stopTest();
    }
}
