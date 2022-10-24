/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

public with sharing class LCTRL_CategoryHandler {

    public static Map<Id, ProductCategory> getMapOfCategoryByProductIds(Set<Id> productsIds){
        List<ProductCategoryProduct> categories = [SELECT ProductId, ProductCategory.Name, ProductCategory.Id, ProductCategory.Catalog.Name FROM ProductCategoryProduct WHERE ProductId = :productsIds];
        Map<Id, ProductCategory> categoriesMap = new Map<Id, ProductCategory>();

        for(ProductCategoryProduct category : categories){
            ProductCategory productCategory = new ProductCategory();
            productCategory.Id = category.ProductCategory.Id;
            productCategory.Name = category.ProductCategory.Name;
            ProductCatalog catalog = new ProductCatalog();
            catalog.Name = category.ProductCategory.Catalog.Name;
            productCategory.Catalog = catalog;
            categoriesMap.put(category.ProductId, productCategory);
        }

        return categoriesMap;
    }

    public static List<ProductCategory> getCategoryByName(String name){
        String query = '%'+name+'%';
        return [SELECT Id, Name, Catalog.Name, Catalog.Id FROM ProductCategory WHERE Name LIKE :query];
    }
}