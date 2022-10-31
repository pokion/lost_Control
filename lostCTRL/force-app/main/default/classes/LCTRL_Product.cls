/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

public with sharing class LCTRL_Product {
    private String id;
    private ProductCategory category;
    private String name;
    private Decimal price;
    private Integer quantity;
    private String description;
    private List<LCTRL_Image> images;
    private List<LCTRL_Spec> specs;

    public LCTRL_Product(){

    }

    public String getId(){
        return id;
    }

    public void setId(String id){
        this.id = id;
    }

    public ProductCategory getCategory(){
        return category;
    }

    public void setCategory(ProductCategory category){
        this.category = category;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public Decimal getPrice(){
        return price;
    }

    public void setPrice(Decimal price){
        this.price = price;
    }

    public Integer getQuantity(){
        return quantity;
    }

    public void setQuantity(Integer quantity){
        this.quantity = quantity;
    }

    public String getDescription(){
        return description;
    }

    public void setDescription(String description){
        this.description = description;
    }

    public List<LCTRL_Image> getImages(){
        return images;
    }

    public void setImages(List<LCTRL_Image> images){
        this.images = images;
    }

    public List<LCTRL_Spec> getSpecs(){
        return specs;
    }

    public void setSpecs(List<LCTRL_Spec> specs){
        this.specs = specs;
    }
}