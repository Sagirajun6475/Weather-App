//
//  WeatherCoordinator.swift
//  Weather App
//
//  Created by Nikhil Varma on 9/15/24.
//

import Foundation
import UIKit
import SwiftUI

// Protocol defining a basic Coordinator that manages the app’s navigation flow.
protocol Coordinator {
    func start() // Method to initiate the coordinator's flow.
}

// WeatherCoordinator manages navigation and state for the weather application.
class WeatherCoordinator: ObservableObject {
    // Published property to notify views of changes in the current view state.
    @Published var currentView: CurrentView = .main
    
    // Enum to represent different views in the application.
    enum CurrentView {
        case main // Represents the main view of the app.
        case detail(city: String) // Represents the detail view for a specific city.
    }
    
    // Method to navigate back to the main view.
    func showMain() {
        currentView = .main
    }
    
    // Method to navigate to the detail view for a specific city.
    func showDetail(for city: String) {
        currentView = .detail(city: city)
    }
}
