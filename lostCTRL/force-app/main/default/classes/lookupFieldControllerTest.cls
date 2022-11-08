@IsTest
public class lookupFieldControllerTest {
    
    @IsTest(SeeAllData=True)
    static void lookupFieldTest(){
        Test.startTest();
        List<string> returnFields = new List<string> {'Name'};
        Account a = [SELECT Id FROM Account LIMIT 1];
		lookupfieldController.getObjectDetails('Account');
        lookupfieldController.GetRecentRecords('Account', returnFields, 5);
        lookupfieldController.SearchRecords('Account', returnFields, returnFields, '', 'Name', 'ASC', 5, 'CreatedDate > 2001-01-01T00:00:01Z');
        lookupfieldController.GetRecord('Account', returnFields, a.Id);
        Test.stopTest();
    }
}
