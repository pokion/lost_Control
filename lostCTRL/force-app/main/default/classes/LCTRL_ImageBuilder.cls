/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

public with sharing class LCTRL_ImageBuilder {
    private LCTRL_Image image;

    public LCTRL_ImageBuilder(){
        this.image = new LCTRL_Image();
    }

    public LCTRL_ImageBuilder setImage(String image){
        this.image.setImage(image);
        return this;
    }

    public LCTRL_ImageBuilder setMain(Boolean main){
        this.image.setMain(main);
        return this;
    }

    public LCTRL_Image getImage(){
        return this.image;
    }
}