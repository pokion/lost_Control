/**
 * Created by cezary.bubieniec on 17.10.2022.
 */

public with sharing class LCTRL_SaveComment {

    @AuraEnabled
    public static Boolean saveComment(String JSON){
        commentWrapper comment = commentWrapper.parse(JSON);
        CommentsProduct__c com = new CommentsProduct__c();
        com.FirstName__c = comment.name;
        com.comment__c = comment.comment;
        com.Email__c = comment.email;
        com.Product__c = comment.productId;
        com.Star__c = comment.stars;

        Database.SaveResult save = Database.insert(com);

       

        return save.isSuccess();
    }

    @AuraEnabled(cacheable=true)
    public static String getComments(String productId){
        List<CommentsProduct__c> comments = [SELECT FirstName__c, Star__c, comment__c, CreatedDate FROM CommentsProduct__c WHERE Product__c = :productId AND Approval_status__c = 'Accepted'];
        return JSON.serialize(comments);
    }
}