//
//  OnboardingFive.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI

struct OnboardingFive: View {
    var body: some View {
        VStack{
            Text("3. Choose a gym!")
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .padding(.bottom,30)
            Image("gymList")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 50, height: .infinity, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
        }
    }
}

struct OnboardingFive_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFive()
    }
}
