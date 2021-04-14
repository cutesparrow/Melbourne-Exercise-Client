//
//  OnboardingThree.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI

struct OnboardingThree: View {
    @Binding var show:Bool
    var body: some View {
        ZStack{
            skipButton(show: $show)
                
                .position(x: UIScreen.main.bounds.width - 60, y: 110)
            VStack{Text("1. Read safety policy easily!")
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .padding(.bottom,50)
            Image("safety_policy")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 50, height: .infinity, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))}
        }
    }
}

struct OnboardingThree_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingThree(show: .constant(true))
    }
}
