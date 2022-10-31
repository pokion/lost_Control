/**
 * Created by cezary.bubieniec on 29.09.2022.
 */

public with sharing class LCTRL_ProductWrapper {
    public String id;
    public ProductCategory category;
    public List<LCTRL_ImagesWrapper> images;
    public String name;
    public Decimal price;
    public Integer quantity;
    public String description;
    public List<LCTRL_SpecWrapper> specs;
}