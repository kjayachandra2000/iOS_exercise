import XCTest

enum UIState: String {
    case exist = "exists == true"
    case notExist = "exists == false"
    case hittable = "isHittable == true"
}

class ScreenActions {
    
    internal var app: XCUIApplication
    
    lazy var keyboardNextButton =  app.keyboards.buttons["Next"]
    lazy var keyboardDoneButton =  app.keyboards.buttons["Done"]
    
    required init(_ app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func waitForAppToLoad() -> ScreenActions {
        let activityIndicator = app.activityIndicators["In progress"]
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: UIState.exist.rawValue), object: activityIndicator)
        _ = XCTWaiter.wait(for: [expectation], timeout: TimeInterval(4))
        waitFor(activityIndicator, status: .notExist, 16)
        return ScreenActions.init(app)
    }
    
    @discardableResult
    func relaunch() -> ScreenActions {
        app.launchArguments.removeAll()
        app.terminate()
        app.launch()
        return self
    }
    
    internal func tap(_ element: XCUIElement, timeout: Int = 10) {
        waitFor(element, status: .hittable, timeout)
        element.tap()
    }
    
    internal func typeInto(_ element: XCUIElement, text: String, timeout: Int = 10) {
        waitFor(element, status: .exist, timeout)
        element.typeText(text)
    }
    
    internal func tapAndTypeInto(_ element: XCUIElement, text: String, timeout: Int = 10) {
        tap(element, timeout: timeout)
        typeInto(element, text: text)
    }
    
    internal func labelOf(_ element: XCUIElement,_ timeout: Int = 10) -> String {
        waitFor(element, status: .exist, timeout)
        return element.label
    }
    
    internal func exists(_ element: XCUIElement, timeout: Int = 10) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: UIState.exist.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: TimeInterval(timeout))
        return (result != .timedOut)
    }
    
    internal func swipeUpOn(_ app: XCUIApplication,_ iterations: Int = 2) {
        (0...iterations - 1).forEach { _  in
            app.windows["iPhoneWindow"].swipeUp()
        }
    }
    
    internal func waitFor(_ element: XCUIElement, status: UIState,_ timeout: Int = 10) {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: TimeInterval(timeout))
        
        if (result == .timedOut) {
            XCTFail(expectation.description)
        }
    }
    
    internal func labelLike(_ text: String) -> XCUIElement {
        let predicate = NSPredicate(format: "label LIKE %@", text)
        return app.staticTexts.element(matching: predicate)
    }
    
    internal func enabled(_ element: XCUIElement) -> Bool {
        return element.isEnabled
    }
    
    internal func labelContains(_ text: String) -> XCUIElement {
        let predicate = NSPredicate(format: "label CONTAINS[cd] %@", text)
        return app.staticTexts.element(matching: predicate)
    }
    
    internal func clearText(_ element: XCUIElement) {
        element.doubleTap()
        let select = app.menuItems["Select All"]
        let cut = app.menuItems["Cut"]
        if exists(select) {
            tap(select)
            tap(cut)
        }
    }
}
