//
//  WeatherManager.swift
//  Weather App
//
//  Created by Nikhil Varma on 9/15/24.
//

import Foundation
import CoreLocation

struct WeatherManager {
    
    private static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private static let apiKey = "403a996a76f5adb2e850e97dcdd59aa9"
    private static let units = "imperial"
    private let weatherURL = "\(baseURL)?appid=\(apiKey)&units=\(units)"
    
    // Fetch weather based on city name
    func fetchWeather(cityName: String, completion: @escaping (Result<WeatherModel, WeatherError>) -> Void) {
        guard let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.invalidCityName))
            return
        }
        print("Fetched weather based on city name")
        let urlString = "\(weatherURL)&q=\(encodedCityName)"
        performRequest(with: urlString, completion: completion)
    }
    
    // Fetch weather based on coordinates
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<WeatherModel, WeatherError>) -> Void) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString, completion: completion)
    }
    
    // Performs the actual network request
    private func performRequest(with urlString: String, completion: @escaping (Result<WeatherModel, WeatherError>) -> Void) {
        //Define URL
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidCityName))
            return
        }
        
        //Create URL session
        let session = URLSession(configuration: .default)
        
        //Create Data task
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            //Handle response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            //Process data
            guard let data = data, let weather = self.parseJSON(data) else {
                completion(.failure(.failedToDecode))
                return
            }
            
            completion(.success(weather))
        }
        task.resume()
    }
    
    // Parses the received JSON data into a WeatherModel
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let icon = decodedData.weather[0].icon
            let temp = decodedData.main.temp
            let name = decodedData.name
            return WeatherModel(cityName: name, temperature: temp, conditionId: id, icon: icon)
        } catch {
            return nil
        }
    }
}
