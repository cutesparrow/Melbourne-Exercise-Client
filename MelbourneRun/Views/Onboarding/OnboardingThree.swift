//
//  OnboardingThree.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI

struct OnboardingThree: View {
    var body: some View {
        VStack{
            Text("1. Read safety policy easily!")
                .font(.title)
                .padding()
                .padding(.bottom,50)
            Image("safety_policy")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 50, height: .infinity, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
    }
}

struct OnboardingThree_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingThree()
    }
}
