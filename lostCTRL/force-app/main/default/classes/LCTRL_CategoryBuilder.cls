public with sharing class LCTRL_CategoryBuilder {
    private LCTRL_Category category;

    public LCTRL_CategoryBuilder() {
        this.category = new LCTRL_Category();
    }

    public LCTRL_CategoryBuilder setName(String name){
        this.image.setName(name);
        return this;
    }

    public LCTRL_CategoryBuilder setId(String Id){
        this.image.setId(Id);
        return this;
    }

    public LCTRL_CategoryBuilder setCatalog(String catalog){
        this.image.setCatalog(catalog);
        return this;
    }

    public LCTRL_Category getCategory(){
        return this.category;
    }
}
