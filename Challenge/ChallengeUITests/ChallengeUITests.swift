//
//  ChallengeUITests.swift
//  ChallengeUITests
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import XCTest
@testable import Challenge

class ChallengeUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_MasterTableView_exists() {
        XCTAssertNotNil(app.masterTableView)
    }
    

    func test_tappingTableViewCellDisplaysDetailView() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIDevice.shared.orientation = .landscapeRight
            app.masterTableView.tap()
            XCTAssertNotNil(app.otherElements.otherElements["detail_view"])
        } else {
            XCTAssert(true)
        }
    }
    
    func test_detailView_inLandscape_does_not_have_backButton() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIDevice.shared.orientation = .landscapeRight
            app.masterTableView.tap()
            let leftNavBarButton = XCUIApplication().navigationBars.buttons["displayModeButtonItem"]
            XCTAssertFalse(leftNavBarButton.exists)
        } else {
            XCTAssert(true)
        }
    }
    
    func test_detailView_inPortrait_does_have_backButton() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIDevice.shared.orientation = .landscapeLeft
            app.masterTableView.tap()
            XCUIDevice.shared.orientation = .portrait
            let leftNavBarButton = XCUIApplication().navigationBars.buttons["displayModeButtonItem"]
            XCTAssertTrue(leftNavBarButton.exists)
        } else {
            XCTAssert(true)
        }
    }
    
    func test_swipe_onDetailView_ChangesView() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIDevice.shared.orientation = .landscapeLeft
            app.masterTableView.staticTexts["2"].tap()
            XCTAssertFalse(app.detailView.staticTexts["3"].exists)
            XCTAssertTrue(app.detailView.staticTexts["2"].exists)
            app.detailView.swipeLeft()
            XCTAssertTrue(app.detailView.staticTexts["3"].exists)
        } else {
            XCTAssert(true)
        }
    }
    
}
extension XCUIApplication {
    var masterTableView: XCUIElement  {
        return tables["masterTableView"]
    }
    
    var detailView: XCUIElement {
        return otherElements.otherElements["detailView"]
    }
}
