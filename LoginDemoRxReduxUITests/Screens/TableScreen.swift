import XCTest

final class TableScreen: ScreenActions {

    private lazy var refreshButton = app.buttons["Refresh"]
    private lazy var table = app.tables
    private lazy var titles = [String]()
    
    required init(_ app: XCUIApplication) {
        super.init(app)
    }
    
    func getRecordCount()->Int {
        waitForAppToLoad()
        return table.cells.count
    }
    
    func fetchTitles() -> TableScreen{
        for i in 0...getRecordCount()-1{
            titles.append(table.cells.element(boundBy: i).staticTexts.element(boundBy: 0).label)
        }
        return self
    }
    
    func refresh() ->TableScreen{
        tap(refreshButton)
        waitForAppToLoad()
        return self
    }
    
    func verifyNewTitlesPopulated(){
        for i in 0...getRecordCount()-1{
            XCTAssertFalse (titles.contains(table.cells.element(boundBy: i).staticTexts.element(boundBy: 0).label))
        }
    }
    
}
