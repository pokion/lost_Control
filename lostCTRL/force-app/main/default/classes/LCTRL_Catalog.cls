public with sharing class LCTRL_Catalog {
    private String Name;
    private String Id;

    public LCTRL_Catalog() {

    }

    public void setName(String name){
        this.Name = name;
    }

    public String getName(){
        return this.Name;
    }

    public void setId(String id){
        this.Id = id;
    }

    public String getId(){
        return this.Id;
    }

    public ProductCatalog getSObject(){
        ProductCatalog catalogS = new ProductCatalog();
        catalogS.Name = this.Name;
        catalogS.Id = this.Id;
        return catalogS;
    }


}
