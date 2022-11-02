public with sharing class LCTRL_CategoryBuilder {
    private LCTRL_Category category;

    public LCTRL_CategoryBuilder() {
        this.category = new LCTRL_Category();
    }

    public LCTRL_CategoryBuilder setName(String name){
        this.category.setName(name);
        return this;
    }

    public LCTRL_CategoryBuilder setId(String Id){
        this.category.setId(Id);
        return this;
    }

    public LCTRL_CategoryBuilder setCatalog(LCTRL_Catalog catalog){
        this.category.setCatalog(catalog);
        return this;
    }

    public LCTRL_Category getCategory(){
        return this.category;
    }
}
