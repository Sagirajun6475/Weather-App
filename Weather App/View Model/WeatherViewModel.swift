//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Nikhil Varma on 9/15/24.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var city: String = "" {
        didSet {
            saveLastSearchedCity()
        }
    }
    @Published var weather: WeatherModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let locationManager: CLLocationManager
    private let weatherManager = WeatherManager()
    
    private let lastCityKey = "lastCity"
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        // Load the last searched city from UserDefaults
        if let lastCity = UserDefaults.standard.string(forKey: lastCityKey) {
            self.city = lastCity
            fetchWeather() // Auto-load weather for the last city
        }
    }
    
    // Fetches weather based on the current city
    func fetchWeather() {
        guard !city.isEmpty else { return }
        clearWeatherData()
        isLoading = true
        weatherManager.fetchWeather(cityName: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weather):
                    self?.weather = weather
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    // Requests location for weather data
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    // Location Manager Delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            isLoading = true
            weatherManager.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { [weak self] result in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch result {
                    case .success(let weather):
                        self?.weather = weather
                        self?.errorMessage = nil
                    case .failure(let error):
                        self?.errorMessage = "Location error: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = "Location error: \(error.localizedDescription)"
        }
    }
    
    // Clears the current weather data and error message
    func clearWeatherData() {
        weather = nil
        errorMessage = nil
    }
    
    // Saves the last searched city in UserDefaults
    private func saveLastSearchedCity() {
        UserDefaults.standard.set(city, forKey: lastCityKey)
    }
}
