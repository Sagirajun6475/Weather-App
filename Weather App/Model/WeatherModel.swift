//
//  WeatherModel.swift
//  Weather App
//
//  Created by Nikhil Varma on 9/15/24.
//

// Represents the weather information for a city.
struct WeatherModel: Codable {
    // The name of the city for which the weather information is provided.
    let cityName: String
    
    // The current temperature in degrees Celsius.
    let temperature: Double
    
    // An identifier for the weather condition, used to determine the appropriate SF Symbol.
    let conditionId: Int
    
    // An icon code representing the weather condition, which is used to determine if it's day or night.
    let icon: String
    
    // A computed property that formats the temperature to one decimal place as a String.
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        // Check if the weather icon code ends with "d" to determine if it's daytime.
        let isDaytime = icon.hasSuffix("d")
        
        // Determine the SF Symbol based on the weather condition ID.
        switch conditionId {
            case 200...232:
                return "cloud.bolt.fill" // Thunderstorm
            case 300...321:
                return "cloud.drizzle.fill" // Drizzle
            case 500...531:
                return "cloud.rain.fill" // Rain
            case 600...622:
                return "cloud.snow.fill" // Snow
            case 701...781:
                return "cloud.fog.fill"  // Fog
            case 800:
                // Clear sky; choose symbol based on daytime or nighttime.
                return isDaytime ? "sun.max.fill" : "moon.stars.fill"
            case 801...804:
                // Cloudy; choose symbol based on daytime or nighttime.
                return isDaytime ? "cloud.sun.fill" : "cloud.moon.fill"
            default:
                return "cloud.fill" // Default case for unknown or unhandled condition IDs.
        }
    }
}
