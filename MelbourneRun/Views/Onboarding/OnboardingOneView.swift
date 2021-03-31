//
//  OnboardingOneView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI

struct OnboardingOneView: View {
    var body: some View {
        ZStack{
            
            VStack{
            Text("Why?")
                .font(.title)
                .bold()
                .padding()
               
            Text("COVID-19 is an illness caused by a new virus.It has casued 2.8M deaths!")
                .padding()
            Image("Covid_count")
                .padding()
            Text("However:")
                .padding()
            Image("Treatment")
                .resizable()
                .scaledToFit()
                .padding()
            Text("Fortunately!")
                .padding()
                .padding(.bottom,50)
            Text("WE CAN HELP YOU!")
                .font(.title)
                .foregroundColor(.purple)
                .bold()
            }
            .frame(width: UIScreen.main.bounds.width-20, height: .infinity, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 25.0, style: .circular)
                        .stroke(Color(.label), lineWidth: 2)
                        )
            
        }
    }
}

struct OnboardingOneView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingOneView()
    }
}
