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
            VStack{
                Image("3")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding(.bottom,40)
                Text("Press the button to go if you want to exercise safely in Melbourne City. ")
                    .padding(.horizontal,40)
            }
             
        }
    }
}

struct OnboardingFour_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFour(show: .constant(true))
    }
}
