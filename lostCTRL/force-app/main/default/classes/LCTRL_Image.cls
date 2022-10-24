/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

public with sharing class LCTRL_Image {
    private String image;
    private Boolean isMain;

    public LCTRL_Image(){

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