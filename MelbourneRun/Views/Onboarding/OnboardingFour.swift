//
//  OnboardingFour.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI

struct OnboardingFour: View {
    var body: some View {
        VStack{
            Text("2. Your gym membership!")
                .lineLimit(1)
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .padding(.bottom,20)
            Image("membership")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 50, height: .infinity, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
    }
}

struct OnboardingFour_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFour()
    }
}
