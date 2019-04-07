import XCTest

class TableSpec: XCUITestCase {
    
    func testCountOfRecords() {
        
        LoginScreen(app)
            .loginWith(user:"TestUser",pass:"TestPassword")
            .loginSuccessful()
        
        
        TableScreen(app)
            .fetchTitles()
            .refresh()
            .verifyNewTitlesPopulated()
    }
    
}
