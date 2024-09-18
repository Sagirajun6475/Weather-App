//
//  WeatherError.swift
//  Weather App
//
//  Created by Nikhil Varma on 9/18/24.
//

import Foundation

// An enum for handling various weather-related errors.
enum WeatherError: Error {
    case invalidCityName
    case invalidResponse
    case failedToDecode
    case networkError(String)
    
    // Localized description for each error case.
    var localizedDescription: String {
        //Switch statement to return a user-friendly message based on the error type.
        switch self {
        case .invalidCityName:
            return "Invalid city name."
        case .invalidResponse:
            return "Invalid response from the server."
        case .failedToDecode:
            return "Failed to decode the weather data."
        case .networkError(let message):
            // Additional information from the network error.
            return "Network error: \(message)"
        }
    }
}

