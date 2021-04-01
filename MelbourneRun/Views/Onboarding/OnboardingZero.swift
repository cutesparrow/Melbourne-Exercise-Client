//
//  OnboardingZero.swift
//  MelbExercise
//
//  Created by gaoyu shi on 1/4/21.
//

import SwiftUI

struct OnboardingZero: View {
    @State private var animationAmount:CGFloat = 1
   
    var body: some View {
        VStack{
            HStack{
                Text("Welcome to")
                    .font(.title)
                    .foregroundColor(.black)
                    Text("user guide")
                        .foregroundColor(.black)
                    .font(.title)
                    .bold()
            }.padding()
            .padding(.bottom,50)
            HStack{Text("Master this app in")
                .foregroundColor(.black)
                Text("4")
                    .foregroundColor(Color(hex: 0xde2a18))
                    .bold()
                    .font(.title)
                Text("steps!")
                    .foregroundColor(.black)
            }
            .padding()
            .padding(.bottom,30)
            Text("")
                .padding()
            Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(Color(.black))
                    .scaleEffect(animationAmount)
                    
                .padding(.top,130)
                .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: true),value: animationAmount)
                .onAppear{
                    self.animationAmount = 1.5
                }
                
                
                
           
                
        }
    }
}

struct OnboardingZero_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingZero()
    }
}
