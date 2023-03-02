//
//  WeatherManager.swift
//  WTF - What's the Forecast
//
//  Created by janelle myers on 2/28/23.
//

import Foundation
import CoreLocation



class WeatherManager {
    //async throws, may throw error
    //returns ResponseBody
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=APIKEYHERE&units=imperial") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        //await for req url then try for data
        //saved to data and res variables
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        //check for response and status code 200
        // guard is opposite of -if-, runs when condition is not met
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data )
        
        return decodedData
    }
}

// Model of the response body we get from calling the OpenWeather API
//struct used to store different data types
//need to create instance of it, this is jsut blueprint
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    

    struct CoordinatesResponse: Decodable {
        var lon: Double //floating point
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
        
    
    }
    
    

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    
}



extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
