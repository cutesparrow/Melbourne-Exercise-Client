//
//  MainButtonJoggingView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 8/4/21.
//

import SwiftUI

struct MainButtonJoggingView: View {
    var imageName: String
    var colorHex: UInt
    var width: CGFloat = 55
    var body: some View {
        ZStack {
            Color(hex: colorHex)
                .frame(width: width, height: width)
                .cornerRadius(width/2)
                .shadow(color: Color(hex: colorHex).opacity(0.3), radius: 15, x: 0, y: 15)
            Image(systemName: imageName)
                .font(.system(size: 30, weight: .regular))
                .foregroundColor(.white)
        }
    }
}

struct MainButtonJoggingView_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonJoggingView(imageName: "plus", colorHex: 0xeb3b5a)
    }
}
