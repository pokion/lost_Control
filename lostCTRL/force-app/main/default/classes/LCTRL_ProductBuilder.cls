/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

public with sharing class LCTRL_ProductBuilder {
    private LCTRL_Product product;

    public LCTRL_ProductBuilder(){
        this.product = new LCTRL_Product();
    }

    public LCTRL_ProductBuilder setId(String id){
        this.product.setId(id);
        return this;
    }

    public LCTRL_ProductBuilder setCategory(ProductCategory category){
        this.product.setCategory(category);
        return this;
    }

    public LCTRL_ProductBuilder setName(String name){
        this.product.setName(name);
        return this;
    }

    public LCTRL_ProductBuilder setPrice(Decimal price){
        this.product.setPrice(price);
        return this;
    }

    public LCTRL_ProductBuilder setQuantity(Integer quantity){
        this.product.setQuantity(quantity);
        return this;
    }

    public LCTRL_ProductBuilder setDescription(String description){
        this.product.setDescription(description);
        return this;
    }

    public LCTRL_ProductBuilder setImages(List<LCTRL_Image> images){
        this.product.setImages(images);
        return this;
    }

    public LCTRL_ProductBuilder setSpecs(List<LCTRL_Spec> specs){
        this.product.setSpecs(specs);
        return this;
    }

    public LCTRL_Product getProduct(){
        return this.product;
    }
}