public with sharing class LCTRL_Category {
    private LCTRL_Catalog catalog;
    private String name;
    private String id;

    public LCTRL_Category() {

    }

    public void setName(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public void setId(String id){
        this.id = id;
    }

    public String getId(){
        return this.id;
    }

    public void setCatalog(LCTRL_Catalog catalog){
        this.catalog = catalog;
    }

    public LCTRL_Catalog getCatalog(){
        return this.catalog;
    }
}
