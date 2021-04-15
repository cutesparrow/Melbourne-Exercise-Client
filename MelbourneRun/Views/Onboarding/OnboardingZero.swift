//
//  OnboardingZero.swift
//  MelbExercise
//
//  Created by gaoyu shi on 1/4/21.
//

import SwiftUI

struct OnboardingZero: View {
    @State private var animationAmount:CGFloat = 1
    @Binding var show:Bool
    var body: some View {
        ZStack{
            skipButton(show: $show)
                .position(x: UIScreen.main.bounds.width - 60, y: 110)
            VStack{
                Image("1")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                Text("Welcome to Melbourne Safe Exercise! ")
                    .font(.title3)
                    .padding()
                Text("We offer you a platform to help you exercise safely during Covid and support you to manage your physical health. ")
                    .font(.caption).padding().foregroundColor(.gray)
                Text("Browse through a quick tutorial and be ready to go! ")
                    .font(.caption)
           
                
        }
    }
}
}
struct OnboardingZero_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingZero(show: .constant(true))
    }
}
