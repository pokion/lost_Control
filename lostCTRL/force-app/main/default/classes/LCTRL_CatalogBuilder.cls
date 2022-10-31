public with sharing class LCTRL_CatalogBuilder {
    private LCTRL_Catalog catalog;

    public LCTRL_CatalogBuilder() {
        this.catalog = new LCTRL_Catalog();
    }

    public LCTRL_CatalogBuilder setName(String name){
        this.catalog.setName(name);
        return this;
    }

    public LCTRL_CatalogBuilder setId(String id){
        this.catalog.setId(id);
        return this;
    }

    public LCTRL_Catalog getCatalog(){
        return this.catalog;
    }
}
