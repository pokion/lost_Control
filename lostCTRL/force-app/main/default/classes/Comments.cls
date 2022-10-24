public with sharing class Comments {
    public Comments() {

    }

    @AuraEnabled
    public static string getAllCommentsFromId(String movieId){
        try {
            Comments__c[] comment = [SELECT Owner.Name, text__c, Id, rating__c FROM Comments__c WHERE movieId__c =:movieId];

            return JSON.serialize(comment);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string addComment(String movieId, String comment, Integer rating){
        try {
            Comments__c comments = new Comments__c();
            comments.text__c = comment;
            comments.movieId__c = movieId;
            comments.rating__c = rating;

            Database.SaveResult srList = Database.insert(comments, false);

            return JSON.serialize(srList);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}