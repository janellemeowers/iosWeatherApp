//
//  ContentView.swift
//  WTF - What's the Forecast
//
//  Created by janelle myers on 2/27/23.
//

import SwiftUI

struct ContentView: View {
    //view is notified when updated
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    //state allows struct modification
    @State var weather: ResponseBody? //make optional
    
    var body: some View {
        VStack {
            //if bc it is optional
            //get location manager location
            if let location = locationManager.location {
                //optional above, needs to be unwrapped
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                    //for async functions
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    //load welcome, location manager from WV
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
