//
//  OnboardingFour.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI

struct OnboardingFour: View {
    @Binding var show:Bool
    var body: some View {
        ZStack{
            skipButton(show: $show)
                
                .position(x: UIScreen.main.bounds.width - 60, y: 110)
            VStack{Text("2. Your gym membership!")
                .lineLimit(1)
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .padding(.bottom,20)
            Image("membership")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 50, height: .infinity, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))}
             
        }
    }
}

struct OnboardingFour_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFour(show: .constant(true))
    }
}
