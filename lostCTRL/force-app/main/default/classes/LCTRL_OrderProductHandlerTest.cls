@isTest
public class LCTRL_OrderProductHandlerTest {
    

    @isTest
    static void orderhanlderTest(){
        Order order = new Order();
        order.country = 'pol';
        order.firstName = 'cez';
        order.lastName = 'be';
        order.streetAddress = 'asd';
        order.city = 'asd';
        order.state = 'asd';
        order.zipCode = 'asd';
        order.email = 'asd@asd.pl';
        order.phoneNumber = '111222333';
        order.payment = 'card';

        Test.startTest();
        LCTRL_OrderProductService.saveOrder(JSON.serialize(order));
        LCTRL_OrderProductService.getOrders();
        LCTRL_OrderService.getAllOrders();
        Test.stopTest();
    }
}