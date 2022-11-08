@IsTest
public class LCTRL_ComplaintTest {
    
    @IsTest 
    static void complaintPositive(){
        Test.startTest();
        String result = LCTRL_Complaint.createComplaint('New', 'Web', 'email@email.com', 'name', 'phone', 'subject', 'description');
        Test.stopTest();

        System.assertEquals('[]', result, 'Is Empty errors');
    }

}