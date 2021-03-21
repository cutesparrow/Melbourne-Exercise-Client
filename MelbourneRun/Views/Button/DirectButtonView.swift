//
//  DirectButtonView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI

struct DirectButtonView: View {
    var color:Color
    var text:String
    var body: some View {
        Text(text)
            .fontWeight(.regular)
            .font(.caption)
            .padding()
            .frame(width: 90, height: 40, alignment: .center)
            .background(color)
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(3)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(color, lineWidth: 3)
            )
            
    }
}

struct DirectButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DirectButtonView(color: Color.blue,text: "LET'S GO")
    }
}
