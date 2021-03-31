//
//  OnboardingTwo.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI

struct OnboardingTwo: View {
    var body: some View {
        VStack{
            Text("What?")
                .font(.title)
                .bold()
                .padding()
            Text("Exercise is more important than ever!")
                .font(.title3)
                .padding()
                .padding(.bottom,-30)
            Image("ExerciseUseful")
                .resizable()
                .scaledToFit()
                .padding()
            Text("We have a lot of exercise programs for you!")
                .padding()
            Text("Worry about infection during exercise?")
                .padding()
                .padding(.bottom,50)
            Text("WE CAN PROTECT YOU!")
                .font(.title)
                .foregroundColor(.purple)
                .bold()
            
        }
    }
}

struct OnboardingTwo_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTwo()
    }
}
