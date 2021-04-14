//
//  skipButton.swift
//  MelbExercise
//
//  Created by gaoyu shi on 13/4/21.
//

import SwiftUI

struct skipButton: View {
    @Binding var show:Bool
    var body: some View {
        Button(action: {self.show.toggle()}, label: {
            ZStack{
                Text("skip")
                        .padding(10.0)
                        .overlay(
                            Circle()
                                .stroke(lineWidth: 2.0)
                        )
            }
        })
    }
}

struct skipButton_Previews: PreviewProvider {
    static var previews: some View {
        skipButton(show: .constant(true))
    }
}
