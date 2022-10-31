/**
 * Created by cezary.bubieniec on 29.09.2022.
 */

public with sharing class LCTRL_ProductHandler {

    public class Response {
        public Boolean status;
        public Database.UpsertResult[] errors;
    }

    public static Response create(LCTRL_ProductWrapper product){

        Database.UpsertResult productCreated = createProduct(product);
        Product2 newProduct = new Product2();
        if(productCreated.isSuccess()){
            newProduct.Id = productCreated.getId();
            Database.UpsertResult[] issues;

            List<SObject> objects = new List<SObject>();

            objects.addAll(appendCategory(product.category, newProduct));
            objects.addAll(appendSpecs(product.specs, newProduct));
            objects.addAll(setPrice(product.price, newProduct));
            objects.addAll(setImages(product.images, newProduct));

            issues = Database.upsert(objects, false);
            Response response = new Response();
            response.status = true;

            for(Database.UpsertResult issue : issues){
                System.debug(issue.isSuccess());
                if (!issue.isSuccess()) {
                    response.status = false;
                }
            }

            response.errors = issues;

            return response;

        }else{
            Response res = new Response();
            res.status = false;
            List<Database.UpsertResult> issue = new List<Database.UpsertResult>();
            issue.add(productCreated);
            res.errors = issue;

            return res;
        }
    }

    public static List<SObject> appendCategory(ProductCategory category, Product2 product){
        ProductCategoryProduct categoryJunction = new ProductCategoryProduct();
        categoryJunction.ProductId = product.Id;
        categoryJunction.ProductCategoryId = category.Id;

        return new List<SObject>{ categoryJunction };
    }

    public static List<SObject> appendSpecs(List<LCTRL_SpecWrapper> specs, Product2 product){
        List<PartsProduct__c> partsJunction = new List<PartsProduct__c>();

        for(LCTRL_SpecWrapper spec : specs){
            PartsToProducts__c part = new PartsToProducts__c();
            PartsProduct__c junction = new PartsProduct__c();
            part.Id = spec.part.Id;

            junction.Parts__c = part.Id;
            junction.Product__c = product.Id;

            partsJunction.add(junction);
        }

        return new List<SObject>((List<SObject>) partsJunction);
    }

    public static Database.UpsertResult createProduct(LCTRL_ProductWrapper productWrapper){
        Product2 product = new Product2();
        product.Id = productWrapper.id;
        product.Name = productWrapper.name;
        product.Quantity__c = productWrapper.quantity;
        product.Description__c = productWrapper.description;


        Database.UpsertResult productResult = Database.upsert(product);

        return productResult;
    }

    public static List<SObject> setPrice(Decimal price, Product2 product){
        Pricebook2 standardPriceBook = [SELECT Id FROM Pricebook2 WHERE IsStandard = TRUE];
        PricebookEntry entry = new PricebookEntry();
        entry.Product2Id = product.Id;
        entry.Pricebook2Id = standardPriceBook.Id;
        entry.UnitPrice = price;
        entry.IsActive = true;

        return new List<SObject>{ entry };
    }

    public static List<SObject> setImages(List<LCTRL_ImagesWrapper> imageWrappers, Product2 product){
        List<Product_images__c> images =  new List<Product_images__c>();

        for(LCTRL_ImagesWrapper wrapper : imageWrappers){
            Product_images__c image = new Product_images__c();
            image.Product__c = product.Id;
            image.image__c = wrapper.Id;
            image.Is_main_image__c = wrapper.IsMainImage;

            images.add(image);
        }


        return new List<SObject>((List<SObject>) images);
    }
}