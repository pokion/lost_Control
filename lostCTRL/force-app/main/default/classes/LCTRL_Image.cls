/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

public with sharing class LCTRL_Image {
    private String image;
    private Boolean isMain;
    private Blob base64;
    private String type;

    public LCTRL_Image(){

    }

    public void setBase(Blob base){
        this.base64 = base;
    }

    public void setType(String type){
        this.type = type;
    }

    public void setImage(String image){
        this.image = image;
    }

    public String getImage(){
        return this.image;
    }

    public void setMain(Boolean main){
        this.isMain = main;
    }

    public Boolean getMain(){
        return this.isMain;
    }
}