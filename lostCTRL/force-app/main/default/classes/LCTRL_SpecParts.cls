/**
 * Created by cezary.bubieniec on 23.09.2022.
 */

public with sharing class LCTRL_SpecParts {


    @AuraEnabled
    public static String getAllSpecsByCatalog(String catalog){
        try{
            List<SpecPart__c> specs = [SELECT Name__c, Id FROM SpecPart__c WHERE Catalog__r.Name LIKE :catalog];

            return JSON.serialize(specs);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String getAllParts(){
        try{
            List<PartsToProducts__c>  parts = [SELECT Name, Part__r.Name__c, Id FROM PartsToProducts__c];

            return JSON.serialize(parts);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}