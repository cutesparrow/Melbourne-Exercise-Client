//
//  OnboardingFive.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI

struct OnboardingFive: View {
    @Binding var show:Bool
    var body: some View {
        ZStack{
            skipButton(show: $show)
                
                .position(x: UIScreen.main.bounds.width - 60, y: 110)
            VStack{Text("3. Choose a gym!")
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .padding(.bottom,30)
            Image("gymList")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 50, height: .infinity, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))}
                
                
        }
    }
}

struct OnboardingFive_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFive(show: .constant(true))
    }
}
