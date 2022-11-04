@IsTest
public class LCTRL_PartServiceTest {
    
    @IsTest
    static void getAllPartsPositive(){
        
        List<PartsToProducts__c> parts = [SELECT Id, Name, Part__r.Name__c, Part__c FROM PartsToProducts__c WHERE Name LIKE '%Ram%' OR Part__r.Name__c LIKE '%Ram%' ];
        List<LCTRL_Spec> specs = new List<LCTRL_Spec>();

        for(PartsToProducts__c part : parts){

            LCTRL_Spec spec = new LCTRL_SpecBuilder()
                                    .setPart(part.Part__c,part.Part__r.Name__c)
                                    .setValue(part.Id, part.Name)
                                    .getSpec();
            specs.add(spec);
        }

        Test.startTest();
        String dataReturn = LCTRL_PartService.getAllParts('Ram');
        Test.stopTest();

        System.assertEquals(JSON.serialize(specs), dataReturn, 'Data return neet to match.');
    }

    @IsTest
    static void getAllPartsNegative(){
        List<PartsToProducts__c> parts = [SELECT Id, Name, Part__r.Name__c, Part__c FROM PartsToProducts__c WHERE Name LIKE '%%' OR Part__r.Name__c LIKE '%%' ];
        List<LCTRL_Spec> specs = new List<LCTRL_Spec>();

        for(PartsToProducts__c part : parts){

            LCTRL_Spec spec = new LCTRL_SpecBuilder()
                                    .setPart(part.Part__c,part.Part__r.Name__c)
                                    .setValue(part.Id, part.Name)
                                    .getSpec();
            specs.add(spec);
        }

        Test.startTest();
        String dataReturn = LCTRL_PartService.getAllParts('');
        Test.stopTest();

        System.assertEquals(JSON.serialize(specs), dataReturn, 'Data return neet to match.');
    }

}