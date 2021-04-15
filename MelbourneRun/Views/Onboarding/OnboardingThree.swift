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
            VStack{
                Image("2")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                VStack(alignment:.leading){
                    Text("LEARN TIPS")
                        .padding(.vertical,5)
                Text("Get to know the safety tips to protect yourself from covid infection. We also provide tips for different forms of exercise to help improve your effectiveness. ")
                    .font(.caption)
                Text("GO TO GYM ")
                    .padding(.vertical,5)
                Text("Explore different gyms around you and choose the one you like. We offer you help to find the lowest risk time to go to the gym. ")
                    .font(.caption)
                Text("SAFETY ROUTE")
                    .padding(.vertical,5)
                Text("Set your destination and preferences, we will help you find all the possible routes with the lowest risk. ")
                    .font(.caption)
                }.padding(.horizontal,40)
           
                
        }
        }
    }
}

struct OnboardingThree_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingThree(show: .constant(true))
    }
}
