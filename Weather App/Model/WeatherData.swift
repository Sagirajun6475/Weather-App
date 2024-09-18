//
//  WeatherData.swift
//  Weather App
//
//  Created by Nikhil Varma on 9/15/24.
//

import Foundation

// Represents the weather data returned from an API.
struct WeatherData: Codable {
    // The name of the city or location for which the weather data is provided.
    let name: String
    
    // Contains main weather parameters like temperature.
    let main: Main
    
    // An array of weather conditions.
    let weather: [Weather]
}

// Represents the main weather parameters.
struct Main: Codable {
    // The current temperature in degrees Celsius.
    let temp: Double
}

// Represents a weather condition.
struct Weather: Codable {
    // An identifier for the weather condition.
    let id: Int
    
    // An icon code representing the weather condition.
    let icon: String
}
