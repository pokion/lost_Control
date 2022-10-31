/**
 * Created by cezary.bubieniec on 11.10.2022.
 */

public with sharing class LCTRL_SpecHandler {

    public static List<LCTRL_Spec> getAllSpecOfProduct(String productId){
        List<PartsProduct__c> parts = [SELECT Parts__r.Id, Parts__r.Name, Parts__r.Part__r.Name__c, Parts__r.Part__r.Id FROM PartsProduct__c WHERE Product__c = :productId];
        List<LCTRL_Spec> specs = new List<LCTRL_Spec>();

        for(PartsProduct__c part : parts){
            LCTRL_Spec spec = new LCTRL_SpecBuilder().setPart(part.Parts__r.Id,part.Parts__r.Name).setValue(part.Parts__r.Part__r.Id, part.Parts__r.Part__r.Name__c).getSpec();
            specs.add(spec);
        }
        return specs;
    }
}