//
//  SensorMapAnnotationView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/4/21.
//

import SwiftUI

struct SensorMapAnnotationView: View {
    @State private var wave = false
    @State private var wave1 = false
    var color:Color
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 4)
                .frame(width: 10, height: 10)
                .foregroundColor(color.opacity(0.7))
                .scaleEffect(wave ? 2 : 1)
                .opacity(wave ? 0 : 1)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false).speed(0.5))
                .onAppear(){
                    self.wave.toggle()
                }
            Circle()
                .stroke(lineWidth: 4)
                .frame(width: 10, height: 10)
                .foregroundColor(color.opacity(0.7))
                .scaleEffect(wave1 ? 2 : 1)
                .opacity(wave1 ? 0 : 1)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false).speed(0.7))
                .onAppear(){
                    self.wave1.toggle()
                }
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(color.opacity(0.7))
                .shadow(radius: 25)
           
        }
    }
}

struct SensorMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        SensorMapAnnotationView(color: Color.blue)
    }
}
