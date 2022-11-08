@IsTest
public class LCTRL_CategoryServiceTest {
   
    @IsTest
    static void getAllCategoryTest(){
        Database.SaveResult catalogRestult = Database.insert(new LCTRL_CatalogBuilder().setName('test').getCatalog().getSObject());
        ProductCategory category = new ProductCategory();
        category.Name = 'categoryTest';
        category.CatalogId = catalogRestult.getId();
        Database.SaveResult categoryResult = Database.insert(category);

        Test.startTest();
        String ret = LCTRL_CategoryService.getAllCategory(0);
        String ret2 = LCTRL_CategoryService.getAllCategory(25);
        Test.stopTest();
    }

    @IsTest
    static void getByIdCategoryTest(){
        Database.SaveResult catalogRestult = Database.insert(new LCTRL_CatalogBuilder().setName('test').getCatalog().getSObject());
        ProductCategory category = new ProductCategory();
        category.Name = 'categoryTest';
        category.CatalogId = catalogRestult.getId();
        Database.SaveResult categoryResult = Database.insert(category);

        Test.startTest();
        String ret = LCTRL_CategoryService.getCategoryById(categoryResult.getId());
        Test.stopTest();
    }

    @IsTest
    static void getByNameCategoryTest(){
        Database.SaveResult catalogRestult = Database.insert(new LCTRL_CatalogBuilder().setName('test').getCatalog().getSObject());
        ProductCategory category = new ProductCategory();
        category.Name = 'categoryTest';
        category.CatalogId = catalogRestult.getId();
        Database.SaveResult categoryResult = Database.insert(category);

        Test.startTest();
        String ret = LCTRL_CategoryService.getCategoriesByName('test');
        Test.stopTest();
    }
}
