//
//  WelcomeView.swift
//  WTF - What's the Forecast
//
//  Created by janelle myers on 2/27/23.
//

import SwiftUI
import CoreLocationUI //for loc button

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            //vstack inside
            VStack(spacing: 20) {
                Text("Welcome to WTF ☀️")
                    .bold()
                    .font(.title)

                Text("Please share your current location to get the weather in your area")
                    .padding()
            }
            .multilineTextAlignment(.center) //center both stacks
            .padding()
            
            LocationButton(.shareCurrentLocation){
                //add action when clicked
                //function from the class
                locationManager.requestLocation()
            } //button design
            
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)

        }
        //max w and h
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
