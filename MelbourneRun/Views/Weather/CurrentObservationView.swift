//
//  ContentView.swift
//  swift-weather-ui
//
//  Created by Guven Bolukbasi on 8.12.2019.
//  Copyright © 2019 dorianlabs. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CurrentObservationView: View {
    @EnvironmentObject var userData:UserData
	let currentTemperature: Float = 1.4
	let dailyMaxTemperature: Float = 5.2
	let dailyMinTemperature: Float = -2.8
	let feelsLikeText = "Feels like -3°"
	let currentConditionsText = "Slightly Windy"
	let currentConditionsImageName = "MostlySunny"

	var body: some View {

		HStack {
            WebImage(url: URL(string: "http:" + self.userData.weather.current.condition.icon.replacingOccurrences(of: "64", with: "128")))
				.resizable()
                .scaledToFill()
				.frame(width: 100, height: 100)
                .padding()
            
			VStack {
				HStack {
                    Text(String(format: "%.f°C", self.userData.weather.current.temp_c))
						.font(Font.largeTitle)
						.fontWeight(.bold)
                        .foregroundColor(Color(.label))
					//Text(String(format: "%.f° / %.f°", self.dailyMaxTemperature, self.dailyMinTemperature))
                    //.foregroundColor(Color(.label))
				}
                Text("Feels like \(Int(self.userData.weather.current.feelslike_c))°C")
					.padding([.bottom], 5)
                    .foregroundColor(Color(.label))
                Text(self.userData.weather.current.condition.text)
                    .foregroundColor(Color(.label))
			}
            .padding()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        PreviewFactory.previews(forView: CurrentObservationView())
    }
    
}
