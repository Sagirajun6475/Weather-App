//
//  WeatherView.swift
//  Weather App
//
//  Created by Nikhil Varma on 9/15/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    
                    // Title
                    HStack {
                        //Weather Tittle
                        Text(NSLocalizedString("Weather", comment: "Weather title"))
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 40)
                        
                        Spacer()
                        
                        //Current Location button
                        Button(action: {
                            viewModel.requestLocation()
                        }) {
                            Image(systemName: "location.circle.fill")
                                .font(.largeTitle)
                        }
                        .accessibility(label: Text(NSLocalizedString("Get Current Location", comment: "Button to get current location")))
                        .accessibility(identifier: "locationButton")
                        .padding(.top, 40)
                        
                    }
                    // Location and Search Section
                    HStack {
                        
                        //Search text field
                        TextField(
                            NSLocalizedString("Enter the city name", comment: "Placeholder for search text field"),
                            text: $viewModel.city,
                            onEditingChanged: { isEditing in
                                if isEditing {
                                    // Clear weather information when the user starts editing
                                    viewModel.clearWeatherData()
                                }
                            },
                            onCommit: {
                                viewModel.fetchWeather()
                            }
                        )
                        .accessibility(identifier: "searchField")
                        .padding(10)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .accessibility(label: Text(NSLocalizedString("Enter the city name", comment: "Label for search text field")))
                        
                        Spacer()
                        
                        //Search button
                        Button(action: {
                            viewModel.fetchWeather()
                            viewModel.city="" //Clear the text field after searching
                        }) {
                            Image(systemName: "magnifyingglass")
                                .font(.largeTitle)
                        }
                        .accessibility(label: Text(NSLocalizedString("Search Weather", comment: "Button to search weather")))
                        .accessibility(identifier: "searchButton")
                    }
                    
                    Spacer()
                    
                    // Weather display and error handling
                    VStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding(.top)
                        } else if let weather = viewModel.weather {
                            VStack {
                                
                                //weather condition
                                Image(systemName: weather.conditionName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                
                                //temperature
                                Text(weather.temperatureString + "°F")
                                    .font(.largeTitle)
                                    .bold()
                                    .accessibility(identifier: "TemperatureLabel")
                                
                                //city name
                                Text(weather.cityName)
                                    .font(.title)
                            }
                            .padding()
                        } else if let errorMessage = viewModel.errorMessage {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .padding(.top)
                        } else {
                            Text(NSLocalizedString("Type in a city or select your current location", comment: "Prompt for entering a city or using current location"))
                                .padding(.top)
                        }
                    }
                    .padding()
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel())
    }
}
