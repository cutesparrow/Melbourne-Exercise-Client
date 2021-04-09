//
//  CardView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 8/4/21.
//

import SwiftUI

struct CardView: View {
    var content:AnyView
    var body: some View {
        ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 10)

                    
                        content
                    
                    
                }
        .frame(width: UIScreen.main.bounds.width/1.14, height: UIScreen.main.bounds.height/1.5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(content: AnyView(Text("dsfsd")))
    }
}

