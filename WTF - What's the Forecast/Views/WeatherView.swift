//
//  WeatherView.swift
//  WTF - What's the Forecast
//
//  Created by janelle myers on 2/28/23.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    //switch symbol based on ID
    var conditionString: String {
        switch weather.weather[0].id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                //each element will have 5pix spacing
                //Location + Time
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name)
                        .bold().font(.title)
                    //automatically gets date
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                //main weather results
                VStack{
                    //hstack is horizontal
                    //main weather data
                    HStack {
                        VStack(spacing: 20) {
                            //sf symbols
                            Image(systemName:conditionString)
                                .font(.system(size: 40))
                                                    
                            Text("\(weather.weather[0].main)")
                        }
                        .frame(width: 150, alignment: .leading)
                                                
                        Spacer()
                        
                        //call roundDouble func
                        Text(weather.main.feels_like.roundDouble()+"°")
                            .font(.system(size: 90))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    //add image closure to modify
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                //bottom weather section
                VStack(alignment: .leading, spacing: 20) {
                    Text("Today")
                        .bold().padding(.bottom)
                    
                    HStack{
                        //reusable weather row component
                        WeatherRow(logo: "thermometer", name: "Min Temp", value:
                            (weather.main.tempMin.roundDouble()+"°"))
                        
                        Spacer()
                        
                        WeatherRow(logo: "thermometer", name: "Max Temp", value: (weather.main.tempMax.roundDouble()+"°"))
                        
                    }
                    //another hstack below
                    HStack{
                        //reusable weather row component
                        WeatherRow(logo: "wind", name: "Wind Speed", value:
                            (weather.wind.speed.roundDouble()+" mph"))
                        
                        Spacer()
                        
                        WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble()+"%"))
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20) //extra padding
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                //corner radius ext
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
