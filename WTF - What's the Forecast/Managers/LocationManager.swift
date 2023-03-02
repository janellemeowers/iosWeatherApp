//
//  LocationManager.swift
//  WTF - What's the Forecast
//
//  Created by janelle myers on 2/27/23.
//

import Foundation
import CoreLocation

//protocols are blueprints
//observable object allows to react to changes in your data, and queue view updates for the UI's next render cycle
//CLLocationManagerDelegate receive events from location-manager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    //published allows listening for changes, view redraw
    //lat and long, ? is optional
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
            super.init()
            manager.delegate = self
        }

        func requestLocation() {
            isLoading = true
            manager.requestLocation()
        }

    //For CLLlocation manager, need didUpdatelocations func
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            location = locations.first?.coordinate //update location first one in array
            isLoading = false //change state
        }
    //didFailWithError, error function
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error getting location", error)
            isLoading = false
        }
    
}
