/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

public with sharing class LCTRL_SpecItem {
    public String id;
    public String name;

    public LCTRL_SpecItem setId(String id){
        this.id = id;
        return this;
    }

    public LCTRL_SpecItem setName(String name){
        this.name = name;
        return this;
    }
}