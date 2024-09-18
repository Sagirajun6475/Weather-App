//
//  WeatherApp.swift
//  Weather App
//
//  Created by Nikhil Varma on 9/18/24.
//

import SwiftUI
import UIKit

@main
struct WeatherApp: App {
    // The main entry point of the application.
    
    // Create a StateObject for the WeatherCoordinator.
    @StateObject private var coordinator = WeatherCoordinator()
    
    var body: some Scene {
        // The body property describes the app's content and its layout.
        WindowGroup {
            // WindowGroup is a container for managing multiple windows in the app.
            Group {
                // Group allows you to combine multiple views together.
                
                // WeatherView is the main view of the app, initialized with its view model.
                WeatherView(viewModel: WeatherViewModel())
                    // Inject the WeatherCoordinator into the environment for use by child views.
                    .environmentObject(coordinator)
            }
        }
    }
}

