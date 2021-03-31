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
                .padding()
            Text("For each day, we predict risk level on road based on pedestrian sensor data in CBD. Use the slider and choose a safe time goto gym!")
                .lineLimit(3)
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
