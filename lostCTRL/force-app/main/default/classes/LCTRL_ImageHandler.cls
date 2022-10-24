/**
 * Created by cezary.bubieniec on 10.10.2022.
 */

public with sharing class LCTRL_ImageHandler {

    public static Map<String ,LCTRL_Image> getMapImagesOfProducts(Set<Id> productIdSet){
        List<Product_images__c> images = [SELECT image__c, Is_main_image__c, Product__c FROM Product_images__c WHERE Product__c IN :productIdSet AND Is_main_image__c = TRUE];
        Map<String ,LCTRL_Image> imagesReturn = new Map<String ,LCTRL_Image>();

        for(Product_images__c image: images){
            LCTRL_Image imageReturn = new LCTRL_ImageBuilder().setMain(image.Is_main_image__c).setImage(image.image__c).getImage();
            imagesReturn.put(image.Product__c, imageReturn);
        }

        return imagesReturn;
    }

    public static List<LCTRL_Image> getAllImagesOfProduct(String productId){
        List<Product_images__c> images = [SELECT image__c, Is_main_image__c, Product__c FROM Product_images__c WHERE Product__c =:productId];
        List<LCTRL_Image> imagesReturn = new List<LCTRL_Image>();

        for(Product_images__c image: images){
            LCTRL_Image imageReturn = new LCTRL_ImageBuilder().setMain(image.Is_main_image__c).setImage(image.image__c).getImage();
            imagesReturn.add(imageReturn);
        }

        return imagesReturn;
    }
}