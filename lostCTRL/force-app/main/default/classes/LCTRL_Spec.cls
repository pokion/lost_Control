/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

public with sharing class LCTRL_Spec {
    private final LCTRL_SpecItem part;
    private final LCTRL_SpecItem value;
    private final ProductCatalog catalog;

    public LCTRL_Spec(LCTRL_SpecItem part, LCTRL_SpecItem value, ProductCatalog catalog){
        this.part = part;
        this.value = value;
        this.catalog = catalog;
    }

    public LCTRL_SpecItem getPart(){
        return part;
    }

    public LCTRL_SpecItem getValue(){
        return value;
    }
}