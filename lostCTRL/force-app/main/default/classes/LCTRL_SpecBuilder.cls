/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

public with sharing class LCTRL_SpecBuilder {
    private LCTRL_SpecItem part;
    private LCTRL_SpecItem value;
    private ProductCatalog catalog;

    public LCTRL_SpecBuilder setPart(String id, String name){
        this.part = new LCTRL_SpecItem().setId(id).setName(name);
        return this;
    }

    public LCTRL_SpecBuilder setCatalog(ProductCatalog catalog){
        this.catalog = catalog;
        return this;
    }

    public LCTRL_SpecBuilder setValue(String id, String name){
        this.value = new LCTRL_SpecItem().setName(name).setId(id);
        return this;
    }

    public LCTRL_Spec getSpec(){
        return new LCTRL_Spec(part, value, catalog);
    }

}