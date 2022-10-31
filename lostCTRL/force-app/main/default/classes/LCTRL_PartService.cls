/**
 * Created by cezary.bubieniec on 05.10.2022.
 */

public with sharing class LCTRL_PartService {

    @AuraEnabled
    public static String getAllParts(String value){
        String wildCard = '%'+value+'%';
        List<PartsToProducts__c> parts = [SELECT Id, Name, Part__r.Name__c, Part__c FROM PartsToProducts__c WHERE Name LIKE:wildCard OR Part__r.Name__c LIKE:wildCard ];
        List<LCTRL_Spec> specs = new List<LCTRL_Spec>();

        for(PartsToProducts__c part : parts){

            LCTRL_Spec spec = new LCTRL_SpecBuilder()
                                    .setPart(part.Part__c,part.Part__r.Name__c)
                                    .setValue(part.Id, part.Name)
                                    .getSpec();
            specs.add(spec);
        }

        return JSON.serialize(specs);
    }

    @AuraEnabled
    public static String deletePart(String id){
        Database.DeleteResult remove = Database.delete(id);

        return JSON.serialize(remove);
    }

    @AuraEnabled
    public static String savePart(String partId, String value){
        PartsToProducts__c newPart = new PartsToProducts__c();
        newPart.Part__c = partId;
        newPart.Name = value;

        Database.UpsertResult result = Database.upsert(newPart);

        System.debug(result);

        return JSON.serialize(result);
    }

}