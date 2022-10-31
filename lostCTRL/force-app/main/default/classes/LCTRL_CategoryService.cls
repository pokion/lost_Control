/**
 * Created by cezary.bubieniec on 23.09.2022.
 */

public with sharing class LCTRL_CategoryService {

    @AuraEnabled
    public static String getAllCategory(Integer offset){
        try{
            if(offset > 0){
                List<ProductCategory> categories = [SELECT Id, Name, Catalog.Name, Catalog.Id FROM ProductCategory];

                CategoryWrapper response = New CategoryWrapper();
                response.Categories = categories;

                return JSON.serialize(response);

            }else{
                List<ProductCategory> categories = [SELECT Id, Name, Catalog.Name, Catalog.Id FROM ProductCategory LIMIT 25];
                Integer count = [SELECT Count() FROM ProductCategory LIMIT 25];

                CategoryWrapper response = New CategoryWrapper();
                response.Categories = categories;
                response.Count = count;
                response.Offset = 0;

                return JSON.serialize(response);

            }
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String getCategoryById(String id){
        try{
            ProductCategory category = [SELECT Id, Name, Catalog.Name, Catalog.Id FROM ProductCategory WHERE Id =:id LIMIT 1];

            return JSON.serialize(category);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String getCategoriesByName(String name){
        try{
            return JSON.serialize(LCTRL_CategoryHandler.getCategoryByName(name));
        }catch (Exception e){
            return JSON.serialize(e.getMessage());
        }
    }

    public class CategoryWrapper {
        public List<ProductCategory> Categories;
        public Integer Count;
        public Integer Offset;
    }

}