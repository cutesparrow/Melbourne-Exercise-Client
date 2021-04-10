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
    var id:Int
    var color:Color
    var speed:Double
    var body: some View {
        ZStack{
//            Circle()
//                .stroke(lineWidth: 4)
//                .frame(width: 2, height: 2)
//                .foregroundColor(color.opacity(0.7))
//                .scaleEffect(wave ? 5 : 1)
//                .opacity(wave ? 0 : 1)
//                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false).speed(0.35))
//                .onAppear(){
//                    self.wave.toggle()
//                }
            Circle()
                .stroke(lineWidth: 4)
                .frame(width: 2, height: 2)
                .foregroundColor(color.opacity(0.7))
                .scaleEffect(wave1 ? 5 : 1)
                .opacity(wave1 ? 0 : 1)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false).speed(self.speed))
                .onAppear(){
                    self.wave1.toggle()
                }
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(color.opacity(0.7))
                .shadow(radius: 25)
//            Text(String(id))
           
        }
    }
}

struct SensorMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        SensorMapAnnotationView(id: 1, color: Color.blue,speed: 1)
    }
}
