import XCTest

final class LoginScreen: ScreenActions {
    
    private lazy var username = app.textFields["Username"]
    private lazy var password = app.secureTextFields["Password"]
    private lazy var loginButton = app.buttons["Login"]
    private lazy var invalidLogin = app.alerts["An unowned Error occured"]
    private lazy var refreshButton = app.buttons["Refresh"]
    
    required init(_ app: XCUIApplication) {
        super.init(app)
    }
    
    @discardableResult
    func loginWith(user:String,pass:String)->LoginScreen {
        tapAndTypeInto(username, text: user)
        tapAndTypeInto(password, text: pass)
        tap(loginButton)
        return self
    }
    
    func checkAlertMessagePresent() {
        XCTAssertTrue( exists(invalidLogin))
    }
    
    func loginSuccessful(){
        XCTAssertTrue( exists(refreshButton))
    }
}
