//
//  TopNavigationBarView.swift
//  swift-weather-ui
//
//  Created by Guven Bolukbasi on 21.12.2019.
//  Copyright © 2019 dorianlabs. All rights reserved.
//

import SwiftUI

struct TopNavigationBarView: View {
    @EnvironmentObject var userData:UserData
    var body: some View {
        HStack(alignment: .center, spacing: 10.0) {
            Text(userData.weather.location.name + " " + userData.weather.location.region)
                .lineLimit(1)
                .foregroundColor(Color(.label))
            Spacer()
        }
        .padding()
    }
}

struct TopNavigationBarView_Previews: PreviewProvider {

    static var previews: some View {
        PreviewFactory.previews(forView: TopNavigationBarView())
    }
}
