import XCTest

final class LoginSpec:XCUITestCase{
    
    func testValidUser() {
        
        LoginScreen(app)
            .loginWith(user:"TestUser",pass:"TestPassword")
            .loginSuccessful()
    }
    
    func testInValidUser() {
        
        LoginScreen(app)
            .loginWith(user:"TestUserRock",pass:"TestPassword")
            .checkAlertMessagePresent()
    }
}
