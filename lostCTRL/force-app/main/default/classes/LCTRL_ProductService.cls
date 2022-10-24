public with sharing class LCTRL_ProductService {

    @AuraEnabled(cacheable=true)
    public static String getProductsFromString(String searchString) {
        String wildCardString = '%' + searchString + '%';
        try {
            List<Product2> products = [SELECT Id, Name, Quantity__c FROM Product2 WHERE Name LIKE :wildCardString];
            Set<Id> productsIds = (new Map<Id, SObject>(products)).keySet();
            Map<Id, ProductCategory> categoriesMap = LCTRL_CategoryHandler.getMapOfCategoryByProductIds(productsIds);
            Map<Id, PricebookEntry> priceMap = LCTRL_PriceBookHandler.getMapOfPriceBooksByProductsIds(productsIds);
            Map<String ,LCTRL_Image> images = LCTRL_ImageHandler.getMapImagesOfProducts(productsIds);
            List<LCTRL_Product> productsToReturn = new List<LCTRL_Product>();

            for(Product2 product : products){
                    LCTRL_Product product2 = new LCTRL_ProductBuilder()
                                            .setId(product.Id)
                                            .setName(product.Name)
                                            .setCategory(categoriesMap.get(product.Id))
                                            .setQuantity((Integer) product.Quantity__c)
                                            .setPrice(priceMap.get(product.Id).UnitPrice)
                                            .setImages(new List<LCTRL_Image>{ images.get(product.Id) })
                                            .getProduct();
                    productsToReturn.add(product2);

            }
            return JSON.serialize(productsToReturn);

        } catch (Exception e) {
            return JSON.serialize(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getProductsSearch(String searchString, String category) {
        String wildCardString = '%' + searchString + '%';
        try {
            List<Product2> products = [SELECT Id, Name, Quantity__c FROM Product2 WHERE Name LIKE :wildCardString];
            System.debug('products '+products);
            Set<Id> productsIds = (new Map<Id, SObject>(products)).keySet();
            Map<Id, ProductCategory> categoriesMap = LCTRL_CategoryHandler.getMapOfCategoryByProductIds(productsIds);
            Map<Id, PricebookEntry> priceMap = LCTRL_PriceBookHandler.getMapOfPriceBooksByProductsIds(productsIds);
            Map<String ,LCTRL_Image> images = LCTRL_ImageHandler.getMapImagesOfProducts(productsIds);
            List<LCTRL_Product> productsToReturn = new List<LCTRL_Product>();

            for(Product2 product : products){
                System.debug('.:::::categoty name::::::. ' +categoriesMap.get(product.Id).Name);
                System.debug('.:::::categoty name::::::. ' +category);
                    if(category != null){
                        System.debug('.:::::categoty name::::::. ' +categoriesMap.get(product.Id).Name);
                        if(category == categoriesMap.get(product.Id).Name){
                            
                            LCTRL_Product product2 = new LCTRL_ProductBuilder()
                                            .setId(product.Id)
                                            .setName(product.Name)
                                            .setCategory(categoriesMap.get(product.Id))
                                            .setQuantity((Integer) product.Quantity__c)
                                            .setPrice(priceMap.get(product.Id).UnitPrice)
                                            .setImages(new List<LCTRL_Image>{ images.get(product.Id) })
                                            .getProduct();
                        productsToReturn.add(product2);
                        }
                    }else {
                        LCTRL_Product product2 = new LCTRL_ProductBuilder()
                                            .setId(product.Id)
                                            .setName(product.Name)
                                            .setCategory(categoriesMap.get(product.Id))
                                            .setQuantity((Integer) product.Quantity__c)
                                            .setPrice(priceMap.get(product.Id).UnitPrice)
                                            .setImages(new List<LCTRL_Image>{ images.get(product.Id) })
                                            .getProduct();
                        productsToReturn.add(product2);
                    }

            }
            System.debug('.:::::return obj:::::. ' +productsToReturn);
            return JSON.serialize(productsToReturn);

        } catch (Exception e) {
            return JSON.serialize(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static String  getProductById(String productId){
        try {
            List<Product2> products = [SELECT Id, Name, Quantity__c, Description__c FROM Product2 WHERE Id =:productId];
            Set<Id> productsIds = (new Map<Id, SObject>(products)).keySet();
            Map<Id, ProductCategory> categoriesMap = LCTRL_CategoryHandler.getMapOfCategoryByProductIds(productsIds);
            Map<Id, PricebookEntry> priceMap = LCTRL_PriceBookHandler.getMapOfPriceBooksByProductsIds(productsIds);
            List<LCTRL_Image> images = LCTRL_ImageHandler.getAllImagesOfProduct(productId);
            List<LCTRL_Spec> specs = LCTRL_SpecHandler.getAllSpecOfProduct(productId);
            List<LCTRL_Product> productsToReturn = new List<LCTRL_Product>();

            for(Product2 product : products){
                LCTRL_Product product2 = new LCTRL_ProductBuilder()
                        .setId(product.Id)
                        .setName(product.Name)
                        .setCategory(categoriesMap.get(product.Id))
                        .setQuantity((Integer) product.Quantity__c)
                        .setPrice(priceMap.get(product.Id).UnitPrice)
                        .setImages(images)
                        .setSpecs(specs)
                        .setDescription(product.Description__c)
                        .getProduct();
                productsToReturn.add(product2);
            }
            System.debug(productsToReturn);
            return JSON.serialize(productsToReturn);

        } catch (Exception e) {
            throw new AuraHandledException('Darn it! Something went wrong: '
                    + e.getMessage());
        }
    }

    @AuraEnabled
    public static String createNewProduct(String productJSON){
        try{
            LCTRL_ProductWrapper product = (LCTRL_ProductWrapper) JSON.deserialize(productJSON, LCTRL_ProductWrapper.class);
            return JSON.serialize(LCTRL_ProductHandler.create(product));
        } catch (Exception e) {

            return JSON.serialize(e.getMessage());
        }
    }

    @AuraEnabled
    public static String deleteProduct(String id){
        Database.DeleteResult record = Database.delete(id);

        return JSON.serialize(record);
    }

}