import XCTest
import LocalServer

class XCUITestCase: XCTestCase {
    
    let app = XCUIApplication()
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        if ProcessInfo.processInfo.environment["verbose_level"] == "verbose"
        {
            print("debug statements")
        }
        
        if ProcessInfo().arguments.contains("IS_MOCK") {
            setupMock()
            app.launchArguments=["-UITest"]
            app.launchEnvironment = [UITestServer.environmentKey : UITestServer.environmentInfo]
        }
        
        app.launch()
        UITestServer.resetAll()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupMock() {
        UITestResponse(filename: "table", ofType: "json", bundle: Bundle(for: XCUITestCase.self))
        .send(to: "https://api.got.show/api/characters/")
    }
}
