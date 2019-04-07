import XCTest

class XCUITestCase: XCTestCase {
    
    let app = XCUIApplication()
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
