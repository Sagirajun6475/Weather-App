//
//  Weather_AppUITests.swift
//  Weather AppUITests
//
//  Created by Nikhil Varma on 9/18/24.
//

import XCTest

class Weather_AppUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }

    func testWeatherViewLoads() throws {
        // Check if the "Weather" title is present
        XCTAssertTrue(app.staticTexts["Weather"].exists)
    }
    
    func testLocationButton() throws {
        let locationButton = app.buttons["locationButton"]
        XCTAssertTrue(locationButton.exists)
    }

    func testSearchFunctionality() throws {
        // Now use the identifier to access the search field
        let searchField = app.textFields["searchField"]
        let searchButton = app.buttons["searchButton"]
        let temperatureLabel = app.staticTexts["TemperatureLabel"]
        
        // Enter a city name
        searchField.tap()
        searchField.typeText("New York")
        
        // Tap the search button
        searchButton.tap()
        
        // Verify that the weather information is displayed
        let exists = temperatureLabel.waitForExistence(timeout: 10)
        XCTAssertTrue(exists, "The temperature label should exist after a search.")
    }
    
    
    func testLayoutChangesOnOrientation() throws {
        // Perform tests in portrait mode
        let weatherTitlePortrait = app.staticTexts["Weather"]
        XCTAssertTrue(weatherTitlePortrait.exists)
        
        // Rotate the device to landscape mode
        XCUIDevice.shared.orientation = .landscapeLeft
        
        // Check if the elements still exist and are positioned correctly
        let weatherTitleLandscape = app.staticTexts["Weather"]
        XCTAssertTrue(weatherTitleLandscape.exists)
    }
    
}

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        // Tap the text field and send delete key presses to clear it
        self.tap()
        let deleteString = String(repeating: "\u{8}", count: stringValue.count)
        self.typeText(deleteString)
    }
}

