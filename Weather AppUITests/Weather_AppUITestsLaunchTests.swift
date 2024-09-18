//
//  Weather_AppUITestsLaunchTests.swift
//  Weather AppUITests
//
//  Created by Nikhil Varma on 9/18/24.
//

import XCTest

class WeatherAppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let defaultMessage = app.staticTexts["Type in a city or select your current location"]
        XCTAssertTrue(defaultMessage.exists, "The default message should be visible on app launch.")
    }
}
