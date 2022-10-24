/**
 * Created by cezary.bubieniec on 03.10.2022.
 */

({

    sleep: function(cmp,status){
        window.setTimeout(
            $A.getCallback(function() {
                cmp.set('v.focusCombobox', status);
            }), 200
        );
    }

});