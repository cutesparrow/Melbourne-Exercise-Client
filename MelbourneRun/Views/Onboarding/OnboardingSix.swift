//
//  OnboardingSix.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI

struct OnboardingSix: View {
    var body: some View {
        VStack{
            Text("4. Less risk on road!")
                .font(.title)
                .foregroundColor(.black)
                .padding()
            Text("We predict risk level on road based on pedestrian sensor data in CBD. One capsule represents one hour, the top side is the upper limit of the number of people on street, and the bottom side is the lower limit of the prediction. Use the slider and choose a safe time goto gym! ")
                .foregroundColor(.black)
                .lineLimit(6)
                .font(.caption)
                .padding()
            Image("RiskLevel")
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.height/2, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
    }
}

struct OnboardingSix_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSix()
    }
}
