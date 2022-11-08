public class commentWrapper{
    public String name;
    public String email;
    public String comment;
    public Decimal stars;
    public String productId;
    public static commentWrapper parse(String json){
        return (commentWrapper) System.JSON.deserialize(json, commentWrapper.class);
    }
}